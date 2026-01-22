package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class DatageEvent extends Event
   {
      
      public var id:String;
      
      public var data:String;
      
      public function DatageEvent(param1:String, param2:String, param3:String = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.id = param2;
         this.data = param3;
      }
      
      override public function clone() : Event
      {
         return new DatageEvent(type,this.id,this.data,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomEvent","type","id","data","bubbles","cancelable");
      }
   }
}

