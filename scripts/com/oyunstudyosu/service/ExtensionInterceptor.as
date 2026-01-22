package com.oyunstudyosu.service
{
	import com.oyunstudyosu.service.ServiceModel;
	import com.oyunstudyosu.utils.TraceLogger;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.core.SFSEvent;

	/**
	 * ExtensionInterceptor - Intercepts extension requests/responses
	 *
	 * Hooks into ServiceModel to log:
	 * - Extension requests (BEFORE_PARSE)
	 * - Extension responses (BEFORE_PARSE, AFTER_PARSE, BEFORE_APPLY, AFTER_APPLY)
	 * - Client transformations
	 * - State changes
	 */
	public class ExtensionInterceptor
	{
		private var _serviceModel:ServiceModel;
		private var _logger:TraceLogger;
		private var _requestIdCounter:uint = 0;
		private var _pendingRequests:Object = {}; // cmd -> correlation_id

		// Store original methods
		private var _originalRequestData:Function;
		private var _originalOnExtensionResponse:Function;

		public function ExtensionInterceptor(serviceModel:ServiceModel)
		{
			_serviceModel = serviceModel;
			_logger = TraceLogger.instance;
		}

		/**
		 * Install interceptors
		 */
		public function install():void
		{
			// Store original methods
			_originalRequestData = _serviceModel.requestData;
			_originalOnExtensionResponse = _serviceModel["onExtensionResponse"];

			// Replace with interceptors
			_serviceModel.requestData = interceptRequestData;

			// Note: onExtensionResponse is protected, so we hook via listenExtension instead
			// Install a global extension listener that fires BEFORE any others
			hookExtensionResponse();

			trace("[ExtensionInterceptor] Installed");
		}

		/**
		 * Intercept extension request
		 */
		private function interceptRequestData(cmd:String, params:Object, callback:Function, room:* = null):void
		{
			var rid:uint = _requestIdCounter++;
			var correlationId:String = "ext_" + cmd + "_" + rid + "_" + new Date().time;

			// Store for correlation
			_pendingRequests[cmd] = correlationId;

			// Get context
			var user:Object = _serviceModel.sfs.mySelf ?
				{id: _serviceModel.sfs.mySelf.id, name: _serviceModel.sfs.mySelf.name} : null;
			var roomObj:Object = _serviceModel.sfs.lastJoinedRoom ?
				{id: _serviceModel.sfs.lastJoinedRoom.id, name: _serviceModel.sfs.lastJoinedRoom.name} : null;

			// Log BEFORE_PARSE (client constructs request)
			_logger.logRecord({
				source: "CLIENT",
				dir: "OUT",
				phase: "BEFORE_PARSE",
				cmd: "EXTENSION_REQUEST_" + cmd,
				rid: rid,
				correlation_id: correlationId,
				user: user,
				room: roomObj,
				decoded: {
					type: "ExtensionRequest",
					cmd: cmd,
					params: params
				},
				notes: ["Extension request: " + cmd]
			});

			// Call original
			_originalRequestData.call(_serviceModel, cmd, params, function(response:Object):void
			{
				// Log AFTER_APPLY (final callback)
				logExtensionCallback(cmd, response, correlationId, user, roomObj);

				// Call original callback
				if (callback != null)
				{
					callback(response);
				}
			}, room);
		}

		/**
		 * Hook extension response via event listener
		 */
		private function hookExtensionResponse():void
		{
			// Add listener with highest priority (executes first)
			_serviceModel.sfs.addEventListener("extensionResponse", onExtensionResponseBefore, false, 1000);
		}

		/**
		 * Extension response interceptor (BEFORE processing)
		 */
		private function onExtensionResponseBefore(event:SFSEvent):void
		{
			var cmd:String = event.params.cmd;
			var params:ISFSObject = event.params.params;
			var correlationId:String = _pendingRequests[cmd];

			// Get context
			var user:Object = _serviceModel.sfs.mySelf ?
				{id: _serviceModel.sfs.mySelf.id, name: _serviceModel.sfs.mySelf.name} : null;
			var room:Object = _serviceModel.sfs.lastJoinedRoom ?
				{id: _serviceModel.sfs.lastJoinedRoom.id, name: _serviceModel.sfs.lastJoinedRoom.name} : null;

			// Convert to plain object
			var paramsObj:Object = params ? params.toObject() : null;

			// Log BEFORE_PARSE (raw response from server)
			_logger.logRecord({
				source: "SERVER",
				dir: "IN",
				phase: "BEFORE_PARSE",
				cmd: "EXTENSION_RESPONSE_" + cmd,
				correlation_id: correlationId,
				user: user,
				room: room,
				decoded: {
					type: "ExtensionResponse",
					cmd: cmd,
					params: paramsObj
				},
				notes: [
					"Extension response: " + cmd,
					paramsObj && paramsObj.errorCode ? "Error: " + paramsObj.errorCode : "Success"
				]
			});

			// Log AFTER_PARSE (same as BEFORE in this case, unless we add custom parsing)
			_logger.logRecord({
				source: "SERVER",
				dir: "IN",
				phase: "AFTER_PARSE",
				cmd: "EXTENSION_RESPONSE_" + cmd,
				correlation_id: correlationId,
				user: user,
				room: room,
				decoded: {
					type: "ExtensionResponse",
					cmd: cmd,
					params: paramsObj
				},
				client_transform: {
					before: paramsObj,
					after: paramsObj // Will be overridden if client transforms
				}
			});
		}

		/**
		 * Log extension callback (AFTER_APPLY phase)
		 */
		private function logExtensionCallback(cmd:String, response:Object, correlationId:String, user:Object, room:Object):void
		{
			_logger.logRecord({
				source: "CLIENT",
				dir: "IN",
				phase: "AFTER_APPLY",
				cmd: "EXTENSION_CALLBACK_" + cmd,
				correlation_id: correlationId,
				user: user,
				room: room,
				decoded: {
					type: "ExtensionCallback",
					cmd: cmd,
					response: response
				},
				notes: ["Extension callback executed: " + cmd]
			});

			// Clean up pending request
			delete _pendingRequests[cmd];
		}
	}
}
