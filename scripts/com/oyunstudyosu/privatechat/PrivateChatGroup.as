package com.oyunstudyosu.privatechat
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PrivateChatEvent;
   
   public class PrivateChatGroup implements IPrivateChatGroup
   {
      
      private var messages:Array;
      
      private var _detailsActivated:Boolean;
      
      private var _groupID:String;
      
      private var _groupName:String;
      
      private var _unreadMessageCount:uint;
      
      private var _avatarID:String;
      
      private var _lastMessage:IPrivateChatMessage;
      
      public function PrivateChatGroup()
      {
         super();
         messages = [];
      }
      
      public function get detailsActivated() : Boolean
      {
         return _detailsActivated;
      }
      
      public function set detailsActivated(param1:Boolean) : void
      {
         if(_detailsActivated == param1)
         {
            return;
         }
         _detailsActivated = param1;
      }
      
      public function get groupID() : String
      {
         return _groupID;
      }
      
      public function set groupID(param1:String) : void
      {
         if(_groupID == param1)
         {
            return;
         }
         _groupID = param1;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function set groupName(param1:String) : void
      {
         if(_groupName == param1)
         {
            return;
         }
         _groupName = param1;
      }
      
      public function get unreadMessageCount() : uint
      {
         return _unreadMessageCount;
      }
      
      public function set unreadMessageCount(param1:uint) : void
      {
         if(_unreadMessageCount == param1)
         {
            return;
         }
         _unreadMessageCount = param1;
      }
      
      public function get avatarID() : String
      {
         return _avatarID;
      }
      
      public function set avatarID(param1:String) : void
      {
         if(_avatarID == param1)
         {
            return;
         }
         _avatarID = param1;
      }
      
      public function get lastMessage() : IPrivateChatMessage
      {
         return _lastMessage;
      }
      
      public function set lastMessage(param1:IPrivateChatMessage) : void
      {
         if(_lastMessage == param1)
         {
            return;
         }
         _lastMessage = param1;
      }
      
      public function addMessage(param1:IPrivateChatMessage) : void
      {
         if(contains(param1))
         {
            trace("already has same message");
         }
         else
         {
            lastMessage = param1.clone();
            if(detailsActivated)
            {
               messages.push(param1);
            }
         }
      }
      
      public function removeMessage(param1:IPrivateChatMessage) : void
      {
         if(!contains(param1))
         {
            trace("there is no message in list");
         }
         else
         {
            messages.splice(messages.indexOf(param1),1);
         }
      }
      
      public function getMessages() : Array
      {
         if(detailsActivated)
         {
            return messages;
         }
         var _loc1_:PrivateChatEvent = new PrivateChatEvent("PrivateChatEvent.GET_GROUP_MESSAGES");
         _loc1_.groupID = groupID;
         Dispatcher.dispatchEvent(_loc1_);
         return null;
      }
      
      public function isMember(param1:String) : Boolean
      {
         return this.avatarID == param1;
      }
      
      public function contains(param1:IPrivateChatMessage) : Boolean
      {
         return messages.indexOf(param1) > -1;
      }
      
      public function isLastMessage(param1:IPrivateChatMessage) : Boolean
      {
         var _loc2_:PrivateChatMessage = messages.getItemAt(messages.length - 1) as PrivateChatMessage;
         if(!contains(param1) || _loc2_.messageID != param1.messageID)
         {
            return false;
         }
         return true;
      }
   }
}

