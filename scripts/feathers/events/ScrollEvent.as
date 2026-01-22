package feathers.events
{
   import flash.Boot;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class ScrollEvent extends Event
   {
      
      public static var SCROLL_START:String = "scrollStart";
      
      public static var SCROLL_COMPLETE:String = "scrollComplete";
      
      public static var SCROLL:String = "scroll";
      
      public function ScrollEvent(param1:String = undefined, param2:Boolean = false, param3:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2,param3);
      }
      
      public static function dispatch(param1:IEventDispatcher, param2:String, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc5_:ScrollEvent = new ScrollEvent(param2,param3,param4);
         return Boolean(param1.dispatchEvent(_loc5_));
      }
      
      override public function clone() : Event
      {
         return new ScrollEvent(type,bubbles,cancelable);
      }
   }
}

