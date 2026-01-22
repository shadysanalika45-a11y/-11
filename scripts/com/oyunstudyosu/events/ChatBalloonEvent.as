package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class ChatBalloonEvent extends Event
   {
      
      public static const BALLOONS_CHANGED:String = "ChatBalloonEvent.BALLOONS_CHANGED";
      
      public function ChatBalloonEvent(param1:String)
      {
         super(param1,bubbles,cancelable);
      }
   }
}

