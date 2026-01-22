package com.oyunstudyosu.utils
{
	import com.oyunstudyosu.utils.TraceLogger;
	import com.oyunstudyosu.service.SFSNetworkInterceptor;
	import com.oyunstudyosu.service.ExtensionInterceptor;
	import com.oyunstudyosu.assets.AssetLoadingInterceptor;
	import com.oyunstudyosu.avatar.AvatarCheckpoints;
	import com.oyunstudyosu.debug.TraceConsole;
	import com.oyunstudyosu.service.ServiceModel;
	import com.oyunstudyosu.assets.AssetModel;
	import com.smartfoxserver.v2.SmartFox;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	/**
	 * TraceManager - Central manager for trace/logging system
	 *
	 * Initializes and coordinates:
	 * - TraceLogger (core)
	 * - SFSNetworkInterceptor
	 * - ExtensionInterceptor
	 * - AssetLoadingInterceptor
	 * - AvatarCheckpoints
	 * - TraceConsole (UI)
	 */
	public class TraceManager
	{
		private static var _instance:TraceManager;
		private static var _initialized:Boolean = false;

		private var _logger:TraceLogger;
		private var _sfsInterceptor:SFSNetworkInterceptor;
		private var _extensionInterceptor:ExtensionInterceptor;
		private var _assetInterceptor:AssetLoadingInterceptor;
		private var _avatarCheckpoints:AvatarCheckpoints;
		private var _traceConsole:TraceConsole;

		public function TraceManager()
		{
			if (_instance != null)
			{
				throw new Error("TraceManager is singleton. Use TraceManager.instance");
			}
		}

		public static function get instance():TraceManager
		{
			if (_instance == null)
			{
				_instance = new TraceManager();
			}
			return _instance;
		}

		/**
		 * Initialize the trace system
		 *
		 * @param sfs SmartFox instance
		 * @param serviceModel ServiceModel instance
		 * @param assetModel AssetModel instance
		 * @param uiContainer Container for TraceConsole UI
		 */
		public function init(sfs:SmartFox, serviceModel:ServiceModel, assetModel:AssetModel, uiContainer:DisplayObjectContainer):void
		{
			if (_initialized)
			{
				trace("[TraceManager] Already initialized");
				return;
			}

			trace("[TraceManager] Initializing trace system...");

			// Initialize core logger
			_logger = TraceLogger.instance;
			_logger.init();

			// Log system init
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "APP_START",
				cmd: "TRACE_SYSTEM_INIT",
				notes: [
					"Trace system initializing",
					"TraceManager version 1.0",
					"Full non-lossy trace enabled"
				]
			});

			// Initialize interceptors
			if (sfs)
			{
				_sfsInterceptor = new SFSNetworkInterceptor(sfs);
				_sfsInterceptor.install();

				_logger.logRecord({
					source: "CLIENT",
					dir: "INTERNAL",
					phase: "AFTER_APPLY",
					cmd: "INTERCEPTOR_INSTALLED",
					notes: ["SFSNetworkInterceptor installed"]
				});
			}
			else
			{
				trace("[TraceManager] Warning: SmartFox instance not provided");
			}

			if (serviceModel)
			{
				_extensionInterceptor = new ExtensionInterceptor(serviceModel);
				_extensionInterceptor.install();

				_logger.logRecord({
					source: "CLIENT",
					dir: "INTERNAL",
					phase: "AFTER_APPLY",
					cmd: "INTERCEPTOR_INSTALLED",
					notes: ["ExtensionInterceptor installed"]
				});
			}
			else
			{
				trace("[TraceManager] Warning: ServiceModel instance not provided");
			}

			if (assetModel)
			{
				_assetInterceptor = new AssetLoadingInterceptor(assetModel);
				_assetInterceptor.install();

				_logger.logRecord({
					source: "CLIENT",
					dir: "INTERNAL",
					phase: "AFTER_APPLY",
					cmd: "INTERCEPTOR_INSTALLED",
					notes: ["AssetLoadingInterceptor installed"]
				});
			}
			else
			{
				trace("[TraceManager] Warning: AssetModel instance not provided");
			}

			// Initialize avatar checkpoints
			_avatarCheckpoints = new AvatarCheckpoints();

			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_APPLY",
				cmd: "CHECKPOINTS_INITIALIZED",
				notes: ["AvatarCheckpoints initialized"]
			});

			// Initialize UI console
			if (uiContainer)
			{
				_traceConsole = new TraceConsole();
				uiContainer.addChild(_traceConsole);

				_logger.logRecord({
					source: "CLIENT",
					dir: "INTERNAL",
					phase: "AFTER_APPLY",
					cmd: "UI_INITIALIZED",
					notes: ["TraceConsole UI initialized", "Hotkey: Ctrl+Shift+T"]
				});
			}
			else
			{
				trace("[TraceManager] Warning: UI container not provided");
			}

			// Log completion
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_APPLY",
				cmd: "TRACE_SYSTEM_READY",
				notes: [
					"Trace system fully initialized",
					"All interceptors installed",
					"Logging to: " + _logger.getCurrentLogFile().nativePath
				]
			});

			_initialized = true;

			trace("[TraceManager] Trace system ready. Logs: " + _logger.getCurrentLogFile().nativePath);
			trace("[TraceManager] Press Ctrl+Shift+T to open trace console");
		}

		/**
		 * Get avatar checkpoints (for manual logging)
		 */
		public function get avatarCheckpoints():AvatarCheckpoints
		{
			return _avatarCheckpoints;
		}

		/**
		 * Get asset interceptor (for manual logging)
		 */
		public function get assetInterceptor():AssetLoadingInterceptor
		{
			return _assetInterceptor;
		}

		/**
		 * Get logger (for manual logging)
		 */
		public function get logger():TraceLogger
		{
			return _logger;
		}

		/**
		 * Get trace console (for programmatic control)
		 */
		public function get traceConsole():TraceConsole
		{
			return _traceConsole;
		}

		/**
		 * Shutdown and cleanup
		 */
		public function shutdown():void
		{
			if (!_initialized)
			{
				return;
			}

			trace("[TraceManager] Shutting down trace system...");

			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "APP_EXIT",
				cmd: "TRACE_SYSTEM_SHUTDOWN",
				notes: ["Trace system shutting down"]
			});

			_logger.shutdown();

			_initialized = false;

			trace("[TraceManager] Trace system shutdown complete");
		}
	}
}
