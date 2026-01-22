package com.oyunstudyosu.trace.interceptors
{
	import com.oyunstudyosu.assets.AssetModel;
	import com.oyunstudyosu.assets.AssetRequest;
	import com.oyunstudyosu.trace.TraceLogger;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * AssetLoadingInterceptor - Tracks all asset loading
	 *
	 * Logs:
	 * - Asset request (URL/path requested)
	 * - Asset resolution (actual source: local/remote/cache)
	 * - Embedded class/symbol resolution
	 * - Load success/failure
	 * - VF/IFILE data sources
	 */
	public class AssetLoadingInterceptor
	{
		private var _assetModel:AssetModel;
		private var _logger:TraceLogger;
		private var _assetIdCounter:uint = 0;

		// Store original methods
		private var _originalRequest:Function;

		public function AssetLoadingInterceptor(assetModel:AssetModel)
		{
			_assetModel = assetModel;
			_logger = TraceLogger.instance;
		}

		/**
		 * Install interceptors
		 */
		public function install():void
		{
			// Store original request method
			_originalRequest = _assetModel.request;

			// Replace with interceptor
			_assetModel.request = interceptRequest;

			trace("[AssetLoadingInterceptor] Installed");
		}

		/**
		 * Intercept asset request
		 */
		private function interceptRequest(assetRequest:AssetRequest):void
		{
			var assetTraceId:uint = _assetIdCounter++;

			// Log asset request
			_logger.logRecord({
				source: "CLIENT",
				dir: "OUT",
				phase: "BEFORE_PARSE",
				cmd: "ASSET_REQUEST",
				rid: assetTraceId,
				decoded: {
					type: "AssetRequest",
					assetId: assetRequest.assetId,
					assetType: assetRequest.type,
					priority: assetRequest.priority,
					url: constructAssetURL(assetRequest)
				},
				data_sources: [{
					type: "asset_request",
					assetId: assetRequest.assetId,
					assetType: assetRequest.type,
					requested_at: new Date().time
				}],
				notes: ["Asset requested: " + assetRequest.assetId]
			});

			// Wrap callbacks to track completion
			var originalLoadedFunction:Function = assetRequest.loadedFunction;
			var originalErrorFunction:Function = assetRequest.errorFunction;

			assetRequest.loadedFunction = function(loader:*):void
			{
				logAssetLoaded(assetRequest, assetTraceId, loader, true);

				if (originalLoadedFunction != null)
				{
					originalLoadedFunction(loader);
				}
			};

			assetRequest.errorFunction = function(event:*):void
			{
				logAssetLoaded(assetRequest, assetTraceId, event, false);

				if (originalErrorFunction != null)
				{
					originalErrorFunction(event);
				}
			};

			// Call original
			_originalRequest.call(_assetModel, assetRequest);
		}

		/**
		 * Log asset load completion
		 */
		private function logAssetLoaded(assetRequest:AssetRequest, assetTraceId:uint, result:*, success:Boolean):void
		{
			var resolvedSource:String = "unknown";
			var className:String = null;
			var bytes:uint = 0;

			if (success && result is Loader)
			{
				var loader:Loader = result as Loader;
				if (loader.contentLoaderInfo)
				{
					resolvedSource = loader.contentLoaderInfo.url;
					bytes = loader.contentLoaderInfo.bytesLoaded;

					// Try to get class name for embedded symbols
					try
					{
						if (loader.content)
						{
							className = flash.utils.getQualifiedClassName(loader.content);
						}
					}
					catch (e:Error)
					{
					}
				}
			}

			_logger.logRecord({
				source: "CLIENT",
				dir: "IN",
				phase: "AFTER_APPLY",
				cmd: "ASSET_LOADED",
				rid: assetTraceId,
				decoded: {
					type: "AssetLoaded",
					assetId: assetRequest.assetId,
					assetType: assetRequest.type,
					success: success,
					resolvedSource: resolvedSource,
					className: className,
					bytes: bytes,
					error: success ? null : String(result)
				},
				data_sources: [{
					type: "asset_loaded",
					assetId: assetRequest.assetId,
					source: resolvedSource,
					className: className,
					bytes: bytes,
					loaded_at: new Date().time
				}],
				notes: [
					success ? "Asset loaded successfully" : "Asset load failed",
					"AssetId: " + assetRequest.assetId,
					"Source: " + resolvedSource
				]
			});
		}

		/**
		 * Construct asset URL from request
		 */
		private function constructAssetURL(assetRequest:AssetRequest):String
		{
			// This depends on AssetModel implementation
			// Basic reconstruction:
			var root:String = _assetModel.hasOwnProperty("ROOT") ? _assetModel["ROOT"] : "";
			return root + assetRequest.assetId;
		}

		/**
		 * Log VF/IFILE data sources
		 * Call this manually when parsing VF/IFILE tools data
		 */
		public function logDataSource(sourceType:String, sourceData:Object):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "BEFORE_PARSE",
				cmd: "DATA_SOURCE_PARSED",
				decoded: {
					type: sourceType,
					data: sourceData
				},
				data_sources: [{
					type: sourceType,
					data: sourceData,
					parsed_at: new Date().time
				}],
				notes: ["Data source parsed: " + sourceType]
			});
		}

		/**
		 * Log embedded class resolution
		 */
		public function logClassResolution(requestedAsset:String, className:String, success:Boolean, error:String = null):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "INTERNAL",
				phase: "AFTER_PARSE",
				cmd: "CLASS_RESOLUTION",
				decoded: {
					type: "ClassResolution",
					requestedAsset: requestedAsset,
					resolvedClass: className,
					success: success,
					error: error
				},
				data_sources: [{
					type: "class_resolution",
					requestedAsset: requestedAsset,
					className: className,
					success: success,
					resolved_at: new Date().time
				}],
				notes: [
					success ? "Class resolved" : "Class resolution failed",
					"Asset: " + requestedAsset,
					"Class: " + (className || "null"),
					error ? "Error: " + error : ""
				]
			});
		}
	}
}
