package com.oyunstudyosu.mission
{
   import flash.events.Event;
   
   public class RiceDayMissionEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "RiceDayMissionEvent.CHANGE_STEP";
      
      public static const ASCI:int = 1;
      
      public static const ULUBILGE:int = 10;
      
      public static const KUAFOR:int = 20;
      
      public static const KOSTUMCU:int = 30;
      
      public static const CICEKCI:int = 40;
      
      public static const SEVGI:int = 50;
      
      public static const COMPLETE_MISSION:int = 60;
      
      public var step:int;
      
      public function RiceDayMissionEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

