package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class FarmEvent extends Event
   {
      
      public static const IMPLANT:String = "FarmEvent.IMPLANT";
      
      public static const IMPLANTED:String = "FarmEvent.IMPLANTED";
      
      public static const HARVEST:String = "FarmEvent.HARVEST";
      
      public var status:int;
      
      public var id:int;
      
      public var index:int;
      
      public var avatarID:int;
      
      public var itemID:int;
      
      public var data:Object;
      
      public function FarmEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new OrderEvent(type,bubbles,cancelable);
      }
   }
}

