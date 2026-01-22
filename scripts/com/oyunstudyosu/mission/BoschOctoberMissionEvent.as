package com.oyunstudyosu.mission
{
   import flash.events.Event;
   
   public class BoschOctoberMissionEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "BoschOctoberMissionEvent.CHANGE_STEP";
      
      public static const DURU:int = 1;
      
      public static const ORCUN:int = 10;
      
      public static const KLIMAFIRST:int = 20;
      
      public static const KLIMASECOND:int = 30;
      
      public static const KLIMATHIRD:int = 40;
      
      public static const MELIS:int = 50;
      
      public static const COMPLETE_MISSION:int = 60;
      
      public var step:int;
      
      public function BoschOctoberMissionEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

