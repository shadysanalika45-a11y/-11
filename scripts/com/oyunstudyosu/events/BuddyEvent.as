package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class BuddyEvent extends Event
   {
      
      public static const SEND_DIAMOND:String = "MyBuddyEvent.SEND_DIAMOND";
      
      public static const SEND_MESSAGE:String = "MyBuddyEvent.SEND_MESSAGE";
      
      public static const BUDDY_LOCATE:String = "MyBuddyEvent.BUDDY_LOCATE";
      
      public static const INVITE_LOCATION:String = "MyBuddyEvent.INVITE_LOCATION";
      
      public static const REMOVE_BUDDY_CONFIRM:String = "MyBuddyEvent.REMOVE_FRIEND_CONFIRM";
      
      public static const REMOVE_BUDDY:String = "MyBuddyEvent.REMOVE_FRIEND";
      
      public static const ADD_FRIEND:String = "MyBuddyEvent.ADD_FRIEND";
      
      public static const CHANGE_RELATION:String = "MyBuddyEvent.CHANGE_RELATION";
      
      public static const CHANGE_MOOD:String = "MyBuddyEvent.CHANGE_MOOD";
      
      public static const CHANGE_STATUS_MESSAGE:String = "MyBuddyEvent.CHANGE_STATUS_MESSAGE";
      
      public static const ACCEPT_FRIEND_REQUEST:String = "MyBuddyEvent.ACCEPT_FRIEND_REQUEST";
      
      public static const REJECT_FRIEND_REQUEST:String = "MyBuddyEvent.REJECT_FRIEND_REQUEST";
      
      public static const BUDDY_LIST_UPDATED:String = "MyBuddyEvent.BUDDY_LIST_UPDATED";
      
      public static const REQUEST_LIST_UPDATED:String = "MyBuddyEvent.REQUEST_LIST_UPDATED";
      
      public static const BUDDY_LIST_INITALIZED:String = "MyBuddyEvent.BUDDY_LIST_INITALIZED";
      
      public static const REQUEST_LIST_INITALIZED:String = "MyBuddyEvent.REQUEST_LIST_INITALIZED";
      
      public static const SHOW_PROFILE:String = "MyBuddyEvent.SHOW_PROFILE";
      
      public var relationID:int;
      
      public var avatarID:String;
      
      public var moodID:int;
      
      public var message:String;
      
      public function BuddyEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new BuddyEvent(type);
      }
   }
}

