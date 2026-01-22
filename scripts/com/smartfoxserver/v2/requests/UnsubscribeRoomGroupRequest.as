package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   
   public class UnsubscribeRoomGroupRequest extends BaseRequest
   {
      
      public static const KEY_GROUP_ID:String = "g";
      
      private var _groupId:String;
      
      public function UnsubscribeRoomGroupRequest(param1:String)
      {
         super(BaseRequest.UnsubscribeRoomGroup);
         this._groupId = param1;
      }
      
      override public function validate(param1:SmartFox) : void
      {
         var _loc2_:Array = [];
         if(this._groupId == null || this._groupId.length == 0)
         {
            _loc2_.push("Invalid groupId. Must be a string with at least 1 character.");
         }
         if(_loc2_.length > 0)
         {
            throw new SFSValidationError("UnsubscribeGroup request error",_loc2_);
         }
      }
      
      override public function execute(param1:SmartFox) : void
      {
         _sfso.putUtfString(KEY_GROUP_ID,this._groupId);
      }
   }
}

