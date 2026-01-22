package feathers.layout
{
   import feathers.events.FeathersEvent;
   import flash.Boot;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class HorizontalLayoutData extends EventDispatcher implements ILayoutData
   {
      
      public var _percentWidth:Object;
      
      public var _percentHeight:Object;
      
      public function HorizontalLayoutData(param1:Object = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _percentHeight = null;
         _percentWidth = null;
         super();
         set_percentWidth(param1);
         set_percentHeight(param2);
      }
      
      public static function fill() : HorizontalLayoutData
      {
         return new HorizontalLayoutData(100,100);
      }
      
      public static function fillHorizontal(param1:Number = 100) : HorizontalLayoutData
      {
         return new HorizontalLayoutData(param1,null);
      }
      
      public static function fillVertical(param1:Number = 100) : HorizontalLayoutData
      {
         return new HorizontalLayoutData(null,param1);
      }
      
      public function set_percentWidth(param1:Object) : Object
      {
         if(_percentWidth == param1)
         {
            return _percentWidth;
         }
         _percentWidth = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _percentWidth;
      }
      
      public function set percentWidth(param1:Object) : void
      {
         set_percentWidth(param1);
      }
      
      public function set_percentHeight(param1:Object) : Object
      {
         if(_percentHeight == param1)
         {
            return _percentHeight;
         }
         _percentHeight = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _percentHeight;
      }
      
      public function set percentHeight(param1:Object) : void
      {
         set_percentHeight(param1);
      }
      
      public function get_percentWidth() : Object
      {
         return _percentWidth;
      }
      
      public function get percentWidth() : Object
      {
         return get_percentWidth();
      }
      
      public function get_percentHeight() : Object
      {
         return _percentHeight;
      }
      
      public function get percentHeight() : Object
      {
         return get_percentHeight();
      }
   }
}

