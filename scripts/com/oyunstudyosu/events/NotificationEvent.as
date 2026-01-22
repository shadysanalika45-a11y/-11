package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class NotificationEvent extends Event
   {
      
      public static const BOT_NOTIFICATION:String = "NoticationEvent.BOT_NOTIFICATION";
      
      public var data:Object;
      
      public function NotificationEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         var _loc1_:NotificationEvent = new NotificationEvent(type);
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}

