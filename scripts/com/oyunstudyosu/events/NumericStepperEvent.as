package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class NumericStepperEvent extends Event
   {
      
      public static const STEPPER_CHANGE:String = "stepperChange";
      
      public function NumericStepperEvent(param1:String)
      {
         super(param1);
      }
   }
}

