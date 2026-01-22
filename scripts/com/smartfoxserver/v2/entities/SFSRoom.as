package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.entities.managers.IRoomManager;
   import com.smartfoxserver.v2.entities.managers.IUserManager;
   import com.smartfoxserver.v2.entities.managers.SFSUserManager;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   import com.smartfoxserver.v2.entities.variables.SFSRoomVariable;
   import com.smartfoxserver.v2.exceptions.SFSError;
   import com.smartfoxserver.v2.kernel;
   import com.smartfoxserver.v2.util.ArrayUtil;
   
   use namespace kernel;
   
   public class SFSRoom implements Room
   {
      
      protected var _id:int;
      
      protected var _name:String;
      
      protected var _groupId:String;
      
      protected var _isGame:Boolean;
      
      protected var _isHidden:Boolean;
      
      protected var _isJoined:Boolean;
      
      protected var _isPasswordProtected:Boolean;
      
      protected var _isManaged:Boolean;
      
      protected var _variables:Object;
      
      protected var _properties:Object;
      
      protected var _userManager:IUserManager;
      
      protected var _maxUsers:int;
      
      protected var _maxSpectators:int;
      
      protected var _userCount:int;
      
      protected var _specCount:int;
      
      protected var _roomManager:IRoomManager;
      
      public function SFSRoom(param1:int, param2:String, param3:String = "default")
      {
         super();
         this._id = param1;
         this._name = param2;
         this._groupId = param3;
         this._isJoined = this._isGame = this._isHidden = false;
         this._isManaged = true;
         this._userCount = this._specCount = 0;
         this._variables = new Object();
         this._properties = new Object();
         this._userManager = new SFSUserManager(null);
      }
      
      public static function fromSFSArray(param1:ISFSArray) : Room
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:RoomVariable = null;
         var _loc5_:MMORoom = null;
         var _loc6_:* = param1.size() == 14;
         var _loc7_:Room = null;
         if(_loc6_)
         {
            _loc7_ = new MMORoom(param1.getInt(0),param1.getUtfString(1),param1.getUtfString(2));
         }
         else
         {
            _loc7_ = new SFSRoom(param1.getInt(0),param1.getUtfString(1),param1.getUtfString(2));
         }
         _loc7_.isGame = param1.getBool(3);
         _loc7_.isHidden = param1.getBool(4);
         _loc7_.isPasswordProtected = param1.getBool(5);
         _loc7_.userCount = param1.getShort(6);
         _loc7_.maxUsers = param1.getShort(7);
         var _loc8_:ISFSArray = param1.getSFSArray(8);
         if(_loc8_.size() > 0)
         {
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc8_.size())
            {
               _loc4_ = SFSRoomVariable.fromSFSArray(_loc8_.getSFSArray(_loc3_));
               _loc2_.push(_loc4_);
               _loc3_++;
            }
            _loc7_.setVariables(_loc2_);
         }
         if(_loc7_.isGame)
         {
            _loc7_.spectatorCount = param1.getShort(9);
            _loc7_.maxSpectators = param1.getShort(10);
         }
         if(_loc6_)
         {
            _loc5_ = _loc7_ as MMORoom;
            _loc5_.defaultAOI = Vec3D.fromArray(param1.getElementAt(11));
            if(!param1.isNull(13))
            {
               _loc5_.lowerMapLimit = Vec3D.fromArray(param1.getElementAt(12));
               _loc5_.higherMapLimit = Vec3D.fromArray(param1.getElementAt(13));
            }
         }
         return _loc7_;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get groupId() : String
      {
         return this._groupId;
      }
      
      public function get isGame() : Boolean
      {
         return this._isGame;
      }
      
      public function get isHidden() : Boolean
      {
         return this._isHidden;
      }
      
      public function get isJoined() : Boolean
      {
         return this._isJoined;
      }
      
      public function get isPasswordProtected() : Boolean
      {
         return this._isPasswordProtected;
      }
      
      public function set isPasswordProtected(param1:Boolean) : void
      {
         this._isPasswordProtected = param1;
      }
      
      public function set isJoined(param1:Boolean) : void
      {
         this._isJoined = param1;
      }
      
      public function set isGame(param1:Boolean) : void
      {
         this._isGame = param1;
      }
      
      public function set isHidden(param1:Boolean) : void
      {
         this._isHidden = param1;
      }
      
      public function get isManaged() : Boolean
      {
         return this._isManaged;
      }
      
      public function set isManaged(param1:Boolean) : void
      {
         this._isManaged = param1;
      }
      
      public function getVariables() : Array
      {
         return ArrayUtil.objToArray(this._variables);
      }
      
      public function getVariable(param1:String) : RoomVariable
      {
         return this._variables[param1];
      }
      
      public function get userCount() : int
      {
         if(!this._isJoined)
         {
            return this._userCount;
         }
         if(this.isGame)
         {
            return this.playerList.length;
         }
         return this._userManager.userCount;
      }
      
      public function get maxUsers() : int
      {
         return this._maxUsers;
      }
      
      public function get capacity() : int
      {
         return this._maxUsers + this._maxSpectators;
      }
      
      public function get spectatorCount() : int
      {
         if(!this.isGame)
         {
            return 0;
         }
         if(this._isJoined)
         {
            return this.spectatorList.length;
         }
         return this._specCount;
      }
      
      public function get maxSpectators() : int
      {
         return this._maxSpectators;
      }
      
      public function set userCount(param1:int) : void
      {
         this._userCount = param1;
      }
      
      public function set maxUsers(param1:int) : void
      {
         this._maxUsers = param1;
      }
      
      public function set spectatorCount(param1:int) : void
      {
         this._specCount = param1;
      }
      
      public function set maxSpectators(param1:int) : void
      {
         this._maxSpectators = param1;
      }
      
      public function getUserByName(param1:String) : User
      {
         return this._userManager.getUserByName(param1);
      }
      
      public function getUserById(param1:int) : User
      {
         return this._userManager.getUserById(param1);
      }
      
      public function get userList() : Array
      {
         return this._userManager.getUserList();
      }
      
      public function get playerList() : Array
      {
         var _loc1_:User = null;
         var _loc2_:Array = [];
         for each(_loc1_ in this._userManager.getUserList())
         {
            if(_loc1_.isPlayerInRoom(this))
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function get spectatorList() : Array
      {
         var _loc1_:User = null;
         var _loc2_:Array = [];
         for each(_loc1_ in this._userManager.getUserList())
         {
            if(_loc1_.isSpectatorInRoom(this))
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function removeUser(param1:User) : void
      {
         this._userManager.removeUser(param1);
      }
      
      public function setVariable(param1:RoomVariable) : void
      {
         if(param1.isNull())
         {
            delete this._variables[param1.name];
         }
         else
         {
            this._variables[param1.name] = param1;
         }
      }
      
      public function setVariables(param1:Array) : void
      {
         var _loc2_:RoomVariable = null;
         for each(_loc2_ in param1)
         {
            this.setVariable(_loc2_);
         }
      }
      
      public function containsVariable(param1:String) : Boolean
      {
         return this._variables[param1] != null;
      }
      
      public function get properties() : Object
      {
         return this._properties;
      }
      
      public function set properties(param1:Object) : void
      {
         this._properties = param1;
      }
      
      public function addUser(param1:User) : void
      {
         this._userManager.addUser(param1);
      }
      
      public function containsUser(param1:User) : Boolean
      {
         return this._userManager.containsUser(param1);
      }
      
      public function get roomManager() : IRoomManager
      {
         return this._roomManager;
      }
      
      public function set roomManager(param1:IRoomManager) : void
      {
         if(this._roomManager != null)
         {
            throw new SFSError("Room manager already assigned. Room: " + this);
         }
         this._roomManager = param1;
      }
      
      public function setPasswordProtected(param1:Boolean) : void
      {
         this._isPasswordProtected = param1;
      }
      
      public function toString() : String
      {
         return "[Room: " + this._name + ", Id: " + this._id + ", GroupId: " + this._groupId + "]";
      }
      
      kernel function merge(param1:Room, param2:User) : void
      {
         var _loc3_:RoomVariable = null;
         var _loc4_:User = null;
         if(!this.isJoined)
         {
            this._variables = [];
            for each(_loc3_ in param1.getVariables())
            {
               this._variables[_loc3_.name] = _loc3_;
            }
            this._userManager.kernel::clearAll();
            for each(_loc4_ in param1.userList)
            {
               this._userManager.addUser(_loc4_);
            }
         }
      }
   }
}

