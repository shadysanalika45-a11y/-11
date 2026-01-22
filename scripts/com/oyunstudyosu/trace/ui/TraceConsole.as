package com.oyunstudyosu.trace.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	import com.oyunstudyosu.trace.TraceLogger;
	import com.oyunstudyosu.trace.TraceRecord;

	/**
	 * TraceConsole - UI viewer for trace events
	 *
	 * Features:
	 * - Live event stream (one-line summaries)
	 * - Details panel (full record view)
	 * - Open log file at offset
	 * - Toggle visibility with hotkey
	 * - Auto-scroll
	 */
	public class TraceConsole extends Sprite
	{
		private var _background:Sprite;
		private var _listContainer:Sprite;
		private var _listTextField:TextField;
		private var _detailsPanel:Sprite;
		private var _detailsTextField:TextField;
		private var _openLogButton:Sprite;
		private var _clearButton:Sprite;
		private var _closeButton:Sprite;

		private var _logger:TraceLogger;
		private var _visible:Boolean = false;
		private var _records:Vector.<TraceRecord> = new Vector.<TraceRecord>();
		private var _maxRecords:uint = 1000;

		private var _width:Number = 1000;
		private var _height:Number = 600;

		public function TraceConsole()
		{
			_logger = TraceLogger.instance;

			// Set up UI
			createUI();

			// Register callback
			_logger.setRecordCallback(onRecordAdded);

			// Hide by default
			this.visible = false;

			// Listen for hotkey (Ctrl+Shift+T)
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}

		private function onAddedToStage(e:flash.events.Event):void
		{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}

		private function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function createUI():void
		{
			// Background
			_background = new Sprite();
			_background.graphics.beginFill(0x000000, 0.9);
			_background.graphics.drawRect(0, 0, _width, _height);
			_background.graphics.endFill();
			addChild(_background);

			// Title
			var title:TextField = createTextField("TRACE CONSOLE (Ctrl+Shift+T to toggle)", 14, true);
			title.x = 10;
			title.y = 5;
			title.width = 400;
			addChild(title);

			// Open log button
			_openLogButton = createButton("Open Log File", 650, 5, 120, 20);
			_openLogButton.addEventListener(MouseEvent.CLICK, onOpenLogClick);
			addChild(_openLogButton);

			// Clear button
			_clearButton = createButton("Clear", 780, 5, 80, 20);
			_clearButton.addEventListener(MouseEvent.CLICK, onClearClick);
			addChild(_clearButton);

			// Close button
			_closeButton = createButton("X", _width - 30, 5, 20, 20);
			_closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
			addChild(_closeButton);

			// List container
			_listContainer = new Sprite();
			_listContainer.x = 5;
			_listContainer.y = 35;
			addChild(_listContainer);

			var listBg:Sprite = new Sprite();
			listBg.graphics.beginFill(0x1a1a1a);
			listBg.graphics.drawRect(0, 0, _width - 10, _height - 40);
			listBg.graphics.endFill();
			_listContainer.addChild(listBg);

			// List text field
			_listTextField = createTextField("", 10, false);
			_listTextField.x = 5;
			_listTextField.y = 5;
			_listTextField.width = _width - 20;
			_listTextField.height = _height - 50;
			_listTextField.wordWrap = false;
			_listTextField.multiline = true;
			_listTextField.selectable = true;
			_listContainer.addChild(_listTextField);

			// Instructions
			appendToList("=== TRACE CONSOLE READY ===");
			appendToList("Events will appear here in real-time");
			appendToList("Click 'Open Log File' to view full NDJSON logs");
			appendToList("================================");
		}

		private function createTextField(text:String, size:uint, bold:Boolean):TextField
		{
			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Courier New";
			format.size = size;
			format.color = 0x00FF00;
			format.bold = bold;

			tf.defaultTextFormat = format;
			tf.text = text;
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;

			return tf;
		}

		private function createButton(label:String, x:Number, y:Number, w:Number, h:Number):Sprite
		{
			var btn:Sprite = new Sprite();
			btn.graphics.beginFill(0x333333);
			btn.graphics.lineStyle(1, 0x666666);
			btn.graphics.drawRect(0, 0, w, h);
			btn.graphics.endFill();
			btn.x = x;
			btn.y = y;
			btn.buttonMode = true;

			var tf:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font = "Arial";
			format.size = 11;
			format.color = 0xFFFFFF;
			format.align = "center";
			tf.defaultTextFormat = format;
			tf.text = label;
			tf.width = w;
			tf.height = h;
			tf.y = 2;
			tf.selectable = false;
			tf.mouseEnabled = false;
			btn.addChild(tf);

			return btn;
		}

		private function onRecordAdded(record:TraceRecord):void
		{
			// Add to records list
			_records.push(record);

			// Trim if too many
			if (_records.length > _maxRecords)
			{
				_records.shift();
			}

			// Add summary line to display
			var summary:String = formatRecordSummary(record);
			appendToList(summary);
		}

		private function formatRecordSummary(record:TraceRecord):String
		{
			var time:String = formatTime(record.t_ms);
			var seq:String = "[" + record.seq + "]";
			var dir:String = record.source + "/" + record.dir;
			var cmd:String = record.cmd || "UNKNOWN";

			// Build one-line summary
			var summary:String = time + " " + seq + " " + dir.substr(0, 10) + " " + cmd;

			// Add relevant details
			if (record.notes && record.notes.length > 0)
			{
				summary += " | " + record.notes[0];
			}

			return summary;
		}

		private function formatTime(ms:Number):String
		{
			var date:Date = new Date(ms);
			return pad(date.hours) + ":" + pad(date.minutes) + ":" + pad(date.seconds) + "." + pad(date.milliseconds, 3);
		}

		private function pad(n:Number, len:uint = 2):String
		{
			var str:String = String(n);
			while (str.length < len)
			{
				str = "0" + str;
			}
			return str;
		}

		private function appendToList(text:String):void
		{
			if (!_visible)
			{
				return; // Don't update if not visible (performance)
			}

			_listTextField.appendText(text + "\n");

			// Auto-scroll to bottom
			_listTextField.scrollV = _listTextField.maxScrollV;
		}

		private function onKeyDown(e:KeyboardEvent):void
		{
			// Ctrl+Shift+T
			if (e.ctrlKey && e.shiftKey && e.keyCode == Keyboard.T)
			{
				toggleVisibility();
			}
		}

		private function toggleVisibility():void
		{
			_visible = !_visible;
			this.visible = _visible;

			if (_visible)
			{
				// Refresh display
				refreshList();
			}
		}

		private function refreshList():void
		{
			_listTextField.text = "";

			// Show last N records
			var start:int = Math.max(0, _records.length - 100);
			for (var i:int = start; i < _records.length; i++)
			{
				var summary:String = formatRecordSummary(_records[i]);
				_listTextField.appendText(summary + "\n");
			}

			_listTextField.scrollV = _listTextField.maxScrollV;
		}

		private function onOpenLogClick(e:MouseEvent):void
		{
			try
			{
				var logFile:File = _logger.getCurrentLogFile();
				if (logFile && logFile.exists)
				{
					logFile.openWithDefaultApplication();
				}
				else
				{
					trace("[TraceConsole] Log file not found");
				}
			}
			catch (err:Error)
			{
				trace("[TraceConsole] Error opening log: " + err.message);
			}
		}

		private function onClearClick(e:MouseEvent):void
		{
			_listTextField.text = "";
			appendToList("=== CLEARED ===");
		}

		private function onCloseClick(e:MouseEvent):void
		{
			toggleVisibility();
		}

		/**
		 * Show console programmatically
		 */
		public function show():void
		{
			_visible = true;
			this.visible = true;
			refreshList();
		}

		/**
		 * Hide console programmatically
		 */
		public function hide():void
		{
			_visible = false;
			this.visible = false;
		}
	}
}
