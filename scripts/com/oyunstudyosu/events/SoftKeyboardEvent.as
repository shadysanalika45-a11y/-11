package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SoftKeyboardEvent extends Event
   {
      
      public static const SOFT_KEYBOARD_ACTIVATE:String = "SOFT_KEYBOARD_ACTIVATE";
      
      public static const SOFT_KEYBOARD_DEACTIVATE:String = "SOFT_KEYBOARD_DEACTIVATE";
      
      public var height:Number;
      
      public var y:Number;
      
      public function SoftKeyboardEvent(param1:String, param2:Number = 0, param3:Number = 0)
      {
         super(param1,true,false);
         this.height = param2;
         this.y = param3;
      }
      
      override public function clone() : Event
      {
         return new SoftKeyboardEvent(this.type,this.height,this.y);
      }
   }
}

