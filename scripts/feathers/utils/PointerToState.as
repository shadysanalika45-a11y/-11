package feathers.utils
{
   import feathers.core.IStateContext;
   import flash.Boot;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PointerToState
   {
      
      public var _upState:Object;
      
      public var _target:InteractiveObject;
      
      public var _stateContext:IStateContext;
      
      public var _keepDownStateOnRollOut:Boolean;
      
      public var _hoverState:Object;
      
      public var _hoverBeforeDown:Boolean;
      
      public var _enabled:Boolean;
      
      public var _downState:Object;
      
      public var _down:Boolean;
      
      public var _customHitTest:Function;
      
      public var _currentState:Object;
      
      public var _callback:Function;
      
      public function PointerToState(param1:InteractiveObject = undefined, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _down = false;
         _hoverBeforeDown = false;
         _keepDownStateOnRollOut = false;
         _enabled = true;
         _hoverState = null;
         _downState = null;
         _upState = null;
         _callback = null;
         _stateContext = null;
         _target = null;
         set_target(param1);
         if(param3 != null)
         {
            set_upState(param3);
         }
         if(param4 != null)
         {
            set_downState(param4);
         }
         if(param5 != null)
         {
            set_hoverState(param5);
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
            _target.removeEventListener(Event.REMOVED_FROM_STAGE,pointerToState_target_removedFromStageHandler);
            _target.removeEventListener(MouseEvent.ROLL_OVER,pointerToState_target_rollOverHandler);
            _target.removeEventListener(MouseEvent.ROLL_OUT,pointerToState_target_rollOutHandler);
            _target.removeEventListener(MouseEvent.MOUSE_DOWN,pointerToState_target_mouseDownHandler);
         }
         _target = param1;
         if(_target != null)
         {
            _currentState = _upState;
            _target.addEventListener(Event.REMOVED_FROM_STAGE,pointerToState_target_removedFromStageHandler);
            _target.addEventListener(MouseEvent.ROLL_OVER,pointerToState_target_rollOverHandler);
            _target.addEventListener(MouseEvent.ROLL_OUT,pointerToState_target_rollOutHandler);
            _target.addEventListener(MouseEvent.MOUSE_DOWN,pointerToState_target_mouseDownHandler);
         }
         return _target;
      }
      
      public function set target(param1:InteractiveObject) : void
      {
         set_target(param1);
      }
      
      public function set_stateContext(param1:IStateContext) : IStateContext
      {
         if(_stateContext == param1)
         {
            return _stateContext;
         }
         _stateContext = param1;
         return _stateContext;
      }
      
      public function set stateContext(param1:IStateContext) : void
      {
         set_stateContext(param1);
      }
      
      public function set_keepDownStateOnRollOut(param1:Boolean) : Boolean
      {
         _keepDownStateOnRollOut = param1;
         return _keepDownStateOnRollOut;
      }
      
      public function set keepDownStateOnRollOut(param1:Boolean) : void
      {
         set_keepDownStateOnRollOut(param1);
      }
      
      public function set_hoverState(param1:Object) : Object
      {
         _hoverState = param1;
         return _hoverState;
      }
      
      public function set hoverState(param1:Object) : void
      {
         set_hoverState(param1);
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
      
      public function set_downState(param1:Object) : Object
      {
         _downState = param1;
         return _downState;
      }
      
      public function set downState(param1:Object) : void
      {
         set_downState(param1);
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
      
      public function resetTouchState() : void
      {
         _hoverBeforeDown = false;
         changeState(_upState);
      }
      
      public function pointerToState_target_rollOverHandler(param1:MouseEvent) : void
      {
         if(!_enabled)
         {
            return;
         }
         if(_customHitTest != null && !_customHitTest(param1.stageX,param1.stageY))
         {
            return;
         }
         _hoverBeforeDown = true;
         if(_down)
         {
            changeState(_downState);
         }
         else
         {
            changeState(_hoverState);
         }
      }
      
      public function pointerToState_target_rollOutHandler(param1:MouseEvent) : void
      {
         if(!_enabled)
         {
            return;
         }
         _hoverBeforeDown = false;
         if(_keepDownStateOnRollOut && _down)
         {
            changeState(_downState);
            return;
         }
         changeState(_upState);
      }
      
      public function pointerToState_target_removedFromStageHandler(param1:Event) : void
      {
         if(_target.stage != null)
         {
            _target.stage.removeEventListener(MouseEvent.MOUSE_UP,pointerToState_stage_mouseUpHandler);
         }
         resetTouchState();
      }
      
      public function pointerToState_target_mouseDownHandler(param1:MouseEvent) : void
      {
         if(!_enabled || _target.stage == null)
         {
            return;
         }
         if(_customHitTest != null && !_customHitTest(param1.stageX,param1.stageY))
         {
            return;
         }
         _down = true;
         _target.stage.addEventListener(MouseEvent.MOUSE_UP,pointerToState_stage_mouseUpHandler,false,0,true);
         changeState(_downState);
      }
      
      public function pointerToState_stage_mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Stage = param1.currentTarget;
         _down = false;
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,pointerToState_stage_mouseUpHandler);
         if(_hoverBeforeDown && _target.hitTestPoint(param1.stageX,param1.stageY))
         {
            changeState(_hoverState);
         }
         else
         {
            resetTouchState();
         }
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
      
      public function get_stateContext() : IStateContext
      {
         return _stateContext;
      }
      
      public function get stateContext() : IStateContext
      {
         return get_stateContext();
      }
      
      public function get_keepDownStateOnRollOut() : Boolean
      {
         return _keepDownStateOnRollOut;
      }
      
      public function get keepDownStateOnRollOut() : Boolean
      {
         return get_keepDownStateOnRollOut();
      }
      
      public function get_hoverState() : Object
      {
         return _hoverState;
      }
      
      public function get hoverState() : Object
      {
         return get_hoverState();
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
      
      public function get_customHitTest() : Function
      {
         return _customHitTest;
      }
      
      public function get customHitTest() : Function
      {
         return get_customHitTest();
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
         var _loc3_:IStateContext = _stateContext;
         if(_loc3_ == null && _target is IStateContext)
         {
            _loc3_ = _target;
         }
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.get_currentState();
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

