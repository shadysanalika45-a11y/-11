package com.smartfoxserver.v2.controllers
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.bitswarm.BaseController;
   import com.smartfoxserver.v2.bitswarm.BitSwarmClient;
   import com.smartfoxserver.v2.bitswarm.IMessage;
   import com.smartfoxserver.v2.core.SFSBuddyEvent;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.Buddy;
   import com.smartfoxserver.v2.entities.IMMOItem;
   import com.smartfoxserver.v2.entities.MMOItem;
   import com.smartfoxserver.v2.entities.MMORoom;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.SFSBuddy;
   import com.smartfoxserver.v2.entities.SFSRoom;
   import com.smartfoxserver.v2.entities.SFSUser;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.entities.invitation.Invitation;
   import com.smartfoxserver.v2.entities.invitation.SFSInvitation;
   import com.smartfoxserver.v2.entities.managers.IRoomManager;
   import com.smartfoxserver.v2.entities.managers.IUserManager;
   import com.smartfoxserver.v2.entities.managers.SFSGlobalUserManager;
   import com.smartfoxserver.v2.entities.variables.BuddyVariable;
   import com.smartfoxserver.v2.entities.variables.IMMOItemVariable;
   import com.smartfoxserver.v2.entities.variables.MMOItemVariable;
   import com.smartfoxserver.v2.entities.variables.ReservedBuddyVariables;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   import com.smartfoxserver.v2.entities.variables.SFSBuddyVariable;
   import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
   import com.smartfoxserver.v2.entities.variables.SFSUserVariable;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   import com.smartfoxserver.v2.kernel;
   import com.smartfoxserver.v2.requests.BaseRequest;
   import com.smartfoxserver.v2.requests.ChangeRoomCapacityRequest;
   import com.smartfoxserver.v2.requests.ChangeRoomNameRequest;
   import com.smartfoxserver.v2.requests.ChangeRoomPasswordStateRequest;
   import com.smartfoxserver.v2.requests.CreateRoomRequest;
   import com.smartfoxserver.v2.requests.FindRoomsRequest;
   import com.smartfoxserver.v2.requests.FindUsersRequest;
   import com.smartfoxserver.v2.requests.GenericMessageRequest;
   import com.smartfoxserver.v2.requests.GenericMessageType;
   import com.smartfoxserver.v2.requests.JoinRoomRequest;
   import com.smartfoxserver.v2.requests.LoginRequest;
   import com.smartfoxserver.v2.requests.LogoutRequest;
   import com.smartfoxserver.v2.requests.PlayerToSpectatorRequest;
   import com.smartfoxserver.v2.requests.SetRoomVariablesRequest;
   import com.smartfoxserver.v2.requests.SetUserVariablesRequest;
   import com.smartfoxserver.v2.requests.SpectatorToPlayerRequest;
   import com.smartfoxserver.v2.requests.SubscribeRoomGroupRequest;
   import com.smartfoxserver.v2.requests.UnsubscribeRoomGroupRequest;
   import com.smartfoxserver.v2.requests.buddylist.AddBuddyRequest;
   import com.smartfoxserver.v2.requests.buddylist.BlockBuddyRequest;
   import com.smartfoxserver.v2.requests.buddylist.GoOnlineRequest;
   import com.smartfoxserver.v2.requests.buddylist.InitBuddyListRequest;
   import com.smartfoxserver.v2.requests.buddylist.RemoveBuddyRequest;
   import com.smartfoxserver.v2.requests.buddylist.SetBuddyVariablesRequest;
   import com.smartfoxserver.v2.requests.game.InviteUsersRequest;
   import com.smartfoxserver.v2.requests.mmo.SetMMOItemVariables;
   import com.smartfoxserver.v2.requests.mmo.SetUserPositionRequest;
   import com.smartfoxserver.v2.util.BuddyOnlineState;
   import com.smartfoxserver.v2.util.ClientDisconnectionReason;
   import com.smartfoxserver.v2.util.SFSErrorCodes;
   
   use namespace kernel;
   
   public class SystemController extends BaseController
   {
      
      private var sfs:SmartFox;
      
      private var bitSwarm:BitSwarmClient;
      
      private var requestHandlers:Object;
      
      public function SystemController(param1:BitSwarmClient)
      {
         super(param1);
         this.bitSwarm = param1;
         this.sfs = param1.sfs;
         this.requestHandlers = new Object();
         this.initRequestHandlers();
      }
      
      private function initRequestHandlers() : void
      {
         this.requestHandlers[BaseRequest.Handshake] = {
            "name":"Handshake",
            "handler":this["fnHandshake"]
         };
         this.requestHandlers[BaseRequest.Login] = {
            "name":"Login",
            "handler":this["fnLogin"]
         };
         this.requestHandlers[BaseRequest.Logout] = {
            "name":"Logout",
            "handler":this["fnLogout"]
         };
         this.requestHandlers[BaseRequest.JoinRoom] = {
            "name":"JoinRoom",
            "handler":this["fnJoinRoom"]
         };
         this.requestHandlers[BaseRequest.CreateRoom] = {
            "name":"CreateRoom",
            "handler":this["fnCreateRoom"]
         };
         this.requestHandlers[BaseRequest.GenericMessage] = {
            "name":"GenericMessage",
            "handler":this["fnGenericMessage"]
         };
         this.requestHandlers[BaseRequest.ChangeRoomName] = {
            "name":"ChangeRoomName",
            "handler":this["fnChangeRoomName"]
         };
         this.requestHandlers[BaseRequest.ChangeRoomPassword] = {
            "name":"ChangeRoomPassword",
            "handler":this["fnChangeRoomPassword"]
         };
         this.requestHandlers[BaseRequest.ChangeRoomCapacity] = {
            "name":"ChangeRoomCapacity",
            "handler":this["fnChangeRoomCapacity"]
         };
         this.requestHandlers[BaseRequest.SetRoomVariables] = {
            "name":"SetRoomVariables",
            "handler":this["fnSetRoomVariables"]
         };
         this.requestHandlers[BaseRequest.SetUserVariables] = {
            "name":"SetUserVariables",
            "handler":this["fnSetUserVariables"]
         };
         this.requestHandlers[BaseRequest.SubscribeRoomGroup] = {
            "name":"SubscribeRoomGroup",
            "handler":this["fnSubscribeRoomGroup"]
         };
         this.requestHandlers[BaseRequest.UnsubscribeRoomGroup] = {
            "name":"UnsubscribeRoomGroup",
            "handler":this["fnUnsubscribeRoomGroup"]
         };
         this.requestHandlers[BaseRequest.SpectatorToPlayer] = {
            "name":"SpectatorToPlayer",
            "handler":this["fnSpectatorToPlayer"]
         };
         this.requestHandlers[BaseRequest.PlayerToSpectator] = {
            "name":"PlayerToSpectator",
            "handler":this["fnPlayerToSpectator"]
         };
         this.requestHandlers[BaseRequest.InitBuddyList] = {
            "name":"InitBuddyList",
            "handler":this["fnInitBuddyList"]
         };
         this.requestHandlers[BaseRequest.AddBuddy] = {
            "name":"AddBuddy",
            "handler":this["fnAddBuddy"]
         };
         this.requestHandlers[BaseRequest.RemoveBuddy] = {
            "name":"RemoveBuddy",
            "handler":this["fnRemoveBuddy"]
         };
         this.requestHandlers[BaseRequest.BlockBuddy] = {
            "name":"BlockBuddy",
            "handler":this["fnBlockBuddy"]
         };
         this.requestHandlers[BaseRequest.GoOnline] = {
            "name":"GoOnline",
            "handler":this["fnGoOnline"]
         };
         this.requestHandlers[BaseRequest.SetBuddyVariables] = {
            "name":"SetBuddyVariables",
            "handler":this["fnSetBuddyVariables"]
         };
         this.requestHandlers[BaseRequest.FindRooms] = {
            "name":"FindRooms",
            "handler":this["fnFindRooms"]
         };
         this.requestHandlers[BaseRequest.FindUsers] = {
            "name":"FindUsers",
            "handler":this["fnFindUsers"]
         };
         this.requestHandlers[BaseRequest.InviteUser] = {
            "name":"InviteUser",
            "handler":this["fnInviteUsers"]
         };
         this.requestHandlers[BaseRequest.InvitationReply] = {
            "name":"InvitationReply",
            "handler":this["fnInvitationReply"]
         };
         this.requestHandlers[BaseRequest.QuickJoinGame] = {
            "name":"QuickJoinGame",
            "handler":this["fnQuickJoinGame"]
         };
         this.requestHandlers[BaseRequest.PingPong] = {
            "name":"PingPong",
            "handler":this["fnPingPong"]
         };
         this.requestHandlers[BaseRequest.SetUserPosition] = {
            "name":"SetUserPosition",
            "handler":this["fnSetUserPosition"]
         };
         this.requestHandlers[1000] = {
            "name":"UserEnterRoom",
            "handler":this["fnUserEnterRoom"]
         };
         this.requestHandlers[1001] = {
            "name":"UserCountChange",
            "handler":this["fnUserCountChange"]
         };
         this.requestHandlers[1002] = {
            "name":"UserLost",
            "handler":this["fnUserLost"]
         };
         this.requestHandlers[1003] = {
            "name":"RoomLost",
            "handler":this["fnRoomLost"]
         };
         this.requestHandlers[1004] = {
            "name":"UserExitRoom",
            "handler":this["fnUserExitRoom"]
         };
         this.requestHandlers[1005] = {
            "name":"ClientDisconnection",
            "handler":this["fnClientDisconnection"]
         };
         this.requestHandlers[1006] = {
            "name":"ReconnectionFailure",
            "handler":this["fnReconnectionFailure"]
         };
         this.requestHandlers[1007] = {
            "name":"SetMMOItemVariables",
            "handler":this["fnSetMMOItemVariables"]
         };
      }
      
      override public function handleMessage(param1:IMessage) : void
      {
         var _loc2_:Object = this.requestHandlers[param1.id];
         if(_loc2_ != null)
         {
            if(this.sfs.debug)
            {
               log.info(_loc2_.name + ", " + param1);
            }
            _loc2_.handler(param1);
         }
         else
         {
            log.warn("Unknown message id: " + param1.id);
         }
      }
      
      kernel function addRequestHandler(param1:int, param2:Object) : void
      {
         this.requestHandlers[param1] = param2;
      }
      
      private function fnHandshake(param1:IMessage) : void
      {
         var _loc2_:Object = {"message":param1};
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.HANDSHAKE,_loc2_));
      }
      
      private function fnLogin(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         if(_loc4_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            this.populateRoomList(_loc4_.getSFSArray(LoginRequest.KEY_ROOMLIST));
            this.sfs.mySelf = new SFSUser(_loc4_.getInt(LoginRequest.KEY_ID),_loc4_.getUtfString(LoginRequest.KEY_USER_NAME),true);
            this.sfs.mySelf.userManager = this.sfs.userManager;
            this.sfs.mySelf.privilegeId = _loc4_.getShort(LoginRequest.KEY_PRIVILEGE_ID);
            this.sfs.userManager.addUser(this.sfs.mySelf);
            this.sfs.setReconnectionSeconds(_loc4_.getShort(LoginRequest.KEY_RECONNECTION_SECONDS));
            _loc5_.zone = _loc4_.getUtfString(LoginRequest.KEY_ZONE_NAME);
            _loc5_.user = this.sfs.mySelf;
            _loc5_.data = _loc4_.getSFSObject(LoginRequest.KEY_PARAMS);
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.LOGIN,_loc5_));
         }
         else
         {
            _loc2_ = _loc4_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc3_ = SFSErrorCodes.getErrorMessage(_loc2_,_loc4_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc5_ = {
               "errorMessage":_loc3_,
               "errorCode":_loc2_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.LOGIN_ERROR,_loc5_));
         }
      }
      
      private function fnCreateRoom(param1:IMessage) : void
      {
         var _loc2_:IRoomManager = null;
         var _loc3_:Room = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = this.sfs.roomManager;
            _loc3_ = SFSRoom.fromSFSArray(_loc6_.getSFSArray(CreateRoomRequest.KEY_ROOM));
            _loc3_.roomManager = this.sfs.roomManager;
            _loc2_.addRoom(_loc3_);
            _loc7_.room = _loc3_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_ADD,_loc7_));
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_CREATION_ERROR,_loc7_));
         }
      }
      
      private function fnJoinRoom(param1:IMessage) : void
      {
         var _loc2_:ISFSArray = null;
         var _loc3_:ISFSArray = null;
         var _loc4_:Room = null;
         var _loc5_:int = 0;
         var _loc6_:ISFSArray = null;
         var _loc7_:User = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:IRoomManager = this.sfs.roomManager;
         var _loc11_:ISFSObject = param1.content;
         var _loc12_:Object = {};
         this.sfs.isJoining = false;
         if(_loc11_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc11_.getSFSArray(JoinRoomRequest.KEY_ROOM);
            _loc3_ = _loc11_.getSFSArray(JoinRoomRequest.KEY_USER_LIST);
            _loc4_ = SFSRoom.fromSFSArray(_loc2_);
            _loc4_.roomManager = this.sfs.roomManager;
            _loc4_ = _loc10_.replaceRoom(_loc4_,_loc10_.containsGroup(_loc4_.groupId));
            _loc5_ = 0;
            while(_loc5_ < _loc3_.size())
            {
               _loc6_ = _loc3_.getSFSArray(_loc5_);
               _loc7_ = this.getOrCreateUser(_loc6_,true,_loc4_);
               _loc7_.setPlayerId(_loc6_.getShort(3),_loc4_);
               _loc4_.addUser(_loc7_);
               _loc5_++;
            }
            _loc4_.isJoined = true;
            this.sfs.lastJoinedRoom = _loc4_;
            _loc12_.room = _loc4_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_JOIN,_loc12_));
         }
         else
         {
            _loc8_ = _loc11_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc9_ = SFSErrorCodes.getErrorMessage(_loc8_,_loc11_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc12_ = {
               "errorMessage":_loc9_,
               "errorCode":_loc8_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_JOIN_ERROR,_loc12_));
         }
      }
      
      private function fnUserEnterRoom(param1:IMessage) : void
      {
         var _loc2_:ISFSArray = null;
         var _loc3_:User = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         var _loc6_:Room = this.sfs.roomManager.getRoomById(_loc4_.getInt("r"));
         if(_loc6_ != null)
         {
            _loc2_ = _loc4_.getSFSArray("u");
            _loc3_ = this.getOrCreateUser(_loc2_,true,_loc6_);
            _loc6_.addUser(_loc3_);
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_ENTER_ROOM,{
               "user":_loc3_,
               "room":_loc6_
            }));
         }
      }
      
      private function fnUserCountChange(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         var _loc6_:Room = this.sfs.roomManager.getRoomById(_loc4_.getInt("r"));
         if(_loc6_ != null)
         {
            _loc2_ = _loc4_.getShort("uc");
            _loc3_ = 0;
            if(_loc4_.containsKey("sc"))
            {
               _loc3_ = _loc4_.getShort("sc");
            }
            _loc6_.userCount = _loc2_;
            _loc6_.spectatorCount = _loc3_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_COUNT_CHANGE,{
               "room":_loc6_,
               "uCount":_loc2_,
               "sCount":_loc3_
            }));
         }
      }
      
      private function fnUserLost(param1:IMessage) : void
      {
         var _loc2_:Array = null;
         var _loc3_:SFSGlobalUserManager = null;
         var _loc4_:Room = null;
         var _loc5_:ISFSObject = param1.content;
         var _loc6_:int = _loc5_.getInt("u");
         var _loc7_:User = this.sfs.userManager.getUserById(_loc6_);
         if(_loc7_ != null)
         {
            _loc2_ = this.sfs.roomManager.getUserRooms(_loc7_);
            this.sfs.roomManager.removeUser(_loc7_);
            _loc3_ = this.sfs.userManager as SFSGlobalUserManager;
            _loc3_.removeUserReference(_loc7_,true);
            for each(_loc4_ in _loc2_)
            {
               this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_EXIT_ROOM,{
                  "user":_loc7_,
                  "room":_loc4_
               }));
            }
         }
      }
      
      private function fnRoomLost(param1:IMessage) : void
      {
         var _loc2_:User = null;
         var _loc3_:ISFSObject = param1.content;
         var _loc4_:Object = {};
         var _loc5_:int = _loc3_.getInt("r");
         var _loc6_:Room = this.sfs.roomManager.getRoomById(_loc5_);
         var _loc7_:IUserManager = this.sfs.userManager;
         if(_loc6_ != null)
         {
            this.sfs.roomManager.removeRoom(_loc6_);
            for each(_loc2_ in _loc6_.userList)
            {
               _loc7_.removeUser(_loc2_);
            }
            _loc4_.room = _loc6_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_REMOVE,_loc4_));
         }
      }
      
      private function checkIfIamLastPlayer(param1:Room) : Boolean
      {
         var _loc2_:int = param1.isGame ? int(param1.userCount + param1.spectatorCount) : int(param1.userCount);
         return _loc2_ == 1 && param1.containsUser(this.sfs.mySelf);
      }
      
      private function fnGenericMessage(param1:IMessage) : void
      {
         var _loc2_:ISFSObject = param1.content;
         var _loc3_:int = _loc2_.getByte(GenericMessageRequest.KEY_MESSAGE_TYPE);
         switch(_loc3_)
         {
            case GenericMessageType.PUBLIC_MSG:
               this.handlePublicMessage(_loc2_);
               break;
            case GenericMessageType.PRIVATE_MSG:
               this.handlePrivateMessage(_loc2_);
               break;
            case GenericMessageType.BUDDY_MSG:
               this.handleBuddyMessage(_loc2_);
               break;
            case GenericMessageType.MODERATOR_MSG:
               this.handleModMessage(_loc2_);
               break;
            case GenericMessageType.ADMING_MSG:
               this.handleAdminMessage(_loc2_);
               break;
            case GenericMessageType.OBJECT_MSG:
               this.handleObjectMessage(_loc2_);
         }
      }
      
      private function handlePublicMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = param1.getInt(GenericMessageRequest.KEY_ROOM_ID);
         var _loc4_:Room = this.sfs.roomManager.getRoomById(_loc3_);
         if(_loc4_ != null)
         {
            _loc2_.room = _loc4_;
            _loc2_.sender = this.sfs.userManager.getUserById(param1.getInt(GenericMessageRequest.KEY_USER_ID));
            _loc2_.message = param1.getUtfString(GenericMessageRequest.KEY_MESSAGE);
            _loc2_.data = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.PUBLIC_MESSAGE,_loc2_));
         }
         else
         {
            log.warn("Unexpected, PublicMessage target room doesn\'t exist. RoomId: " + _loc3_);
         }
      }
      
      public function handlePrivateMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = param1.getInt(GenericMessageRequest.KEY_USER_ID);
         var _loc4_:User = this.sfs.userManager.getUserById(_loc3_);
         if(_loc4_ == null)
         {
            if(!param1.containsKey(GenericMessageRequest.KEY_SENDER_DATA))
            {
               log.warn("Unexpected. Private message has no Sender details!");
               return;
            }
            _loc4_ = SFSUser.fromSFSArray(param1.getSFSArray(GenericMessageRequest.KEY_SENDER_DATA));
         }
         _loc2_.sender = _loc4_;
         _loc2_.message = param1.getUtfString(GenericMessageRequest.KEY_MESSAGE);
         _loc2_.data = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.PRIVATE_MESSAGE,_loc2_));
      }
      
      public function handleBuddyMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = param1.getInt(GenericMessageRequest.KEY_USER_ID);
         var _loc4_:Buddy = this.sfs.buddyManager.getBuddyById(_loc3_);
         _loc2_.isItMe = this.sfs.mySelf.id == _loc3_;
         _loc2_.buddy = _loc4_;
         _loc2_.message = param1.getUtfString(GenericMessageRequest.KEY_MESSAGE);
         _loc2_.data = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
         this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_MESSAGE,_loc2_));
      }
      
      public function handleModMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         _loc2_.sender = SFSUser.fromSFSArray(param1.getSFSArray(GenericMessageRequest.KEY_SENDER_DATA));
         _loc2_.message = param1.getUtfString(GenericMessageRequest.KEY_MESSAGE);
         _loc2_.data = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.MODERATOR_MESSAGE,_loc2_));
      }
      
      public function handleAdminMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         _loc2_.sender = SFSUser.fromSFSArray(param1.getSFSArray(GenericMessageRequest.KEY_SENDER_DATA));
         _loc2_.message = param1.getUtfString(GenericMessageRequest.KEY_MESSAGE);
         _loc2_.data = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ADMIN_MESSAGE,_loc2_));
      }
      
      public function handleObjectMessage(param1:ISFSObject) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = param1.getInt(GenericMessageRequest.KEY_USER_ID);
         _loc2_.sender = this.sfs.userManager.getUserById(_loc3_);
         _loc2_.message = param1.getSFSObject(GenericMessageRequest.KEY_XTRA_PARAMS);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.OBJECT_MESSAGE,_loc2_));
      }
      
      private function fnUserExitRoom(param1:IMessage) : void
      {
         var _loc2_:ISFSObject = param1.content;
         var _loc3_:Object = {};
         var _loc4_:int = _loc2_.getInt("r");
         var _loc5_:int = _loc2_.getInt("u");
         var _loc6_:Room = this.sfs.roomManager.getRoomById(_loc4_);
         var _loc7_:User = this.sfs.userManager.getUserById(_loc5_);
         if(_loc6_ != null && _loc7_ != null)
         {
            _loc6_.removeUser(_loc7_);
            this.sfs.userManager.removeUser(_loc7_);
            if(_loc7_.isItMe && _loc6_.isJoined)
            {
               _loc6_.isJoined = false;
               if(this.sfs.joinedRooms.length == 0)
               {
                  this.sfs.lastJoinedRoom = null;
               }
               if(!_loc6_.isManaged)
               {
                  this.sfs.roomManager.removeRoom(_loc6_);
               }
            }
            _loc3_.user = _loc7_;
            _loc3_.room = _loc6_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_EXIT_ROOM,_loc3_));
         }
         else
         {
            log.debug("Failed to handle UserExit event. Room: " + _loc6_ + ", User: " + _loc7_);
         }
      }
      
      private function fnClientDisconnection(param1:IMessage) : void
      {
         var _loc2_:ISFSObject = param1.content;
         var _loc3_:int = _loc2_.getByte("dr");
         this.sfs.kernel::handleClientDisconnection(ClientDisconnectionReason.getReason(_loc3_));
      }
      
      private function fnReconnectionFailure(param1:IMessage) : void
      {
         this.sfs.kernel::handleReconnectionFailure();
      }
      
      private function fnSetRoomVariables(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:RoomVariable = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         var _loc6_:int = _loc4_.getInt(SetRoomVariablesRequest.KEY_VAR_ROOM);
         var _loc7_:ISFSArray = _loc4_.getSFSArray(SetRoomVariablesRequest.KEY_VAR_LIST);
         var _loc8_:Room = this.sfs.roomManager.getRoomById(_loc6_);
         var _loc9_:Array = [];
         if(_loc8_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc7_.size())
            {
               _loc3_ = SFSRoomVariable.fromSFSArray(_loc7_.getSFSArray(_loc2_));
               _loc8_.setVariable(_loc3_);
               _loc9_.push(_loc3_.name);
               _loc2_++;
            }
            _loc5_.changedVars = _loc9_;
            _loc5_.room = _loc8_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_VARIABLES_UPDATE,_loc5_));
         }
         else
         {
            log.warn("RoomVariablesUpdate, unknown Room id = " + _loc6_);
         }
      }
      
      private function fnSetUserVariables(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UserVariable = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         var _loc6_:int = _loc4_.getInt(SetUserVariablesRequest.KEY_USER);
         var _loc7_:ISFSArray = _loc4_.getSFSArray(SetUserVariablesRequest.KEY_VAR_LIST);
         var _loc8_:User = this.sfs.userManager.getUserById(_loc6_);
         var _loc9_:Array = [];
         if(_loc8_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc7_.size())
            {
               _loc3_ = SFSUserVariable.fromSFSArray(_loc7_.getSFSArray(_loc2_));
               _loc8_.setVariable(_loc3_);
               _loc9_.push(_loc3_.name);
               _loc2_++;
            }
            _loc5_.changedVars = _loc9_;
            _loc5_.user = _loc8_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_VARIABLES_UPDATE,_loc5_));
         }
         else
         {
            log.warn("UserVariablesUpdate: unknown user id = " + _loc6_);
         }
      }
      
      private function fnSubscribeRoomGroup(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:ISFSArray = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getUtfString(SubscribeRoomGroupRequest.KEY_GROUP_ID);
            _loc3_ = _loc6_.getSFSArray(SubscribeRoomGroupRequest.KEY_ROOM_LIST);
            if(this.sfs.roomManager.containsGroup(_loc2_))
            {
               log.warn("SubscribeGroup Error. Group:",_loc2_,"already subscribed!");
            }
            this.sfs.roomManager.addGroup(_loc2_);
            this.populateRoomList(_loc3_);
            _loc7_.groupId = _loc2_;
            _loc7_.newRooms = this.sfs.roomManager.getRoomListFromGroup(_loc2_);
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_GROUP_SUBSCRIBE,_loc7_));
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_GROUP_SUBSCRIBE_ERROR,_loc7_));
         }
      }
      
      private function fnUnsubscribeRoomGroup(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:ISFSObject = param1.content;
         var _loc6_:Object = {};
         if(_loc5_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc5_.getUtfString(UnsubscribeRoomGroupRequest.KEY_GROUP_ID);
            if(!this.sfs.roomManager.containsGroup(_loc2_))
            {
               log.warn("UnsubscribeGroup Error. Group:",_loc2_,"is not subscribed!");
            }
            this.sfs.roomManager.removeGroup(_loc2_);
            _loc6_.groupId = _loc2_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_GROUP_UNSUBSCRIBE,_loc6_));
         }
         else
         {
            _loc3_ = _loc5_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc4_ = SFSErrorCodes.getErrorMessage(_loc3_,_loc5_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc6_ = {
               "errorMessage":_loc4_,
               "errorCode":_loc3_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_GROUP_UNSUBSCRIBE_ERROR,_loc6_));
         }
      }
      
      private function fnChangeRoomName(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Room = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getInt(ChangeRoomNameRequest.KEY_ROOM);
            _loc3_ = this.sfs.roomManager.getRoomById(_loc2_);
            if(_loc3_ != null)
            {
               _loc7_.oldName = _loc3_.name;
               this.sfs.roomManager.changeRoomName(_loc3_,_loc6_.getUtfString(ChangeRoomNameRequest.KEY_NAME));
               _loc7_.room = _loc3_;
               this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_NAME_CHANGE,_loc7_));
            }
            else
            {
               log.warn("Room not found, ID:",_loc2_,", Room name change failed.");
            }
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_NAME_CHANGE_ERROR,_loc7_));
         }
      }
      
      private function fnChangeRoomPassword(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Room = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getInt(ChangeRoomPasswordStateRequest.KEY_ROOM);
            _loc3_ = this.sfs.roomManager.getRoomById(_loc2_);
            if(_loc3_ != null)
            {
               this.sfs.roomManager.changeRoomPasswordState(_loc3_,_loc6_.getBool(ChangeRoomPasswordStateRequest.KEY_PASS));
               _loc7_.room = _loc3_;
               this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_PASSWORD_STATE_CHANGE,_loc7_));
            }
            else
            {
               log.warn("Room not found, ID:",_loc2_,", Room password change failed.");
            }
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_PASSWORD_STATE_CHANGE_ERROR,_loc7_));
         }
      }
      
      private function fnChangeRoomCapacity(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Room = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getInt(ChangeRoomCapacityRequest.KEY_ROOM);
            _loc3_ = this.sfs.roomManager.getRoomById(_loc2_);
            if(_loc3_ != null)
            {
               this.sfs.roomManager.changeRoomCapacity(_loc3_,_loc6_.getInt(ChangeRoomCapacityRequest.KEY_USER_SIZE),_loc6_.getInt(ChangeRoomCapacityRequest.KEY_SPEC_SIZE));
               _loc7_.room = _loc3_;
               this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_CAPACITY_CHANGE,_loc7_));
            }
            else
            {
               log.warn("Room not found, ID:",_loc2_,", Room capacity change failed.");
            }
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_CAPACITY_CHANGE_ERROR,_loc7_));
         }
      }
      
      private function fnLogout(param1:IMessage) : void
      {
         this.sfs.kernel::handleLogout();
         var _loc2_:ISFSObject = param1.content;
         var _loc3_:Object = {};
         _loc3_.zoneName = _loc2_.getUtfString(LogoutRequest.KEY_ZONE_NAME);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.LOGOUT,_loc3_));
      }
      
      private function fnSpectatorToPlayer(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:User = null;
         var _loc6_:Room = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:ISFSObject = param1.content;
         var _loc10_:Object = {};
         if(_loc9_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc9_.getInt(SpectatorToPlayerRequest.KEY_ROOM_ID);
            _loc3_ = _loc9_.getInt(SpectatorToPlayerRequest.KEY_USER_ID);
            _loc4_ = _loc9_.getShort(SpectatorToPlayerRequest.KEY_PLAYER_ID);
            _loc5_ = this.sfs.userManager.getUserById(_loc3_);
            _loc6_ = this.sfs.roomManager.getRoomById(_loc2_);
            if(_loc6_ != null)
            {
               if(_loc5_ != null)
               {
                  if(_loc5_.isJoinedInRoom(_loc6_))
                  {
                     _loc5_.setPlayerId(_loc4_,_loc6_);
                     _loc10_.room = _loc6_;
                     _loc10_.user = _loc5_;
                     _loc10_.playerId = _loc4_;
                     this.sfs.dispatchEvent(new SFSEvent(SFSEvent.SPECTATOR_TO_PLAYER,_loc10_));
                  }
                  else
                  {
                     log.warn("User: " + _loc5_ + " not joined in Room: ",_loc6_,", SpectatorToPlayer failed.");
                  }
               }
               else
               {
                  log.warn("User not found, ID:",_loc3_,", SpectatorToPlayer failed.");
               }
            }
            else
            {
               log.warn("Room not found, ID:",_loc2_,", SpectatorToPlayer failed.");
            }
         }
         else
         {
            _loc7_ = _loc9_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc8_ = SFSErrorCodes.getErrorMessage(_loc7_,_loc9_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc10_ = {
               "errorMessage":_loc8_,
               "errorCode":_loc7_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.SPECTATOR_TO_PLAYER_ERROR,_loc10_));
         }
      }
      
      private function fnPlayerToSpectator(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:User = null;
         var _loc5_:Room = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:ISFSObject = param1.content;
         var _loc9_:Object = {};
         if(_loc8_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc8_.getInt(PlayerToSpectatorRequest.KEY_ROOM_ID);
            _loc3_ = _loc8_.getInt(PlayerToSpectatorRequest.KEY_USER_ID);
            _loc4_ = this.sfs.userManager.getUserById(_loc3_);
            _loc5_ = this.sfs.roomManager.getRoomById(_loc2_);
            if(_loc5_ != null)
            {
               if(_loc4_ != null)
               {
                  if(_loc4_.isJoinedInRoom(_loc5_))
                  {
                     _loc4_.setPlayerId(-1,_loc5_);
                     _loc9_.room = _loc5_;
                     _loc9_.user = _loc4_;
                     this.sfs.dispatchEvent(new SFSEvent(SFSEvent.PLAYER_TO_SPECTATOR,_loc9_));
                  }
                  else
                  {
                     log.warn("User: " + _loc4_ + " not joined in Room: ",_loc5_,", PlayerToSpectator failed.");
                  }
               }
               else
               {
                  log.warn("User not found, ID:",_loc3_,", PlayerToSpectator failed.");
               }
            }
            else
            {
               log.warn("Room not found, ID:",_loc2_,", PlayerToSpectator failed.");
            }
         }
         else
         {
            _loc6_ = _loc8_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc7_ = SFSErrorCodes.getErrorMessage(_loc6_,_loc8_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc9_ = {
               "errorMessage":_loc7_,
               "errorCode":_loc6_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.PLAYER_TO_SPECTATOR_ERROR,_loc9_));
         }
      }
      
      private function fnInitBuddyList(param1:IMessage) : void
      {
         var _loc2_:ISFSArray = null;
         var _loc3_:ISFSArray = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Buddy = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:ISFSObject = param1.content;
         var _loc11_:Object = {};
         if(_loc10_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc10_.getSFSArray(InitBuddyListRequest.KEY_BLIST);
            _loc3_ = _loc10_.getSFSArray(InitBuddyListRequest.KEY_MY_VARS);
            _loc4_ = _loc10_.getUtfStringArray(InitBuddyListRequest.KEY_BUDDY_STATES);
            this.sfs.buddyManager.clearAll();
            _loc5_ = 0;
            while(_loc5_ < _loc2_.size())
            {
               _loc7_ = SFSBuddy.fromSFSArray(_loc2_.getSFSArray(_loc5_));
               this.sfs.buddyManager.addBuddy(_loc7_);
               _loc5_++;
            }
            if(_loc4_ != null)
            {
               this.sfs.buddyManager.setBuddyStates(_loc4_);
            }
            _loc6_ = [];
            _loc5_ = 0;
            while(_loc5_ < _loc3_.size())
            {
               _loc6_.push(SFSBuddyVariable.fromSFSArray(_loc3_.getSFSArray(_loc5_)));
               _loc5_++;
            }
            this.sfs.buddyManager.setMyVariables(_loc6_);
            this.sfs.buddyManager.setInited(true);
            _loc11_.buddyList = this.sfs.buddyManager.buddyList;
            _loc11_.myVariables = this.sfs.buddyManager.myVariables;
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_LIST_INIT,_loc11_));
         }
         else
         {
            _loc8_ = _loc10_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc9_ = SFSErrorCodes.getErrorMessage(_loc8_,_loc10_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc11_ = {
               "errorMessage":_loc9_,
               "errorCode":_loc8_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc11_));
         }
      }
      
      private function fnAddBuddy(param1:IMessage) : void
      {
         var _loc2_:Buddy = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:ISFSObject = param1.content;
         var _loc6_:Object = {};
         if(_loc5_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = SFSBuddy.fromSFSArray(_loc5_.getSFSArray(AddBuddyRequest.KEY_BUDDY_NAME));
            this.sfs.buddyManager.addBuddy(_loc2_);
            _loc6_.buddy = _loc2_;
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ADD,_loc6_));
         }
         else
         {
            _loc3_ = _loc5_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc4_ = SFSErrorCodes.getErrorMessage(_loc3_,_loc5_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc6_ = {
               "errorMessage":_loc4_,
               "errorCode":_loc3_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc6_));
         }
      }
      
      private function fnRemoveBuddy(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:Buddy = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getUtfString(RemoveBuddyRequest.KEY_BUDDY_NAME);
            _loc3_ = this.sfs.buddyManager.removeBuddyByName(_loc2_);
            if(_loc3_ != null)
            {
               _loc7_.buddy = _loc3_;
               this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_REMOVE,_loc7_));
            }
            else
            {
               log.warn("RemoveBuddy failed, buddy not found: " + _loc2_);
            }
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc7_));
         }
      }
      
      private function fnBlockBuddy(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:Buddy = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ISFSObject = param1.content;
         var _loc7_:Object = {};
         if(_loc6_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc6_.getUtfString(BlockBuddyRequest.KEY_BUDDY_NAME);
            _loc3_ = this.sfs.buddyManager.getBuddyByName(_loc2_);
            if(_loc6_.containsKey(BlockBuddyRequest.KEY_BUDDY))
            {
               _loc3_ = SFSBuddy.fromSFSArray(_loc6_.getSFSArray(BlockBuddyRequest.KEY_BUDDY));
               this.sfs.buddyManager.addBuddy(_loc3_);
            }
            else
            {
               if(_loc3_ == null)
               {
                  log.warn("BlockBuddy failed, buddy not found: " + _loc2_ + ", in local BuddyList");
                  return;
               }
               _loc3_.setBlocked(_loc6_.getBool(BlockBuddyRequest.KEY_BUDDY_BLOCK_STATE));
            }
            _loc7_.buddy = _loc3_;
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_BLOCK,_loc7_));
         }
         else
         {
            _loc4_ = _loc6_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc5_ = SFSErrorCodes.getErrorMessage(_loc4_,_loc6_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc7_ = {
               "errorMessage":_loc5_,
               "errorCode":_loc4_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc7_));
         }
      }
      
      private function fnGoOnline(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:Buddy = null;
         var _loc4_:* = false;
         var _loc5_:int = 0;
         var _loc6_:* = false;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:ISFSObject = param1.content;
         var _loc11_:Object = {};
         if(_loc10_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc10_.getUtfString(GoOnlineRequest.KEY_BUDDY_NAME);
            _loc3_ = this.sfs.buddyManager.getBuddyByName(_loc2_);
            _loc4_ = _loc2_ == this.sfs.mySelf.name;
            _loc5_ = _loc10_.getByte(GoOnlineRequest.KEY_ONLINE);
            _loc6_ = _loc5_ == BuddyOnlineState.ONLINE;
            _loc7_ = true;
            if(_loc4_)
            {
               if(this.sfs.buddyManager.myOnlineState != _loc6_)
               {
                  log.warn("Unexpected: MyOnlineState is not in synch with the server. Resynching: " + _loc6_);
                  this.sfs.buddyManager.setMyOnlineState(_loc6_);
               }
            }
            else
            {
               if(_loc3_ == null)
               {
                  log.warn("GoOnline error, buddy not found: " + _loc2_ + ", in local BuddyList.");
                  return;
               }
               _loc3_.setId(_loc10_.getInt(GoOnlineRequest.KEY_BUDDY_ID));
               _loc3_.setVariable(new SFSBuddyVariable(ReservedBuddyVariables.BV_ONLINE,_loc6_));
               if(_loc5_ == BuddyOnlineState.LEFT_THE_SERVER)
               {
                  _loc3_.clearVolatileVariables();
               }
               _loc7_ = this.sfs.buddyManager.myOnlineState;
            }
            if(_loc7_)
            {
               _loc11_.buddy = _loc3_;
               _loc11_.isItMe = _loc4_;
               this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ONLINE_STATE_UPDATE,_loc11_));
            }
         }
         else
         {
            _loc8_ = _loc10_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc9_ = SFSErrorCodes.getErrorMessage(_loc8_,_loc10_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc11_ = {
               "errorMessage":_loc9_,
               "errorCode":_loc8_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc11_));
         }
      }
      
      private function fnSetBuddyVariables(param1:IMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:ISFSArray = null;
         var _loc4_:Buddy = null;
         var _loc5_:* = false;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:BuddyVariable = null;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:ISFSObject = param1.content;
         var _loc14_:Object = {};
         if(_loc13_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc13_.getUtfString(SetBuddyVariablesRequest.KEY_BUDDY_NAME);
            _loc3_ = _loc13_.getSFSArray(SetBuddyVariablesRequest.KEY_BUDDY_VARS);
            _loc4_ = this.sfs.buddyManager.getBuddyByName(_loc2_);
            _loc5_ = _loc2_ == this.sfs.mySelf.name;
            _loc6_ = [];
            _loc7_ = [];
            _loc8_ = true;
            _loc9_ = 0;
            while(_loc9_ < _loc3_.size())
            {
               _loc10_ = SFSBuddyVariable.fromSFSArray(_loc3_.getSFSArray(_loc9_));
               _loc7_.push(_loc10_);
               _loc6_.push(_loc10_.name);
               _loc9_++;
            }
            if(_loc5_)
            {
               this.sfs.buddyManager.setMyVariables(_loc7_);
            }
            else
            {
               if(_loc4_ == null)
               {
                  log.warn("Unexpected. Target of BuddyVariables update not found: " + _loc2_);
                  return;
               }
               _loc4_.setVariables(_loc7_);
               _loc8_ = this.sfs.buddyManager.myOnlineState;
            }
            if(_loc8_)
            {
               _loc14_.isItMe = _loc5_;
               _loc14_.changedVars = _loc6_;
               _loc14_.buddy = _loc4_;
               this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_VARIABLES_UPDATE,_loc14_));
            }
         }
         else
         {
            _loc11_ = _loc13_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc12_ = SFSErrorCodes.getErrorMessage(_loc11_,_loc13_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc14_ = {
               "errorMessage":_loc12_,
               "errorCode":_loc11_
            };
            this.sfs.dispatchEvent(new SFSBuddyEvent(SFSBuddyEvent.BUDDY_ERROR,_loc14_));
         }
      }
      
      private function fnFindRooms(param1:IMessage) : void
      {
         var _loc2_:Room = null;
         var _loc3_:Room = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         var _loc6_:ISFSArray = _loc4_.getSFSArray(FindRoomsRequest.KEY_FILTERED_ROOMS);
         var _loc7_:Array = [];
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.size())
         {
            _loc2_ = SFSRoom.fromSFSArray(_loc6_.getSFSArray(_loc8_));
            _loc3_ = this.sfs.roomManager.getRoomById(_loc2_.id);
            if(_loc3_ != null)
            {
               _loc2_.isJoined = _loc3_.isJoined;
            }
            _loc7_.push(_loc2_);
            _loc8_++;
         }
         _loc5_.rooms = _loc7_;
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_FIND_RESULT,_loc5_));
      }
      
      private function fnFindUsers(param1:IMessage) : void
      {
         var _loc2_:User = null;
         var _loc3_:ISFSObject = param1.content;
         var _loc4_:Object = {};
         var _loc5_:ISFSArray = _loc3_.getSFSArray(FindUsersRequest.KEY_FILTERED_USERS);
         var _loc6_:Array = [];
         var _loc7_:User = this.sfs.mySelf;
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.size())
         {
            _loc2_ = SFSUser.fromSFSArray(_loc5_.getSFSArray(_loc8_));
            if(_loc2_.id == _loc7_.id)
            {
               _loc2_ = _loc7_;
            }
            _loc6_.push(_loc2_);
            _loc8_++;
         }
         _loc4_.users = _loc6_;
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.USER_FIND_RESULT,_loc4_));
      }
      
      private function fnInviteUsers(param1:IMessage) : void
      {
         var _loc2_:ISFSObject = param1.content;
         var _loc3_:Object = {};
         var _loc4_:User = null;
         if(_loc2_.containsKey(InviteUsersRequest.KEY_USER_ID))
         {
            _loc4_ = this.sfs.userManager.getUserById(_loc2_.getInt(InviteUsersRequest.KEY_USER_ID));
         }
         else
         {
            _loc4_ = SFSUser.fromSFSArray(_loc2_.getSFSArray(InviteUsersRequest.KEY_USER));
         }
         var _loc5_:int = _loc2_.getShort(InviteUsersRequest.KEY_TIME);
         var _loc6_:int = _loc2_.getInt(InviteUsersRequest.KEY_INVITATION_ID);
         var _loc7_:ISFSObject = _loc2_.getSFSObject(InviteUsersRequest.KEY_PARAMS);
         var _loc8_:Invitation = new SFSInvitation(_loc4_,this.sfs.mySelf,_loc5_,_loc7_);
         _loc8_.id = _loc6_;
         _loc3_.invitation = _loc8_;
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.INVITATION,_loc3_));
      }
      
      private function fnInvitationReply(param1:IMessage) : void
      {
         var _loc2_:User = null;
         var _loc3_:int = 0;
         var _loc4_:ISFSObject = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:ISFSObject = param1.content;
         var _loc8_:Object = {};
         if(_loc7_.isNull(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = null;
            if(_loc7_.containsKey(InviteUsersRequest.KEY_USER_ID))
            {
               _loc2_ = this.sfs.userManager.getUserById(_loc7_.getInt(InviteUsersRequest.KEY_USER_ID));
            }
            else
            {
               _loc2_ = SFSUser.fromSFSArray(_loc7_.getSFSArray(InviteUsersRequest.KEY_USER));
            }
            _loc3_ = _loc7_.getUnsignedByte(InviteUsersRequest.KEY_REPLY_ID);
            _loc4_ = _loc7_.getSFSObject(InviteUsersRequest.KEY_PARAMS);
            _loc8_.invitee = _loc2_;
            _loc8_.reply = _loc3_;
            _loc8_.data = _loc4_;
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.INVITATION_REPLY,_loc8_));
         }
         else
         {
            _loc5_ = _loc7_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc6_ = SFSErrorCodes.getErrorMessage(_loc5_,_loc7_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc8_ = {
               "errorMessage":_loc6_,
               "errorCode":_loc5_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.INVITATION_REPLY_ERROR,_loc8_));
         }
      }
      
      private function fnQuickJoinGame(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:ISFSObject = param1.content;
         var _loc5_:Object = {};
         if(_loc4_.containsKey(BaseRequest.KEY_ERROR_CODE))
         {
            _loc2_ = _loc4_.getShort(BaseRequest.KEY_ERROR_CODE);
            _loc3_ = SFSErrorCodes.getErrorMessage(_loc2_,_loc4_.getUtfStringArray(BaseRequest.KEY_ERROR_PARAMS));
            _loc5_ = {
               "errorMessage":_loc3_,
               "errorCode":_loc2_
            };
            this.sfs.dispatchEvent(new SFSEvent(SFSEvent.ROOM_JOIN_ERROR,_loc5_));
         }
      }
      
      private function fnPingPong(param1:IMessage) : void
      {
         var _loc2_:int = int(this.sfs.kernel::lagMonitor.onPingPong());
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.PING_PONG,{"lagValue":_loc2_});
         this.sfs.dispatchEvent(_loc3_);
      }
      
      private function fnSetUserPosition(param1:IMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:User = null;
         var _loc5_:ISFSArray = null;
         var _loc6_:User = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:IMMOItem = null;
         var _loc10_:ISFSArray = null;
         var _loc11_:IMMOItem = null;
         var _loc12_:Array = null;
         var _loc13_:ISFSObject = param1.content;
         var _loc14_:Object = {};
         var _loc15_:int = _loc13_.getInt(SetUserPositionRequest.KEY_ROOM);
         var _loc16_:Array = _loc13_.getIntArray(SetUserPositionRequest.KEY_MINUS_USER_LIST);
         var _loc17_:ISFSArray = _loc13_.getSFSArray(SetUserPositionRequest.KEY_PLUS_USER_LIST);
         var _loc18_:Array = _loc13_.getIntArray(SetUserPositionRequest.KEY_MINUS_ITEM_LIST);
         var _loc19_:ISFSArray = _loc13_.getSFSArray(SetUserPositionRequest.KEY_PLUS_ITEM_LIST);
         var _loc20_:Room = this.sfs.roomManager.getRoomById(_loc15_);
         var _loc21_:Array = [];
         var _loc22_:Array = [];
         var _loc23_:Array = [];
         var _loc24_:Array = [];
         if(_loc16_ != null && _loc16_.length > 0)
         {
            for each(_loc3_ in _loc16_)
            {
               _loc4_ = _loc20_.getUserById(_loc3_);
               if(_loc4_ != null)
               {
                  _loc20_.removeUser(_loc4_);
                  _loc22_.push(_loc4_);
               }
            }
         }
         if(_loc17_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc17_.size())
            {
               _loc5_ = _loc17_.getSFSArray(_loc2_);
               _loc6_ = this.getOrCreateUser(_loc5_,true,_loc20_);
               _loc21_.push(_loc6_);
               _loc20_.addUser(_loc6_);
               _loc7_ = _loc5_.getElementAt(5);
               if(_loc7_ != null)
               {
                  (_loc6_ as SFSUser).aoiEntryPoint = Vec3D.fromArray(_loc5_.getElementAt(5));
               }
               _loc2_++;
            }
         }
         var _loc25_:MMORoom = _loc20_ as MMORoom;
         if(_loc18_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc18_.length)
            {
               _loc8_ = int(_loc18_[_loc2_]);
               _loc9_ = _loc25_.getMMOItem(_loc8_);
               if(_loc9_ != null)
               {
                  _loc25_.kernel::removeItem(_loc8_);
                  _loc24_.push(_loc9_);
               }
               _loc2_++;
            }
         }
         if(_loc19_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc19_.size())
            {
               _loc10_ = _loc19_.getSFSArray(_loc2_);
               _loc11_ = MMOItem.fromSFSArray(_loc10_);
               _loc23_.push(_loc11_);
               _loc25_.kernel::addMMOItem(_loc11_);
               _loc12_ = _loc10_.getElementAt(2);
               if(_loc12_ != null)
               {
                  (_loc11_ as MMOItem).aoiEntryPoint = Vec3D.fromArray(_loc10_.getElementAt(2));
               }
               _loc2_++;
            }
         }
         _loc14_.addedItems = _loc23_;
         _loc14_.removedItems = _loc24_;
         _loc14_.removedUsers = _loc22_;
         _loc14_.addedUsers = _loc21_;
         _loc14_.room = _loc20_ as MMORoom;
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.PROXIMITY_LIST_UPDATE,_loc14_));
      }
      
      private function fnSetMMOItemVariables(param1:IMessage) : void
      {
         var _loc2_:IMMOItem = null;
         var _loc3_:int = 0;
         var _loc4_:IMMOItemVariable = null;
         var _loc5_:ISFSObject = param1.content;
         var _loc6_:Object = {};
         var _loc7_:int = _loc5_.getInt(SetMMOItemVariables.KEY_ROOM_ID);
         var _loc8_:int = _loc5_.getInt(SetMMOItemVariables.KEY_ITEM_ID);
         var _loc9_:ISFSArray = _loc5_.getSFSArray(SetMMOItemVariables.KEY_VAR_LIST);
         var _loc10_:MMORoom = this.sfs.getRoomById(_loc7_) as MMORoom;
         var _loc11_:Array = [];
         if(_loc10_ != null)
         {
            _loc2_ = _loc10_.getMMOItem(_loc8_);
            if(_loc2_ != null)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc9_.size())
               {
                  _loc4_ = MMOItemVariable.fromSFSArray(_loc9_.getSFSArray(_loc3_));
                  _loc2_.setVariable(_loc4_);
                  _loc11_.push(_loc4_.name);
                  _loc3_++;
               }
               _loc6_.changedVars = _loc11_;
               _loc6_.mmoItem = _loc2_;
               _loc6_.room = _loc10_;
               this.sfs.dispatchEvent(new SFSEvent(SFSEvent.MMOITEM_VARIABLES_UPDATE,_loc6_));
            }
         }
      }
      
      private function populateRoomList(param1:ISFSArray) : void
      {
         var _loc2_:ISFSArray = null;
         var _loc3_:Room = null;
         var _loc4_:IRoomManager = this.sfs.roomManager;
         var _loc5_:int = 0;
         while(_loc5_ < param1.size())
         {
            _loc2_ = param1.getSFSArray(_loc5_);
            _loc3_ = SFSRoom.fromSFSArray(_loc2_);
            _loc4_.replaceRoom(_loc3_);
            _loc5_++;
         }
      }
      
      private function getOrCreateUser(param1:ISFSArray, param2:Boolean = false, param3:Room = null) : User
      {
         var _loc4_:ISFSArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = param1.getInt(0);
         var _loc7_:User = this.sfs.userManager.getUserById(_loc6_);
         if(_loc7_ == null)
         {
            _loc7_ = SFSUser.fromSFSArray(param1,param3);
            _loc7_.userManager = this.sfs.userManager;
         }
         else if(param3 != null)
         {
            _loc7_.setPlayerId(param1.getShort(3),param3);
            _loc4_ = param1.getSFSArray(4);
            _loc5_ = 0;
            while(_loc5_ < _loc4_.size())
            {
               _loc7_.setVariable(SFSUserVariable.fromSFSArray(_loc4_.getSFSArray(_loc5_)));
               _loc5_++;
            }
         }
         if(param2)
         {
            this.sfs.userManager.addUser(_loc7_);
         }
         return _loc7_;
      }
   }
}

