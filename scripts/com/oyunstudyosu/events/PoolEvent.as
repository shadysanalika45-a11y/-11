package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class PoolEvent extends Event
   {
      
      public static const SHOW_EXIT_BUTTON:String = "PoolEvent.SHOW_EXIT_BUTTON";
      
      public static const HIDE_EXIT_BUTTON:String = "PoolEvent.HIDE_EXIT_BUTTON";
      
      public function PoolEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

