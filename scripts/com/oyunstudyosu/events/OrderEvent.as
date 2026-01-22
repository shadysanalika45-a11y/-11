package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class OrderEvent extends Event
   {
      
      public static const OPEN_ORDER:String = "OrderEvent.OPEN_ORDER";
      
      public static const NEW_ORDER:String = "OrderEvent.NEW_ORDER";
      
      public static const TIMEDOUT:String = "OrderEvent.TIMEDOUT";
      
      public static const DELIVERED:String = "OrderEvent.DELIVERED";
      
      public static const CANCELLED:String = "OrderEvent.CANCELLED";
      
      public static const PREPARING:String = "OrderEvent.PREPARING";
      
      public var status:int;
      
      public var id:int;
      
      public var index:int;
      
      public var avatarID:int;
      
      public var data:Object;
      
      public function OrderEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new OrderEvent(type,bubbles,cancelable);
      }
   }
}

