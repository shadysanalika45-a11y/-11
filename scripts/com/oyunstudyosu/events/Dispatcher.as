package com.oyunstudyosu.events
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Dispatcher
   {
      
      protected static var eventDispatcher:EventDispatcher;
      
      public static var listenerCount:uint = 0;
      
      public function Dispatcher()
      {
         super();
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = false, param5:int = 0) : void
      {
         if(eventDispatcher == null)
         {
            eventDispatcher = new EventDispatcher();
         }
         ++listenerCount;
         eventDispatcher.addEventListener(param1,param2,param4,param5,param3);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(eventDispatcher == null)
         {
            return;
         }
         if(eventDispatcher.hasEventListener(param1))
         {
            eventDispatcher.removeEventListener(param1,param2,param3);
         }
         --listenerCount;
      }
      
      public static function dispatchEvent(param1:Event) : void
      {
         if(eventDispatcher == null)
         {
            return;
         }
         eventDispatcher.dispatchEvent(param1);
      }
   }
}

