package feathers.events
{
   import feathers.style.IStyleObject;
   import flash.Boot;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class StyleProviderEvent extends Event
   {
      
      public static var STYLES_CHANGE:String = "stylesChange";
      
      public var affectsTarget:Function;
      
      public function StyleProviderEvent(param1:String = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         affectsTarget = param2 != null ? param2 : StyleProviderEvent.defaultAffectsTarget;
      }
      
      public static function dispatch(param1:IEventDispatcher, param2:String, param3:Object = undefined) : Boolean
      {
         var _loc4_:StyleProviderEvent = new StyleProviderEvent(param2,param3);
         return Boolean(param1.dispatchEvent(_loc4_));
      }
      
      public static function defaultAffectsTarget(param1:IStyleObject) : Boolean
      {
         return true;
      }
      
      override public function clone() : Event
      {
         return new StyleProviderEvent(type,affectsTarget);
      }
   }
}

