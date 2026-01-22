package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SurveyEvent extends Event
   {
      
      public static const NEW:String = "newQuestion";
      
      public var questionID:int;
      
      public var answerID:int;
      
      public function SurveyEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new OrderEvent(type,bubbles,cancelable);
      }
   }
}

