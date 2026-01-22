package com.oyunstudyosu.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import com.oyunstudyosu.utils.DeepSerializer;

	/**
	 * TraceLogger - NON-LOSSY END-TO-END TRACE SYSTEM
	 *
	 * HARD RULES:
	 * - NO TRUNCATION EVER
	 * - RAW + DECODED for all network messages
	 * - SINGLE CONTIGUOUS TIMELINE (strict ordering)
	 * - FULL depth serialization
	 */
	public class TraceLogger
	{
		private static var _instance:TraceLogger;
		private static var _initialized:Boolean = false;

		// Timing
		private var _startTime:Number;
		private var _sessionId:String;
		private var _pid:String;
		private var _seq:uint = 0;

		// File handling
		private var _logFile:File;
		private var _rawFile:File;
		private var _stream:FileStream;
		private var _rawStream:FileStream;
		private var _currentChunk:uint = 0;
		private var _currentSize:Number = 0;
		private var _maxChunkSize:Number = 200 * 1024 * 1024; // 200MB

		// Buffering for ordering
		private var _buffer:Vector.<TraceRecord> = new Vector.<TraceRecord>();
		private var _bufferFlushTimer:uint = 0;

		// UI callback
		private var _onRecordCallback:Function;

		// Constants
		private static const FLUSH_INTERVAL:uint = 100; // ms

		public function TraceLogger()
		{
			if (_instance != null)
			{
				throw new Error("TraceLogger is singleton. Use TraceLogger.instance");
			}
		}

		public static function get instance():TraceLogger
		{
			if (_instance == null)
			{
				_instance = new TraceLogger();
			}
			return _instance;
		}

		/**
		 * Initialize the trace logger
		 */
		public function init():void
		{
			if (_initialized)
			{
				return;
			}

			_startTime = new Date().time;
			_sessionId = formatDate(new Date()) + "_" + Math.floor(Math.random() * 10000);
			_pid = String(Math.floor(Math.random() * 100000));

			// Create logs directory
			var logsDir:File = File.applicationStorageDirectory.resolvePath("logs");
			if (!logsDir.exists)
			{
				logsDir.createDirectory();
			}

			// Initialize log files
			openLogFiles();

			// Write session start marker
			logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "APP_START",
				cmd: "SESSION_START",
				notes: [
					"TraceLogger initialized",
					"Session ID: " + _sessionId,
					"PID: " + _pid,
					"Start time: " + new Date().toString()
				]
			});

			_initialized = true;

			trace("[TraceLogger] Initialized. Logs: " + _logFile.nativePath);
		}

		private function formatDate(date:Date):String
		{
			function pad(n:Number):String
			{
				return n < 10 ? "0" + n : String(n);
			}

			return date.fullYear +
				pad(date.month + 1) +
				pad(date.date) + "_" +
				pad(date.hours) +
				pad(date.minutes) +
				pad(date.seconds);
		}

		private function openLogFiles():void
		{
			var logsDir:File = File.applicationStorageDirectory.resolvePath("logs");
			var baseName:String = "session_" + _sessionId + "_" + _pid;

			if (_currentChunk > 0)
			{
				baseName += "_chunk" + _currentChunk;
			}

			_logFile = logsDir.resolvePath(baseName + ".ndjson");
			_rawFile = logsDir.resolvePath(baseName + ".raw");

			// Open streams
			_stream = new FileStream();
			_stream.open(_logFile, FileMode.APPEND);

			_rawStream = new FileStream();
			_rawStream.open(_rawFile, FileMode.APPEND);

			_currentSize = _logFile.exists ? _logFile.size : 0;
		}

		/**
		 * Log a trace record
		 * @param data Partial record data (will be completed with timestamps, seq, etc.)
		 */
		public function logRecord(data:Object):void
		{
			if (!_initialized)
			{
				init();
			}

			var record:TraceRecord = new TraceRecord();
			record.t_ms = new Date().time;
			record.mono_ms = getTimer();
			record.seq = _seq++;
			record.thread = "main"; // AS3 is single-threaded, but may add Worker support
			record.frame = 0; // TODO: track frame count if needed

			// Merge provided data
			for (var key:String in data)
			{
				record[key] = data[key];
			}

			// Add to buffer for ordered flushing
			_buffer.push(record);

			// Trigger flush (debounced)
			clearTimeout(_bufferFlushTimer);
			_bufferFlushTimer = setTimeout(flushBuffer, FLUSH_INTERVAL);

			// Notify UI
			if (_onRecordCallback != null)
			{
				_onRecordCallback(record);
			}
		}

		/**
		 * Flush buffered records to disk in order
		 */
		private function flushBuffer():void
		{
			if (_buffer.length == 0)
			{
				return;
			}

			// Sort by sequence to ensure strict ordering
			_buffer.sort(function(a:TraceRecord, b:TraceRecord):Number
			{
				return a.seq - b.seq;
			});

			for each (var record:TraceRecord in _buffer)
			{
				writeRecord(record);
			}

			_buffer.length = 0;

			// Flush to disk
			if (_stream)
			{
				_stream.flush();
			}
			if (_rawStream)
			{
				_rawStream.flush();
			}
		}

		private function writeRecord(record:TraceRecord):void
		{
			// Check if we need to rotate to next chunk
			if (_currentSize >= _maxChunkSize)
			{
				rotateChunk();
			}

			// Convert record to JSON
			var json:String = recordToJSON(record);
			var line:String = json + "\n";
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(line);

			// Write to file
			var byteOffset:Number = _stream.position;
			_stream.writeUTFBytes(line);

			_currentSize += bytes.length;

			// Update record with file metadata
			record.file = {
				name: _logFile.name,
				chunk: _currentChunk,
				byteOffset: byteOffset
			};
		}

		private function rotateChunk():void
		{
			// Close current streams
			if (_stream)
			{
				_stream.close();
			}
			if (_rawStream)
			{
				_rawStream.close();
			}

			// Increment chunk
			_currentChunk++;
			_currentSize = 0;

			// Open new files
			openLogFiles();

			trace("[TraceLogger] Rotated to chunk " + _currentChunk);
		}

		/**
		 * Convert TraceRecord to NDJSON format
		 * NO TRUNCATION - full depth serialization
		 */
		private function recordToJSON(record:TraceRecord):String
		{
			var obj:Object = {};

			// Copy all fields
			obj.t_ms = record.t_ms;
			obj.mono_ms = record.mono_ms;
			obj.seq = record.seq;
			obj.thread = record.thread;
			obj.frame = record.frame;
			obj.source = record.source;
			obj.dir = record.dir;
			obj.phase = record.phase;
			obj.cmd = record.cmd;
			obj.rid = record.rid;
			obj.sn = record.sn;
			obj.ts = record.ts;
			obj.correlation_id = record.correlation_id;
			obj.user = record.user;
			obj.room = record.room;
			obj.raw = record.raw;
			obj.decoded = record.decoded;
			obj.client_transform = record.client_transform;
			obj.state_diff = record.state_diff;
			obj.checkpoints = record.checkpoints;
			obj.data_sources = record.data_sources;
			obj.notes = record.notes;
			obj.file = record.file;

			// Deep serialize with NO truncation
			return DeepSerializer.serialize(obj);
		}

		/**
		 * Write raw bytes to .raw file and return reference
		 */
		public function writeRawBytes(bytes:ByteArray, label:String = ""):Object
		{
			if (!_initialized)
			{
				init();
			}

			var offset:Number = _rawStream.position;

			bytes.position = 0;
			_rawStream.writeBytes(bytes, 0, bytes.length);
			_rawStream.flush();

			return {
				type: "raw_reference",
				file: _rawFile.name,
				offset: offset,
				length: bytes.length,
				label: label
			};
		}

		/**
		 * Set callback for UI updates
		 */
		public function setRecordCallback(callback:Function):void
		{
			_onRecordCallback = callback;
		}

		/**
		 * Force flush all pending records
		 */
		public function flush():void
		{
			flushBuffer();
		}

		/**
		 * Shutdown and cleanup
		 */
		public function shutdown():void
		{
			logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "APP_EXIT",
				cmd: "SESSION_END",
				notes: [
					"TraceLogger shutting down",
					"Total records: " + _seq,
					"End time: " + new Date().toString()
				]
			});

			flushBuffer();

			if (_stream)
			{
				_stream.close();
				_stream = null;
			}

			if (_rawStream)
			{
				_rawStream.close();
				_rawStream = null;
			}

			_initialized = false;

			trace("[TraceLogger] Shutdown complete. Total records: " + _seq);
		}

		/**
		 * Get log directory for UI access
		 */
		public function getLogDirectory():File
		{
			return File.applicationStorageDirectory.resolvePath("logs");
		}

		/**
		 * Get current log file
		 */
		public function getCurrentLogFile():File
		{
			return _logFile;
		}
	}
}
