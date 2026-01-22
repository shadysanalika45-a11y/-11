package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class RestrictedEvent extends Event
   {
      
      public static const RESTRICTED_LIST:String = "MyRestrictedEvent.RESTRICTED_LIST";
      
      public static const RESTRICTED_LIST_UPDATED:String = "MyRestrictedEvent.RESTRICTED_LIST_UPDATED";
      
      public static const RESTRICTED_REMOVED:String = "MyRestrictedEvent.RESTRICTED_REMOVED";
      
      public static const REMOVE_RESTRICTED:String = "MyBuddyEvent.REMOVE_RESTRICTED";
      
      public var avatarID:String;
      
      public function RestrictedEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new RestrictedEvent(type);
      }
   }
}

