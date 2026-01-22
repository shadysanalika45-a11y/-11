package com.oyunstudyosu.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class CustomEvent extends Event
   {
      
      public var id:String;
      
      public var index:int;
      
      public var bitmapData:BitmapData;
      
      public function CustomEvent(param1:String, param2:String, param3:int, param4:BitmapData = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.id = param2;
         this.index = param3;
         this.bitmapData = param4;
      }
      
      override public function clone() : Event
      {
         return new CustomEvent(type,this.id,this.index,this.bitmapData,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("CustomEvent","type","id","index","bubbles","cancelable");
      }
   }
}

