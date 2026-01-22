package feathers.utils
{
   import feathers.core.IFocusManager;
   import feathers.core.IFocusObject;
   import feathers.core.IStateContext;
   import flash.Boot;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   
   public class KeyToState
   {
      
      public var _upState:Object;
      
      public var _target:InteractiveObject;
      
      public var _enabled:Boolean;
      
      public var _downState:Object;
      
      public var _downKeyCode:Object;
      
      public var _currentState:Object;
      
      public var _callback:Function;
      
      public function KeyToState(param1:InteractiveObject = undefined, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _downKeyCode = null;
         _enabled = true;
         _downState = null;
         _upState = null;
         _callback = null;
         _target = null;
         set_target(param1);
         if(param3 != null)
         {
            _upState = param3;
         }
         if(param4 != null)
         {
            set_downState(param4);
         }
         _currentState = _upState;
         set_callback(param2);
      }
      
      public function set_upState(param1:Object) : Object
      {
         _upState = param1;
         return _upState;
      }
      
      public function set upState(param1:Object) : void
      {
         set_upState(param1);
      }
      
      public function set_target(param1:InteractiveObject) : InteractiveObject
      {
         if(_target == param1)
         {
            return _target;
         }
         if(_target != null)
         {
            _target.removeEventListener(Event.REMOVED_FROM_STAGE,keyToState_target_removedFromStageHandler);
            _target.removeEventListener(FocusEvent.FOCUS_OUT,keyToState_target_focusOutHandler);
            _target.removeEventListener(KeyboardEvent.KEY_DOWN,keyToState_target_keyDownHandler);
            _target.removeEventListener(KeyboardEvent.KEY_UP,keyToState_target_keyUpHandler);
         }
         _target = param1;
         if(_target != null)
         {
            _currentState = _upState;
            _target.addEventListener(Event.REMOVED_FROM_STAGE,keyToState_target_removedFromStageHandler);
            _target.addEventListener(FocusEvent.FOCUS_OUT,keyToState_target_focusOutHandler);
            _target.addEventListener(KeyboardEvent.KEY_DOWN,keyToState_target_keyDownHandler);
            _target.addEventListener(KeyboardEvent.KEY_UP,keyToState_target_keyUpHandler);
         }
         return _target;
      }
      
      public function set target(param1:InteractiveObject) : void
      {
         set_target(param1);
      }
      
      public function set_enabled(param1:Boolean) : Boolean
      {
         if(_enabled == param1)
         {
            return _enabled;
         }
         _enabled = param1;
         if(!_enabled)
         {
            resetKeyState();
         }
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         set_enabled(param1);
      }
      
      public function set_downState(param1:Object) : Object
      {
         _downState = param1;
         return _downState;
      }
      
      public function set downState(param1:Object) : void
      {
         set_downState(param1);
      }
      
      public function set_callback(param1:Function) : Function
      {
         if(_callback == param1)
         {
            return _callback;
         }
         _callback = param1;
         if(_callback != null)
         {
            _callback(_currentState);
         }
         return _callback;
      }
      
      public function set callback(param1:Function) : void
      {
         set_callback(param1);
      }
      
      public function resetKeyState() : void
      {
         if(_downKeyCode == null)
         {
            return;
         }
         _downKeyCode = null;
         changeState(_upState);
      }
      
      public function keyToState_target_removedFromStageHandler(param1:Event) : void
      {
         resetKeyState();
      }
      
      public function keyToState_target_keyUpHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode != _downKeyCode)
         {
            return;
         }
         resetKeyState();
      }
      
      public function keyToState_target_keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:* = null as IFocusObject;
         var _loc3_:* = null as IFocusManager;
         if(_target is IFocusObject)
         {
            _loc2_ = _target;
            _loc3_ = _loc2_.get_focusManager();
            if(_loc3_ != null && _loc3_.get_focus() != _loc2_)
            {
               return;
            }
         }
         if(!_enabled || _downKeyCode != null || param1.keyCode != 32 && param1.keyCode != 13)
         {
            return;
         }
         _downKeyCode = param1.keyCode;
         changeState(_downState);
      }
      
      public function keyToState_target_focusOutHandler(param1:FocusEvent) : void
      {
         resetKeyState();
      }
      
      public function get_upState() : Object
      {
         return _upState;
      }
      
      public function get upState() : Object
      {
         return get_upState();
      }
      
      public function get_target() : InteractiveObject
      {
         return _target;
      }
      
      public function get target() : InteractiveObject
      {
         return get_target();
      }
      
      public function get_enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get enabled() : Boolean
      {
         return get_enabled();
      }
      
      public function get_downState() : Object
      {
         return _downState;
      }
      
      public function get downState() : Object
      {
         return get_downState();
      }
      
      public function get_currentState() : Object
      {
         return _currentState;
      }
      
      public function get currentState() : Object
      {
         return get_currentState();
      }
      
      public function get_callback() : Function
      {
         return _callback;
      }
      
      public function get callback() : Function
      {
         return get_callback();
      }
      
      public function changeState(param1:Object) : void
      {
         var _loc2_:Object = _currentState;
         if(_target is IStateContext)
         {
            _loc2_ = _target.get_currentState();
         }
         _currentState = param1;
         if(_loc2_ == param1)
         {
            return;
         }
         if(_callback != null)
         {
            _callback(param1);
         }
      }
   }
}

