package com.oyunstudyosu.privatechat
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   
   public class PrivateChatMessage implements IPrivateChatMessage
   {
      
      private var _sender:String;
      
      private var _date:String;
      
      private var _content:String;
      
      private var _status:String;
      
      private var _messageID:String;
      
      private var _isAdmin:Boolean = false;
      
      public function PrivateChatMessage()
      {
         super();
      }
      
      public function get sender() : String
      {
         return this._sender;
      }
      
      public function set sender(param1:String) : void
      {
         if(this._sender == param1)
         {
            return;
         }
         this._sender = param1;
      }
      
      public function get date() : String
      {
         return this._date;
      }
      
      public function set date(param1:String) : void
      {
         if(this._date == param1)
         {
            return;
         }
         this._date = param1;
      }
      
      public function get content() : String
      {
         return this._content;
      }
      
      public function set content(param1:String) : void
      {
         if(this._content == param1)
         {
            return;
         }
         this._content = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         if(this._status == param1)
         {
            return;
         }
         this._status = param1;
      }
      
      public function get messageID() : String
      {
         return this._messageID;
      }
      
      public function set messageID(param1:String) : void
      {
         if(this._messageID == param1)
         {
            return;
         }
         this._messageID = param1;
      }
      
      public function get isMine() : Boolean
      {
         return this.sender == Connectr.instance.avatarModel.avatarId;
      }
      
      public function get isAdmin() : Boolean
      {
         return this._isAdmin;
      }
      
      public function set isAdmin(param1:Boolean) : void
      {
         this._isAdmin = param1;
      }
      
      public function clone() : IPrivateChatMessage
      {
         var _loc1_:IPrivateChatMessage = new PrivateChatMessage();
         _loc1_.content = this.content;
         _loc1_.date = this.date;
         _loc1_.messageID = this.messageID;
         _loc1_.sender = this.sender;
         _loc1_.status = this.status;
         return _loc1_;
      }
   }
}

