package com.oyunstudyosu.alert
{
   import flash.events.Event;
   
   public class AlertEvent extends Event
   {
      
      public static const SEND:String = "AlertEvent.SEND";
      
      public var vo:AlertVo;
      
      public function AlertEvent(param1:AlertVo)
      {
         super("AlertEvent.SEND",false,false);
         this.vo = param1;
      }
      
      override public function clone() : Event
      {
         return new AlertEvent(this.vo);
      }
      
      override public function toString() : String
      {
         return formatToString("AlertEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

