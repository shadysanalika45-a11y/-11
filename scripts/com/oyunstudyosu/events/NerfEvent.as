package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class NerfEvent extends Event
   {
      
      public static const GUN_RELOADED:String = "NerfEvent.GUN_RELOADED";
      
      public var bullet:int;
      
      public function NerfEvent(param1:String)
      {
         super(param1);
      }
   }
}

