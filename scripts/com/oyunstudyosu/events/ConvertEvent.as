package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class ConvertEvent extends Event
   {
      
      public static const CONVERT:String = "convert";
      
      public function ConvertEvent(param1:String)
      {
         super(CONVERT);
      }
      
      override public function clone() : Event
      {
         return new ConvertEvent(CONVERT);
      }
      
      override public function toString() : String
      {
         return "[Event name=\"" + CONVERT + "\", type=\"com.arabicode.text.Flaraby.ConvertEvent\" ]";
      }
   }
}

