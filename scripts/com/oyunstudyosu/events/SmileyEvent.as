package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SmileyEvent extends Event
   {
      
      public static const LIST_UPDATED:String = "SmileyEvent.LIST_UPDATED";
      
      public var id:int;
      
      public function SmileyEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new SmileyEvent(type,bubbles,cancelable);
      }
   }
}

