package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class CellEvent extends Event
   {
      
      public static const ON_ENTER:String = "ON_ENTER";
      
      public static const WALK_OVER:String = "WALK_OVER";
      
      public static const ON_EXIT:String = "ON_EXIT";
      
      public var charID:String;
      
      public function CellEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.charID = param2;
      }
   }
}

