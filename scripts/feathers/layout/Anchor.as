package feathers.layout
{
   import feathers.events.FeathersEvent;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class Anchor extends EventDispatcher
   {
      
      public var _value:Number;
      
      public var _relativeTo:DisplayObject;
      
      public function Anchor(param1:Number = 0, param2:DisplayObject = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         _value = param1;
         _relativeTo = param2;
      }
      
      public function set_value(param1:Number) : Number
      {
         if(_value == param1)
         {
            return _value;
         }
         _value = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         set_value(param1);
      }
      
      public function set_relativeTo(param1:DisplayObject) : DisplayObject
      {
         if(_relativeTo == param1)
         {
            return _relativeTo;
         }
         _relativeTo = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _relativeTo;
      }
      
      public function set relativeTo(param1:DisplayObject) : void
      {
         set_relativeTo(param1);
      }
      
      public function get_value() : Number
      {
         return _value;
      }
      
      public function get value() : Number
      {
         return get_value();
      }
      
      public function get_relativeTo() : DisplayObject
      {
         return _relativeTo;
      }
      
      public function get relativeTo() : DisplayObject
      {
         return get_relativeTo();
      }
   }
}

