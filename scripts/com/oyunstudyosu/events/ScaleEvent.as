package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class ScaleEvent extends Event
   {
      
      public static const UI_SCALE_CHANGED:String = "UI_SCALE_CHANGED";
      
      public static const SCALE_CHANGED:String = "SCALE_CHANGED";
      
      public function ScaleEvent(param1:String)
      {
         super(param1,true,false);
      }
      
      override public function clone() : Event
      {
         return new ScaleEvent(this.type);
      }
   }
}

