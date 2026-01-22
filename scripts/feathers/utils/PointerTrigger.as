package feathers.utils
{
   import feathers.events.TriggerEvent;
   import flash.Boot;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   
   public class PointerTrigger
   {
      
      public var _target:InteractiveObject;
      
      public var _eventFactory:Function;
      
      public var _enabled:Boolean;
      
      public var _customHitTest:Function;
      
      public function PointerTrigger(param1:InteractiveObject = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _enabled = true;
         _eventFactory = null;
         _target = null;
         set_target(param1);
         set_eventFactory(param2);
      }
      
      public function set_target(param1:InteractiveObject) : InteractiveObject
      {
         if(_target == param1)
         {
            return _target;
         }
         if(_target != null)
         {
            _target.removeEventListener(MouseEvent.CLICK,pointerTrigger_target_clickHandler);
            _target.removeEventListener(TouchEvent.TOUCH_TAP,pointerTrigger_target_touchTapHandler);
         }
         _target = param1;
         if(_target != null)
         {
            _target.addEventListener(MouseEvent.CLICK,pointerTrigger_target_clickHandler);
            _target.addEventListener(TouchEvent.TOUCH_TAP,pointerTrigger_target_touchTapHandler);
         }
         return _target;
      }
      
      public function set target(param1:InteractiveObject) : void
      {
         set_target(param1);
      }
      
      public function set_eventFactory(param1:Function) : Function
      {
         if(_eventFactory == param1)
         {
            return _eventFactory;
         }
         _eventFactory = param1;
         return _eventFactory;
      }
      
      public function set eventFactory(param1:Function) : void
      {
         set_eventFactory(param1);
      }
      
      public function set_enabled(param1:Boolean) : Boolean
      {
         _enabled = param1;
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         set_enabled(param1);
      }
      
      public function set_customHitTest(param1:Function) : Function
      {
         _customHitTest = param1;
         return _customHitTest;
      }
      
      public function set customHitTest(param1:Function) : void
      {
         set_customHitTest(param1);
      }
      
      public function pointerTrigger_target_touchTapHandler(param1:TouchEvent) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(param1.isPrimaryTouchPoint)
         {
            return;
         }
         if(_customHitTest != null && !_customHitTest(param1.stageX,param1.stageY))
         {
            return;
         }
         if(_eventFactory != null)
         {
            _target.dispatchEvent(_eventFactory());
            return;
         }
         TriggerEvent.dispatchFromTouchEvent(_target,param1);
      }
      
      public function pointerTrigger_target_clickHandler(param1:MouseEvent) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_customHitTest != null && !_customHitTest(param1.stageX,param1.stageY))
         {
            return;
         }
         if(_eventFactory != null)
         {
            _target.dispatchEvent(_eventFactory());
            return;
         }
         TriggerEvent.dispatchFromMouseEvent(_target,param1);
      }
      
      public function get_target() : InteractiveObject
      {
         return _target;
      }
      
      public function get target() : InteractiveObject
      {
         return get_target();
      }
      
      public function get_eventFactory() : Function
      {
         return _eventFactory;
      }
      
      public function get eventFactory() : Function
      {
         return get_eventFactory();
      }
      
      public function get_enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get enabled() : Boolean
      {
         return get_enabled();
      }
      
      public function get_customHitTest() : Function
      {
         return _customHitTest;
      }
      
      public function get customHitTest() : Function
      {
         return get_customHitTest();
      }
   }
}

