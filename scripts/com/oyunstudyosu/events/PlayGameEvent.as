package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class PlayGameEvent extends Event
   {
      
      public static var PLAY_GAME:String = "playGame";
      
      public var data:Object;
      
      public function PlayGameEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.data = param2;
      }
      
      override public function clone() : Event
      {
         return new PlayGameEvent(type,this.data,bubbles,cancelable);
      }
   }
}

