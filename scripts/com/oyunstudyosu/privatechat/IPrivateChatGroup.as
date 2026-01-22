package com.oyunstudyosu.privatechat
{
   public interface IPrivateChatGroup
   {
      
      function get groupID() : String;
      
      function set groupID(param1:String) : void;
      
      function get groupName() : String;
      
      function set groupName(param1:String) : void;
      
      function get unreadMessageCount() : uint;
      
      function set unreadMessageCount(param1:uint) : void;
      
      function get detailsActivated() : Boolean;
      
      function set detailsActivated(param1:Boolean) : void;
      
      function get avatarID() : String;
      
      function set avatarID(param1:String) : void;
      
      function get lastMessage() : IPrivateChatMessage;
      
      function set lastMessage(param1:IPrivateChatMessage) : void;
      
      function isMember(param1:String) : Boolean;
      
      function getMessages() : Array;
      
      function addMessage(param1:IPrivateChatMessage) : void;
      
      function removeMessage(param1:IPrivateChatMessage) : void;
      
      function contains(param1:IPrivateChatMessage) : Boolean;
      
      function isLastMessage(param1:IPrivateChatMessage) : Boolean;
   }
}

