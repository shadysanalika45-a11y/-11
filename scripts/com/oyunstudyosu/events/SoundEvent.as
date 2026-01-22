package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SoundEvent extends Event
   {
      
      public static const PLAY_SOUND:String = "SoundEvent.PLAY_SOUND";
      
      public var soundKey:String;
      
      public function SoundEvent(param1:String)
      {
         super(param1);
      }
   }
}

