package feathers.controls.supportClasses
{
   import feathers.controls.IScrollBar;
   import feathers.controls.ScrollMode;
   import feathers.controls.ScrollPolicy;
   import feathers.core.FeathersControl;
   import feathers.core.IFocusObject;
   import feathers.core.IMeasureObject;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.events.ScrollEvent;
   import feathers.graphics.FillStyle;
   import feathers.layout.Measurements;
   import feathers.layout.RelativePosition;
   import feathers.skins.IProgrammaticSkin;
   import feathers.skins.RectangleSkin;
   import feathers.utils.DisplayObjectFactory;
   import feathers.utils.DisplayUtil;
   import feathers.utils.ExclusivePointer;
   import feathers.utils.MathUtil;
   import feathers.utils.MeasurementsUtil;
   import feathers.utils.Scroller;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Rectangle;
   import motion.Actuate;
   import motion.actuators.GenericActuator;
   import motion.actuators.SimpleActuator;
   import motion.easing.IEasing;
   import motion.easing.Quart;
   import openfl.Lib;
   
   public class BaseScrollContainer extends FeathersControl implements IFocusObject
   {
      
      public static var INVALIDATION_FLAG_SCROLLER_FACTORY:InvalidationFlag = InvalidationFlag.CUSTOM("scrollerFactory");
      
      public static var INVALIDATION_FLAG_SCROLL_BAR_FACTORY:InvalidationFlag = InvalidationFlag.CUSTOM("scrollBarFactory");
      
      public static var defaultScrollBarXFactory:DisplayObjectFactory = DisplayObjectFactory.withClass(HScrollBar);
      
      public static var defaultScrollBarYFactory:DisplayObjectFactory = DisplayObjectFactory.withClass(VScrollBar);
      
      public var topViewPortOffset:Number;
      
      public var showScrollBarY:Boolean;
      
      public var showScrollBarX:Boolean;
      
      public var scroller:Scroller;
      
      public var scrollBarY:IScrollBar;
      
      public var scrollBarX:IScrollBar;
      
      public var rightViewPortOffset:Number;
      
      public var leftViewPortOffset:Number;
      
      public var chromeMeasuredWidth:Number;
      
      public var chromeMeasuredMinWidth:Number;
      
      public var chromeMeasuredMinHeight:Number;
      
      public var chromeMeasuredMaxWidth:Number;
      
      public var chromeMeasuredMaxHeight:Number;
      
      public var chromeMeasuredHeight:Number;
      
      public var bottomViewPortOffset:Number;
      
      public var _viewPortBoundsChanged:Boolean;
      
      public var _viewPort:IViewPort;
      
      public var _temporaryScrollY:Object;
      
      public var _temporaryScrollX:Object;
      
      public var _temporaryRestrictedScrollY:Object;
      
      public var _temporaryRestrictedScrollX:Object;
      
      public var _settingScrollerDimensions:Boolean;
      
      public var _scrollerFactory:Function;
      
      public var _scrollerDraggingY:Boolean;
      
      public var _scrollerDraggingX:Boolean;
      
      public var _scrollStepY:Number;
      
      public var _scrollStepX:Number;
      
      public var _scrollRect2:Rectangle;
      
      public var _scrollRect1:Rectangle;
      
      public var _scrollPolicyY:ScrollPolicy;
      
      public var _scrollPolicyX:ScrollPolicy;
      
      public var _scrollMode:ScrollMode;
      
      public var _scrollBarYRevealTime:int;
      
      public var _scrollBarYHover:Boolean;
      
      public var _scrollBarYFactory:DisplayObjectFactory;
      
      public var _scrollBarXRevealTime:int;
      
      public var _scrollBarXHover:Boolean;
      
      public var _scrollBarXFactory:DisplayObjectFactory;
      
      public var _previousViewPortWidth:Number;
      
      public var _previousViewPortHeight:Number;
      
      public var _prevMinScrollY:Number;
      
      public var _prevMinScrollX:Number;
      
      public var _prevMaxScrollY:Number;
      
      public var _prevMaxScrollX:Number;
      
      public var _oldScrollBarYFactory:DisplayObjectFactory;
      
      public var _oldScrollBarXFactory:DisplayObjectFactory;
      
      public var _ignoreViewPortResizing:Boolean;
      
      public var _ignoreScrollerChanges:Boolean;
      
      public var _ignoreScrollBarYChange:Boolean;
      
      public var _ignoreScrollBarXChange:Boolean;
      
      public var _hideScrollBarY:SimpleActuator;
      
      public var _hideScrollBarX:SimpleActuator;
      
      public var _fallbackViewPortMaskSkin:DisplayObject;
      
      public var _currentViewPortMaskSkin:DisplayObject;
      
      public var _currentScrollRect:Rectangle;
      
      public var _currentMaskSkin:DisplayObject;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var __viewPortMaskSkin:DisplayObject;
      
      public var __showScrollBars:Boolean;
      
      public var __showScrollBarMinimumDuration:Number;
      
      public var __scrollPixelSnapping:Boolean;
      
      public var __scrollBarYPosition:RelativePosition;
      
      public var __scrollBarXPosition:RelativePosition;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __maskSkin:DisplayObject;
      
      public var __hideScrollBarEase:IEasing;
      
      public var __hideScrollBarDuration:Number;
      
      public var __fixedScrollBars:Boolean;
      
      public var __disabledBackgroundSkin:DisplayObject;
      
      public var __backgroundSkin:DisplayObject;
      
      public var __autoHideScrollBars:Boolean;
      
      public function BaseScrollContainer()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __scrollPixelSnapping = false;
         __hideScrollBarEase = Quart.easeOut;
         __hideScrollBarDuration = 0.2;
         __showScrollBarMinimumDuration = 0.5;
         __scrollBarYPosition = RelativePosition.RIGHT;
         __scrollBarXPosition = RelativePosition.BOTTOM;
         __autoHideScrollBars = true;
         __showScrollBars = true;
         __fixedScrollBars = false;
         __viewPortMaskSkin = null;
         __maskSkin = null;
         __disabledBackgroundSkin = null;
         __backgroundSkin = null;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         _scrollMode = ScrollMode.MASK;
         _previousViewPortHeight = 0;
         _previousViewPortWidth = 0;
         _ignoreViewPortResizing = false;
         _viewPortBoundsChanged = false;
         _settingScrollerDimensions = false;
         _ignoreScrollerChanges = false;
         _scrollRect2 = new Rectangle();
         _scrollRect1 = new Rectangle();
         _prevMaxScrollY = 0;
         _prevMinScrollY = 0;
         _prevMaxScrollX = 0;
         _prevMinScrollX = 0;
         _hideScrollBarY = null;
         _hideScrollBarX = null;
         _scrollPolicyY = ScrollPolicy.AUTO;
         _scrollPolicyX = ScrollPolicy.AUTO;
         _scrollStepY = 0;
         _scrollStepX = 0;
         _temporaryRestrictedScrollY = null;
         _temporaryScrollY = null;
         _temporaryRestrictedScrollX = null;
         _temporaryScrollX = null;
         showScrollBarY = false;
         showScrollBarX = false;
         _ignoreScrollBarYChange = false;
         _ignoreScrollBarXChange = false;
         chromeMeasuredMaxHeight = 1 / 0;
         chromeMeasuredMinHeight = 0;
         chromeMeasuredHeight = 0;
         chromeMeasuredMaxWidth = 1 / 0;
         chromeMeasuredMinWidth = 0;
         chromeMeasuredWidth = 0;
         leftViewPortOffset = 0;
         bottomViewPortOffset = 0;
         rightViewPortOffset = 0;
         topViewPortOffset = 0;
         _fallbackViewPortMaskSkin = null;
         _currentViewPortMaskSkin = null;
         _currentMaskSkin = null;
         _backgroundSkinMeasurements = null;
         _currentBackgroundSkin = null;
         _scrollBarYHover = false;
         _scrollBarXHover = false;
         _scrollerDraggingY = false;
         _scrollerDraggingX = false;
         super();
         tabEnabled = true;
         tabChildren = true;
         focusRect = null;
         addEventListener(KeyboardEvent.KEY_DOWN,baseScrollContainer_keyDownHandler);
         addEventListener(Event.ADDED_TO_STAGE,baseScrollContainer_addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,baseScrollContainer_removedFromStageHandler);
      }
      
      public function viewPort_resizeHandler(param1:Event) : void
      {
         if(_ignoreViewPortResizing || MathUtil.fuzzyEquals(Number(_viewPort.width),_previousViewPortWidth) && MathUtil.fuzzyEquals(Number(_viewPort.height),_previousViewPortHeight))
         {
            return;
         }
         _previousViewPortWidth = Number(_viewPort.width);
         _previousViewPortHeight = Number(_viewPort.height);
         if(_validating)
         {
            _viewPortBoundsChanged = true;
         }
         else
         {
            setInvalid(InvalidationFlag.SIZE);
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.STYLES);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc4_:Boolean = isInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLLER_FACTORY);
         var _loc5_:Boolean = isInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLL_BAR_FACTORY);
         var _loc6_:Boolean = _ignoreScrollerChanges;
         _ignoreScrollerChanges = true;
         if(_loc4_)
         {
            createScroller();
         }
         if(_loc1_ || _loc3_)
         {
            refreshBackgroundSkin();
         }
         if(_loc1_)
         {
            refreshMaskSkin();
            refreshViewPortMaskSkin();
         }
         if(_loc5_)
         {
            createScrollBars();
         }
         refreshEnabled();
         refreshScrollerValues();
         refreshViewPort();
         applyTemporaryScrollPositions();
         refreshScrollRect();
         refreshScrollBarValues();
         layoutChildren();
         _ignoreScrollerChanges = _loc6_;
      }
      
      public function set_viewPortMaskSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("viewPortMaskSkin"))
         {
            return __viewPortMaskSkin;
         }
         if(__viewPortMaskSkin == param1)
         {
            return __viewPortMaskSkin;
         }
         _previousClearStyle = clearStyle_viewPortMaskSkin;
         __viewPortMaskSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __viewPortMaskSkin;
      }
      
      public function set viewPortMaskSkin(param1:DisplayObject) : void
      {
         set_viewPortMaskSkin(param1);
      }
      
      public function set_viewPort(param1:IViewPort) : IViewPort
      {
         if(_viewPort == param1)
         {
            return _viewPort;
         }
         if(_viewPort != null)
         {
            _viewPort.removeEventListener(Event.RESIZE,viewPort_resizeHandler);
         }
         if(scroller != null)
         {
            scroller.set_target(null);
         }
         _viewPort = param1;
         if(_viewPort != null)
         {
            _viewPort.addEventListener(Event.RESIZE,viewPort_resizeHandler);
         }
         setInvalid(InvalidationFlag.SCROLL);
         return _viewPort;
      }
      
      public function set viewPort(param1:IViewPort) : void
      {
         set_viewPort(param1);
      }
      
      public function set_showScrollBars(param1:Boolean) : Boolean
      {
         if(!setStyle("showScrollBars"))
         {
            return __showScrollBars;
         }
         if(__showScrollBars == param1)
         {
            return __showScrollBars;
         }
         _previousClearStyle = clearStyle_showScrollBars;
         __showScrollBars = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __showScrollBars;
      }
      
      public function set showScrollBars(param1:Boolean) : void
      {
         set_showScrollBars(param1);
      }
      
      public function set_showScrollBarMinimumDuration(param1:Number) : Number
      {
         if(!setStyle("showScrollBarMinimumDuration"))
         {
            return __showScrollBarMinimumDuration;
         }
         if(__showScrollBarMinimumDuration == param1)
         {
            return __showScrollBarMinimumDuration;
         }
         _previousClearStyle = clearStyle_showScrollBarMinimumDuration;
         __showScrollBarMinimumDuration = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __showScrollBarMinimumDuration;
      }
      
      public function set showScrollBarMinimumDuration(param1:Number) : void
      {
         set_showScrollBarMinimumDuration(param1);
      }
      
      public function set_scrollerFactory(param1:Function) : Function
      {
         if(_scrollerFactory == param1)
         {
            return _scrollerFactory;
         }
         _scrollerFactory = param1;
         setInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLLER_FACTORY);
         return _scrollerFactory;
      }
      
      public function set scrollerFactory(param1:Function) : void
      {
         set_scrollerFactory(param1);
      }
      
      public function set_scrollY(param1:Number) : Number
      {
         if(scroller == null)
         {
            _temporaryScrollY = param1;
            _temporaryRestrictedScrollY = null;
            ScrollEvent.dispatch(this,"scroll");
            return _temporaryScrollY;
         }
         scroller.set_scrollY(param1);
         return scroller.get_scrollY();
      }
      
      public function set scrollY(param1:Number) : void
      {
         set_scrollY(param1);
      }
      
      public function set_scrollX(param1:Number) : Number
      {
         if(scroller == null)
         {
            _temporaryScrollX = param1;
            _temporaryRestrictedScrollX = null;
            ScrollEvent.dispatch(this,"scroll");
            return _temporaryScrollX;
         }
         scroller.set_scrollX(param1);
         return scroller.get_scrollX();
      }
      
      public function set scrollX(param1:Number) : void
      {
         set_scrollX(param1);
      }
      
      public function set_scrollStepY(param1:Number) : Number
      {
         if(_scrollStepY == param1)
         {
            return _scrollStepY;
         }
         _scrollStepY = param1;
         setInvalid(InvalidationFlag.SCROLL);
         return _scrollStepY;
      }
      
      public function set scrollStepY(param1:Number) : void
      {
         set_scrollStepY(param1);
      }
      
      public function set_scrollStepX(param1:Number) : Number
      {
         if(_scrollStepX == param1)
         {
            return _scrollStepX;
         }
         _scrollStepX = param1;
         setInvalid(InvalidationFlag.SCROLL);
         return _scrollStepX;
      }
      
      public function set scrollStepX(param1:Number) : void
      {
         set_scrollStepX(param1);
      }
      
      public function set_scrollPolicyY(param1:ScrollPolicy) : ScrollPolicy
      {
         if(_scrollPolicyY == param1)
         {
            return _scrollPolicyY;
         }
         _scrollPolicyY = param1;
         setInvalid(InvalidationFlag.SCROLL);
         return _scrollPolicyY;
      }
      
      public function set scrollPolicyY(param1:ScrollPolicy) : void
      {
         set_scrollPolicyY(param1);
      }
      
      public function set_scrollPolicyX(param1:ScrollPolicy) : ScrollPolicy
      {
         if(_scrollPolicyX == param1)
         {
            return _scrollPolicyX;
         }
         _scrollPolicyX = param1;
         setInvalid(InvalidationFlag.SCROLL);
         return _scrollPolicyX;
      }
      
      public function set scrollPolicyX(param1:ScrollPolicy) : void
      {
         set_scrollPolicyX(param1);
      }
      
      public function set_scrollPixelSnapping(param1:Boolean) : Boolean
      {
         if(!setStyle("scrollPixelSnapping"))
         {
            return __scrollPixelSnapping;
         }
         if(__scrollPixelSnapping == param1)
         {
            return __scrollPixelSnapping;
         }
         _previousClearStyle = clearStyle_scrollPixelSnapping;
         __scrollPixelSnapping = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __scrollPixelSnapping;
      }
      
      public function set scrollPixelSnapping(param1:Boolean) : void
      {
         set_scrollPixelSnapping(param1);
      }
      
      public function set_scrollMode(param1:ScrollMode) : ScrollMode
      {
         if(_scrollMode == param1)
         {
            return _scrollMode;
         }
         _scrollMode = param1;
         setInvalid(InvalidationFlag.LAYOUT);
         return _scrollMode;
      }
      
      public function set scrollMode(param1:ScrollMode) : void
      {
         set_scrollMode(param1);
      }
      
      public function set_scrollBarYPosition(param1:RelativePosition) : RelativePosition
      {
         if(!setStyle("scrollBarYPosition"))
         {
            return __scrollBarYPosition;
         }
         if(__scrollBarYPosition == param1)
         {
            return __scrollBarYPosition;
         }
         _previousClearStyle = clearStyle_scrollBarYPosition;
         __scrollBarYPosition = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __scrollBarYPosition;
      }
      
      public function set scrollBarYPosition(param1:RelativePosition) : void
      {
         set_scrollBarYPosition(param1);
      }
      
      public function set_scrollBarYFactory(param1:DisplayObjectFactory) : DisplayObjectFactory
      {
         if(_scrollBarYFactory == param1)
         {
            return _scrollBarYFactory;
         }
         _scrollBarYFactory = param1;
         setInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLL_BAR_FACTORY);
         return _scrollBarYFactory;
      }
      
      public function set scrollBarYFactory(param1:DisplayObjectFactory) : void
      {
         set_scrollBarYFactory(param1);
      }
      
      public function set_scrollBarXPosition(param1:RelativePosition) : RelativePosition
      {
         if(!setStyle("scrollBarXPosition"))
         {
            return __scrollBarXPosition;
         }
         if(__scrollBarXPosition == param1)
         {
            return __scrollBarXPosition;
         }
         _previousClearStyle = clearStyle_scrollBarXPosition;
         __scrollBarXPosition = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __scrollBarXPosition;
      }
      
      public function set scrollBarXPosition(param1:RelativePosition) : void
      {
         set_scrollBarXPosition(param1);
      }
      
      public function set_scrollBarXFactory(param1:DisplayObjectFactory) : DisplayObjectFactory
      {
         if(_scrollBarXFactory == param1)
         {
            return _scrollBarXFactory;
         }
         _scrollBarXFactory = param1;
         setInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLL_BAR_FACTORY);
         return _scrollBarXFactory;
      }
      
      public function set scrollBarXFactory(param1:DisplayObjectFactory) : void
      {
         set_scrollBarXFactory(param1);
      }
      
      public function set_restrictedScrollY(param1:Number) : Number
      {
         if(scroller == null)
         {
            _temporaryRestrictedScrollY = param1;
            _temporaryScrollY = null;
            ScrollEvent.dispatch(this,"scroll");
            return _temporaryRestrictedScrollY;
         }
         scroller.set_restrictedScrollY(param1);
         return scroller.get_restrictedScrollY();
      }
      
      public function set restrictedScrollY(param1:Number) : void
      {
         set_restrictedScrollY(param1);
      }
      
      public function set_restrictedScrollX(param1:Number) : Number
      {
         if(scroller == null)
         {
            _temporaryRestrictedScrollX = param1;
            _temporaryScrollX = null;
            ScrollEvent.dispatch(this,"scroll");
            return _temporaryRestrictedScrollX;
         }
         scroller.set_restrictedScrollX(param1);
         return scroller.get_restrictedScrollX();
      }
      
      public function set restrictedScrollX(param1:Number) : void
      {
         set_restrictedScrollX(param1);
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
      
      public function set_maskSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("maskSkin"))
         {
            return __maskSkin;
         }
         if(__maskSkin == param1)
         {
            return __maskSkin;
         }
         _previousClearStyle = clearStyle_maskSkin;
         __maskSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __maskSkin;
      }
      
      public function set maskSkin(param1:DisplayObject) : void
      {
         set_maskSkin(param1);
      }
      
      public function set_hideScrollBarEase(param1:IEasing) : IEasing
      {
         if(!setStyle("hideScrollBarEase"))
         {
            return __hideScrollBarEase;
         }
         if(__hideScrollBarEase == param1)
         {
            return __hideScrollBarEase;
         }
         _previousClearStyle = clearStyle_hideScrollBarEase;
         __hideScrollBarEase = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __hideScrollBarEase;
      }
      
      public function set hideScrollBarEase(param1:IEasing) : void
      {
         set_hideScrollBarEase(param1);
      }
      
      public function set_hideScrollBarDuration(param1:Number) : Number
      {
         if(!setStyle("hideScrollBarDuration"))
         {
            return __hideScrollBarDuration;
         }
         if(__hideScrollBarDuration == param1)
         {
            return __hideScrollBarDuration;
         }
         _previousClearStyle = clearStyle_hideScrollBarDuration;
         __hideScrollBarDuration = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __hideScrollBarDuration;
      }
      
      public function set hideScrollBarDuration(param1:Number) : void
      {
         set_hideScrollBarDuration(param1);
      }
      
      public function set_fixedScrollBars(param1:Boolean) : Boolean
      {
         if(!setStyle("fixedScrollBars"))
         {
            return __fixedScrollBars;
         }
         if(__fixedScrollBars == param1)
         {
            return __fixedScrollBars;
         }
         _previousClearStyle = clearStyle_fixedScrollBars;
         __fixedScrollBars = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __fixedScrollBars;
      }
      
      public function set fixedScrollBars(param1:Boolean) : void
      {
         set_fixedScrollBars(param1);
      }
      
      public function set_disabledBackgroundSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("disabledBackgroundSkin"))
         {
            return __disabledBackgroundSkin;
         }
         if(__disabledBackgroundSkin == param1)
         {
            return __disabledBackgroundSkin;
         }
         _previousClearStyle = clearStyle_disabledBackgroundSkin;
         __disabledBackgroundSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __disabledBackgroundSkin;
      }
      
      public function set disabledBackgroundSkin(param1:DisplayObject) : void
      {
         set_disabledBackgroundSkin(param1);
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
      
      public function set_autoHideScrollBars(param1:Boolean) : Boolean
      {
         if(!setStyle("autoHideScrollBars"))
         {
            return __autoHideScrollBars;
         }
         if(__autoHideScrollBars == param1)
         {
            return __autoHideScrollBars;
         }
         _previousClearStyle = clearStyle_autoHideScrollBars;
         __autoHideScrollBars = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __autoHideScrollBars;
      }
      
      public function set autoHideScrollBars(param1:Boolean) : void
      {
         set_autoHideScrollBars(param1);
      }
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function scrollWithKeyboard(param1:KeyboardEvent) : void
      {
         if(_scrollPolicyY == ScrollPolicy.OFF && _scrollPolicyX == ScrollPolicy.OFF)
         {
            return;
         }
         var _loc2_:Number = _scrollStepX;
         if(_loc2_ <= 0)
         {
            _loc2_ = 1;
         }
         var _loc3_:Number = _scrollStepY;
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         var _loc4_:Number = get_scrollX();
         var _loc5_:Number = get_scrollY();
         switch(int(param1.keyCode))
         {
            case 33:
               _loc5_ = get_scrollY() - _viewPort.get_visibleHeight();
               break;
            case 34:
               _loc5_ = get_scrollY() + _viewPort.get_visibleHeight();
               break;
            case 35:
               _loc5_ = get_maxScrollY();
               break;
            case 36:
               _loc5_ = get_minScrollY();
               break;
            case 37:
               _loc4_ = get_scrollX() - _loc2_;
               break;
            case 38:
               _loc5_ = get_scrollY() - _loc3_;
               break;
            case 39:
               _loc4_ = get_scrollX() + _loc2_;
               break;
            case 40:
               _loc5_ = get_scrollY() + _loc3_;
               break;
            default:
               return;
         }
         if(_loc5_ < get_minScrollY())
         {
            _loc5_ = get_minScrollY();
         }
         else if(_loc5_ > get_maxScrollY())
         {
            _loc5_ = get_maxScrollY();
         }
         if(_loc4_ < get_minScrollX())
         {
            _loc4_ = get_minScrollX();
         }
         else if(_loc4_ > get_maxScrollX())
         {
            _loc4_ = get_maxScrollX();
         }
         var _loc6_:Boolean = false;
         if(get_scrollY() != _loc5_ && _scrollPolicyY != ScrollPolicy.OFF)
         {
            _loc6_ = true;
            set_scrollY(_loc5_);
         }
         if(get_scrollX() != _loc4_ && _scrollPolicyX != ScrollPolicy.OFF)
         {
            _loc6_ = true;
            set_scrollX(_loc4_);
         }
         if(_loc6_)
         {
            param1.preventDefault();
         }
      }
      
      public function scrollBarY_scrollStartHandler(param1:ScrollEvent) : void
      {
         scroller.stop();
         _scrollerDraggingY = true;
         ScrollEvent.dispatch(this,"scrollStart");
      }
      
      public function scrollBarY_scrollCompleteHandler(param1:ScrollEvent) : void
      {
         _scrollerDraggingY = false;
         if(!_scrollBarYHover && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarY();
         }
         ScrollEvent.dispatch(this,"scrollComplete");
      }
      
      public function scrollBarY_rollOverHandler(param1:MouseEvent) : void
      {
         _scrollBarYHover = true;
         revealScrollBarY();
      }
      
      public function scrollBarY_rollOutHandler(param1:MouseEvent) : void
      {
         if(!_scrollBarYHover)
         {
            return;
         }
         _scrollBarYHover = false;
         if(!_scrollerDraggingY && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarY();
         }
      }
      
      public function scrollBarY_changeHandler(param1:Event) : void
      {
         if(_ignoreScrollBarYChange)
         {
            return;
         }
         scroller.set_scrollY(Number(scrollBarY.get_value()));
      }
      
      public function scrollBarX_scrollStartHandler(param1:ScrollEvent) : void
      {
         scroller.stop();
         _scrollerDraggingX = true;
         ScrollEvent.dispatch(this,"scrollStart");
      }
      
      public function scrollBarX_scrollCompleteHandler(param1:ScrollEvent) : void
      {
         _scrollerDraggingX = false;
         if(!_scrollBarXHover && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarX();
         }
         ScrollEvent.dispatch(this,"scrollComplete");
      }
      
      public function scrollBarX_rollOverHandler(param1:MouseEvent) : void
      {
         _scrollBarXHover = true;
         revealScrollBarX();
      }
      
      public function scrollBarX_rollOutHandler(param1:MouseEvent) : void
      {
         if(!_scrollBarXHover)
         {
            return;
         }
         _scrollBarXHover = false;
         if(!_scrollerDraggingX && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarX();
         }
      }
      
      public function scrollBarX_changeHandler(param1:Event) : void
      {
         if(_ignoreScrollBarXChange)
         {
            return;
         }
         scroller.set_scrollX(Number(scrollBarX.get_value()));
      }
      
      public function revealScrollBarY() : void
      {
         if(scrollBarY == null || scroller.get_minScrollY() == scroller.get_maxScrollY())
         {
            return;
         }
         if(_hideScrollBarY != null)
         {
            Actuate.stop(_hideScrollBarY);
         }
         scrollBarY.alpha = 1;
         _scrollBarYRevealTime = Lib.getTimer();
      }
      
      public function revealScrollBarX() : void
      {
         if(scrollBarX == null || scroller.get_minScrollX() == scroller.get_maxScrollX())
         {
            return;
         }
         if(_hideScrollBarX != null)
         {
            Actuate.stop(_hideScrollBarX);
         }
         scrollBarX.alpha = 1;
         _scrollBarXRevealTime = Lib.getTimer();
      }
      
      public function restrictScrollAfterRefreshViewPort() : void
      {
         if(scroller.get_scrolling())
         {
            return;
         }
         if(_prevMinScrollX != scroller.get_minScrollX() && scroller.get_scrollX() < scroller.get_minScrollX())
         {
            scroller.set_restrictedScrollX(scroller.get_scrollX());
         }
         else if(_prevMaxScrollX != scroller.get_maxScrollX() && scroller.get_scrollX() > scroller.get_maxScrollX())
         {
            scroller.set_restrictedScrollX(scroller.get_scrollX());
         }
         if(_prevMinScrollY != scroller.get_minScrollY() && scroller.get_scrollY() < scroller.get_minScrollY())
         {
            scroller.set_restrictedScrollY(scroller.get_scrollY());
         }
         else if(_prevMaxScrollY != scroller.get_maxScrollY() && scroller.get_scrollY() > scroller.get_maxScrollY())
         {
            scroller.set_restrictedScrollY(scroller.get_scrollY());
         }
      }
      
      public function resetViewPortOffsets() : void
      {
         topViewPortOffset = 0;
         rightViewPortOffset = 0;
         bottomViewPortOffset = 0;
         leftViewPortOffset = 0;
         chromeMeasuredWidth = 0;
         chromeMeasuredMinWidth = 0;
         chromeMeasuredMaxWidth = 1 / 0;
         chromeMeasuredHeight = 0;
         chromeMeasuredMinHeight = 0;
         chromeMeasuredMaxHeight = 1 / 0;
      }
      
      public function removeCurrentViewPortMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1.parent == this)
         {
            removeChild(param1);
         }
         _viewPort.mask = null;
      }
      
      public function removeCurrentMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1.parent == this)
         {
            removeChild(param1);
         }
         mask = null;
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
         _backgroundSkinMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
      }
      
      public function refreshViewPortMaskSkin() : void
      {
         var _loc1_:DisplayObject = _currentViewPortMaskSkin;
         _currentViewPortMaskSkin = getCurrentViewPortMaskSkin();
         if(_currentViewPortMaskSkin == _loc1_)
         {
            return;
         }
         removeCurrentViewPortMaskSkin(_loc1_);
         addCurrentViewPortMaskSkin(_currentViewPortMaskSkin);
      }
      
      public function refreshViewPortBoundsForMeasurement() : void
      {
         var _loc4_:Number = NaN;
         var _loc1_:Boolean = _ignoreViewPortResizing;
         _ignoreViewPortResizing = true;
         var _loc2_:Number = get_paddingLeft() + leftViewPortOffset;
         var _loc3_:Number = get_paddingTop() + topViewPortOffset;
         if(_scrollMode == ScrollMode.MASK || _scrollMode == ScrollMode.MASKLESS || _currentViewPortMaskSkin != null)
         {
            _loc2_ -= get_scrollX();
            _loc3_ -= get_scrollY();
         }
         _viewPort.x = _loc2_;
         _viewPort.y = _loc3_;
         if(get_explicitWidth() != null)
         {
            _loc4_ = get_explicitWidth() - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_visibleWidth(_loc4_);
         }
         else
         {
            _viewPort.set_visibleWidth(null);
         }
         if(get_explicitHeight() != null)
         {
            _loc4_ = get_explicitHeight() - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_visibleHeight(_loc4_);
         }
         else
         {
            _viewPort.set_visibleHeight(null);
         }
         if(get_explicitMinWidth() != null)
         {
            _loc4_ = get_explicitMinWidth() - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_minVisibleWidth(_loc4_);
         }
         else
         {
            _viewPort.set_minVisibleWidth(null);
         }
         if(get_explicitMinHeight() != null)
         {
            _loc4_ = get_explicitMinHeight() - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_minVisibleHeight(_loc4_);
         }
         else
         {
            _viewPort.set_minVisibleHeight(null);
         }
         if(get_explicitMaxWidth() != null)
         {
            _loc4_ = get_explicitMaxWidth() - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_maxVisibleWidth(_loc4_);
         }
         else if(_backgroundSkinMeasurements != null && _backgroundSkinMeasurements.maxWidth != null)
         {
            _loc4_ = _backgroundSkinMeasurements.maxWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_maxVisibleWidth(_loc4_);
         }
         else
         {
            _viewPort.set_maxVisibleWidth(1 / 0);
         }
         if(get_explicitMaxHeight() != null)
         {
            _loc4_ = get_explicitMaxHeight() - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_maxVisibleHeight(_loc4_);
         }
         else if(_backgroundSkinMeasurements != null && _backgroundSkinMeasurements.maxHeight != null)
         {
            _loc4_ = _backgroundSkinMeasurements.maxHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _viewPort.set_maxVisibleHeight(_loc4_);
         }
         else
         {
            _viewPort.set_maxVisibleHeight(1 / 0);
         }
         _viewPort.validateNow();
         _ignoreViewPortResizing = _loc1_;
      }
      
      public function refreshViewPortBoundsForLayout() : void
      {
         var _loc1_:Boolean = _ignoreViewPortResizing;
         _ignoreViewPortResizing = true;
         var _loc2_:Number = actualWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         var _loc3_:Number = actualHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:Number = actualMinWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = actualMinHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:Number = actualMaxWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         var _loc7_:Number = actualMaxHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
         if(_loc7_ < 0)
         {
            _loc7_ = 0;
         }
         var _loc8_:Number = get_paddingLeft() + leftViewPortOffset;
         var _loc9_:Number = get_paddingTop() + topViewPortOffset;
         if(_scrollMode == ScrollMode.MASK || _scrollMode == ScrollMode.MASKLESS || _currentViewPortMaskSkin != null)
         {
            _loc8_ -= get_scrollX();
            _loc9_ -= get_scrollY();
         }
         _viewPort.x = _loc8_;
         _viewPort.y = _loc9_;
         _viewPort.set_visibleWidth(_loc2_);
         _viewPort.set_visibleHeight(_loc3_);
         _viewPort.set_minVisibleWidth(_loc4_);
         _viewPort.set_minVisibleHeight(_loc5_);
         _viewPort.set_maxVisibleWidth(_loc6_);
         _viewPort.set_maxVisibleHeight(_loc7_);
         _ignoreViewPortResizing = _loc1_;
         _viewPort.validateNow();
         var _loc10_:Boolean = _settingScrollerDimensions;
         _settingScrollerDimensions = true;
         scroller.setDimensions(_viewPort.get_visibleWidth(),_viewPort.get_visibleHeight(),Number(_viewPort.width),Number(_viewPort.height));
         _settingScrollerDimensions = _loc10_;
      }
      
      public function refreshViewPort() : void
      {
         var _loc1_:Boolean = false;
         if(scrollBarX is IValidating)
         {
            scrollBarX.validateNow();
         }
         if(scrollBarY is IValidating)
         {
            scrollBarY.validateNow();
         }
         _viewPort.set_scrollX(get_scrollX());
         _viewPort.set_scrollY(get_scrollY());
         _prevMinScrollX = scroller.get_minScrollX();
         _prevMaxScrollX = scroller.get_maxScrollX();
         _prevMinScrollY = scroller.get_minScrollY();
         _prevMaxScrollY = scroller.get_maxScrollY();
         if(!needsMeasurement())
         {
            _viewPort.validateNow();
            _loc1_ = _settingScrollerDimensions;
            _settingScrollerDimensions = true;
            scroller.setDimensions(_viewPort.get_visibleWidth(),_viewPort.get_visibleHeight(),Number(_viewPort.width),Number(_viewPort.height));
            _settingScrollerDimensions = _loc1_;
            restrictScrollAfterRefreshViewPort();
            return;
         }
         refreshViewPortBoundsForMeasurement();
         var _loc2_:int = 0;
         while(true)
         {
            _viewPortBoundsChanged = false;
            if(get_measureViewPort())
            {
               resetViewPortOffsets();
               calculateViewPortOffsets(true,false);
               refreshViewPortBoundsForMeasurement();
            }
            resetViewPortOffsets();
            calculateViewPortOffsets(false,false);
            measure();
            resetViewPortOffsets();
            calculateViewPortOffsets(false,true);
            refreshViewPortBoundsForLayout();
            if(++_loc2_ >= 10)
            {
               break;
            }
            if(!_viewPortBoundsChanged)
            {
               _previousViewPortWidth = Number(_viewPort.width);
               _previousViewPortHeight = Number(_viewPort.height);
               restrictScrollAfterRefreshViewPort();
               return;
            }
         }
         throw new IllegalOperationError(Type.getClassName(Type.getClass(this)) + " stuck in an infinite loop during measurement and validation. This may be an issue with the layout or children, such as custom item renderers.");
      }
      
      public function refreshScrollerValues() : void
      {
         if(stage != null)
         {
            scroller.set_target(_viewPort);
         }
         scroller.enabledX = _enabled && _scrollPolicyX != ScrollPolicy.OFF;
         scroller.enabledY = _enabled && _scrollPolicyY != ScrollPolicy.OFF;
      }
      
      public function refreshScrollRect() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as DisplayObject;
         var _loc6_:* = null as Rectangle;
         var _loc1_:Number = scroller.get_scrollX();
         var _loc2_:Number = scroller.get_scrollY();
         if(get_scrollPixelSnapping())
         {
            _loc3_ = DisplayUtil.getConcatenatedScaleX(this);
            _loc4_ = DisplayUtil.getConcatenatedScaleY(this);
            _loc1_ = int(Math.round(_loc1_ / _loc3_)) * _loc3_;
            _loc2_ = int(Math.round(_loc2_ / _loc4_)) * _loc4_;
         }
         if(_scrollMode == ScrollMode.MASK || _scrollMode == ScrollMode.MASKLESS || _currentViewPortMaskSkin != null)
         {
            _loc5_ = _viewPort;
            _loc5_.scrollRect = null;
            _loc3_ = get_paddingLeft() + leftViewPortOffset;
            _viewPort.x = _loc3_ - _loc1_;
            _loc4_ = get_paddingTop() + topViewPortOffset;
            _viewPort.y = _loc4_ - _loc2_;
         }
         else
         {
            if(_scrollMode != ScrollMode.SCROLL_RECT)
            {
               throw new ArgumentError("Unknown scrollMode: " + Std.string(_scrollMode));
            }
            _loc6_ = _scrollRect1;
            if(_currentScrollRect == _loc6_)
            {
               _loc6_ = _scrollRect2;
            }
            _currentScrollRect = _loc6_;
            _loc3_ = actualWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
            if(_loc3_ < 0)
            {
               _loc3_ = 0;
            }
            _loc4_ = actualHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            _loc6_.setTo(_loc1_,_loc2_,_loc3_,_loc4_);
            _loc5_ = _viewPort;
            _loc5_.scrollRect = _loc6_;
         }
      }
      
      public function refreshScrollBarValues() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:* = null as DisplayObjectContainer;
         if(scrollBarX != null)
         {
            _loc1_ = _ignoreScrollBarXChange;
            _ignoreScrollBarXChange = true;
            scrollBarX.set_minimum(scroller.get_minScrollX());
            scrollBarX.set_maximum(scroller.get_maxScrollX());
            scrollBarX.set_value(scroller.get_scrollX());
            scrollBarX.set_page((scroller.get_maxScrollX() - scroller.get_minScrollX()) * _viewPort.get_visibleWidth() / Number(_viewPort.width));
            scrollBarX.set_step(_scrollStepX);
            _loc2_ = scrollBarX;
            _loc2_.visible = showScrollBarX;
            if(get_fixedScrollBars() || !get_autoHideScrollBars())
            {
               scrollBarX.alpha = 1;
            }
            _ignoreScrollBarXChange = _loc1_;
         }
         if(scrollBarY != null)
         {
            _loc1_ = _ignoreScrollBarYChange;
            _ignoreScrollBarYChange = true;
            scrollBarY.set_minimum(scroller.get_minScrollY());
            scrollBarY.set_maximum(scroller.get_maxScrollY());
            scrollBarY.set_value(scroller.get_scrollY());
            scrollBarY.set_page((scroller.get_maxScrollY() - scroller.get_minScrollY()) * _viewPort.get_visibleHeight() / Number(_viewPort.height));
            scrollBarY.set_step(_scrollStepY);
            _loc2_ = scrollBarY;
            _loc2_.visible = showScrollBarY;
            if(get_fixedScrollBars() || !get_autoHideScrollBars())
            {
               scrollBarY.alpha = 1;
            }
            _ignoreScrollBarYChange = _loc1_;
         }
      }
      
      public function refreshMaskSkin() : void
      {
         var _loc1_:DisplayObject = _currentMaskSkin;
         _currentMaskSkin = getCurrentMaskSkin();
         if(_currentMaskSkin == _loc1_)
         {
            return;
         }
         removeCurrentMaskSkin(_loc1_);
         addCurrentMaskSkin(_currentMaskSkin);
      }
      
      public function refreshEnabled() : void
      {
         _viewPort.set_enabled(_enabled);
         if(scrollBarX != null)
         {
            scrollBarX.set_enabled(_enabled);
         }
         if(scrollBarY != null)
         {
            scrollBarY.set_enabled(_enabled);
         }
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
      
      public function reclaimTouch(param1:int) : void
      {
         if(scroller.get_touchPointIsSimulated() || scroller.get_touchPointID() == null || scroller.get_touchPointID() != param1)
         {
            return;
         }
         var _loc2_:ExclusivePointer = ExclusivePointer.forStage(stage);
         var _loc3_:DisplayObject = _loc2_.getTouchClaim(param1);
         if(_loc3_ != null)
         {
            return;
         }
         _loc2_.claimTouch(param1,this);
      }
      
      public function reclaimMouse() : void
      {
         if(!scroller.get_touchPointIsSimulated())
         {
            return;
         }
         var _loc1_:ExclusivePointer = ExclusivePointer.forStage(stage);
         var _loc2_:DisplayObject = _loc1_.getMouseClaim();
         if(_loc2_ != null)
         {
            return;
         }
         _loc1_.claimMouse(this);
      }
      
      public function needsScrollMeasurement() : Boolean
      {
         return false;
      }
      
      public function needsMeasurement() : Boolean
      {
         if(!(isInvalid(InvalidationFlag.SCROLL) && needsScrollMeasurement() || isInvalid(InvalidationFlag.DATA) || isInvalid(InvalidationFlag.SIZE) || isInvalid(InvalidationFlag.STYLES) || isInvalid(BaseScrollContainer.INVALIDATION_FLAG_SCROLL_BAR_FACTORY) || isInvalid(InvalidationFlag.STATE)))
         {
            return isInvalid(InvalidationFlag.LAYOUT);
         }
         return true;
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
            if(get_measureViewPort())
            {
               _loc8_ = _viewPort.get_visibleWidth();
            }
            else
            {
               _loc8_ = 0;
            }
            _loc8_ += leftViewPortOffset + rightViewPortOffset;
            _loc8_ = Math.max(_loc8_,chromeMeasuredWidth);
            _loc8_ = _loc8_ + (get_paddingLeft() + get_paddingRight());
            if(_currentBackgroundSkin != null)
            {
               _loc8_ = Math.max(_loc8_,_currentBackgroundSkin.width);
            }
         }
         var _loc9_:Object = get_explicitHeight();
         if(_loc2_)
         {
            if(get_measureViewPort())
            {
               _loc9_ = _viewPort.get_visibleHeight();
            }
            else
            {
               _loc9_ = 0;
            }
            _loc9_ += topViewPortOffset + bottomViewPortOffset;
            _loc9_ = Math.max(_loc9_,chromeMeasuredHeight);
            _loc9_ = _loc9_ + (get_paddingTop() + get_paddingBottom());
            if(_currentBackgroundSkin != null)
            {
               _loc9_ = Math.max(_loc9_,_currentBackgroundSkin.height);
            }
         }
         var _loc10_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            if(get_measureViewPort())
            {
               _loc10_ = _viewPort.get_minVisibleWidth();
            }
            else
            {
               _loc10_ = 0;
            }
            _loc10_ += leftViewPortOffset + rightViewPortOffset;
            _loc10_ = Math.max(_loc10_,chromeMeasuredMinWidth);
            _loc10_ = _loc10_ + (get_paddingLeft() + get_paddingRight());
            if(_loc7_ != null)
            {
               _loc10_ = Math.max(_loc10_,_loc7_.get_minWidth());
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc10_ = Math.max(_loc10_,_backgroundSkinMeasurements.minWidth);
            }
         }
         var _loc11_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            if(get_measureViewPort())
            {
               _loc11_ = _viewPort.get_minVisibleHeight();
            }
            else
            {
               _loc11_ = 0;
            }
            _loc11_ += topViewPortOffset + bottomViewPortOffset;
            _loc11_ = Math.max(_loc11_,chromeMeasuredMinHeight);
            _loc11_ = _loc11_ + (get_paddingTop() + get_paddingBottom());
            if(_loc7_ != null)
            {
               _loc11_ = Math.max(_loc11_,_loc7_.get_minHeight());
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc11_ = Math.max(_loc11_,_backgroundSkinMeasurements.minHeight);
            }
         }
         var _loc12_:Object = get_explicitMaxWidth();
         if(_loc5_)
         {
            if(get_measureViewPort())
            {
               _loc12_ = _viewPort.get_maxVisibleWidth();
            }
            else
            {
               _loc12_ = 1 / 0;
            }
            _loc12_ += leftViewPortOffset + rightViewPortOffset;
            _loc12_ = Math.min(_loc12_,chromeMeasuredMaxWidth);
            _loc12_ = _loc12_ + (get_paddingLeft() + get_paddingRight());
            if(_loc7_ != null)
            {
               _loc12_ = Math.min(_loc12_,_loc7_.get_maxWidth());
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc12_ = Math.min(_loc12_,_backgroundSkinMeasurements.maxWidth);
            }
         }
         var _loc13_:Object = get_explicitMaxHeight();
         if(_loc6_)
         {
            if(get_measureViewPort())
            {
               _loc13_ = _viewPort.get_maxVisibleHeight();
            }
            else
            {
               _loc13_ = 1 / 0;
            }
            _loc13_ += topViewPortOffset + bottomViewPortOffset;
            _loc13_ = Math.min(_loc13_,chromeMeasuredMaxHeight);
            _loc13_ = _loc13_ + (get_paddingTop() + get_paddingBottom());
            if(_loc7_ != null)
            {
               _loc13_ = Math.min(_loc13_,_loc7_.get_maxHeight());
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc13_ = Math.min(_loc13_,_backgroundSkinMeasurements.maxHeight);
            }
         }
         return saveMeasurements(_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_);
      }
      
      public function layoutViewPortMaskSkin() : void
      {
         if(_currentViewPortMaskSkin == null)
         {
            return;
         }
         var _loc1_:Number = get_paddingLeft();
         _currentViewPortMaskSkin.x = _loc1_ + leftViewPortOffset;
         var _loc2_:Number = get_paddingTop();
         _currentViewPortMaskSkin.y = _loc2_ + topViewPortOffset;
         _currentViewPortMaskSkin.width = _viewPort.get_visibleWidth();
         _currentViewPortMaskSkin.height = _viewPort.get_visibleHeight();
         if(_currentViewPortMaskSkin is IValidating)
         {
            _currentViewPortMaskSkin.validateNow();
         }
      }
      
      public function layoutScrollBars() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:Number = actualWidth - leftViewPortOffset - rightViewPortOffset - get_paddingLeft() - get_paddingRight();
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         var _loc2_:Number = actualHeight - topViewPortOffset - bottomViewPortOffset - get_paddingTop() - get_paddingBottom();
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(scrollBarX != null && scrollBarX is IValidating)
         {
            scrollBarX.validateNow();
         }
         if(scrollBarY != null && scrollBarY is IValidating)
         {
            scrollBarY.validateNow();
         }
         if(scrollBarX != null)
         {
            if(get_scrollBarXPosition().index == 0)
            {
               scrollBarX.y = get_paddingTop();
            }
            else
            {
               _loc3_ = get_paddingTop() + topViewPortOffset;
               scrollBarX.y = _loc3_ + _loc2_;
            }
            _loc3_ = get_paddingLeft();
            scrollBarX.x = _loc3_ + leftViewPortOffset;
            if(!get_fixedScrollBars())
            {
               var _temp_1:* = scrollBarX;
               _temp_1.y = Number(_temp_1.y) - Number(scrollBarX.height);
               if((showScrollBarY || _hideScrollBarY != null) && scrollBarY != null)
               {
                  _loc4_ = _loc1_ - Number(scrollBarY.width);
                  if(_loc4_ < 0)
                  {
                     _loc4_ = 0;
                  }
                  scrollBarX.width = _loc4_;
               }
               else
               {
                  scrollBarX.width = _loc1_;
               }
            }
            else
            {
               scrollBarX.width = _loc1_;
            }
         }
         if(scrollBarY != null)
         {
            if(get_scrollBarYPosition().index == 3)
            {
               scrollBarY.x = get_paddingLeft();
            }
            else
            {
               _loc3_ = get_paddingLeft() + leftViewPortOffset;
               scrollBarY.x = _loc3_ + _loc1_;
            }
            _loc3_ = get_paddingTop();
            scrollBarY.y = _loc3_ + topViewPortOffset;
            if(!get_fixedScrollBars())
            {
               var _temp_3:* = scrollBarY;
               _temp_3.x = Number(_temp_3.x) - Number(scrollBarY.width);
               if((showScrollBarX || _hideScrollBarX != null) && scrollBarX != null)
               {
                  _loc4_ = _loc2_ - Number(scrollBarX.height);
                  if(_loc4_ < 0)
                  {
                     _loc4_ = 0;
                  }
                  scrollBarY.height = _loc4_;
               }
               else
               {
                  scrollBarY.height = _loc2_;
               }
            }
            else
            {
               scrollBarY.height = _loc2_;
            }
         }
      }
      
      public function layoutMaskSkin() : void
      {
         if(_currentMaskSkin == null)
         {
            return;
         }
         _currentMaskSkin.x = 0;
         _currentMaskSkin.y = 0;
         _currentMaskSkin.width = actualWidth;
         _currentMaskSkin.height = actualHeight;
         if(_currentMaskSkin is IValidating)
         {
            _currentMaskSkin.validateNow();
         }
      }
      
      public function layoutChildren() : void
      {
         layoutBackgroundSkin();
         layoutMaskSkin();
         layoutViewPortMaskSkin();
         layoutScrollBars();
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
      
      public function hideScrollBarY_onComplete() : void
      {
         _hideScrollBarY = null;
      }
      
      public function hideScrollBarY() : void
      {
         var _gthis:BaseScrollContainer = this;
         if(scrollBarY == null || _hideScrollBarY != null)
         {
            return;
         }
         if(Number(scrollBarY.alpha) == 0)
         {
            return;
         }
         if(get_hideScrollBarDuration() == 0)
         {
            scrollBarY.alpha = 0;
            return;
         }
         var _loc1_:GenericActuator = Actuate.update(function(param1:Number):Number
         {
            return _gthis.scrollBarY.alpha = param1;
         },get_hideScrollBarDuration(),[Number(scrollBarY.alpha)],[0],true);
         _hideScrollBarY = _loc1_;
         _hideScrollBarY.ease(get_hideScrollBarEase());
         _hideScrollBarY.autoVisible(false);
         var _loc2_:Number = (Lib.getTimer() - _scrollBarYRevealTime) / 1000;
         if(_loc2_ < get_showScrollBarMinimumDuration())
         {
            _hideScrollBarY.delay(get_showScrollBarMinimumDuration() - _loc2_);
         }
         _hideScrollBarY.onComplete(hideScrollBarY_onComplete);
      }
      
      public function hideScrollBarX_onComplete() : void
      {
         _hideScrollBarX = null;
      }
      
      public function hideScrollBarX() : void
      {
         var _gthis:BaseScrollContainer = this;
         if(scrollBarX == null || _hideScrollBarX != null)
         {
            return;
         }
         if(Number(scrollBarX.alpha) == 0)
         {
            return;
         }
         if(get_hideScrollBarDuration() == 0)
         {
            scrollBarX.alpha = 0;
            return;
         }
         var _loc1_:GenericActuator = Actuate.update(function(param1:Number):Number
         {
            return _gthis.scrollBarX.alpha = param1;
         },get_hideScrollBarDuration(),[Number(scrollBarX.alpha)],[0],true);
         _hideScrollBarX = _loc1_;
         _hideScrollBarX.ease(get_hideScrollBarEase());
         _hideScrollBarX.autoVisible(false);
         var _loc2_:Number = (Lib.getTimer() - _scrollBarXRevealTime) / 1000;
         if(_loc2_ < get_showScrollBarMinimumDuration())
         {
            _hideScrollBarX.delay(get_showScrollBarMinimumDuration() - _loc2_);
         }
         _hideScrollBarX.onComplete(hideScrollBarX_onComplete);
      }
      
      public function get_viewPortMaskSkin() : DisplayObject
      {
         return __viewPortMaskSkin;
      }
      
      public function get viewPortMaskSkin() : DisplayObject
      {
         return get_viewPortMaskSkin();
      }
      
      public function get_viewPort() : IViewPort
      {
         return _viewPort;
      }
      
      public function get viewPort() : IViewPort
      {
         return get_viewPort();
      }
      
      override public function get tabEnabled() : Boolean
      {
         if(get_maxScrollY() != get_minScrollY() || get_maxScrollX() != get_minScrollX())
         {
            return get_rawTabEnabled();
         }
         return false;
      }
      
      public function get_showScrollBars() : Boolean
      {
         return __showScrollBars;
      }
      
      public function get showScrollBars() : Boolean
      {
         return get_showScrollBars();
      }
      
      public function get_showScrollBarMinimumDuration() : Number
      {
         return __showScrollBarMinimumDuration;
      }
      
      public function get showScrollBarMinimumDuration() : Number
      {
         return get_showScrollBarMinimumDuration();
      }
      
      public function get_scrollerFactory() : Function
      {
         return _scrollerFactory;
      }
      
      public function get scrollerFactory() : Function
      {
         return get_scrollerFactory();
      }
      
      public function get_scrollY() : Number
      {
         if(scroller == null)
         {
            if(_temporaryRestrictedScrollY != null)
            {
               return _temporaryRestrictedScrollY;
            }
            if(_temporaryScrollY != null)
            {
               return _temporaryScrollY;
            }
            return 0;
         }
         return scroller.get_scrollY();
      }
      
      public function get scrollY() : Number
      {
         return get_scrollY();
      }
      
      public function get_scrollX() : Number
      {
         if(scroller == null)
         {
            if(_temporaryRestrictedScrollX != null)
            {
               return _temporaryRestrictedScrollX;
            }
            if(_temporaryScrollX != null)
            {
               return _temporaryScrollX;
            }
            return 0;
         }
         return scroller.get_scrollX();
      }
      
      public function get scrollX() : Number
      {
         return get_scrollX();
      }
      
      public function get_scrollStepY() : Number
      {
         return _scrollStepY;
      }
      
      public function get scrollStepY() : Number
      {
         return get_scrollStepY();
      }
      
      public function get_scrollStepX() : Number
      {
         return _scrollStepX;
      }
      
      public function get scrollStepX() : Number
      {
         return get_scrollStepX();
      }
      
      public function get_scrollPolicyY() : ScrollPolicy
      {
         return _scrollPolicyY;
      }
      
      public function get scrollPolicyY() : ScrollPolicy
      {
         return get_scrollPolicyY();
      }
      
      public function get_scrollPolicyX() : ScrollPolicy
      {
         return _scrollPolicyX;
      }
      
      public function get scrollPolicyX() : ScrollPolicy
      {
         return get_scrollPolicyX();
      }
      
      public function get_scrollPixelSnapping() : Boolean
      {
         return __scrollPixelSnapping;
      }
      
      public function get scrollPixelSnapping() : Boolean
      {
         return get_scrollPixelSnapping();
      }
      
      public function get_scrollMode() : ScrollMode
      {
         return _scrollMode;
      }
      
      public function get scrollMode() : ScrollMode
      {
         return get_scrollMode();
      }
      
      public function get_scrollBarYPosition() : RelativePosition
      {
         return __scrollBarYPosition;
      }
      
      public function get scrollBarYPosition() : RelativePosition
      {
         return get_scrollBarYPosition();
      }
      
      public function get_scrollBarYFactory() : DisplayObjectFactory
      {
         return _scrollBarYFactory;
      }
      
      public function get scrollBarYFactory() : DisplayObjectFactory
      {
         return get_scrollBarYFactory();
      }
      
      public function get_scrollBarXPosition() : RelativePosition
      {
         return __scrollBarXPosition;
      }
      
      public function get scrollBarXPosition() : RelativePosition
      {
         return get_scrollBarXPosition();
      }
      
      public function get_scrollBarXFactory() : DisplayObjectFactory
      {
         return _scrollBarXFactory;
      }
      
      public function get scrollBarXFactory() : DisplayObjectFactory
      {
         return get_scrollBarXFactory();
      }
      
      public function get_restrictedScrollY() : Number
      {
         if(scroller == null)
         {
            get_scrollY();
         }
         return scroller.get_restrictedScrollY();
      }
      
      public function get restrictedScrollY() : Number
      {
         return get_restrictedScrollY();
      }
      
      public function get_restrictedScrollX() : Number
      {
         if(scroller == null)
         {
            return get_scrollX();
         }
         return scroller.get_restrictedScrollX();
      }
      
      public function get restrictedScrollX() : Number
      {
         return get_restrictedScrollX();
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
      
      public function get_minScrollY() : Number
      {
         if(scroller == null)
         {
            return 0;
         }
         return scroller.get_minScrollY();
      }
      
      public function get minScrollY() : Number
      {
         return get_minScrollY();
      }
      
      public function get_minScrollX() : Number
      {
         if(scroller == null)
         {
            return 0;
         }
         return scroller.get_minScrollX();
      }
      
      public function get minScrollX() : Number
      {
         return get_minScrollX();
      }
      
      public function get_measureViewPort() : Boolean
      {
         return true;
      }
      
      public function get measureViewPort() : Boolean
      {
         return get_measureViewPort();
      }
      
      public function get_maxScrollY() : Number
      {
         if(scroller == null)
         {
            return 0;
         }
         return scroller.get_maxScrollY();
      }
      
      public function get maxScrollY() : Number
      {
         return get_maxScrollY();
      }
      
      public function get_maxScrollX() : Number
      {
         if(scroller == null)
         {
            return 0;
         }
         return scroller.get_maxScrollX();
      }
      
      public function get maxScrollX() : Number
      {
         return get_maxScrollX();
      }
      
      public function get_maskSkin() : DisplayObject
      {
         return __maskSkin;
      }
      
      public function get maskSkin() : DisplayObject
      {
         return get_maskSkin();
      }
      
      public function get_hideScrollBarEase() : IEasing
      {
         return __hideScrollBarEase;
      }
      
      public function get hideScrollBarEase() : IEasing
      {
         return get_hideScrollBarEase();
      }
      
      public function get_hideScrollBarDuration() : Number
      {
         return __hideScrollBarDuration;
      }
      
      public function get hideScrollBarDuration() : Number
      {
         return get_hideScrollBarDuration();
      }
      
      public function get_fixedScrollBars() : Boolean
      {
         return __fixedScrollBars;
      }
      
      public function get fixedScrollBars() : Boolean
      {
         return get_fixedScrollBars();
      }
      
      public function get_disabledBackgroundSkin() : DisplayObject
      {
         return __disabledBackgroundSkin;
      }
      
      public function get disabledBackgroundSkin() : DisplayObject
      {
         return get_disabledBackgroundSkin();
      }
      
      public function get_backgroundSkin() : DisplayObject
      {
         return __backgroundSkin;
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function get_autoHideScrollBars() : Boolean
      {
         return __autoHideScrollBars;
      }
      
      public function get autoHideScrollBars() : Boolean
      {
         return get_autoHideScrollBars();
      }
      
      public function getViewPortVisibleBounds(param1:Rectangle = undefined) : Rectangle
      {
         var _loc2_:Number = leftViewPortOffset + get_paddingLeft();
         var _loc3_:Number = topViewPortOffset + get_paddingTop();
         if(param1 == null)
         {
            param1 = new Rectangle(_loc2_,_loc3_,_viewPort.get_visibleWidth(),_viewPort.get_visibleHeight());
         }
         else
         {
            param1.setTo(_loc2_,_loc3_,_viewPort.get_visibleWidth(),_viewPort.get_visibleHeight());
         }
         return param1;
      }
      
      public function getCurrentViewPortMaskSkin() : DisplayObject
      {
         if(get_viewPortMaskSkin() != null)
         {
            return get_viewPortMaskSkin();
         }
         if(_scrollMode == ScrollMode.MASK)
         {
            if(_fallbackViewPortMaskSkin == null)
            {
               _fallbackViewPortMaskSkin = new RectangleSkin(FillStyle.SolidColor(16711935));
            }
            return _fallbackViewPortMaskSkin;
         }
         return null;
      }
      
      public function getCurrentMaskSkin() : DisplayObject
      {
         return get_maskSkin();
      }
      
      public function getCurrentBackgroundSkin() : DisplayObject
      {
         if(!_enabled && get_disabledBackgroundSkin() != null)
         {
            return get_disabledBackgroundSkin();
         }
         return get_backgroundSkin();
      }
      
      public function createScroller() : void
      {
         if(scroller != null)
         {
            _temporaryScrollX = scroller.get_scrollX();
            _temporaryScrollY = scroller.get_scrollY();
            _temporaryRestrictedScrollX = null;
            _temporaryRestrictedScrollY = null;
            scroller.set_target(null);
            scroller.removeEventListener(Event.SCROLL,baseScrollContainer_scroller_scrollHandler);
            scroller.removeEventListener("scrollStart",baseScrollContainer_scroller_scrollStartHandler);
            scroller.removeEventListener("scrollComplete",baseScrollContainer_scroller_scrollCompleteHandler);
            scroller = null;
         }
         scroller = _scrollerFactory != null ? _scrollerFactory() : new Scroller();
         scroller.addEventListener(Event.SCROLL,baseScrollContainer_scroller_scrollHandler);
         scroller.addEventListener("scrollStart",baseScrollContainer_scroller_scrollStartHandler);
         scroller.addEventListener("scrollComplete",baseScrollContainer_scroller_scrollCompleteHandler);
      }
      
      public function createScrollBars() : void
      {
         if(scrollBarX != null)
         {
            scrollBarX.removeEventListener(Event.CHANGE,scrollBarX_changeHandler);
            scrollBarX.removeEventListener(MouseEvent.ROLL_OVER,scrollBarX_rollOverHandler);
            scrollBarX.removeEventListener(MouseEvent.ROLL_OUT,scrollBarX_rollOutHandler);
            scrollBarX.removeEventListener("scrollStart",scrollBarX_scrollStartHandler);
            scrollBarX.removeEventListener("scrollComplete",scrollBarX_scrollCompleteHandler);
            removeChild(scrollBarX);
            if(_oldScrollBarXFactory.destroy != null)
            {
               _oldScrollBarXFactory.destroy(scrollBarX);
            }
            _oldScrollBarXFactory = null;
            scrollBarX = null;
         }
         if(scrollBarY != null)
         {
            scrollBarY.removeEventListener(Event.CHANGE,scrollBarY_changeHandler);
            scrollBarY.removeEventListener(MouseEvent.ROLL_OVER,scrollBarY_rollOverHandler);
            scrollBarY.removeEventListener(MouseEvent.ROLL_OUT,scrollBarY_rollOutHandler);
            scrollBarY.removeEventListener("scrollStart",scrollBarY_scrollStartHandler);
            scrollBarY.removeEventListener("scrollComplete",scrollBarY_scrollCompleteHandler);
            removeChild(scrollBarY);
            if(_oldScrollBarYFactory.destroy != null)
            {
               _oldScrollBarYFactory.destroy(scrollBarY);
            }
            _oldScrollBarYFactory = null;
            scrollBarY = null;
         }
         var _loc1_:DisplayObjectFactory = _scrollBarXFactory != null ? _scrollBarXFactory : BaseScrollContainer.defaultScrollBarXFactory;
         _oldScrollBarXFactory = _loc1_;
         scrollBarX = _loc1_.create();
         if(get_autoHideScrollBars())
         {
            scrollBarX.alpha = 0;
         }
         scrollBarX.addEventListener(Event.CHANGE,scrollBarX_changeHandler);
         scrollBarX.addEventListener(MouseEvent.ROLL_OVER,scrollBarX_rollOverHandler);
         scrollBarX.addEventListener(MouseEvent.ROLL_OUT,scrollBarX_rollOutHandler);
         scrollBarX.addEventListener("scrollStart",scrollBarX_scrollStartHandler);
         scrollBarX.addEventListener("scrollComplete",scrollBarX_scrollCompleteHandler);
         addChild(scrollBarX);
         var _loc2_:DisplayObjectFactory = _scrollBarYFactory != null ? _scrollBarYFactory : BaseScrollContainer.defaultScrollBarYFactory;
         _oldScrollBarYFactory = _loc2_;
         scrollBarY = _loc2_.create();
         if(get_autoHideScrollBars())
         {
            scrollBarY.alpha = 0;
         }
         scrollBarY.addEventListener(Event.CHANGE,scrollBarY_changeHandler);
         scrollBarY.addEventListener(MouseEvent.ROLL_OVER,scrollBarY_rollOverHandler);
         scrollBarY.addEventListener(MouseEvent.ROLL_OUT,scrollBarY_rollOutHandler);
         scrollBarY.addEventListener("scrollStart",scrollBarY_scrollStartHandler);
         scrollBarY.addEventListener("scrollComplete",scrollBarY_scrollCompleteHandler);
         addChild(scrollBarY);
      }
      
      public function clearStyle_viewPortMaskSkin() : DisplayObject
      {
         set_viewPortMaskSkin(null);
         return get_viewPortMaskSkin();
      }
      
      public function clearStyle_showScrollBars() : Boolean
      {
         set_showScrollBars(true);
         return get_showScrollBars();
      }
      
      public function clearStyle_showScrollBarMinimumDuration() : Number
      {
         set_showScrollBarMinimumDuration(0.5);
         return get_showScrollBarMinimumDuration();
      }
      
      public function clearStyle_scrollPixelSnapping() : Boolean
      {
         set_scrollPixelSnapping(false);
         return get_scrollPixelSnapping();
      }
      
      public function clearStyle_scrollBarYPosition() : RelativePosition
      {
         set_scrollBarYPosition(RelativePosition.RIGHT);
         return get_scrollBarYPosition();
      }
      
      public function clearStyle_scrollBarXPosition() : RelativePosition
      {
         set_scrollBarXPosition(RelativePosition.BOTTOM);
         return get_scrollBarXPosition();
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
      
      public function clearStyle_maskSkin() : DisplayObject
      {
         set_maskSkin(null);
         return get_maskSkin();
      }
      
      public function clearStyle_hideScrollBarEase() : IEasing
      {
         set_hideScrollBarEase(Quart.easeOut);
         return get_hideScrollBarEase();
      }
      
      public function clearStyle_hideScrollBarDuration() : Number
      {
         set_hideScrollBarDuration(0.2);
         return get_hideScrollBarDuration();
      }
      
      public function clearStyle_fixedScrollBars() : Boolean
      {
         set_fixedScrollBars(false);
         return get_fixedScrollBars();
      }
      
      public function clearStyle_disabledBackgroundSkin() : DisplayObject
      {
         set_disabledBackgroundSkin(null);
         return get_disabledBackgroundSkin();
      }
      
      public function clearStyle_backgroundSkin() : DisplayObject
      {
         set_backgroundSkin(null);
         return get_backgroundSkin();
      }
      
      public function clearStyle_autoHideScrollBars() : Boolean
      {
         set_autoHideScrollBars(true);
         return get_autoHideScrollBars();
      }
      
      public function checkForRevealScrollBars() : void
      {
         if(!_scrollerDraggingX && scroller.get_draggingX())
         {
            _scrollerDraggingX = true;
            revealScrollBarX();
         }
         if(!_scrollerDraggingY && scroller.get_draggingY())
         {
            _scrollerDraggingY = true;
            revealScrollBarY();
         }
      }
      
      public function calculateViewPortOffsetsForFixedScrollBarY(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:* = null as Object;
         var _loc4_:* = null as Object;
         var _loc5_:Number = NaN;
         if(scrollBarY != null && (get_measureViewPort() || param2))
         {
            _loc3_ = param2 ? actualHeight : get_explicitHeight();
            if(_loc3_ != null)
            {
               _loc3_ -= get_paddingTop() + get_paddingBottom() + topViewPortOffset + bottomViewPortOffset;
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
            }
            if(!param2 && !param1 && _loc3_ == null)
            {
               _loc3_ = _viewPort.get_visibleHeight();
            }
            _loc4_ = get_explicitMaxHeight();
            if(_loc4_ != null)
            {
               _loc4_ -= get_paddingTop() + get_paddingBottom() + topViewPortOffset + bottomViewPortOffset;
               if(_loc4_ < 0)
               {
                  _loc4_ = 0;
               }
            }
            if(!get_showScrollBars())
            {
               showScrollBarY = false;
               return;
            }
            _loc5_ = Number(_viewPort.height);
            if(param1 || _scrollPolicyY == ScrollPolicy.ON || (_loc5_ > _loc3_ && !MathUtil.fuzzyEquals(_loc5_,_loc3_) || _loc4_ != null && _loc5_ > _loc4_ && !MathUtil.fuzzyEquals(_loc5_,_loc4_)) && _scrollPolicyY != ScrollPolicy.OFF)
            {
               showScrollBarY = true;
               if(get_fixedScrollBars())
               {
                  if(get_scrollBarYPosition() == RelativePosition.LEFT)
                  {
                     leftViewPortOffset += Number(scrollBarY.width);
                  }
                  else
                  {
                     rightViewPortOffset += Number(scrollBarY.width);
                  }
               }
            }
            else
            {
               showScrollBarY = false;
            }
         }
         else
         {
            showScrollBarY = false;
         }
      }
      
      public function calculateViewPortOffsetsForFixedScrollBarX(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:* = null as Object;
         var _loc4_:* = null as Object;
         var _loc5_:Number = NaN;
         if(scrollBarX != null && (get_measureViewPort() || param2))
         {
            _loc3_ = param2 ? actualWidth : get_explicitWidth();
            if(_loc3_ != null)
            {
               _loc3_ -= get_paddingLeft() + get_paddingRight() + leftViewPortOffset + rightViewPortOffset;
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
            }
            if(!param2 && !param1 && _loc3_ == null)
            {
               _loc3_ = _viewPort.get_visibleWidth();
            }
            _loc4_ = get_explicitMaxWidth();
            if(_loc4_ != null)
            {
               _loc4_ -= get_paddingLeft() + get_paddingRight() + leftViewPortOffset + rightViewPortOffset;
               if(_loc4_ < 0)
               {
                  _loc4_ = 0;
               }
            }
            if(!get_showScrollBars())
            {
               showScrollBarX = false;
               return;
            }
            _loc5_ = Number(_viewPort.width);
            if(param1 || _scrollPolicyX == ScrollPolicy.ON || (_loc5_ > _loc3_ && !MathUtil.fuzzyEquals(_loc5_,_loc3_) || _loc4_ != null && _loc5_ > _loc4_ && !MathUtil.fuzzyEquals(_loc5_,_loc4_)) && _scrollPolicyX != ScrollPolicy.OFF)
            {
               showScrollBarX = true;
               if(get_fixedScrollBars())
               {
                  if(get_scrollBarXPosition() == RelativePosition.TOP)
                  {
                     topViewPortOffset += Number(scrollBarX.height);
                  }
                  else
                  {
                     bottomViewPortOffset += Number(scrollBarX.height);
                  }
               }
            }
            else
            {
               showScrollBarX = false;
            }
         }
         else
         {
            showScrollBarX = false;
         }
      }
      
      public function calculateViewPortOffsets(param1:Boolean, param2:Boolean) : void
      {
         calculateViewPortOffsetsForFixedScrollBarX(param1 && get_showScrollBars() && get_scrollPolicyX() != ScrollPolicy.OFF,param2);
         calculateViewPortOffsetsForFixedScrollBarY(param1 && get_showScrollBars() && get_scrollPolicyY() != ScrollPolicy.OFF,param2);
         if(get_fixedScrollBars() && showScrollBarY && !showScrollBarX)
         {
            calculateViewPortOffsetsForFixedScrollBarX(param1 && get_showScrollBars() && get_scrollPolicyX() != ScrollPolicy.OFF,param2);
         }
      }
      
      public function baseScrollContainer_viewPort_touchBeginHandler(param1:TouchEvent) : void
      {
         reclaimTouch(param1.touchPointID);
      }
      
      public function baseScrollContainer_viewPort_mouseDownHandler(param1:MouseEvent) : void
      {
         reclaimMouse();
      }
      
      public function baseScrollContainer_scroller_scrollStartHandler(param1:ScrollEvent) : void
      {
         var _loc3_:* = null as ExclusivePointer;
         var _loc4_:Boolean = false;
         var _loc2_:Object = scroller.get_touchPointID();
         if(scroller.get_touchPointIsSimulated())
         {
            _loc3_ = ExclusivePointer.forStage(stage);
            _loc4_ = _loc3_.claimMouse(this);
            if(!_loc4_)
            {
               scroller.stop();
               return;
            }
         }
         else if(_loc2_ != null)
         {
            _loc3_ = ExclusivePointer.forStage(stage);
            _loc4_ = _loc3_.claimTouch(_loc2_,this);
            if(!_loc4_)
            {
               scroller.stop();
               return;
            }
         }
         _viewPort.addEventListener(MouseEvent.MOUSE_DOWN,baseScrollContainer_viewPort_mouseDownHandler);
         _viewPort.addEventListener(TouchEvent.TOUCH_BEGIN,baseScrollContainer_viewPort_touchBeginHandler);
         _scrollerDraggingX = false;
         _scrollerDraggingY = false;
         checkForRevealScrollBars();
         ScrollEvent.dispatch(this,"scrollStart");
      }
      
      public function baseScrollContainer_scroller_scrollHandler(param1:Event) : void
      {
         if(_ignoreScrollerChanges)
         {
            if(_settingScrollerDimensions && needsScrollMeasurement())
            {
               setInvalid(InvalidationFlag.SCROLL);
            }
            else
            {
               _viewPort.set_scrollX(get_scrollX());
               _viewPort.set_scrollY(get_scrollY());
            }
            return;
         }
         checkForRevealScrollBars();
         if(needsScrollMeasurement())
         {
            setInvalid(InvalidationFlag.SCROLL);
         }
         else
         {
            _viewPort.set_scrollX(get_scrollX());
            _viewPort.set_scrollY(get_scrollY());
            refreshScrollRect();
            refreshScrollBarValues();
         }
         ScrollEvent.dispatch(this,"scroll");
      }
      
      public function baseScrollContainer_scroller_scrollCompleteHandler(param1:ScrollEvent) : void
      {
         _viewPort.removeEventListener(MouseEvent.MOUSE_DOWN,baseScrollContainer_viewPort_mouseDownHandler);
         _viewPort.removeEventListener(TouchEvent.TOUCH_BEGIN,baseScrollContainer_viewPort_touchBeginHandler);
         _scrollerDraggingX = false;
         _scrollerDraggingY = false;
         if(!_scrollBarXHover && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarX();
         }
         if(!_scrollBarYHover && !get_fixedScrollBars() && get_autoHideScrollBars())
         {
            hideScrollBarY();
         }
         ScrollEvent.dispatch(this,"scrollComplete");
      }
      
      public function baseScrollContainer_removedFromStageHandler(param1:Event) : void
      {
         if(scroller != null)
         {
            scroller.set_target(null);
         }
      }
      
      public function baseScrollContainer_keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!_enabled || param1.isDefaultPrevented())
         {
            return;
         }
         scrollWithKeyboard(param1);
      }
      
      public function baseScrollContainer_addedToStageHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.SCROLL);
      }
      
      public function applyTemporaryScrollPositions() : void
      {
         if(_temporaryScrollX != null)
         {
            scroller.set_scrollX(_temporaryScrollX);
         }
         else if(_temporaryRestrictedScrollX != null)
         {
            scroller.set_restrictedScrollX(_temporaryRestrictedScrollX);
         }
         if(_temporaryScrollY != null)
         {
            scroller.set_scrollY(_temporaryScrollY);
         }
         else if(_temporaryRestrictedScrollY != null)
         {
            scroller.set_restrictedScrollY(_temporaryRestrictedScrollY);
         }
         _temporaryScrollX = null;
         _temporaryScrollY = null;
         _temporaryRestrictedScrollX = null;
         _temporaryRestrictedScrollY = null;
      }
      
      public function addCurrentViewPortMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         addChild(param1);
         _viewPort.mask = param1;
      }
      
      public function addCurrentMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         addChild(param1);
         mask = param1;
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
         addChildAt(param1,0);
      }
   }
}

import feathers.controls.HScrollBar;
import feathers.controls.VScrollBar;
import feathers.core.InvalidationFlag;
import feathers.utils.DisplayObjectFactory;

