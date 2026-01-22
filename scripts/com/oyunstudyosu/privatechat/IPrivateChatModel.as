package com.oyunstudyosu.privatechat
{
   public interface IPrivateChatModel
   {
      
      function addGroup(param1:IPrivateChatGroup) : void;
      
      function removeGroup(param1:String) : IPrivateChatGroup;
      
      function contains(param1:String) : IPrivateChatGroup;
      
      function hasGroup(param1:String) : IPrivateChatGroup;
      
      function deleteGroup(param1:String) : void;
      
      function getGroupList() : Array;
      
      function setAsFirst(param1:String) : void;
      
      function get isActivated() : Boolean;
      
      function set isActivated(param1:Boolean) : void;
      
      function get activeGroupID() : String;
      
      function set activeGroupID(param1:String) : void;
      
      function get unreadCount() : int;
      
      function set unreadCount(param1:int) : void;
      
      function get cellPhoneActive() : Boolean;
      
      function set cellPhoneActive(param1:Boolean) : void;
   }
}

