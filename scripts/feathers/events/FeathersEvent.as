package feathers.events
{
   import flash.Boot;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class FeathersEvent extends Event
   {
      
      public static var INITIALIZE:String = "initialize";
      
      public static var CREATION_COMPLETE:String = "creationComplete";
      
      public static var LAYOUT_DATA_CHANGE:String = "layoutDataChange";
      
      public static var STATE_CHANGE:String = "stateChange";
      
      public static var OPENING:String = "opening";
      
      public static var CLOSING:String = "closing";
      
      public static var ENABLE:String = "enable";
      
      public static var DISABLE:String = "disable";
      
      public function FeathersEvent(param1:String = undefined, param2:Boolean = false, param3:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2,param3);
      }
      
      public static function dispatch(param1:IEventDispatcher, param2:String, param3:Boolean = false, param4:Boolean = false) : Boolean
      {
         var _loc5_:FeathersEvent = new FeathersEvent(param2,param3,param4);
         return Boolean(param1.dispatchEvent(_loc5_));
      }
      
      override public function clone() : Event
      {
         return new FeathersEvent(type,bubbles,cancelable);
      }
   }
}

