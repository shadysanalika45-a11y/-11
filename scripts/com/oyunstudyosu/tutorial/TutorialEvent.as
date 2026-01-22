package com.oyunstudyosu.tutorial
{
   import flash.events.Event;
   
   public class TutorialEvent extends Event
   {
      
      public static const CHANGE_STEP:String = "TutorialEvent.CHANGE_STEP";
      
      public static const SHOW_TUTORIAL_BUTTON:String = "TutorialEvent.SHOW_TUTORIAL_BUTTON";
      
      public static const EXIT_TUTORIAL:String = "TutorialEvent.EXIT_TUTORIAL";
      
      public static const WELCOME:int = 0;
      
      public static const REAL_ESTATE:int = 1;
      
      public static const BACK_TO_STREET:int = 2;
      
      public static const USER_ROOM:int = 3;
      
      public static const FISHING_STEP:int = 4;
      
      public static const JOIN_GAME:int = 5;
      
      public var step:int;
      
      public function TutorialEvent(param1:String, param2:int = -1)
      {
         this.step = param2;
         super(param1,false,false);
      }
      
      override public function clone() : Event
      {
         return new TutorialEvent(type,this.step);
      }
   }
}

