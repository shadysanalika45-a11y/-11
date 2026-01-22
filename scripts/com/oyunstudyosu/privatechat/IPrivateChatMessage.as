package com.oyunstudyosu.privatechat
{
   public interface IPrivateChatMessage
   {
      
      function get sender() : String;
      
      function set sender(param1:String) : void;
      
      function get date() : String;
      
      function set date(param1:String) : void;
      
      function get content() : String;
      
      function set content(param1:String) : void;
      
      function get status() : String;
      
      function set status(param1:String) : void;
      
      function get messageID() : String;
      
      function set messageID(param1:String) : void;
      
      function get isMine() : Boolean;
      
      function get isAdmin() : Boolean;
      
      function set isAdmin(param1:Boolean) : void;
      
      function clone() : IPrivateChatMessage;
   }
}

