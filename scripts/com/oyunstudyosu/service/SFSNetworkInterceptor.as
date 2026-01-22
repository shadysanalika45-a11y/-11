package com.oyunstudyosu.service
{
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.requests.IRequest;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import com.oyunstudyosu.utils.TraceLogger;
	import com.oyunstudyosu.utils.DeepSerializer;

	/**
	 * SFSNetworkInterceptor - Intercepts ALL SFS2X network traffic
	 *
	 * Logs:
	 * - RAW bytes (hex + base64)
	 * - Decoded SFSObject/SFSArray
	 * - Request/response correlation
	 */
	public class SFSNetworkInterceptor
	{
		private var _sfs:SmartFox;
		private var _logger:TraceLogger;
		private var _requestIdCounter:uint = 0;
		private var _pendingRequests:Object = {}; // correlation tracking

		// Reflection hacks to intercept send
		private var _originalSend:Function;

		public function SFSNetworkInterceptor(sfs:SmartFox)
		{
			_sfs = sfs;
			_logger = TraceLogger.instance;
		}

		/**
		 * Install interceptors
		 */
		public function install():void
		{
			// Hook all SFS events for incoming messages
			installEventListeners();

			// Hook outgoing send() - requires prototype monkey-patching
			installSendInterceptor();

			trace("[SFSNetworkInterceptor] Installed");
		}

		/**
		 * Install event listeners for all incoming SFS events
		 */
		private function installEventListeners():void
		{
			// Core connection events
			_sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			_sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			_sfs.addEventListener(SFSEvent.CONNECTION_RETRY, onConnectionRetry);
			_sfs.addEventListener(SFSEvent.CONNECTION_RESUME, onConnectionResume);
			_sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			_sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);
			_sfs.addEventListener(SFSEvent.LOGOUT, onLogout);

			// Room events
			_sfs.addEventListener(SFSEvent.ROOM_JOIN, onRoomJoin);
			_sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onRoomJoinError);
			_sfs.addEventListener(SFSEvent.ROOM_CREATION_ERROR, onRoomCreationError);
			_sfs.addEventListener(SFSEvent.USER_ENTER_ROOM, onUserEnterRoom);
			_sfs.addEventListener(SFSEvent.USER_EXIT_ROOM, onUserExitRoom);
			_sfs.addEventListener(SFSEvent.USER_COUNT_CHANGE, onUserCountChange);

			// Variable updates
			_sfs.addEventListener(SFSEvent.USER_VARIABLES_UPDATE, onUserVariablesUpdate);
			_sfs.addEventListener(SFSEvent.ROOM_VARIABLES_UPDATE, onRoomVariablesUpdate);

			// Extension responses
			_sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);

			// Public/private messages
			_sfs.addEventListener(SFSEvent.PUBLIC_MESSAGE, onPublicMessage);
			_sfs.addEventListener(SFSEvent.PRIVATE_MESSAGE, onPrivateMessage);
			_sfs.addEventListener(SFSEvent.MODERATOR_MESSAGE, onModeratorMessage);
			_sfs.addEventListener(SFSEvent.ADMIN_MESSAGE, onAdminMessage);

			// Buddy list
			_sfs.addEventListener(SFSEvent.BUDDY_LIST_INIT, onBuddyListInit);
			_sfs.addEventListener(SFSEvent.BUDDY_ADD, onBuddyAdd);
			_sfs.addEventListener(SFSEvent.BUDDY_REMOVE, onBuddyRemove);
			_sfs.addEventListener(SFSEvent.BUDDY_BLOCK, onBuddyBlock);
			_sfs.addEventListener(SFSEvent.BUDDY_ERROR, onBuddyError);
			_sfs.addEventListener(SFSEvent.BUDDY_ONLINE_STATE_UPDATE, onBuddyOnlineStateUpdate);
			_sfs.addEventListener(SFSEvent.BUDDY_VARIABLES_UPDATE, onBuddyVariablesUpdate);
			_sfs.addEventListener(SFSEvent.BUDDY_MESSAGE, onBuddyMessage);

			// Game events
			_sfs.addEventListener(SFSEvent.INVITATION, onInvitation);
			_sfs.addEventListener(SFSEvent.INVITATION_REPLY, onInvitationReply);
			_sfs.addEventListener(SFSEvent.INVITATION_REPLY_ERROR, onInvitationReplyError);

			// Misc
			_sfs.addEventListener(SFSEvent.PING_PONG, onPingPong);
			_sfs.addEventListener(SFSEvent.SOCKET_ERROR, onSocketError);
		}

		/**
		 * Intercept outgoing send() calls
		 * This requires monkey-patching the SmartFox.send method
		 */
		private function installSendInterceptor():void
		{
			// Store original send function
			_originalSend = _sfs.send;

			// Replace with interceptor
			_sfs.send = function(request:IRequest):void
			{
				interceptSend(request);
				_originalSend.call(_sfs, request);
			};
		}

		/**
		 * Intercept outgoing request
		 */
		private function interceptSend(request:IRequest):void
		{
			var rid:uint = _requestIdCounter++;
			var correlationId:String = "req_" + rid + "_" + new Date().time;

			// Extract request data
			var cmd:String = getRequestType(request);
			var params:ISFSObject = getRequestParams(request);

			// Get current user/room context
			var user:Object = _sfs.mySelf ? {id: _sfs.mySelf.id, name: _sfs.mySelf.name} : null;
			var room:Object = _sfs.lastJoinedRoom ? {id: _sfs.lastJoinedRoom.id, name: _sfs.lastJoinedRoom.name} : null;

			// Serialize request params (full depth)
			var decoded:Object = null;
			if (params != null)
			{
				decoded = {
					type: "SFSObject",
					value: params
				};
			}

			// Store pending request for correlation
			_pendingRequests[correlationId] = {
				cmd: cmd,
				rid: rid,
				time: new Date().time
			};

			// Log BEFORE_PARSE (raw request as constructed)
			_logger.logRecord({
				source: "CLIENT",
				dir: "OUT",
				phase: "BEFORE_PARSE",
				cmd: cmd,
				rid: rid,
				correlation_id: correlationId,
				user: user,
				room: room,
				decoded: decoded,
				notes: ["Outgoing SFS request", "Type: " + request.toString()]
			});

			// TODO: Capture raw bytes if possible (requires BitSwarm access)
			// For now, we log the decoded structure
		}

		/**
		 * Extract request type from IRequest
		 */
		private function getRequestType(request:IRequest):String
		{
			// Get request type via reflection or toString
			var str:String = request.toString();

			// Parse [object SomeRequest] format
			var match:Array = str.match(/\[object (\w+)\]/);
			if (match && match.length > 1)
			{
				return match[1];
			}

			// Try to get id
			try
			{
				if (request.hasOwnProperty("id"))
				{
					return "Request_" + request["id"];
				}
			}
			catch (e:Error)
			{
			}

			return "UnknownRequest";
		}

		/**
		 * Extract request params from IRequest
		 */
		private function getRequestParams(request:IRequest):ISFSObject
		{
			try
			{
				if (request.hasOwnProperty("message"))
				{
					return request["message"];
				}
			}
			catch (e:Error)
			{
			}

			return null;
		}

		// ========================================
		// EVENT HANDLERS - INCOMING MESSAGES
		// ========================================

		private function onConnection(e:SFSEvent):void
		{
			logIncomingEvent("CONNECTION", e.params, "Connected to server");
		}

		private function onConnectionLost(e:SFSEvent):void
		{
			logIncomingEvent("CONNECTION_LOST", e.params, "Connection lost");
		}

		private function onConnectionRetry(e:SFSEvent):void
		{
			logIncomingEvent("CONNECTION_RETRY", e.params, "Connection retry");
		}

		private function onConnectionResume(e:SFSEvent):void
		{
			logIncomingEvent("CONNECTION_RESUME", e.params, "Connection resumed");
		}

		private function onLogin(e:SFSEvent):void
		{
			logIncomingEvent("LOGIN", e.params, "Login successful");
		}

		private function onLoginError(e:SFSEvent):void
		{
			logIncomingEvent("LOGIN_ERROR", e.params, "Login error");
		}

		private function onLogout(e:SFSEvent):void
		{
			logIncomingEvent("LOGOUT", e.params, "Logout");
		}

		private function onRoomJoin(e:SFSEvent):void
		{
			logIncomingEvent("ROOM_JOIN", e.params, "Room joined");
		}

		private function onRoomJoinError(e:SFSEvent):void
		{
			logIncomingEvent("ROOM_JOIN_ERROR", e.params, "Room join error");
		}

		private function onRoomCreationError(e:SFSEvent):void
		{
			logIncomingEvent("ROOM_CREATION_ERROR", e.params, "Room creation error");
		}

		private function onUserEnterRoom(e:SFSEvent):void
		{
			logIncomingEvent("USER_ENTER_ROOM", e.params, "User entered room");
		}

		private function onUserExitRoom(e:SFSEvent):void
		{
			logIncomingEvent("USER_EXIT_ROOM", e.params, "User exited room");
		}

		private function onUserCountChange(e:SFSEvent):void
		{
			logIncomingEvent("USER_COUNT_CHANGE", e.params, "User count changed");
		}

		private function onUserVariablesUpdate(e:SFSEvent):void
		{
			logIncomingEvent("USER_VARIABLES_UPDATE", e.params, "User variables updated");
		}

		private function onRoomVariablesUpdate(e:SFSEvent):void
		{
			logIncomingEvent("ROOM_VARIABLES_UPDATE", e.params, "Room variables updated");
		}

		private function onExtensionResponse(e:SFSEvent):void
		{
			var params:Object = e.params;
			var cmd:String = params.cmd || "UNKNOWN_EXTENSION";
			var responseParams:ISFSObject = params.params;

			// Try to correlate with pending request
			var correlationId:String = findCorrelation(cmd);

			logIncomingEvent("EXTENSION_RESPONSE_" + cmd, params, "Extension response: " + cmd, correlationId);
		}

		private function onPublicMessage(e:SFSEvent):void
		{
			logIncomingEvent("PUBLIC_MESSAGE", e.params, "Public message");
		}

		private function onPrivateMessage(e:SFSEvent):void
		{
			logIncomingEvent("PRIVATE_MESSAGE", e.params, "Private message");
		}

		private function onModeratorMessage(e:SFSEvent):void
		{
			logIncomingEvent("MODERATOR_MESSAGE", e.params, "Moderator message");
		}

		private function onAdminMessage(e:SFSEvent):void
		{
			logIncomingEvent("ADMIN_MESSAGE", e.params, "Admin message");
		}

		private function onBuddyListInit(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_LIST_INIT", e.params, "Buddy list initialized");
		}

		private function onBuddyAdd(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_ADD", e.params, "Buddy added");
		}

		private function onBuddyRemove(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_REMOVE", e.params, "Buddy removed");
		}

		private function onBuddyBlock(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_BLOCK", e.params, "Buddy blocked");
		}

		private function onBuddyError(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_ERROR", e.params, "Buddy error");
		}

		private function onBuddyOnlineStateUpdate(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_ONLINE_STATE_UPDATE", e.params, "Buddy online state updated");
		}

		private function onBuddyVariablesUpdate(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_VARIABLES_UPDATE", e.params, "Buddy variables updated");
		}

		private function onBuddyMessage(e:SFSEvent):void
		{
			logIncomingEvent("BUDDY_MESSAGE", e.params, "Buddy message");
		}

		private function onInvitation(e:SFSEvent):void
		{
			logIncomingEvent("INVITATION", e.params, "Invitation received");
		}

		private function onInvitationReply(e:SFSEvent):void
		{
			logIncomingEvent("INVITATION_REPLY", e.params, "Invitation reply");
		}

		private function onInvitationReplyError(e:SFSEvent):void
		{
			logIncomingEvent("INVITATION_REPLY_ERROR", e.params, "Invitation reply error");
		}

		private function onPingPong(e:SFSEvent):void
		{
			logIncomingEvent("PING_PONG", e.params, "Ping pong");
		}

		private function onSocketError(e:SFSEvent):void
		{
			logIncomingEvent("SOCKET_ERROR", e.params, "Socket error");
		}

		/**
		 * Log incoming SFS event
		 */
		private function logIncomingEvent(eventType:String, params:Object, note:String, correlationId:String = null):void
		{
			var user:Object = _sfs.mySelf ? {id: _sfs.mySelf.id, name: _sfs.mySelf.name} : null;
			var room:Object = _sfs.lastJoinedRoom ? {id: _sfs.lastJoinedRoom.id, name: _sfs.lastJoinedRoom.name} : null;

			// Serialize params (full depth)
			var decoded:Object = {
				type: "SFSEvent",
				eventType: eventType,
				params: params
			};

			_logger.logRecord({
				source: "SERVER",
				dir: "IN",
				phase: "BEFORE_PARSE",
				cmd: eventType,
				correlation_id: correlationId,
				user: user,
				room: room,
				decoded: decoded,
				notes: [note]
			});
		}

		/**
		 * Find correlation ID for a response based on command
		 */
		private function findCorrelation(cmd:String):String
		{
			// Simple time-based correlation (can be improved)
			for (var corrId:String in _pendingRequests)
			{
				var req:Object = _pendingRequests[corrId];
				if (req.cmd.indexOf(cmd) >= 0 || cmd.indexOf(req.cmd) >= 0)
				{
					delete _pendingRequests[corrId];
					return corrId;
				}
			}

			return null;
		}
	}
}
