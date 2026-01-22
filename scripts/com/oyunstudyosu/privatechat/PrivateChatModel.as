package com.oyunstudyosu.privatechat
{
   import com.oyunstudyosu.buddy.BuddyVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PrivateChatEvent;
   import com.oyunstudyosu.sanalika.interfaces.IBuddyModel;
   
   public class PrivateChatModel implements IPrivateChatModel
   {
      
      private var chatGroups:Array;
      
      private var group:IPrivateChatGroup;
      
      private var buddyModel:IBuddyModel;
      
      private var buddyVo:BuddyVo;
      
      private var _isActivated:Boolean;
      
      private var _activeGroupID:String;
      
      private var _cellPhoneActive:Boolean;
      
      private var _unreadCount:int = 0;
      
      public function PrivateChatModel()
      {
         super();
         chatGroups = [];
         buddyModel = Sanalika.instance.buddyModel;
      }
      
      public function addGroup(param1:IPrivateChatGroup) : void
      {
         buddyVo = buddyModel.getBuddyVoById(param1.avatarID);
         if(buddyVo == null || contains(param1.groupID))
         {
            return;
         }
         chatGroups.push(param1);
      }
      
      public function removeGroup(param1:String) : IPrivateChatGroup
      {
         group = contains(param1);
         if(group)
         {
            unreadCount -= group.unreadMessageCount;
            Sanalika.instance.serviceModel.requestData("privatechatdeletegroup",{"groupID":group.groupID},null);
            chatGroups.splice(chatGroups.indexOf(group),1);
         }
         return group;
      }
      
      public function deleteGroup(param1:String) : void
      {
         group = contains(param1);
         if(group)
         {
            unreadCount -= group.unreadMessageCount;
            chatGroups.splice(chatGroups.indexOf(group),1);
            group = null;
         }
      }
      
      public function contains(param1:String) : IPrivateChatGroup
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < chatGroups.length)
         {
            group = chatGroups[_loc2_];
            if(group.groupID == param1)
            {
               return group;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function setAsFirst(param1:String) : void
      {
         group = contains(param1);
         if(group)
         {
            chatGroups.splice(chatGroups.indexOf(group),1);
            chatGroups.unshift(group);
         }
      }
      
      public function hasGroup(param1:String) : IPrivateChatGroup
      {
         var _loc2_:int = 0;
         buddyVo = buddyModel.getBuddyVoById(param1);
         if(buddyVo == null)
         {
            return null;
         }
         _loc2_ = 0;
         while(_loc2_ < chatGroups.length)
         {
            group = chatGroups[_loc2_];
            if(group.avatarID == param1)
            {
               return group;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getGroupList() : Array
      {
         return chatGroups;
      }
      
      public function get isActivated() : Boolean
      {
         return _isActivated;
      }
      
      public function set isActivated(param1:Boolean) : void
      {
         if(_isActivated == param1)
         {
            return;
         }
         _isActivated = param1;
      }
      
      public function get activeGroupID() : String
      {
         return _activeGroupID;
      }
      
      public function set activeGroupID(param1:String) : void
      {
         _activeGroupID = param1;
      }
      
      public function get cellPhoneActive() : Boolean
      {
         return _cellPhoneActive;
      }
      
      public function set cellPhoneActive(param1:Boolean) : void
      {
         _cellPhoneActive = param1;
         var _loc2_:PrivateChatEvent = new PrivateChatEvent("PrivateChatEvent.CELL_PHONE_MODE");
         _loc2_.cellPhoneActivated = param1;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      public function get unreadCount() : int
      {
         return _unreadCount;
      }
      
      public function set unreadCount(param1:int) : void
      {
         if(param1 <= 0)
         {
            _unreadCount = 0;
         }
         else
         {
            _unreadCount = param1;
         }
         Dispatcher.dispatchEvent(new PrivateChatEvent("PrivateChatEvent.UNREAD_COUNT_UPDATED"));
      }
   }
}

