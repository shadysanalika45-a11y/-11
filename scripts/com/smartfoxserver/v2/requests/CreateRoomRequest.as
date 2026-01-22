package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.SFSArray;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.mmo.MMORoomSettings;
   
   public class CreateRoomRequest extends BaseRequest
   {
      
      public static const KEY_ROOM:String = "r";
      
      public static const KEY_NAME:String = "n";
      
      public static const KEY_PASSWORD:String = "p";
      
      public static const KEY_GROUP_ID:String = "g";
      
      public static const KEY_ISGAME:String = "ig";
      
      public static const KEY_MAXUSERS:String = "mu";
      
      public static const KEY_MAXSPECTATORS:String = "ms";
      
      public static const KEY_MAXVARS:String = "mv";
      
      public static const KEY_ROOMVARS:String = "rv";
      
      public static const KEY_PERMISSIONS:String = "pm";
      
      public static const KEY_EVENTS:String = "ev";
      
      public static const KEY_EXTID:String = "xn";
      
      public static const KEY_EXTCLASS:String = "xc";
      
      public static const KEY_EXTPROP:String = "xp";
      
      public static const KEY_AUTOJOIN:String = "aj";
      
      public static const KEY_ROOM_TO_LEAVE:String = "rl";
      
      public static const KEY_ALLOW_JOIN_INVITATION_BY_OWNER:String = "aji";
      
      public static const KEY_MMO_DEFAULT_AOI:String = "maoi";
      
      public static const KEY_MMO_MAP_LOW_LIMIT:String = "mllm";
      
      public static const KEY_MMO_MAP_HIGH_LIMIT:String = "mlhm";
      
      public static const KEY_MMO_USER_MAX_LIMBO_SECONDS:String = "muls";
      
      public static const KEY_MMO_PROXIMITY_UPDATE_MILLIS:String = "mpum";
      
      public static const KEY_MMO_SEND_ENTRY_POINT:String = "msep";
      
      protected var _settings:RoomSettings;
      
      protected var _autoJoin:Boolean;
      
      protected var _roomToLeave:Room;
      
      public function CreateRoomRequest(param1:RoomSettings, param2:Boolean = false, param3:Room = null)
      {
         super(BaseRequest.CreateRoom);
         this._settings = param1;
         this._autoJoin = param2;
         this._roomToLeave = param3;
      }
      
      override public function execute(param1:SmartFox) : void
      {
         var _loc2_:ISFSArray = null;
         var _loc3_:* = undefined;
         var _loc4_:RoomVariable = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:MMORoomSettings = null;
         var _loc8_:Boolean = false;
         _sfso.putUtfString(KEY_NAME,this._settings.name);
         _sfso.putUtfString(KEY_GROUP_ID,this._settings.groupId);
         _sfso.putUtfString(KEY_PASSWORD,this._settings.password);
         _sfso.putBool(KEY_ISGAME,this._settings.isGame);
         _sfso.putShort(KEY_MAXUSERS,this._settings.maxUsers);
         _sfso.putShort(KEY_MAXSPECTATORS,this._settings.maxSpectators);
         _sfso.putShort(KEY_MAXVARS,this._settings.maxVariables);
         _sfso.putBool(KEY_ALLOW_JOIN_INVITATION_BY_OWNER,this._settings.allowOwnerOnlyInvitation);
         if(this._settings.variables != null && this._settings.variables.length > 0)
         {
            _loc2_ = SFSArray.newInstance();
            for each(_loc3_ in this._settings.variables)
            {
               if(_loc3_ is RoomVariable)
               {
                  _loc4_ = _loc3_ as RoomVariable;
                  _loc2_.addSFSArray(_loc4_.toSFSArray());
               }
            }
            _sfso.putSFSArray(KEY_ROOMVARS,_loc2_);
         }
         if(this._settings.permissions != null)
         {
            _loc5_ = [];
            _loc5_.push(this._settings.permissions.allowNameChange);
            _loc5_.push(this._settings.permissions.allowPasswordStateChange);
            _loc5_.push(this._settings.permissions.allowPublicMessages);
            _loc5_.push(this._settings.permissions.allowResizing);
            _sfso.putBoolArray(KEY_PERMISSIONS,_loc5_);
         }
         if(this._settings.events != null)
         {
            _loc6_ = [];
            _loc6_.push(this._settings.events.allowUserEnter);
            _loc6_.push(this._settings.events.allowUserExit);
            _loc6_.push(this._settings.events.allowUserCountChange);
            _loc6_.push(this._settings.events.allowUserVariablesUpdate);
            _sfso.putBoolArray(KEY_EVENTS,_loc6_);
         }
         if(this._settings.extension != null)
         {
            _sfso.putUtfString(KEY_EXTID,this._settings.extension.id);
            _sfso.putUtfString(KEY_EXTCLASS,this._settings.extension.className);
            if(this._settings.extension.propertiesFile != null && this._settings.extension.propertiesFile.length > 0)
            {
               _sfso.putUtfString(KEY_EXTPROP,this._settings.extension.propertiesFile);
            }
         }
         if(this._settings is MMORoomSettings)
         {
            _loc7_ = this._settings as MMORoomSettings;
            _loc8_ = _loc7_.defaultAOI.isFloat();
            if(_loc8_)
            {
               _sfso.putFloatArray(KEY_MMO_DEFAULT_AOI,_loc7_.defaultAOI.toArray());
               if(_loc7_.mapLimits != null)
               {
                  _sfso.putFloatArray(KEY_MMO_MAP_LOW_LIMIT,_loc7_.mapLimits.lowerLimit.toArray());
                  _sfso.putFloatArray(KEY_MMO_MAP_HIGH_LIMIT,_loc7_.mapLimits.higherLimit.toArray());
               }
            }
            else
            {
               _sfso.putIntArray(KEY_MMO_DEFAULT_AOI,_loc7_.defaultAOI.toArray());
               if(_loc7_.mapLimits != null)
               {
                  _sfso.putIntArray(KEY_MMO_MAP_LOW_LIMIT,_loc7_.mapLimits.lowerLimit.toArray());
                  _sfso.putIntArray(KEY_MMO_MAP_HIGH_LIMIT,_loc7_.mapLimits.higherLimit.toArray());
               }
            }
            _sfso.putShort(KEY_MMO_USER_MAX_LIMBO_SECONDS,_loc7_.userMaxLimboSeconds);
            _sfso.putShort(KEY_MMO_PROXIMITY_UPDATE_MILLIS,_loc7_.proximityListUpdateMillis);
            _sfso.putBool(KEY_MMO_SEND_ENTRY_POINT,_loc7_.sendAOIEntryPoint);
         }
         _sfso.putBool(KEY_AUTOJOIN,this._autoJoin);
         if(this._roomToLeave != null)
         {
            _sfso.putInt(KEY_ROOM_TO_LEAVE,this._roomToLeave.id);
         }
      }
      
      override public function validate(param1:SmartFox) : void
      {
         var _loc2_:MMORoomSettings = null;
         var _loc3_:Array = [];
         if(this._settings.name == null || this._settings.name.length == 0)
         {
            _loc3_.push("Missing room name");
         }
         if(this._settings.maxUsers <= 0)
         {
            _loc3_.push("maxUsers must be > 0");
         }
         if(this._settings.extension != null)
         {
            if(this._settings.extension.className == null || this._settings.extension.className.length == 0)
            {
               _loc3_.push("Missing Extension class name");
            }
            if(this._settings.extension.id == null || this._settings.extension.id.length == 0)
            {
               _loc3_.push("Missing Extension id");
            }
         }
         if(this._settings is MMORoomSettings)
         {
            _loc2_ = this._settings as MMORoomSettings;
            if(_loc2_.defaultAOI == null)
            {
               _loc3_.push("Missing default AoI (Area of Interest)");
            }
            if(_loc2_.mapLimits != null && (_loc2_.mapLimits.lowerLimit == null || _loc2_.mapLimits.higherLimit == null))
            {
               _loc3_.push("Map limits must be both defined");
            }
         }
         if(_loc3_.length > 0)
         {
            throw new SFSValidationError("CreateRoom request error",_loc3_);
         }
      }
   }
}

