package com.oyunstudyosu.mission
{
   import flash.events.Event;
   
   public class BasfMissionEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "BasfMissionEvent.CHANGE_STEP";
      
      public static const EROL:int = 1;
      
      public static const RUZGARTURBINI:int = 10;
      
      public static const USTA:int = 20;
      
      public static const COPPOSETI:int = 30;
      
      public static const ARITMAMAKINASI:int = 40;
      
      public static const COMPLETE_MISSION:int = 50;
      
      public var step:int;
      
      public function BasfMissionEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

