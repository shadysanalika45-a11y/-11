package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SanalikaSliderEvent extends Event
   {
      
      public static const SLIDER_UPDATED:String = "SLIDER_UPDATED";
      
      public static const SLIDER_SLIDING:String = "SLIDER_SLIDING";
      
      public var data:Object;
      
      public function SanalikaSliderEvent(param1:String, param2:Boolean = true, param3:Object = null)
      {
         super(param1,param2);
         this.data = param3;
      }
   }
}

