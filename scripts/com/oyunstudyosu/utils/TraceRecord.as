package com.oyunstudyosu.utils
{
	/**
	 * TraceRecord - Structure for a single trace event
	 * Follows NDJSON schema specified in requirements
	 */
	public class TraceRecord
	{
		// Timing
		public var t_ms:Number = 0;           // Wall clock time (milliseconds since epoch)
		public var mono_ms:Number = 0;        // Monotonic time (getTimer)
		public var seq:uint = 0;              // Sequence number (incrementing)
		public var thread:String = "main";    // Thread/task ID
		public var frame:uint = 0;            // Frame number if applicable

		// Direction
		public var source:String;             // "CLIENT" | "SERVER"
		public var dir:String;                // "IN" | "OUT" | "INTERNAL"
		public var phase:String;              // "BEFORE_PARSE" | "AFTER_PARSE" | "BEFORE_APPLY" | "AFTER_APPLY" | "APP_START" | etc.

		// Message identification
		public var cmd:String;                // Command/event name
		public var rid:uint = 0;              // Request ID
		public var sn:uint = 0;               // Sequence number from server
		public var ts:uint = 0;               // Timestamp from server
		public var correlation_id:String;     // Request->Response correlation

		// Context
		public var user:Object;               // {id, name}
		public var room:Object;               // {id, name}

		// Data
		public var raw:Object;                // {hex, b64, len} - raw bytes
		public var decoded:Object;            // {type, value} - decoded structure
		public var client_transform:Object;   // {before, after} - client transformations
		public var state_diff:Object;         // State changes applied

		// Special tracking
		public var checkpoints:Object;        // {AVATAR_RENDER_CHECKLIST, CLOTHES_APPLY_RESULT, etc.}
		public var data_sources:Array;        // Asset/data source tracking
		public var notes:Array;               // Additional notes/comments

		// File metadata
		public var file:Object;               // {name, chunk, byteOffset}

		public function TraceRecord()
		{
			user = {};
			room = {};
			raw = {};
			decoded = {};
			client_transform = {};
			state_diff = {};
			checkpoints = {};
			data_sources = [];
			notes = [];
			file = {};
		}
	}
}
