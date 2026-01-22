package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class WalkEvent extends Event
   {
      
      public static const UPDATE_WALK:String = "updateWalk";
      
      public var stepCount:int;
      
      public var avatarID:int;
      
      public function WalkEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new WalkEvent(type,bubbles,cancelable);
      }
   }
}

