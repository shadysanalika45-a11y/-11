package feathers.controls.supportClasses
{
   import feathers.controls.IScrollBar;
   import feathers.core.FeathersControl;
   import feathers.core.IUIControl;
   import feathers.core.InvalidationFlag;
   import feathers.events.FeathersEvent;
   import feathers.events.ScrollEvent;
   import feathers.layout.Measurements;
   import feathers.skins.IProgrammaticSkin;
   import feathers.utils.ExclusivePointer;
   import feathers.utils.MathUtil;
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import openfl.display._internal.FlashGraphics;
   
   public class BaseScrollBar extends FeathersControl implements IScrollBar
   {
      
      public var liveDragging:Boolean;
      
      public var _value:Number;
      
      public var _trackSkinMeasurements:Measurements;
      
      public var _thumbStartY:Number;
      
      public var _thumbStartX:Number;
      
      public var _thumbSkinMeasurements:Measurements;
      
      public var _step:Number;
      
      public var _snapInterval:Number;
      
      public var _secondaryTrackSkinMeasurements:Measurements;
      
      public var _previousFallbackTrackWidth:Number;
      
      public var _previousFallbackTrackHeight:Number;
      
      public var _pointerStartY:Number;
      
      public var _pointerStartX:Number;
      
      public var _page:Number;
      
      public var _minimum:Number;
      
      public var _maximum:Number;
      
      public var _isDefaultValue:Boolean;
      
      public var _dragging:Boolean;
      
      public var _currentTrackSkin:InteractiveObject;
      
      public var _currentThumbSkin:InteractiveObject;
      
      public var _currentSecondaryTrackSkin:InteractiveObject;
      
      public var __trackSkin:InteractiveObject;
      
      public var __thumbSkin:InteractiveObject;
      
      public var __secondaryTrackSkin:InteractiveObject;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __hideThumbWhenDisabled:Boolean;
      
      public var __fixedThumbSize:Boolean;
      
      public function BaseScrollBar(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __hideThumbWhenDisabled = false;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         __fixedThumbSize = false;
         __secondaryTrackSkin = null;
         __trackSkin = null;
         __thumbSkin = null;
         _previousFallbackTrackHeight = 0;
         _previousFallbackTrackWidth = 0;
         _thumbStartY = 0;
         _thumbStartX = 0;
         _pointerStartY = 0;
         _pointerStartX = 0;
         _dragging = false;
         _secondaryTrackSkinMeasurements = null;
         _currentSecondaryTrackSkin = null;
         _trackSkinMeasurements = null;
         _currentTrackSkin = null;
         _thumbSkinMeasurements = null;
         _currentThumbSkin = null;
         liveDragging = true;
         _page = 0;
         _snapInterval = 0;
         _step = 0.01;
         _maximum = 1;
         _minimum = 0;
         _value = 0;
         _isDefaultValue = true;
         super();
         tabChildren = false;
         focusRect = null;
         set_minimum(param2);
         set_maximum(param3);
         set_value(param1);
         if(param4 != null)
         {
            addEventListener(Event.CHANGE,param4);
         }
      }
      
      public function valueToLocation(param1:Number) : Number
      {
         throw new TypeError("Missing override for \'valueToLocation\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.STYLES);
         if(_loc3_)
         {
            refreshThumb();
            refreshTrack();
            refreshSecondaryTrack();
         }
         if(_loc2_ || _loc3_)
         {
            refreshEnabled();
         }
         if(measure())
         {
            _loc1_ = true;
         }
         layoutContent();
      }
      
      public function trackSkin_stage_mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Stage = param1.currentTarget;
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,trackSkin_stage_mouseMoveHandler);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,trackSkin_stage_mouseUpHandler);
         _dragging = false;
         ScrollEvent.dispatch(this,"scrollComplete");
         if(!liveDragging)
         {
            FeathersEvent.dispatch(this,Event.CHANGE);
         }
      }
      
      public function trackSkin_stage_mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = locationToValue(mouseX,mouseY);
         _loc2_ = restrictValue(_loc2_);
         set_value(_loc2_);
      }
      
      public function trackSkin_mouseDownHandler(param1:MouseEvent) : void
      {
         if(!_enabled || stage == null)
         {
            return;
         }
         var _loc2_:ExclusivePointer = ExclusivePointer.forStage(stage);
         var _loc3_:Boolean = _loc2_.claimMouse(this);
         if(!_loc3_)
         {
            return;
         }
         stage.addEventListener(MouseEvent.MOUSE_MOVE,trackSkin_stage_mouseMoveHandler,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,trackSkin_stage_mouseUpHandler,false,0,true);
         saveThumbStart(mouseX,mouseY);
         _pointerStartX = mouseX;
         _pointerStartY = mouseY;
         _dragging = true;
         ScrollEvent.dispatch(this,"scrollStart");
         var _loc4_:Number = locationToValue(mouseX,mouseY);
         _loc4_ = restrictValue(_loc4_);
         set_value(_loc4_);
      }
      
      public function thumbSkin_stage_mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Stage = param1.currentTarget;
         _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE,thumbSkin_stage_mouseMoveHandler);
         _loc2_.removeEventListener(MouseEvent.MOUSE_UP,thumbSkin_stage_mouseUpHandler);
         _dragging = false;
         ScrollEvent.dispatch(this,"scrollComplete");
         if(!liveDragging)
         {
            FeathersEvent.dispatch(this,Event.CHANGE);
         }
      }
      
      public function thumbSkin_stage_mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = locationToValue(mouseX,mouseY);
         _loc2_ = restrictValue(_loc2_);
         set_value(_loc2_);
      }
      
      public function thumbSkin_mouseDownHandler(param1:MouseEvent) : void
      {
         if(!_enabled || stage == null)
         {
            return;
         }
         var _loc2_:ExclusivePointer = ExclusivePointer.forStage(stage);
         var _loc3_:Boolean = _loc2_.claimMouse(this);
         if(!_loc3_)
         {
            return;
         }
         stage.addEventListener(MouseEvent.MOUSE_MOVE,thumbSkin_stage_mouseMoveHandler,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_UP,thumbSkin_stage_mouseUpHandler,false,0,true);
         _thumbStartX = _currentThumbSkin.x;
         _thumbStartY = _currentThumbSkin.y;
         _pointerStartX = mouseX;
         _pointerStartY = mouseY;
         _dragging = true;
         ScrollEvent.dispatch(this,"scrollStart");
      }
      
      public function set_value(param1:Number) : Number
      {
         if(_value == param1)
         {
            return _value;
         }
         _isDefaultValue = false;
         _value = param1;
         setInvalid(InvalidationFlag.DATA);
         if(liveDragging || !_dragging)
         {
            FeathersEvent.dispatch(this,Event.CHANGE);
         }
         return _value;
      }
      
      public function set value(param1:Number) : void
      {
         set_value(param1);
      }
      
      public function set_trackSkin(param1:InteractiveObject) : InteractiveObject
      {
         if(!setStyle("trackSkin"))
         {
            return __trackSkin;
         }
         if(__trackSkin == param1)
         {
            return __trackSkin;
         }
         _previousClearStyle = clearStyle_trackSkin;
         __trackSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __trackSkin;
      }
      
      public function set trackSkin(param1:InteractiveObject) : void
      {
         set_trackSkin(param1);
      }
      
      public function set_thumbSkin(param1:InteractiveObject) : InteractiveObject
      {
         if(!setStyle("thumbSkin"))
         {
            return __thumbSkin;
         }
         if(__thumbSkin == param1)
         {
            return __thumbSkin;
         }
         _previousClearStyle = clearStyle_thumbSkin;
         __thumbSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __thumbSkin;
      }
      
      public function set thumbSkin(param1:InteractiveObject) : void
      {
         set_thumbSkin(param1);
      }
      
      public function set_step(param1:Number) : Number
      {
         if(_step == param1)
         {
            return _step;
         }
         _step = param1;
         setInvalid(InvalidationFlag.DATA);
         return _step;
      }
      
      public function set step(param1:Number) : void
      {
         set_step(param1);
      }
      
      public function set_snapInterval(param1:Number) : Number
      {
         if(_snapInterval == param1)
         {
            return _snapInterval;
         }
         _snapInterval = param1;
         setInvalid(InvalidationFlag.DATA);
         return _snapInterval;
      }
      
      public function set snapInterval(param1:Number) : void
      {
         set_snapInterval(param1);
      }
      
      public function set_secondaryTrackSkin(param1:InteractiveObject) : InteractiveObject
      {
         if(!setStyle("secondaryTrackSkin"))
         {
            return __secondaryTrackSkin;
         }
         if(__secondaryTrackSkin == param1)
         {
            return __secondaryTrackSkin;
         }
         _previousClearStyle = clearStyle_secondaryTrackSkin;
         __secondaryTrackSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __secondaryTrackSkin;
      }
      
      public function set secondaryTrackSkin(param1:InteractiveObject) : void
      {
         set_secondaryTrackSkin(param1);
      }
      
      public function set_page(param1:Number) : Number
      {
         if(_page == param1)
         {
            return _page;
         }
         _page = param1;
         setInvalid(InvalidationFlag.DATA);
         return _page;
      }
      
      public function set page(param1:Number) : void
      {
         set_page(param1);
      }
      
      public function set_paddingTop(param1:Number) : Number
      {
         if(!setStyle("paddingTop"))
         {
            return __paddingTop;
         }
         if(__paddingTop == param1)
         {
            return __paddingTop;
         }
         _previousClearStyle = clearStyle_paddingTop;
         __paddingTop = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         set_paddingTop(param1);
      }
      
      public function set_paddingRight(param1:Number) : Number
      {
         if(!setStyle("paddingRight"))
         {
            return __paddingRight;
         }
         if(__paddingRight == param1)
         {
            return __paddingRight;
         }
         _previousClearStyle = clearStyle_paddingRight;
         __paddingRight = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         set_paddingRight(param1);
      }
      
      public function set_paddingLeft(param1:Number) : Number
      {
         if(!setStyle("paddingLeft"))
         {
            return __paddingLeft;
         }
         if(__paddingLeft == param1)
         {
            return __paddingLeft;
         }
         _previousClearStyle = clearStyle_paddingLeft;
         __paddingLeft = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         set_paddingLeft(param1);
      }
      
      public function set_paddingBottom(param1:Number) : Number
      {
         if(!setStyle("paddingBottom"))
         {
            return __paddingBottom;
         }
         if(__paddingBottom == param1)
         {
            return __paddingBottom;
         }
         _previousClearStyle = clearStyle_paddingBottom;
         __paddingBottom = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         set_paddingBottom(param1);
      }
      
      public function set_minimum(param1:Number) : Number
      {
         if(_minimum == param1)
         {
            return _minimum;
         }
         _minimum = param1;
         setInvalid(InvalidationFlag.DATA);
         return _minimum;
      }
      
      public function set minimum(param1:Number) : void
      {
         set_minimum(param1);
      }
      
      public function set_maximum(param1:Number) : Number
      {
         if(_maximum == param1)
         {
            return _maximum;
         }
         _maximum = param1;
         setInvalid(InvalidationFlag.DATA);
         return _maximum;
      }
      
      public function set maximum(param1:Number) : void
      {
         set_maximum(param1);
      }
      
      public function set_hideThumbWhenDisabled(param1:Boolean) : Boolean
      {
         if(!setStyle("hideThumbWhenDisabled"))
         {
            return __hideThumbWhenDisabled;
         }
         if(__hideThumbWhenDisabled == param1)
         {
            return __hideThumbWhenDisabled;
         }
         _previousClearStyle = clearStyle_hideThumbWhenDisabled;
         __hideThumbWhenDisabled = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __hideThumbWhenDisabled;
      }
      
      public function set hideThumbWhenDisabled(param1:Boolean) : void
      {
         set_hideThumbWhenDisabled(param1);
      }
      
      public function set_fixedThumbSize(param1:Boolean) : Boolean
      {
         if(!setStyle("fixedThumbSize"))
         {
            return __fixedThumbSize;
         }
         if(__fixedThumbSize == param1)
         {
            return __fixedThumbSize;
         }
         _previousClearStyle = clearStyle_fixedThumbSize;
         __fixedThumbSize = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __fixedThumbSize;
      }
      
      public function set fixedThumbSize(param1:Boolean) : void
      {
         set_fixedThumbSize(param1);
      }
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function saveThumbStart(param1:Number, param2:Number) : void
      {
         throw new TypeError("Missing override for \'saveThumbStart\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function restrictValue(param1:Number) : Number
      {
         if(_snapInterval != 0 && param1 != _minimum && param1 != _maximum)
         {
            param1 = MathUtil.roundToNearest(param1,_snapInterval);
         }
         if(param1 < _minimum)
         {
            param1 = _minimum;
         }
         else if(param1 > _maximum)
         {
            param1 = _maximum;
         }
         return param1;
      }
      
      public function refreshTrack() : void
      {
         var _loc1_:InteractiveObject = _currentTrackSkin;
         _currentTrackSkin = get_trackSkin();
         if(_currentTrackSkin == _loc1_)
         {
            return;
         }
         if(_loc1_ != null)
         {
            if(_loc1_ is IProgrammaticSkin)
            {
               _loc1_.set_uiContext(null);
            }
            removeChild(_loc1_);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,trackSkin_mouseDownHandler);
         }
         if(_currentTrackSkin != null)
         {
            if(_currentTrackSkin is IUIControl)
            {
               _currentTrackSkin.initializeNow();
            }
            if(_trackSkinMeasurements == null)
            {
               _trackSkinMeasurements = new Measurements(_currentTrackSkin);
            }
            else
            {
               _trackSkinMeasurements.save(_currentTrackSkin);
            }
            addChildAt(_currentTrackSkin,0);
            _currentTrackSkin.addEventListener(MouseEvent.MOUSE_DOWN,trackSkin_mouseDownHandler);
            if(_currentTrackSkin is IProgrammaticSkin)
            {
               _currentTrackSkin.set_uiContext(this);
            }
         }
         else
         {
            _trackSkinMeasurements = null;
         }
      }
      
      public function refreshThumb() : void
      {
         var _loc1_:InteractiveObject = _currentThumbSkin;
         _currentThumbSkin = get_thumbSkin();
         if(_currentThumbSkin == _loc1_)
         {
            return;
         }
         if(_loc1_ != null)
         {
            if(_loc1_ is IProgrammaticSkin)
            {
               _loc1_.set_uiContext(null);
            }
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,thumbSkin_mouseDownHandler);
            removeChild(_loc1_);
         }
         if(_currentThumbSkin != null)
         {
            if(_currentThumbSkin is IUIControl)
            {
               _currentThumbSkin.initializeNow();
            }
            if(_thumbSkinMeasurements == null)
            {
               _thumbSkinMeasurements = new Measurements(_currentThumbSkin);
            }
            else
            {
               _thumbSkinMeasurements.save(_currentThumbSkin);
            }
            addChild(_currentThumbSkin);
            _currentThumbSkin.addEventListener(MouseEvent.MOUSE_DOWN,thumbSkin_mouseDownHandler);
            if(_currentThumbSkin is IProgrammaticSkin)
            {
               _currentThumbSkin.set_uiContext(this);
            }
         }
         else
         {
            _thumbSkinMeasurements = null;
         }
      }
      
      public function refreshSecondaryTrack() : void
      {
         var _loc2_:int = 0;
         var _loc1_:InteractiveObject = _currentSecondaryTrackSkin;
         _currentSecondaryTrackSkin = get_secondaryTrackSkin();
         if(_currentSecondaryTrackSkin == _loc1_)
         {
            return;
         }
         if(_loc1_ != null)
         {
            if(_loc1_ is IProgrammaticSkin)
            {
               _loc1_.set_uiContext(null);
            }
            removeChild(_loc1_);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,trackSkin_mouseDownHandler);
         }
         if(_currentSecondaryTrackSkin != null)
         {
            if(_currentSecondaryTrackSkin is IUIControl)
            {
               _currentSecondaryTrackSkin.initializeNow();
            }
            if(_secondaryTrackSkinMeasurements == null)
            {
               _secondaryTrackSkinMeasurements = new Measurements(_currentSecondaryTrackSkin);
            }
            else
            {
               _secondaryTrackSkinMeasurements.save(_currentSecondaryTrackSkin);
            }
            _loc2_ = _currentTrackSkin != null ? 1 : 0;
            addChildAt(_currentSecondaryTrackSkin,_loc2_);
            _currentSecondaryTrackSkin.addEventListener(MouseEvent.MOUSE_DOWN,trackSkin_mouseDownHandler);
            if(_currentSecondaryTrackSkin is IProgrammaticSkin)
            {
               _currentSecondaryTrackSkin.set_uiContext(this);
            }
         }
         else
         {
            _secondaryTrackSkinMeasurements = null;
         }
      }
      
      public function refreshEnabled() : void
      {
         if(_currentThumbSkin is IUIControl)
         {
            _currentThumbSkin.set_enabled(_enabled);
         }
      }
      
      public function normalizeValue(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         if(_minimum != _maximum)
         {
            _loc2_ = (param1 - _minimum) / (_maximum - _minimum);
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            else if(_loc2_ > 1)
            {
               _loc2_ = 1;
            }
         }
         return _loc2_;
      }
      
      public function measure() : Boolean
      {
         throw new TypeError("Missing override for \'measure\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function locationToValue(param1:Number, param2:Number) : Number
      {
         throw new TypeError("Missing override for \'locationToValue\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function layoutThumb() : void
      {
         throw new TypeError("Missing override for \'layoutThumb\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function layoutSplitTrack() : void
      {
         throw new TypeError("Missing override for \'layoutSplitTrack\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function layoutSingleTrack() : void
      {
         throw new TypeError("Missing override for \'layoutSingleTrack\' in type " + Type.getClassName(Type.getClass(this)));
      }
      
      public function layoutContent() : void
      {
         if(_currentTrackSkin != null && _currentSecondaryTrackSkin != null)
         {
            graphics.clear();
            layoutSplitTrack();
         }
         else if(_currentTrackSkin != null)
         {
            graphics.clear();
            layoutSingleTrack();
         }
         else
         {
            drawFallbackTrack();
         }
         layoutThumb();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(_isDefaultValue)
         {
            set_value(restrictValue(_value));
         }
      }
      
      public function get_value() : Number
      {
         return _value;
      }
      
      public function get value() : Number
      {
         return get_value();
      }
      
      public function get_trackSkin() : InteractiveObject
      {
         return __trackSkin;
      }
      
      public function get trackSkin() : InteractiveObject
      {
         return get_trackSkin();
      }
      
      public function get_thumbSkin() : InteractiveObject
      {
         return __thumbSkin;
      }
      
      public function get thumbSkin() : InteractiveObject
      {
         return get_thumbSkin();
      }
      
      public function get_step() : Number
      {
         return _step;
      }
      
      public function get step() : Number
      {
         return get_step();
      }
      
      public function get_snapInterval() : Number
      {
         return _snapInterval;
      }
      
      public function get snapInterval() : Number
      {
         return get_snapInterval();
      }
      
      public function get_secondaryTrackSkin() : InteractiveObject
      {
         return __secondaryTrackSkin;
      }
      
      public function get secondaryTrackSkin() : InteractiveObject
      {
         return get_secondaryTrackSkin();
      }
      
      public function get_page() : Number
      {
         return _page;
      }
      
      public function get page() : Number
      {
         return get_page();
      }
      
      public function get_paddingTop() : Number
      {
         return __paddingTop;
      }
      
      public function get paddingTop() : Number
      {
         return get_paddingTop();
      }
      
      public function get_paddingRight() : Number
      {
         return __paddingRight;
      }
      
      public function get paddingRight() : Number
      {
         return get_paddingRight();
      }
      
      public function get_paddingLeft() : Number
      {
         return __paddingLeft;
      }
      
      public function get paddingLeft() : Number
      {
         return get_paddingLeft();
      }
      
      public function get_paddingBottom() : Number
      {
         return __paddingBottom;
      }
      
      public function get paddingBottom() : Number
      {
         return get_paddingBottom();
      }
      
      public function get_minimum() : Number
      {
         return _minimum;
      }
      
      public function get minimum() : Number
      {
         return get_minimum();
      }
      
      public function get_maximum() : Number
      {
         return _maximum;
      }
      
      public function get maximum() : Number
      {
         return get_maximum();
      }
      
      public function get_hideThumbWhenDisabled() : Boolean
      {
         return __hideThumbWhenDisabled;
      }
      
      public function get hideThumbWhenDisabled() : Boolean
      {
         return get_hideThumbWhenDisabled();
      }
      
      public function get_fixedThumbSize() : Boolean
      {
         return __fixedThumbSize;
      }
      
      public function get fixedThumbSize() : Boolean
      {
         return get_fixedThumbSize();
      }
      
      public function getAdjustedPage() : Number
      {
         var _loc1_:Number = _maximum - _minimum;
         var _loc2_:Number = _page;
         if(_loc2_ == 0)
         {
            _loc2_ = _step;
         }
         else if(_loc2_ > _loc1_)
         {
            _loc2_ = _loc1_;
         }
         return _loc2_;
      }
      
      public function drawFallbackTrack() : void
      {
         if(actualWidth == _previousFallbackTrackWidth && actualHeight == _previousFallbackTrackHeight)
         {
            return;
         }
         graphics.clear();
         var _loc1_:Graphics = graphics;
         var _loc2_:BitmapData = null;
         FlashGraphics.bitmapFill[_loc1_] = _loc2_;
         _loc1_.beginFill(16711935,0);
         graphics.drawRect(0,0,actualWidth,actualHeight);
         _loc1_ = graphics;
         _loc2_ = null;
         FlashGraphics.bitmapFill[_loc1_] = _loc2_;
         _loc1_.endFill();
         _previousFallbackTrackWidth = actualWidth;
         _previousFallbackTrackHeight = actualHeight;
      }
      
      public function clearStyle_trackSkin() : InteractiveObject
      {
         set_trackSkin(null);
         return get_trackSkin();
      }
      
      public function clearStyle_thumbSkin() : InteractiveObject
      {
         set_thumbSkin(null);
         return get_thumbSkin();
      }
      
      public function clearStyle_secondaryTrackSkin() : InteractiveObject
      {
         set_secondaryTrackSkin(null);
         return get_secondaryTrackSkin();
      }
      
      public function clearStyle_paddingTop() : Number
      {
         set_paddingTop(0);
         return get_paddingTop();
      }
      
      public function clearStyle_paddingRight() : Number
      {
         set_paddingRight(0);
         return get_paddingRight();
      }
      
      public function clearStyle_paddingLeft() : Number
      {
         set_paddingLeft(0);
         return get_paddingLeft();
      }
      
      public function clearStyle_paddingBottom() : Number
      {
         set_paddingBottom(0);
         return get_paddingBottom();
      }
      
      public function clearStyle_hideThumbWhenDisabled() : Boolean
      {
         set_hideThumbWhenDisabled(false);
         return get_hideThumbWhenDisabled();
      }
      
      public function clearStyle_fixedThumbSize() : Boolean
      {
         set_fixedThumbSize(false);
         return get_fixedThumbSize();
      }
      
      public function applyValueRestrictions() : void
      {
         set_value(restrictValue(_value));
      }
   }
}

