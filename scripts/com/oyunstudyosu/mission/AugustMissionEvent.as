package com.oyunstudyosu.mission
{
   import flash.events.Event;
   
   public class AugustMissionEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "AugustMissionEvent.CHANGE_STEP";
      
      public static const EYLUL:int = 1;
      
      public static const GAZI:int = 10;
      
      public static const KENAN:int = 20;
      
      public static const COMPLETE_MISSION:int = 30;
      
      public var step:int;
      
      public function AugustMissionEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

