package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class PackItemEvent extends Event
   {
      
      public static const EVENT_ITEMLOADED:String = "item";
      
      public static const EVENT_PNGLOADED:String = "png";
      
      public var key:String;
      
      public var isClothItem:Boolean;
      
      public function PackItemEvent(param1:String, param2:String, param3:Boolean, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.key = param2;
         this.isClothItem = param3;
      }
      
      override public function toString() : String
      {
         return "PackItemEvent : key[" + this.key + "] isClothItem[" + this.isClothItem + "]";
      }
   }
}

