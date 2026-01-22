package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class YouTubePlayerEvent extends Event
   {
      
      public static const READY:String = "ready";
      
      public static const STATE_CHANGE:String = "stateChange";
      
      public function YouTubePlayerEvent(param1:String)
      {
         super(param1);
      }
   }
}

