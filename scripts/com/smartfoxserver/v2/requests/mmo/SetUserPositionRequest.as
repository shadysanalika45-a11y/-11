package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.MMORoom;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   
   public class SetUserPositionRequest extends BaseRequest
   {
      
      public static const KEY_ROOM:String = "r";
      
      public static const KEY_VEC3D:String = "v";
      
      public static const KEY_PLUS_USER_LIST:String = "p";
      
      public static const KEY_MINUS_USER_LIST:String = "m";
      
      public static const KEY_PLUS_ITEM_LIST:String = "q";
      
      public static const KEY_MINUS_ITEM_LIST:String = "n";
      
      private var _pos:Vec3D;
      
      private var _room:Room;
      
      public function SetUserPositionRequest(param1:Vec3D, param2:Room = null)
      {
         super(BaseRequest.SetUserPosition);
         this._pos = param1;
         this._room = param2;
      }
      
      override public function validate(param1:SmartFox) : void
      {
         var _loc2_:Array = [];
         if(this._pos == null)
         {
            _loc2_.push("Position must be a Vec3D instance");
         }
         if(this._room == null)
         {
            this._room = param1.lastJoinedRoom;
         }
         if(this._room == null)
         {
            _loc2_.push("You are not joined in any room");
         }
         if(!(this._room is MMORoom))
         {
            _loc2_.push("Selected Room is not an MMORoom");
         }
         if(_loc2_.length > 0)
         {
            throw new SFSValidationError("SetUserPosition request error",_loc2_);
         }
      }
      
      override public function execute(param1:SmartFox) : void
      {
         _sfso.putInt(KEY_ROOM,this._room.id);
         if(this._pos.isFloat())
         {
            _sfso.putFloatArray(KEY_VEC3D,this._pos.toArray());
         }
         else
         {
            _sfso.putIntArray(KEY_VEC3D,this._pos.toArray());
         }
      }
   }
}

