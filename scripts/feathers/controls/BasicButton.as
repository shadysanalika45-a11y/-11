package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IMeasureObject;
   import feathers.core.IStateContext;
   import feathers.core.IStateObserver;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.events.FeathersEvent;
   import feathers.layout.Measurements;
   import feathers.skins.IProgrammaticSkin;
   import feathers.utils.KeyToState;
   import feathers.utils.MeasurementsUtil;
   import feathers.utils.PointerToState;
   import feathers.utils.PointerTrigger;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   
   public class BasicButton extends FeathersControl implements IStateContext, ITriggerView
   {
      
      public static var __meta__:* = {"fields":{"setSkinForState":{"style":null}}};
      
      public var _stateToSkin:IMap;
      
      public var _pointerTrigger:PointerTrigger;
      
      public var _pointerToState:PointerToState;
      
      public var _keyToState:KeyToState;
      
      public var _currentState:ButtonState;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var __keepDownStateOnRollOut:Boolean;
      
      public var __backgroundSkin:DisplayObject;
      
      public function BasicButton(param1:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __backgroundSkin = null;
         __keepDownStateOnRollOut = false;
         _stateToSkin = new EnumValueMap();
         _currentBackgroundSkin = null;
         _backgroundSkinMeasurements = null;
         _pointerTrigger = null;
         _keyToState = null;
         _pointerToState = null;
         _currentState = ButtonState.UP;
         super();
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = false;
         addEventListener(MouseEvent.CLICK,basicButton_clickHandler);
         addEventListener(TouchEvent.TOUCH_TAP,basicButton_touchTapHandler);
         if(param1 != null)
         {
            addEventListener("trigger",param1);
         }
      }
      
      override public function update() : void
      {
         commitChanges();
         measure();
         layoutContent();
      }
      
      public function set_keepDownStateOnRollOut(param1:Boolean) : Boolean
      {
         if(!setStyle("keepDownStateOnRollOut"))
         {
            return __keepDownStateOnRollOut;
         }
         if(__keepDownStateOnRollOut == param1)
         {
            return __keepDownStateOnRollOut;
         }
         _previousClearStyle = clearStyle_keepDownStateOnRollOut;
         __keepDownStateOnRollOut = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __keepDownStateOnRollOut;
      }
      
      public function set keepDownStateOnRollOut(param1:Boolean) : void
      {
         set_keepDownStateOnRollOut(param1);
      }
      
      override public function set_enabled(param1:Boolean) : Boolean
      {
         super.set_enabled(param1);
         if(_enabled)
         {
            if(_currentState == ButtonState.DISABLED)
            {
               changeState(ButtonState.UP);
            }
         }
         else
         {
            changeState(ButtonState.DISABLED);
         }
         return _enabled;
      }
      
      public function set_backgroundSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("backgroundSkin"))
         {
            return __backgroundSkin;
         }
         if(__backgroundSkin == param1)
         {
            return __backgroundSkin;
         }
         _previousClearStyle = clearStyle_backgroundSkin;
         __backgroundSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __backgroundSkin;
      }
      
      public function set backgroundSkin(param1:DisplayObject) : void
      {
         set_backgroundSkin(param1);
      }
      
      public function setSkinForState(param1:ButtonState, param2:DisplayObject) : void
      {
         if(!setStyle("setSkinForState",param1))
         {
            return;
         }
         var _loc3_:DisplayObject = _stateToSkin._SafeStr_2(param1);
         if(_loc3_ != null && _loc3_ == _currentBackgroundSkin)
         {
            removeCurrentBackgroundSkin(_loc3_);
            _currentBackgroundSkin = null;
         }
         if(param2 == null)
         {
            _stateToSkin.remove(param1);
         }
         else
         {
            _stateToSkin._SafeStr_1(param1,param2);
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function removeCurrentBackgroundSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(null);
         }
         _backgroundSkinMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
      }
      
      public function refreshInteractivity() : void
      {
         _pointerToState.set_keepDownStateOnRollOut(get_keepDownStateOnRollOut());
      }
      
      public function refreshBackgroundSkin() : void
      {
         var _loc1_:DisplayObject = _currentBackgroundSkin;
         _currentBackgroundSkin = getCurrentBackgroundSkin();
         if(_currentBackgroundSkin == _loc1_)
         {
            return;
         }
         removeCurrentBackgroundSkin(_loc1_);
         addCurrentBackgroundSkin(_currentBackgroundSkin);
      }
      
      public function measure() : Boolean
      {
         var _loc1_:* = get_explicitWidth() == null;
         var _loc2_:* = get_explicitHeight() == null;
         var _loc3_:* = get_explicitMinWidth() == null;
         var _loc4_:* = get_explicitMinHeight() == null;
         var _loc5_:* = get_explicitMaxWidth() == null;
         var _loc6_:* = get_explicitMaxHeight() == null;
         if(!_loc1_ && !_loc2_ && !_loc3_ && !_loc4_ && !_loc5_ && !_loc6_)
         {
            return false;
         }
         if(_currentBackgroundSkin != null)
         {
            MeasurementsUtil.resetFluidlyWithParent(_backgroundSkinMeasurements,_currentBackgroundSkin,this);
         }
         var _loc7_:IMeasureObject = null;
         if(_currentBackgroundSkin is IMeasureObject)
         {
            _loc7_ = _currentBackgroundSkin;
         }
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
         var _loc8_:Object = get_explicitWidth();
         if(_loc1_)
         {
            if(_currentBackgroundSkin != null)
            {
               _loc8_ = _currentBackgroundSkin.width;
            }
            else
            {
               _loc8_ = 0;
            }
         }
         var _loc9_:Object = get_explicitHeight();
         if(_loc2_)
         {
            if(_currentBackgroundSkin != null)
            {
               _loc9_ = _currentBackgroundSkin.height;
            }
            else
            {
               _loc9_ = 0;
            }
         }
         var _loc10_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            if(_loc7_ != null)
            {
               _loc10_ = _loc7_.get_minWidth();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc10_ = _backgroundSkinMeasurements.minWidth;
            }
            else
            {
               _loc10_ = 0;
            }
         }
         var _loc11_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            if(_loc7_ != null)
            {
               _loc11_ = _loc7_.get_minHeight();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc11_ = _backgroundSkinMeasurements.minHeight;
            }
            else
            {
               _loc11_ = 0;
            }
         }
         var _loc12_:Object = get_explicitMaxWidth();
         if(_loc5_)
         {
            if(_loc7_ != null)
            {
               _loc12_ = _loc7_.get_maxWidth();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc12_ = _backgroundSkinMeasurements.maxWidth;
            }
            else
            {
               _loc12_ = 1 / 0;
            }
         }
         var _loc13_:Object = get_explicitMaxHeight();
         if(_loc6_)
         {
            if(_loc7_ != null)
            {
               _loc13_ = _loc7_.get_maxHeight();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc13_ = _backgroundSkinMeasurements.maxHeight;
            }
            else
            {
               _loc13_ = 1 / 0;
            }
         }
         return saveMeasurements(_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
      }
      
      public function layoutContent() : void
      {
         layoutBackgroundSkin();
      }
      
      public function layoutBackgroundSkin() : void
      {
         if(_currentBackgroundSkin == null)
         {
            return;
         }
         _currentBackgroundSkin.x = 0;
         _currentBackgroundSkin.y = 0;
         if(_currentBackgroundSkin.width != actualWidth)
         {
            _currentBackgroundSkin.width = actualWidth;
         }
         if(_currentBackgroundSkin.height != actualHeight)
         {
            _currentBackgroundSkin.height = actualHeight;
         }
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(_pointerToState == null)
         {
            _pointerToState = new PointerToState(this,changeState,ButtonState.UP,ButtonState.DOWN,ButtonState.HOVER);
         }
         if(_keyToState == null)
         {
            _keyToState = new KeyToState(this,changeState,ButtonState.UP,ButtonState.DOWN);
         }
         if(_pointerTrigger == null)
         {
            _pointerTrigger = new PointerTrigger(this);
         }
      }
      
      public function get_keepDownStateOnRollOut() : Boolean
      {
         return __keepDownStateOnRollOut;
      }
      
      public function get keepDownStateOnRollOut() : Boolean
      {
         return get_keepDownStateOnRollOut();
      }
      
      public function get_currentState() : *
      {
         return _currentState;
      }
      
      public function get currentState() : *
      {
         return get_currentState();
      }
      
      public function get_backgroundSkin() : DisplayObject
      {
         return __backgroundSkin;
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function getSkinForState(param1:ButtonState) : DisplayObject
      {
         return _stateToSkin._SafeStr_2(param1);
      }
      
      public function getCurrentBackgroundSkin() : DisplayObject
      {
         var _loc1_:DisplayObject = _stateToSkin._SafeStr_2(_currentState);
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         return get_backgroundSkin();
      }
      
      public function commitChanges() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.STYLES);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.STATE);
         if(_loc1_ || _loc2_)
         {
            refreshBackgroundSkin();
         }
         if(_loc1_)
         {
            refreshInteractivity();
         }
      }
      
      public function clearStyle_keepDownStateOnRollOut() : Boolean
      {
         set_keepDownStateOnRollOut(false);
         return get_keepDownStateOnRollOut();
      }
      
      public function clearStyle_backgroundSkin() : DisplayObject
      {
         set_backgroundSkin(null);
         return get_backgroundSkin();
      }
      
      public function changeState(param1:ButtonState) : void
      {
         if(!_enabled)
         {
            param1 = ButtonState.DISABLED;
         }
         if(_currentState == param1)
         {
            return;
         }
         _currentState = param1;
         setInvalid(InvalidationFlag.STATE);
         FeathersEvent.dispatch(this,"stateChange");
      }
      
      public function basicButton_touchTapHandler(param1:TouchEvent) : void
      {
         if(!_enabled)
         {
            param1.stopImmediatePropagation();
            return;
         }
      }
      
      public function basicButton_clickHandler(param1:MouseEvent) : void
      {
         if(!_enabled)
         {
            param1.stopImmediatePropagation();
            return;
         }
      }
      
      public function addCurrentBackgroundSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            _backgroundSkinMeasurements = null;
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(_backgroundSkinMeasurements == null)
         {
            _backgroundSkinMeasurements = new Measurements(param1);
         }
         else
         {
            _backgroundSkinMeasurements.save(param1);
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(this);
         }
         addChildAt(param1,0);
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
