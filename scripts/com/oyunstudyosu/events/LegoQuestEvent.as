package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class LegoQuestEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "LegoQuestEvent.CHANGE_STEP";
      
      public static const DALGIC:int = 1;
      
      public static const ARAC:int = 10;
      
      public static const DALGIC_2:int = 20;
      
      public static const COMPLETE_MISSION:int = 40;
      
      public var step:int;
      
      public function LegoQuestEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

