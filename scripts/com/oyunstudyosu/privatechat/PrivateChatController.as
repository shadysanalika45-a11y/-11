package com.oyunstudyosu.privatechat
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PrivateChatEvent;
   import com.oyunstudyosu.service.IServiceModel;
   
   public class PrivateChatController
   {
      
      private var model:IPrivateChatModel;
      
      private var serviceModel:IServiceModel;
      
      private var chatGroup:IPrivateChatGroup;
      
      private var groupMessage:IPrivateChatMessage;
      
      private var vo:AlertVo;
      
      public function PrivateChatController()
      {
         super();
         model = Sanalika.instance.privateChatModel;
         serviceModel = Sanalika.instance.serviceModel;
         Dispatcher.addEventListener("PrivateChatEvent.GET_LIST",groupListRequest);
         Dispatcher.addEventListener("PrivateChatEvent.GET_GROUP_MESSAGES",groupMessagesRequest);
         serviceModel.listenExtension("privatemessagereceived",newPrivateMessageReceived);
         serviceModel.listenExtension("buddyRemoved",buddyRemovedFromChatGroup);
         serviceModel.listenExtension("privateChatLimitExceeded",privateChatLimitExceeded);
         serviceModel.listenExtension("privateChatUpdate",privateChatUpdate);
      }
      
      private function privateChatLimitExceeded(param1:Object) : void
      {
         vo = new AlertVo();
         vo.alertType = "tooltip";
         vo.description = LanguageKeys.PRIVATE_CHAT_LIMIT_EXCEEDED + ": " + param1.privateChatLimitExceeded;
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function privateChatUpdate(param1:Object) : void
      {
         Sanalika.instance.privateChatModel.unreadCount = param1.unreadMessages;
      }
      
      private function buddyRemovedFromChatGroup(param1:Object) : void
      {
         if(param1.avatarID == null)
         {
            return;
         }
         chatGroup = model.hasGroup(param1.avatarID);
         if(chatGroup)
         {
            model.deleteGroup(chatGroup.groupID);
         }
      }
      
      private function newPrivateMessageReceived(param1:Object) : void
      {
         var _loc4_:IPrivateChatGroup = null;
         var _loc2_:PrivateChatEvent = null;
         var _loc3_:PrivateChatEvent = new PrivateChatEvent("PrivateChatEvent.NEW_MESSAGE_ADDED");
         if(param1.sender != Sanalika.instance.avatarModel.avatarId && (param1.groupID == null || model.activeGroupID == null || model.activeGroupID != param1.groupID))
         {
            model.unreadCount++;
         }
         if(param1.group == null)
         {
            _loc4_ = model.contains(param1.groupID);
            if(_loc4_)
            {
               if(param1.sender != Sanalika.instance.avatarModel.avatarId && (model.activeGroupID == null || model.activeGroupID != param1.groupID))
               {
                  _loc4_.unreadMessageCount++;
               }
               groupMessage = new PrivateChatMessage();
               groupMessage.content = param1.content;
               groupMessage.sender = param1.sender;
               groupMessage.date = param1.date;
               groupMessage.messageID = param1.date;
               _loc4_.addMessage(groupMessage);
               model.setAsFirst(_loc4_.groupID);
               _loc3_.group = _loc4_;
               _loc3_.message = groupMessage;
               Dispatcher.dispatchEvent(_loc3_);
            }
         }
         else
         {
            _loc2_ = new PrivateChatEvent("PrivateChatEvent.NEW_GROUP_ADDED");
            chatGroup = new PrivateChatGroup();
            chatGroup.groupID = param1.group.id;
            chatGroup.groupName = param1.group.name;
            chatGroup.avatarID = param1.group.avatarID;
            chatGroup.unreadMessageCount = param1.group.unreadCount;
            groupMessage = new PrivateChatMessage();
            groupMessage.content = param1.content;
            groupMessage.sender = param1.sender;
            groupMessage.date = param1.date;
            groupMessage.messageID = param1.id;
            chatGroup.lastMessage = groupMessage;
            model.addGroup(chatGroup);
            _loc2_.group = chatGroup;
            _loc3_.group = chatGroup;
            _loc3_.message = groupMessage;
            Dispatcher.dispatchEvent(_loc2_);
            Dispatcher.dispatchEvent(_loc3_);
         }
      }
      
      private function groupMessagesRequest(param1:PrivateChatEvent) : void
      {
         trace("PRIVATE_CHAT_MESSAGE_DETAILS");
         serviceModel.requestData("messagedetails",{"groupID":param1.groupID},chatDetailsResponse);
      }
      
      private function chatDetailsResponse(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PrivateChatEvent = null;
         serviceModel.removeRequestData("messagedetails",chatDetailsResponse);
         var _loc3_:IPrivateChatGroup = model.contains(param1.groupID);
         if(_loc3_)
         {
            _loc3_.detailsActivated = true;
            _loc4_ = 0;
            while(_loc4_ < param1.contents.length)
            {
               groupMessage = new PrivateChatMessage();
               groupMessage.content = param1.contents[_loc4_].content;
               groupMessage.sender = param1.contents[_loc4_].sender;
               groupMessage.date = param1.contents[_loc4_].date;
               groupMessage.messageID = param1.contents[_loc4_].id;
               _loc3_.addMessage(groupMessage);
               _loc4_++;
            }
            _loc2_ = new PrivateChatEvent("PrivateChatEvent.GROUP_MESSAGES_READY");
            _loc2_.groupID = _loc3_.groupID;
            Dispatcher.dispatchEvent(_loc2_);
         }
      }
      
      private function groupListRequest(param1:PrivateChatEvent) : void
      {
         Dispatcher.removeEventListener("PrivateChatEvent.GET_LIST",groupListRequest);
         serviceModel.requestData("privatechatlist",{},privateChatListResponse);
      }
      
      private function privateChatListResponse(param1:Object) : void
      {
         var _loc2_:int = 0;
         serviceModel.removeRequestData("privatechatlist",privateChatListResponse);
         _loc2_ = 0;
         while(_loc2_ < param1.groupList.length)
         {
            if(!(model.hasGroup(param1.groupList[_loc2_].avatarID) != null || param1.groupList[_loc2_].avatarID == 0))
            {
               chatGroup = new PrivateChatGroup();
               chatGroup.groupID = param1.groupList[_loc2_].id;
               chatGroup.groupName = param1.groupList[_loc2_].name;
               chatGroup.avatarID = param1.groupList[_loc2_].avatarID;
               chatGroup.unreadMessageCount = param1.groupList[_loc2_].unreadCount;
               groupMessage = new PrivateChatMessage();
               groupMessage.content = param1.groupList[_loc2_].lastMessage.content;
               groupMessage.sender = param1.groupList[_loc2_].lastMessage.sender;
               groupMessage.date = param1.groupList[_loc2_].lastMessage.date;
               groupMessage.messageID = param1.groupList[_loc2_].lastMessage.id;
               chatGroup.lastMessage = groupMessage;
               model.addGroup(chatGroup);
            }
            _loc2_++;
         }
         model.isActivated = true;
         Dispatcher.dispatchEvent(new PrivateChatEvent("PrivateChatEvent.LIST_ACTIVATED"));
      }
   }
}

