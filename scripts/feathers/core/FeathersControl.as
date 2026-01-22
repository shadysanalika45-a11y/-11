package feathers.core
{
   import feathers.core._FeathersControl.StyleDefinition;
   import feathers.events.FeathersEvent;
   import feathers.events.StyleProviderEvent;
   import feathers.layout.ILayoutData;
   import feathers.layout.ILayoutObject;
   import feathers.style.IStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.IVariantStyleObject;
   import feathers.style.Theme;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.geom.Point;
   
   public class FeathersControl extends MeasureSprite implements ILayoutObject, IVariantStyleObject, IUIControl
   {
      
      public static var __meta__:* = {"fields":{
         "layoutData":{"style":null},
         "focusRectSkin":{"style":null},
         "focusPaddingTop":{"style":null},
         "focusPaddingRight":{"style":null},
         "focusPaddingBottom":{"style":null},
         "focusPaddingLeft":{"style":null}
      }};
      
      public var disabledAlpha:Object;
      
      public var _waitingToApplyStyles:Boolean;
      
      public var _variant:String;
      
      public var _toolTip:String;
      
      public var _themeEnabled:Boolean;
      
      public var _styleProviderStyles:Array;
      
      public var _restrictedStyles:Array;
      
      public var _previousClearStyle:*;
      
      public var _layoutData:ILayoutData;
      
      public var _initializing:Boolean;
      
      public var _initialized:Boolean;
      
      public var _includeInLayout:Boolean;
      
      public var _focusRectSkin:DisplayObject;
      
      public var _focusPaddingTop:Number;
      
      public var _focusPaddingRight:Number;
      
      public var _focusPaddingLeft:Number;
      
      public var _focusPaddingBottom:Number;
      
      public var _focusOwner:IFocusObject;
      
      public var _focusManager:IFocusManager;
      
      public var _focusEnabled:Boolean;
      
      public var _explicitAlpha:Number;
      
      public var _enabled:Boolean;
      
      public var _customStyleProvider:IStyleProvider;
      
      public var _currentStyleProvider:IStyleProvider;
      
      public var _created:Boolean;
      
      public var _clearingStyles:Boolean;
      
      public var _applyingStyles:Boolean;
      
      public function FeathersControl()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _restrictedStyles = [];
         _styleProviderStyles = [];
         _clearingStyles = false;
         _applyingStyles = false;
         _focusPaddingLeft = 0;
         _focusPaddingBottom = 0;
         _focusPaddingRight = 0;
         _focusPaddingTop = 0;
         _focusRectSkin = null;
         _focusEnabled = true;
         _focusManager = null;
         disabledAlpha = null;
         _explicitAlpha = 1;
         _includeInLayout = true;
         _customStyleProvider = null;
         _currentStyleProvider = null;
         _themeEnabled = true;
         _toolTip = null;
         _enabled = true;
         _created = false;
         _initialized = false;
         _initializing = false;
         _waitingToApplyStyles = false;
         super();
         tabEnabled = this is IFocusObject;
         addEventListener(Event.ADDED_TO_STAGE,feathersControl_addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,feathersControl_removedFromStageHandler);
         addEventListener(FocusEvent.FOCUS_IN,feathersControl_focusInHandler);
         addEventListener(FocusEvent.FOCUS_OUT,feathersControl_focusOutHandler);
      }
      
      override public function validateNow() : void
      {
         if(!_initialized)
         {
            if(_initializing)
            {
               throw new IllegalOperationError("A component cannot validate until after it has finished initializing.");
            }
            initializeNow();
         }
         if(_waitingToApplyStyles)
         {
            applyStyles();
         }
         super.validateNow();
         if(!_created)
         {
            _created = true;
            FeathersEvent.dispatch(this,"creationComplete");
         }
      }
      
      public function styleProvider_stylesChangeHandler(param1:StyleProviderEvent) : void
      {
         if(!param1.affectsTarget(this))
         {
            return;
         }
         if(stage != null)
         {
            applyStyles();
         }
         else
         {
            _waitingToApplyStyles = true;
         }
      }
      
      public function styleProvider_clearHandler(param1:Event) : void
      {
         clearStyleProvider();
         if(stage != null)
         {
            applyStyles();
         }
      }
      
      public function showFocus(param1:Boolean) : void
      {
         if(_focusManager == null || _focusRectSkin == null)
         {
            return;
         }
         if(param1)
         {
            _focusManager.get_focusPane().addChild(_focusRectSkin);
            addEventListener(Event.ENTER_FRAME,feathersControl_focusRect_enterFrameHandler);
            positionFocusRect();
         }
         else if(_focusRectSkin.parent != null)
         {
            removeEventListener(Event.ENTER_FRAME,feathersControl_focusRect_enterFrameHandler);
            _focusRectSkin.parent.removeChild(_focusRectSkin);
         }
      }
      
      public function set_variant(param1:String) : String
      {
         if(_variant == param1)
         {
            return _variant;
         }
         _variant = param1;
         if(_initialized && stage != null)
         {
            applyStyles();
         }
         else
         {
            _waitingToApplyStyles = true;
         }
         setInvalid(InvalidationFlag.STYLES);
         return _variant;
      }
      
      public function set variant(param1:String) : void
      {
         set_variant(param1);
      }
      
      public function set_toolTip(param1:String) : String
      {
         if(_toolTip == param1)
         {
            return _toolTip;
         }
         _toolTip = param1;
         return _toolTip;
      }
      
      public function set toolTip(param1:String) : void
      {
         set_toolTip(param1);
      }
      
      public function set_themeEnabled(param1:Boolean) : Boolean
      {
         if(_themeEnabled == param1)
         {
            return _themeEnabled;
         }
         _themeEnabled = param1;
         if(_initialized && stage != null)
         {
            applyStyles();
         }
         else
         {
            _waitingToApplyStyles = true;
         }
         setInvalid(InvalidationFlag.STYLES);
         return _themeEnabled;
      }
      
      public function set themeEnabled(param1:Boolean) : void
      {
         set_themeEnabled(param1);
      }
      
      public function set_styleProvider(param1:IStyleProvider) : IStyleProvider
      {
         if(_customStyleProvider == param1)
         {
            return _customStyleProvider;
         }
         if(_customStyleProvider != null)
         {
            _customStyleProvider.removeEventListener(Event.CLEAR,customStyleProvider_clearHandler);
         }
         _customStyleProvider = param1;
         if(_customStyleProvider != null)
         {
            _customStyleProvider.addEventListener(Event.CLEAR,customStyleProvider_clearHandler,false,0,true);
         }
         if(_initialized && stage != null)
         {
            applyStyles();
         }
         else
         {
            _waitingToApplyStyles = true;
         }
         setInvalid(InvalidationFlag.STYLES);
         return _customStyleProvider;
      }
      
      public function set styleProvider(param1:IStyleProvider) : void
      {
         set_styleProvider(param1);
      }
      
      public function set_layoutData(param1:ILayoutData) : ILayoutData
      {
         if(!setStyle("layoutData"))
         {
            return _layoutData;
         }
         _previousClearStyle = clearStyle_layoutData;
         return setLayoutDataInternal(param1);
      }
      
      public function set layoutData(param1:ILayoutData) : void
      {
         set_layoutData(param1);
      }
      
      public function set_includeInLayout(param1:Boolean) : Boolean
      {
         if(_includeInLayout == param1)
         {
            return _includeInLayout;
         }
         _includeInLayout = param1;
         FeathersEvent.dispatch(this,"layoutDataChange");
         return _includeInLayout;
      }
      
      public function set includeInLayout(param1:Boolean) : void
      {
         set_includeInLayout(param1);
      }
      
      public function set_focusRectSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("focusRectSkin"))
         {
            return _focusRectSkin;
         }
         showFocus(false);
         _previousClearStyle = clearStyle_focusRectSkin;
         _focusRectSkin = param1;
         return _focusRectSkin;
      }
      
      public function set focusRectSkin(param1:DisplayObject) : void
      {
         set_focusRectSkin(param1);
      }
      
      public function set_focusPaddingTop(param1:Number) : Number
      {
         if(!setStyle("focusPaddingTop"))
         {
            return _focusPaddingTop;
         }
         _previousClearStyle = clearStyle_focusPaddingTop;
         _focusPaddingTop = param1;
         return _focusPaddingTop;
      }
      
      public function set focusPaddingTop(param1:Number) : void
      {
         set_focusPaddingTop(param1);
      }
      
      public function set_focusPaddingRight(param1:Number) : Number
      {
         if(!setStyle("focusPaddingRight"))
         {
            return _focusPaddingRight;
         }
         _previousClearStyle = clearStyle_focusPaddingRight;
         _focusPaddingRight = param1;
         return _focusPaddingRight;
      }
      
      public function set focusPaddingRight(param1:Number) : void
      {
         set_focusPaddingRight(param1);
      }
      
      public function set_focusPaddingLeft(param1:Number) : Number
      {
         if(!setStyle("focusPaddingLeft"))
         {
            return _focusPaddingLeft;
         }
         _previousClearStyle = clearStyle_focusPaddingLeft;
         _focusPaddingLeft = param1;
         return _focusPaddingLeft;
      }
      
      public function set focusPaddingLeft(param1:Number) : void
      {
         set_focusPaddingLeft(param1);
      }
      
      public function set_focusPaddingBottom(param1:Number) : Number
      {
         if(!setStyle("focusPaddingBottom"))
         {
            return _focusPaddingBottom;
         }
         _previousClearStyle = clearStyle_focusPaddingBottom;
         _focusPaddingBottom = param1;
         return _focusPaddingBottom;
      }
      
      public function set focusPaddingBottom(param1:Number) : void
      {
         set_focusPaddingBottom(param1);
      }
      
      public function set_focusOwner(param1:IFocusObject) : IFocusObject
      {
         if(_focusOwner == param1)
         {
            return _focusOwner;
         }
         _focusOwner = param1;
         return _focusOwner;
      }
      
      public function set focusOwner(param1:IFocusObject) : void
      {
         set_focusOwner(param1);
      }
      
      public function set_focusManager(param1:IFocusManager) : IFocusManager
      {
         if(_focusManager == param1)
         {
            return _focusManager;
         }
         if(_focusManager != null)
         {
            showFocus(false);
         }
         _focusManager = param1;
         return _focusManager;
      }
      
      public function set focusManager(param1:IFocusManager) : void
      {
         set_focusManager(param1);
      }
      
      public function set_focusEnabled(param1:Boolean) : Boolean
      {
         if(_focusEnabled == param1)
         {
            return _focusEnabled;
         }
         _focusEnabled = param1;
         return _focusEnabled;
      }
      
      public function set focusEnabled(param1:Boolean) : void
      {
         set_focusEnabled(param1);
      }
      
      public function set_enabled(param1:Boolean) : Boolean
      {
         if(_enabled == param1)
         {
            return _enabled;
         }
         _enabled = param1;
         if(_enabled || disabledAlpha == null)
         {
            super.alpha = _explicitAlpha;
         }
         else if(!_enabled && disabledAlpha != null)
         {
            super.alpha = disabledAlpha;
         }
         setInvalid(InvalidationFlag.STATE);
         if(_enabled)
         {
            FeathersEvent.dispatch(this,"enable");
         }
         else
         {
            FeathersEvent.dispatch(this,"disable");
         }
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         set_enabled(param1);
      }
      
      override public function set alpha(param1:Number) : void
      {
         _explicitAlpha = param1;
         if(_enabled || disabledAlpha == null)
         {
            super.alpha = param1;
         }
      }
      
      public function setStyle(param1:String, param2:Object = undefined) : Boolean
      {
         var _loc3_:StyleDefinition = param2 == null ? StyleDefinition.Name(param1) : StyleDefinition.NameAndState(param1,param2);
         var _loc4_:Boolean = containsStyleDef(_restrictedStyles,_loc3_);
         if(_applyingStyles && _loc4_)
         {
            return false;
         }
         if(_applyingStyles)
         {
            if(!_clearingStyles && !containsStyleDef(_styleProviderStyles,_loc3_))
            {
               _styleProviderStyles.push(_loc3_);
            }
         }
         else if(!_loc4_)
         {
            if(!_clearingStyles && containsStyleDef(_styleProviderStyles,_loc3_))
            {
               _styleProviderStyles.remove(_loc3_);
            }
            _restrictedStyles.push(_loc3_);
         }
         return true;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         width = param1;
         height = param2;
      }
      
      public function setLayoutDataInternal(param1:ILayoutData) : ILayoutData
      {
         if(_layoutData == param1)
         {
            return _layoutData;
         }
         if(_layoutData != null)
         {
            _layoutData.removeEventListener(Event.CHANGE,layoutData_changeHandler);
         }
         _layoutData = param1;
         if(_layoutData != null)
         {
            _layoutData.addEventListener(Event.CHANGE,layoutData_changeHandler,false,0,true);
         }
         FeathersEvent.dispatch(this,"layoutDataChange");
         return _layoutData;
      }
      
      public function setFocusPadding(param1:Number) : void
      {
         set_focusPaddingTop(param1);
         set_focusPaddingRight(param1);
         set_focusPaddingBottom(param1);
         set_focusPaddingLeft(param1);
      }
      
      public function positionFocusRect() : void
      {
         if(_focusManager == null || _focusRectSkin == null || _focusRectSkin.parent == null)
         {
            return;
         }
         var _loc1_:Point = new Point(-_focusPaddingLeft,-_focusPaddingTop);
         _loc1_ = localToGlobal(_loc1_);
         _loc1_ = _focusManager.get_focusPane().globalToLocal(_loc1_);
         _focusRectSkin.x = _loc1_.x;
         _focusRectSkin.y = _loc1_.y;
         _loc1_.setTo(actualWidth + _focusPaddingRight,actualHeight + _focusPaddingBottom);
         _loc1_ = localToGlobal(_loc1_);
         _loc1_ = _focusManager.get_focusPane().globalToLocal(_loc1_);
         _focusRectSkin.width = _loc1_.x - _focusRectSkin.x;
         _focusRectSkin.height = _loc1_.y - _focusRectSkin.y;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
         x = param1;
         y = param2;
      }
      
      public function layoutData_changeHandler(param1:Event) : void
      {
         FeathersEvent.dispatch(this,"layoutDataChange");
      }
      
      public function isStyleRestricted(param1:String, param2:Object = undefined) : Boolean
      {
         var _loc3_:StyleDefinition = param2 == null ? StyleDefinition.Name(param1) : StyleDefinition.NameAndState(param1,param2);
         return containsStyleDef(_restrictedStyles,_loc3_);
      }
      
      public function initializeNow() : void
      {
         if(_initialized || _initializing)
         {
            return;
         }
         _waitingToApplyStyles = true;
         _initializing = true;
         initialize();
         setInvalid();
         _initializing = false;
         _initialized = true;
         FeathersEvent.dispatch(this,"initialize");
      }
      
      public function initialize() : void
      {
      }
      
      public function get_variant() : String
      {
         return _variant;
      }
      
      public function get variant() : String
      {
         return get_variant();
      }
      
      public function get_toolTip() : String
      {
         return _toolTip;
      }
      
      public function get toolTip() : String
      {
         return get_toolTip();
      }
      
      public function get_themeEnabled() : Boolean
      {
         return _themeEnabled;
      }
      
      public function get themeEnabled() : Boolean
      {
         return get_themeEnabled();
      }
      
      override public function get tabEnabled() : Boolean
      {
         if(_enabled)
         {
            return super.tabEnabled;
         }
         return false;
      }
      
      public function get_styleProvider() : IStyleProvider
      {
         if(_customStyleProvider != null)
         {
            return _customStyleProvider;
         }
         return _currentStyleProvider;
      }
      
      public function get styleProvider() : IStyleProvider
      {
         return get_styleProvider();
      }
      
      public function get_styleContext() : Class
      {
         return null;
      }
      
      public function get styleContext() : Class
      {
         return get_styleContext();
      }
      
      public function get_rawTabEnabled() : Boolean
      {
         return super.tabEnabled;
      }
      
      public function get rawTabEnabled() : Boolean
      {
         return get_rawTabEnabled();
      }
      
      public function get_layoutData() : ILayoutData
      {
         return _layoutData;
      }
      
      public function get layoutData() : ILayoutData
      {
         return get_layoutData();
      }
      
      public function get_initialized() : Boolean
      {
         return _initialized;
      }
      
      public function get initialized() : Boolean
      {
         return get_initialized();
      }
      
      public function get_includeInLayout() : Boolean
      {
         return _includeInLayout;
      }
      
      public function get includeInLayout() : Boolean
      {
         return get_includeInLayout();
      }
      
      public function get_focusRectSkin() : DisplayObject
      {
         return _focusRectSkin;
      }
      
      public function get focusRectSkin() : DisplayObject
      {
         return get_focusRectSkin();
      }
      
      public function get_focusPaddingTop() : Number
      {
         return _focusPaddingTop;
      }
      
      public function get focusPaddingTop() : Number
      {
         return get_focusPaddingTop();
      }
      
      public function get_focusPaddingRight() : Number
      {
         return _focusPaddingRight;
      }
      
      public function get focusPaddingRight() : Number
      {
         return get_focusPaddingRight();
      }
      
      public function get_focusPaddingLeft() : Number
      {
         return _focusPaddingLeft;
      }
      
      public function get focusPaddingLeft() : Number
      {
         return get_focusPaddingLeft();
      }
      
      public function get_focusPaddingBottom() : Number
      {
         return _focusPaddingBottom;
      }
      
      public function get focusPaddingBottom() : Number
      {
         return get_focusPaddingBottom();
      }
      
      public function get_focusOwner() : IFocusObject
      {
         return _focusOwner;
      }
      
      public function get focusOwner() : IFocusObject
      {
         return get_focusOwner();
      }
      
      public function get_focusManager() : IFocusManager
      {
         return _focusManager;
      }
      
      public function get focusManager() : IFocusManager
      {
         return get_focusManager();
      }
      
      public function get_focusEnabled() : Boolean
      {
         if(_enabled)
         {
            return _focusEnabled;
         }
         return false;
      }
      
      public function get focusEnabled() : Boolean
      {
         return get_focusEnabled();
      }
      
      public function get_enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get enabled() : Boolean
      {
         return get_enabled();
      }
      
      public function get_created() : Boolean
      {
         return _created;
      }
      
      public function get created() : Boolean
      {
         return get_created();
      }
      
      public function feathersControl_removedFromStageHandler(param1:Event) : void
      {
         showFocus(false);
         clearStyleProvider();
      }
      
      public function feathersControl_focusRect_enterFrameHandler(param1:Event) : void
      {
         positionFocusRect();
      }
      
      public function feathersControl_focusOutHandler(param1:FocusEvent) : void
      {
         if(_focusManager == null)
         {
            return;
         }
         showFocus(false);
      }
      
      public function feathersControl_focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:IFocusObject = null;
         if(this is IFocusObject)
         {
            _loc2_ = this;
         }
         if(_focusManager == null || !_focusManager.get_showFocusIndicator() || _focusManager.get_focus() != _loc2_)
         {
            return;
         }
         showFocus(true);
      }
      
      public function feathersControl_addedToStageHandler(param1:Event) : void
      {
         if(!_initialized)
         {
            initializeNow();
         }
         if(_waitingToApplyStyles)
         {
            applyStyles();
         }
      }
      
      public function customStyleProvider_clearHandler(param1:Event) : void
      {
         _customStyleProvider.removeEventListener(Event.CLEAR,customStyleProvider_clearHandler);
         _customStyleProvider = null;
      }
      
      public function containsStyleDef(param1:Array, param2:StyleDefinition) : Boolean
      {
         var _loc4_:* = null as StyleDefinition;
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            if(Type.enumEq(param2,_loc4_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function clearStyles() : void
      {
         var _loc4_:* = null as StyleDefinition;
         var _loc5_:* = null as String;
         var _loc6_:* = null as String;
         var _loc7_:* = null;
         var _loc8_:* = null as Object;
         var _loc1_:Boolean = _clearingStyles;
         _clearingStyles = true;
         var _loc2_:int = 0;
         var _loc3_:Array = _styleProviderStyles;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            switch((++_loc4_).index)
            {
               case 0:
                  _loc5_ = _loc4_.params[0];
                  _loc6_ = "clearStyle_" + _loc5_;
                  _loc7_ = Reflect.field(this,_loc6_);
                  if(_loc7_ == null)
                  {
                     throw new ArgumentError("Missing @style method: \'" + _loc6_ + "\'");
                  }
                  _loc7_.apply(this,[]);
                  break;
               case 1:
                  _loc5_ = _loc4_.params[0];
                  _loc8_ = _loc4_.params[1];
                  _loc7_ = Reflect.field(this,_loc5_);
                  _loc7_.apply(this,[_loc8_,null]);
            }
         }
         _styleProviderStyles = [];
         _clearingStyles = _loc1_;
      }
      
      public function clearStyle_layoutData() : ILayoutData
      {
         return setLayoutDataInternal(null);
      }
      
      public function clearStyle_focusRectSkin() : DisplayObject
      {
         showFocus(false);
         _focusRectSkin = null;
         return _focusRectSkin;
      }
      
      public function clearStyle_focusPaddingTop() : Number
      {
         _focusPaddingTop = 0;
         return _focusPaddingTop;
      }
      
      public function clearStyle_focusPaddingRight() : Number
      {
         _focusPaddingRight = 0;
         return _focusPaddingRight;
      }
      
      public function clearStyle_focusPaddingLeft() : Number
      {
         _focusPaddingLeft = 0;
         return _focusPaddingLeft;
      }
      
      public function clearStyle_focusPaddingBottom() : Number
      {
         _focusPaddingBottom = 0;
         return _focusPaddingBottom;
      }
      
      public function clearStyleProvider() : void
      {
         if(_currentStyleProvider == null)
         {
            return;
         }
         _currentStyleProvider.removeEventListener("stylesChange",styleProvider_stylesChangeHandler);
         _currentStyleProvider.removeEventListener(Event.CLEAR,styleProvider_clearHandler);
         _currentStyleProvider = null;
         _waitingToApplyStyles = true;
      }
      
      public function applyStyles() : void
      {
         var _loc2_:* = null as ITheme;
         if(!_initialized)
         {
            throw new IllegalOperationError("Cannot apply styles until after a Feathers UI component has initialized.");
         }
         _waitingToApplyStyles = false;
         var _loc1_:IStyleProvider = _customStyleProvider;
         if(_loc1_ == null)
         {
            _loc2_ = Theme.getTheme(this);
            if(_loc2_ != null)
            {
               _loc1_ = _loc2_.getStyleProvider(this);
            }
         }
         if(_themeEnabled && _loc1_ == null)
         {
            _loc2_ = Theme.get_fallbackTheme();
            if(_loc2_ != null)
            {
               _loc1_ = _loc2_.getStyleProvider(this);
            }
         }
         if(_loc1_ == null)
         {
            _loc1_ = _currentStyleProvider;
         }
         if(_currentStyleProvider != _loc1_)
         {
            if(_currentStyleProvider != null)
            {
               _currentStyleProvider.removeEventListener("stylesChange",styleProvider_stylesChangeHandler);
               _currentStyleProvider.removeEventListener(Event.CLEAR,styleProvider_clearHandler);
            }
            _currentStyleProvider = _loc1_;
            if(_currentStyleProvider != null)
            {
               _currentStyleProvider.addEventListener("stylesChange",styleProvider_stylesChangeHandler,false,0,true);
               _currentStyleProvider.addEventListener(Event.CLEAR,styleProvider_clearHandler,false,0,true);
            }
         }
         var _loc3_:Boolean = _applyingStyles;
         _applyingStyles = true;
         clearStyles();
         if(_currentStyleProvider != null)
         {
            _currentStyleProvider.applyStyles(this);
         }
         _applyingStyles = _loc3_;
      }
   }
}

