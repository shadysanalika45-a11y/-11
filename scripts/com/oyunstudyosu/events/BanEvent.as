package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class BanEvent extends Event
   {
      
      public static const CHAT_BANNED_COMPLETE:String = "BanEvent.CHAT_BANNED_COMPLETE";
      
      public static const CHAT_BANNED:String = "BanEvent.CHAT_BANNED";
      
      public static const LOGIN_BANNED:String = "BanEvent.LOGIN_BANNED";
      
      public function BanEvent(param1:String)
      {
         trace("type",param1);
         super(param1);
      }
   }
}

