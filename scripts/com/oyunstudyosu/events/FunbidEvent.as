package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class FunbidEvent extends Event
   {
      
      public var id:int;
      
      public var a:int;
      
      public function FunbidEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new OrderEvent(type,bubbles,cancelable);
      }
   }
}

