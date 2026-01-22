package com.oyunstudyosu.events
{
   import com.oyunstudyosu.buddy.BuddyVo;
   import com.oyunstudyosu.privatechat.IPrivateChatGroup;
   import com.oyunstudyosu.privatechat.IPrivateChatMessage;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class PrivateChatEvent extends Event
   {
      
      public static const GET_LIST:String = "PrivateChatEvent.GET_LIST";
      
      public static const GET_GROUP_MESSAGES:String = "PrivateChatEvent.GET_GROUP_MESSAGES";
      
      public static const LIST_ACTIVATED:String = "PrivateChatEvent.LIST_ACTIVATED";
      
      public static const GROUP_MESSAGES_READY:String = "PrivateChatEvent.GROUP_MESSAGES_READY";
      
      public static const UNREAD_COUNT_UPDATED:String = "PrivateChatEvent.UNREAD_COUNT_UPDATED";
      
      public static const NEW_GROUP_ADDED:String = "PrivateChatEvent.NEW_GROUP_ADDED";
      
      public static const NEW_MESSAGE_ADDED:String = "PrivateChatEvent.NEW_MESSAGE_ADDED";
      
      public static const CELL_PHONE_MODE:String = "PrivateChatEvent.CELL_PHONE_MODE";
      
      public static const REMOVE_GROUP:String = "PrivateChatEvent.REMOVE_GROUP";
      
      public static const OPEN_MESSAGE_VIEW:String = "PrivateChatEvent.OPEN_MESSAGE_VIEW";
      
      public static const BACK_TO_LIST:String = "PrivateChatEvent.BACK_TO_LIST";
      
      public var avatarVo:BuddyVo;
      
      public var imageData:BitmapData;
      
      public var avatarID:String;
      
      public var groupID:String;
      
      public var group:IPrivateChatGroup;
      
      public var message:IPrivateChatMessage;
      
      public var cellPhoneActivated:Boolean;
      
      public function PrivateChatEvent(param1:String)
      {
         super(param1);
      }
   }
}

