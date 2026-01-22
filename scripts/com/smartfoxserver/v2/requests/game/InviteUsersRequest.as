package com.smartfoxserver.v2.requests.game
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Buddy;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   
   public class InviteUsersRequest extends BaseRequest
   {
      
      public static const KEY_USER:String = "u";
      
      public static const KEY_USER_ID:String = "ui";
      
      public static const KEY_INVITATION_ID:String = "ii";
      
      public static const KEY_TIME:String = "t";
      
      public static const KEY_PARAMS:String = "p";
      
      public static const KEY_INVITEE_ID:String = "ee";
      
      public static const KEY_INVITED_USERS:String = "iu";
      
      public static const KEY_REPLY_ID:String = "ri";
      
      public static const MAX_INVITATIONS_FROM_CLIENT_SIDE:int = 8;
      
      public static const MIN_EXPIRY_TIME:int = 5;
      
      public static const MAX_EXPIRY_TIME:int = 300;
      
      private var _invitedUsers:Array;
      
      private var _secondsForAnswer:int;
      
      private var _params:ISFSObject;
      
      public function InviteUsersRequest(param1:Array, param2:int, param3:ISFSObject)
      {
         super(BaseRequest.InviteUser);
         this._invitedUsers = param1;
         this._secondsForAnswer = param2;
         this._params = param3;
      }
      
      override public function validate(param1:SmartFox) : void
      {
         var _loc2_:Array = [];
         if(this._invitedUsers == null || this._invitedUsers.length < 1)
         {
            _loc2_.push("No invitation(s) to send");
         }
         if(this._invitedUsers.length > MAX_INVITATIONS_FROM_CLIENT_SIDE)
         {
            _loc2_.push("Too many invitations. Max allowed from client side is: " + MAX_INVITATIONS_FROM_CLIENT_SIDE);
         }
         if(this._secondsForAnswer < MIN_EXPIRY_TIME || this._secondsForAnswer > MAX_EXPIRY_TIME)
         {
            _loc2_.push("SecondsForAnswer value is out of range (" + MIN_EXPIRY_TIME + "-" + MAX_EXPIRY_TIME + ")");
         }
         if(_loc2_.length > 0)
         {
            throw new SFSValidationError("InvitationReply request error",_loc2_);
         }
      }
      
      override public function execute(param1:SmartFox) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = [];
         for each(_loc2_ in this._invitedUsers)
         {
            if(_loc2_ is User || _loc2_ is Buddy)
            {
               if(_loc2_ != param1.mySelf)
               {
                  _loc3_.push(_loc2_.id);
               }
            }
         }
         _sfso.putIntArray(KEY_INVITED_USERS,_loc3_);
         _sfso.putShort(KEY_TIME,this._secondsForAnswer);
         if(this._params != null)
         {
            _sfso.putSFSObject(KEY_PARAMS,this._params);
         }
      }
   }
}

