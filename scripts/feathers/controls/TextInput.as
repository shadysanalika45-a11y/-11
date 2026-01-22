package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IMeasureObject;
   import feathers.core.IStageFocusDelegate;
   import feathers.core.IStateContext;
   import feathers.core.IStateObserver;
   import feathers.core.ITextControl;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.core.PopUpManager;
   import feathers.events.FeathersEvent;
   import feathers.layout.Measurements;
   import feathers.layout.VerticalAlign;
   import feathers.skins.IProgrammaticSkin;
   import feathers.text.TextFormat;
   import feathers.themes.steel.components.SteelTextInputStyles;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   
   public class TextInput extends FeathersControl implements IStageFocusDelegate, ITextControl, IStateContext
   {
      
      public static var __meta__:* = {
         "obj":{"defaultXmlProperty":["text"]},
         "fields":{
            "setSkinForState":{"style":null},
            "setTextFormatForState":{"style":null}
         }
      };
      
      public static var VARIANT_SEARCH:String = "search";
      
      public static var CHILD_VARIANT_ERROR_CALLOUT:String = "textInput_errorCallout";
      
      public static var INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY:InvalidationFlag = InvalidationFlag.CUSTOM("errorCalloutFactory");
      
      public var textField:TextField;
      
      public var promptTextField:TextField;
      
      public var errorStringCallout:TextCallout;
      
      public var _updatedTextStyles:Boolean;
      
      public var _updatedPromptStyles:Boolean;
      
      public var _textMeasuredWidth:Number;
      
      public var _textMeasuredHeight:Number;
      
      public var _text:String;
      
      public var _stateToTextFormat:IMap;
      
      public var _stateToSkin:IMap;
      
      public var _selectable:Boolean;
      
      public var _scrollX:Number;
      
      public var _rightViewMeasurements:Measurements;
      
      public var _promptTextMeasuredWidth:Number;
      
      public var _promptTextMeasuredHeight:Number;
      
      public var _prompt:String;
      
      public var _previousTextFormat:feathers.text.TextFormat;
      
      public var _previousText:String;
      
      public var _previousSimpleTextFormat:flash.text.TextFormat;
      
      public var _previousPromptTextFormat:feathers.text.TextFormat;
      
      public var _previousPromptSimpleTextFormat:flash.text.TextFormat;
      
      public var _previousPrompt:String;
      
      public var _previousMeasureText:String;
      
      public var _previousCustomErrorCalloutVariant:String;
      
      public var _pendingSelectionAnchorIndex:int;
      
      public var _pendingSelectionActiveIndex:int;
      
      public var _measureText:String;
      
      public var _maxChars:int;
      
      public var _leftViewMeasurements:Measurements;
      
      public var _ignoreRightViewResize:Boolean;
      
      public var _ignoreLeftViewResize:Boolean;
      
      public var _errorString:String;
      
      public var _editable:Boolean;
      
      public var _displayAsPassword:Boolean;
      
      public var _currentState:TextInputState;
      
      public var _currentRightView:DisplayObject;
      
      public var _currentLeftView:DisplayObject;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var __verticalAlign:VerticalAlign;
      
      public var __textFormat:feathers.text.TextFormat;
      
      public var __rightViewGap:Number;
      
      public var __rightView:DisplayObject;
      
      public var __restrict:String;
      
      public var __promptTextFormat:feathers.text.TextFormat;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __leftViewGap:Number;
      
      public var __leftView:DisplayObject;
      
      public var __embedFonts:Boolean;
      
      public var __disabledTextFormat:feathers.text.TextFormat;
      
      public var __customErrorCalloutVariant:String;
      
      public var __backgroundSkin:DisplayObject;
      
      public var __autoSizeWidth:Boolean;
      
      public function TextInput(param1:String = undefined, param2:String = undefined, param3:Object = undefined)
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(Boot.skip_constructor)
         {
            return;
         }
         __customErrorCalloutVariant = null;
         __autoSizeWidth = false;
         __verticalAlign = VerticalAlign.MIDDLE;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         __embedFonts = false;
         __promptTextFormat = null;
         __disabledTextFormat = null;
         __textFormat = null;
         __rightViewGap = 0;
         __rightView = null;
         __leftViewGap = 0;
         __leftView = null;
         __backgroundSkin = null;
         _previousCustomErrorCalloutVariant = null;
         _maxChars = 0;
         _pendingSelectionActiveIndex = -1;
         _pendingSelectionAnchorIndex = -1;
         _scrollX = 0;
         _stateToTextFormat = new EnumValueMap();
         _errorString = null;
         _displayAsPassword = false;
         _measureText = null;
         _updatedPromptStyles = false;
         _updatedTextStyles = false;
         _previousPromptTextFormat = null;
         _previousTextFormat = null;
         _previousPrompt = null;
         _previousMeasureText = null;
         _previousText = null;
         _stateToSkin = new EnumValueMap();
         _ignoreRightViewResize = false;
         _ignoreLeftViewResize = false;
         _currentBackgroundSkin = null;
         _backgroundSkinMeasurements = null;
         _currentState = TextInputState.ENABLED;
         _selectable = true;
         _editable = true;
         initializeTextInputTheme();
         super();
         set_text(param1);
         set_prompt(param2);
         tabEnabled = true;
         tabChildren = false;
         focusRect = null;
         addEventListener(FocusEvent.FOCUS_IN,textInput_focusInHandler);
         addEventListener(FocusEvent.FOCUS_OUT,textInput_focusOutHandler);
         if(param3 != null)
         {
            addEventListener(Event.CHANGE,param3);
         }
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.SCROLL);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.SELECTION);
         var _loc4_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc5_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc6_:Boolean = isInvalid(InvalidationFlag.STYLES);
         if(_previousCustomErrorCalloutVariant != get_customErrorCalloutVariant())
         {
            setInvalidationFlag(TextInput.INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY);
         }
         var _loc7_:Boolean = isInvalid(TextInput.INVALIDATION_FLAG_ERROR_CALLOUT_FACTORY);
         _updatedTextStyles = false;
         _updatedPromptStyles = false;
         if(_loc7_ || _loc1_)
         {
            createErrorCallout();
         }
         if(_loc6_ || _loc5_)
         {
            refreshBackgroundSkin();
            refreshLeftView();
            refreshRightView();
         }
         if(_loc1_)
         {
            refreshPrompt();
         }
         if(_loc6_ || _loc5_)
         {
            refreshTextStyles();
            refreshPromptStyles();
         }
         if(_loc1_ || _loc6_ || _loc5_ || _loc4_)
         {
            refreshText(_loc4_);
         }
         if(_loc1_ || _loc6_ || _loc4_)
         {
            refreshPromptText(_loc4_);
         }
         if(_loc3_)
         {
            refreshSelection();
         }
         if(_loc2_)
         {
            refreshScrollPosition();
         }
         measure();
         layoutContent();
         if(_loc7_ || _loc5_ || _loc1_)
         {
            refreshErrorString();
         }
         _previousCustomErrorCalloutVariant = get_customErrorCalloutVariant();
      }
      
      public function textInput_textFormat_changeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function textInput_rightView_resizeHandler(param1:Event) : void
      {
         if(_ignoreRightViewResize)
         {
            return;
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function textInput_promptTextFormat_changeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function textInput_leftView_resizeHandler(param1:Event) : void
      {
         if(_ignoreLeftViewResize)
         {
            return;
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function textInput_focusOutHandler(param1:FocusEvent) : void
      {
         refreshState();
      }
      
      public function textInput_focusInHandler(param1:FocusEvent) : void
      {
         if(stage != null && stage.focus != textField)
         {
            param1.stopImmediatePropagation();
            stage.focus = textField;
         }
         refreshState();
      }
      
      public function textField_scrollHandler(param1:Event) : void
      {
         _scrollX = textField.scrollH;
         FeathersEvent.dispatch(this,Event.SCROLL);
      }
      
      public function textField_changeHandler(param1:Event) : void
      {
         param1.stopPropagation();
         var _loc2_:String = _text;
         var _loc3_:String = textField.text;
         _text = _loc3_;
         var _loc4_:* = _measureText != null;
         var _loc5_:String = _loc4_ ? _measureText : _text;
         if(_loc5_ == null || _loc5_.length == 0)
         {
            _loc4_ = true;
            _loc5_ = "​";
         }
         var _loc6_:Boolean = _text != null && _text.length > 0;
         var _loc7_:Boolean = _loc2_ != null && _loc2_.length > 0;
         var _loc8_:Boolean = _prompt != null && _prompt.length > 0;
         if(get_autoSizeWidth() || _loc8_ && (!_loc6_ && _loc7_ || _loc6_ && !_loc7_))
         {
            setInvalid(InvalidationFlag.DATA);
         }
         else
         {
            _previousMeasureText = _loc5_;
            _previousText = _text;
         }
         FeathersEvent.dispatch(this,Event.CHANGE);
      }
      
      override public function showFocus(param1:Boolean) : void
      {
         super.showFocus(param1);
         if(param1)
         {
            selectRange(_text.length,0);
         }
      }
      
      public function set_verticalAlign(param1:VerticalAlign) : VerticalAlign
      {
         if(!setStyle("verticalAlign"))
         {
            return __verticalAlign;
         }
         if(__verticalAlign == param1)
         {
            return __verticalAlign;
         }
         _previousClearStyle = clearStyle_verticalAlign;
         __verticalAlign = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __verticalAlign;
      }
      
      public function set verticalAlign(param1:VerticalAlign) : void
      {
         set_verticalAlign(param1);
      }
      
      public function set_textFormat(param1:feathers.text.TextFormat) : feathers.text.TextFormat
      {
         if(!setStyle("textFormat"))
         {
            return __textFormat;
         }
         if(__textFormat == param1)
         {
            return __textFormat;
         }
         _previousClearStyle = clearStyle_textFormat;
         __textFormat = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __textFormat;
      }
      
      public function set textFormat(param1:feathers.text.TextFormat) : void
      {
         set_textFormat(param1);
      }
      
      public function set_text(param1:String) : String
      {
         if(param1 == null)
         {
            if(_text.length == 0)
            {
               return _text;
            }
            param1 = "";
         }
         if(_text == param1)
         {
            return _text;
         }
         _text = param1;
         setInvalid(InvalidationFlag.DATA);
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         set_text(param1);
      }
      
      public function set_selectable(param1:Boolean) : Boolean
      {
         if(_selectable == param1)
         {
            return _selectable;
         }
         _selectable = param1;
         setInvalid(InvalidationFlag.STATE);
         return _selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         set_selectable(param1);
      }
      
      public function set_scrollX(param1:Number) : Number
      {
         if(_scrollX == param1)
         {
            return _scrollX;
         }
         _scrollX = param1;
         setInvalid(InvalidationFlag.SCROLL);
         FeathersEvent.dispatch(this,Event.SCROLL);
         return _scrollX;
      }
      
      public function set scrollX(param1:Number) : void
      {
         set_scrollX(param1);
      }
      
      public function set_rightViewGap(param1:Number) : Number
      {
         if(!setStyle("rightViewGap"))
         {
            return __rightViewGap;
         }
         if(__rightViewGap == param1)
         {
            return __rightViewGap;
         }
         _previousClearStyle = clearStyle_rightViewGap;
         __rightViewGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __rightViewGap;
      }
      
      public function set rightViewGap(param1:Number) : void
      {
         set_rightViewGap(param1);
      }
      
      public function set_rightView(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("rightView"))
         {
            return __rightView;
         }
         if(__rightView == param1)
         {
            return __rightView;
         }
         _previousClearStyle = clearStyle_rightView;
         __rightView = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __rightView;
      }
      
      public function set rightView(param1:DisplayObject) : void
      {
         set_rightView(param1);
      }
      
      public function set_restrict(param1:String) : String
      {
         if(__restrict == param1)
         {
            return __restrict;
         }
         __restrict = param1;
         setInvalid(InvalidationFlag.DATA);
         return __restrict;
      }
      
      public function set restrict(param1:String) : void
      {
         set_restrict(param1);
      }
      
      public function set_promptTextFormat(param1:feathers.text.TextFormat) : feathers.text.TextFormat
      {
         if(!setStyle("promptTextFormat"))
         {
            return __promptTextFormat;
         }
         if(__promptTextFormat == param1)
         {
            return __promptTextFormat;
         }
         _previousClearStyle = clearStyle_promptTextFormat;
         __promptTextFormat = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __promptTextFormat;
      }
      
      public function set promptTextFormat(param1:feathers.text.TextFormat) : void
      {
         set_promptTextFormat(param1);
      }
      
      public function set_prompt(param1:String) : String
      {
         if(_prompt == param1)
         {
            return _prompt;
         }
         _prompt = param1;
         setInvalid(InvalidationFlag.DATA);
         return _prompt;
      }
      
      public function set prompt(param1:String) : void
      {
         set_prompt(param1);
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
      
      public function set_measureText(param1:String) : String
      {
         if(_measureText == param1)
         {
            return _measureText;
         }
         _measureText = param1;
         setInvalid(InvalidationFlag.DATA);
         return _measureText;
      }
      
      public function set measureText(param1:String) : void
      {
         set_measureText(param1);
      }
      
      public function set_maxChars(param1:int) : int
      {
         if(_maxChars == param1)
         {
            return _maxChars;
         }
         _maxChars = param1;
         setInvalid(InvalidationFlag.DATA);
         return _maxChars;
      }
      
      public function set maxChars(param1:int) : void
      {
         set_maxChars(param1);
      }
      
      public function set_leftViewGap(param1:Number) : Number
      {
         if(!setStyle("leftViewGap"))
         {
            return __leftViewGap;
         }
         if(__leftViewGap == param1)
         {
            return __leftViewGap;
         }
         _previousClearStyle = clearStyle_leftViewGap;
         __leftViewGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __leftViewGap;
      }
      
      public function set leftViewGap(param1:Number) : void
      {
         set_leftViewGap(param1);
      }
      
      public function set_leftView(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("leftView"))
         {
            return __leftView;
         }
         if(__leftView == param1)
         {
            return __leftView;
         }
         _previousClearStyle = clearStyle_leftView;
         __leftView = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __leftView;
      }
      
      public function set leftView(param1:DisplayObject) : void
      {
         set_leftView(param1);
      }
      
      public function set_errorString(param1:String) : String
      {
         if(_errorString == param1)
         {
            return _errorString;
         }
         _errorString = param1;
         refreshState();
         setInvalid(InvalidationFlag.DATA);
         return _text;
      }
      
      public function set errorString(param1:String) : void
      {
         set_errorString(param1);
      }
      
      override public function set_enabled(param1:Boolean) : Boolean
      {
         super.set_enabled(param1);
         refreshState();
         return _enabled;
      }
      
      public function set_embedFonts(param1:Boolean) : Boolean
      {
         if(!setStyle("embedFonts"))
         {
            return __embedFonts;
         }
         if(__embedFonts == param1)
         {
            return __embedFonts;
         }
         _previousClearStyle = clearStyle_embedFonts;
         __embedFonts = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __embedFonts;
      }
      
      public function set embedFonts(param1:Boolean) : void
      {
         set_embedFonts(param1);
      }
      
      public function set_editable(param1:Boolean) : Boolean
      {
         if(_editable == param1)
         {
            return _editable;
         }
         _editable = param1;
         setInvalid(InvalidationFlag.STATE);
         return _editable;
      }
      
      public function set editable(param1:Boolean) : void
      {
         set_editable(param1);
      }
      
      public function set_displayAsPassword(param1:Boolean) : Boolean
      {
         if(_displayAsPassword == param1)
         {
            return _displayAsPassword;
         }
         _displayAsPassword = param1;
         setInvalid(InvalidationFlag.DATA);
         return _displayAsPassword;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         set_displayAsPassword(param1);
      }
      
      public function set_disabledTextFormat(param1:feathers.text.TextFormat) : feathers.text.TextFormat
      {
         if(!setStyle("disabledTextFormat"))
         {
            return __disabledTextFormat;
         }
         if(__disabledTextFormat == param1)
         {
            return __disabledTextFormat;
         }
         _previousClearStyle = clearStyle_disabledTextFormat;
         __disabledTextFormat = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __disabledTextFormat;
      }
      
      public function set disabledTextFormat(param1:feathers.text.TextFormat) : void
      {
         set_disabledTextFormat(param1);
      }
      
      public function set_customErrorCalloutVariant(param1:String) : String
      {
         if(!setStyle("customErrorCalloutVariant"))
         {
            return __customErrorCalloutVariant;
         }
         if(__customErrorCalloutVariant == param1)
         {
            return __customErrorCalloutVariant;
         }
         _previousClearStyle = clearStyle_customErrorCalloutVariant;
         __customErrorCalloutVariant = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __customErrorCalloutVariant;
      }
      
      public function set customErrorCalloutVariant(param1:String) : void
      {
         set_customErrorCalloutVariant(param1);
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
      
      public function set_autoSizeWidth(param1:Boolean) : Boolean
      {
         if(!setStyle("autoSizeWidth"))
         {
            return __autoSizeWidth;
         }
         if(__autoSizeWidth == param1)
         {
            return __autoSizeWidth;
         }
         _previousClearStyle = clearStyle_autoSizeWidth;
         __autoSizeWidth = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __autoSizeWidth;
      }
      
      public function set autoSizeWidth(param1:Boolean) : void
      {
         set_autoSizeWidth(param1);
      }
      
      public function setTextFormatForState(param1:TextInputState, param2:feathers.text.TextFormat) : void
      {
         if(!setStyle("setTextFormatForState",param1))
         {
            return;
         }
         if(param2 == null)
         {
            _stateToTextFormat.remove(param1);
         }
         else
         {
            _stateToTextFormat._SafeStr_1(param1,param2);
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function setSkinForState(param1:TextInputState, param2:DisplayObject) : void
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
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function selectRange(param1:int, param2:int) : void
      {
         _pendingSelectionAnchorIndex = param1;
         _pendingSelectionActiveIndex = param2;
         setInvalid(InvalidationFlag.SELECTION);
      }
      
      public function selectAll() : void
      {
         selectRange(0,_text.length);
      }
      
      public function removeCurrentRightView(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(Event.RESIZE,textInput_rightView_resizeHandler);
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(null);
         }
         _rightViewMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
      }
      
      public function removeCurrentLeftView(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(Event.RESIZE,textInput_leftView_resizeHandler);
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(null);
         }
         _leftViewMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
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
      
      public function refreshTextStyles() : void
      {
         if(_enabled && _editable && textField.type != "input")
         {
            textField.type = "input";
         }
         else if((!_enabled || !_editable) && textField.type == "input")
         {
            textField.type = "dynamic";
         }
         if(textField.embedFonts != get_embedFonts())
         {
            textField.embedFonts = get_embedFonts();
            _updatedTextStyles = true;
         }
         if(textField.displayAsPassword != _displayAsPassword)
         {
            textField.displayAsPassword = _displayAsPassword;
            _updatedTextStyles = true;
         }
         var _loc1_:feathers.text.TextFormat = getCurrentTextFormat();
         var _loc2_:flash.text.TextFormat = _loc1_ != null ? _loc1_.toSimpleTextFormat() : null;
         if(_loc2_ == _previousSimpleTextFormat)
         {
            return;
         }
         if(_previousTextFormat != null)
         {
            _previousTextFormat.removeEventListener(Event.CHANGE,textInput_textFormat_changeHandler);
         }
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.CHANGE,textInput_textFormat_changeHandler,false,0,true);
            textField.defaultTextFormat = _loc2_;
            _updatedTextStyles = true;
         }
         _previousTextFormat = _loc1_;
         _previousSimpleTextFormat = _loc2_;
      }
      
      public function refreshText(param1:Boolean) : void
      {
         textField.restrict = __restrict;
         textField.maxChars = _maxChars;
         if(_editable)
         {
            textField.selectable = _enabled;
         }
         else
         {
            textField.selectable = _enabled && _selectable;
         }
         var _loc2_:* = _measureText != null;
         var _loc3_:String = _loc2_ ? _measureText : _text;
         if(_loc3_ == null || _loc3_.length == 0)
         {
            _loc2_ = true;
            _loc3_ = "​";
         }
         if(_text == _previousText && _loc3_ == _previousMeasureText && !_updatedTextStyles && !param1)
         {
            return;
         }
         textField.autoSize = "left";
         textField.text = _loc3_;
         _textMeasuredWidth = textField.width;
         _textMeasuredHeight = textField.height;
         textField.autoSize = "none";
         var _loc4_:String = null;
         if(_text == null || _text.length == 0)
         {
            _loc4_ = "";
         }
         else if(_loc2_)
         {
            _loc4_ = _text;
         }
         if(_loc4_ != null)
         {
            textField.text = _loc4_;
         }
         _previousText = _text;
         _previousMeasureText = _loc3_;
      }
      
      public function refreshState() : void
      {
         if(_enabled)
         {
            if(stage != null && stage.focus == textField)
            {
               changeState(TextInputState.FOCUSED);
            }
            else if(_errorString != null)
            {
               changeState(TextInputState.ERROR);
            }
            else
            {
               changeState(TextInputState.ENABLED);
            }
         }
         else
         {
            changeState(TextInputState.DISABLED);
         }
      }
      
      public function refreshSelection() : void
      {
         if(_pendingSelectionActiveIndex == -1 && _pendingSelectionAnchorIndex == -1)
         {
            return;
         }
         var _loc1_:int = _pendingSelectionAnchorIndex;
         var _loc2_:int = _pendingSelectionActiveIndex;
         _pendingSelectionAnchorIndex = -1;
         _pendingSelectionActiveIndex = -1;
         textField.setSelection(_loc1_,_loc2_);
      }
      
      public function refreshScrollPosition() : void
      {
         textField.scrollH = int(Math.round(_scrollX));
      }
      
      public function refreshRightView() : void
      {
         var _loc1_:DisplayObject = _currentRightView;
         _currentRightView = getCurrentRightView();
         if(_currentRightView == _loc1_)
         {
            return;
         }
         removeCurrentRightView(_loc1_);
         if(_currentRightView == null)
         {
            _rightViewMeasurements = null;
            return;
         }
         if(_currentRightView is IUIControl)
         {
            _currentRightView.initializeNow();
         }
         if(_rightViewMeasurements == null)
         {
            _rightViewMeasurements = new Measurements(_currentRightView);
         }
         else
         {
            _rightViewMeasurements.save(_currentRightView);
         }
         if(_currentRightView is IProgrammaticSkin)
         {
            _currentRightView.set_uiContext(this);
         }
         if(_currentRightView is IStateObserver)
         {
            _currentRightView.set_stateContext(this);
         }
         _currentRightView.addEventListener(Event.RESIZE,textInput_rightView_resizeHandler,false,0,true);
         addChild(_currentRightView);
      }
      
      public function refreshPromptText(param1:Boolean) : void
      {
         if(_prompt == null || _prompt == _previousPrompt && !_updatedPromptStyles && !param1)
         {
            return;
         }
         promptTextField.autoSize = "left";
         var _loc2_:* = _prompt.length > 0;
         if(_loc2_)
         {
            promptTextField.text = _prompt;
         }
         else
         {
            promptTextField.text = "​";
         }
         _promptTextMeasuredWidth = promptTextField.width;
         _promptTextMeasuredHeight = promptTextField.height;
         promptTextField.autoSize = "none";
         if(!_loc2_)
         {
            promptTextField.text = "";
         }
         _previousPrompt = _prompt;
      }
      
      public function refreshPromptStyles() : void
      {
         if(_prompt == null)
         {
            return;
         }
         if(promptTextField.embedFonts != get_embedFonts())
         {
            promptTextField.embedFonts = get_embedFonts();
            _updatedPromptStyles = true;
         }
         var _loc1_:feathers.text.TextFormat = getCurrentPromptTextFormat();
         var _loc2_:flash.text.TextFormat = _loc1_ != null ? _loc1_.toSimpleTextFormat() : null;
         if(_loc2_ == _previousPromptSimpleTextFormat)
         {
            return;
         }
         if(_previousPromptTextFormat != null)
         {
            _previousPromptTextFormat.removeEventListener(Event.CHANGE,textInput_promptTextFormat_changeHandler);
         }
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.CHANGE,textInput_textFormat_changeHandler,false,0,true);
            promptTextField.defaultTextFormat = _loc2_;
            _updatedPromptStyles = true;
         }
         _previousPromptTextFormat = _loc1_;
         _previousPromptSimpleTextFormat = _loc2_;
      }
      
      public function refreshPrompt() : void
      {
         if(_prompt == null)
         {
            if(promptTextField != null)
            {
               removeChild(promptTextField);
               promptTextField = null;
            }
            return;
         }
         if(promptTextField == null)
         {
            promptTextField = new TextField();
            addChildAt(promptTextField,getChildIndex(textField));
         }
         promptTextField.selectable = false;
         promptTextField.mouseWheelEnabled = false;
         promptTextField.mouseEnabled = false;
         promptTextField.visible = _text.length == 0;
      }
      
      public function refreshLeftView() : void
      {
         var _loc1_:DisplayObject = _currentLeftView;
         _currentLeftView = getCurrentLeftView();
         if(_currentLeftView == _loc1_)
         {
            return;
         }
         removeCurrentLeftView(_loc1_);
         if(_currentLeftView == null)
         {
            _leftViewMeasurements = null;
            return;
         }
         if(_currentLeftView is IUIControl)
         {
            _currentLeftView.initializeNow();
         }
         if(_leftViewMeasurements == null)
         {
            _leftViewMeasurements = new Measurements(_currentLeftView);
         }
         else
         {
            _leftViewMeasurements.save(_currentLeftView);
         }
         if(_currentLeftView is IProgrammaticSkin)
         {
            _currentLeftView.set_uiContext(this);
         }
         if(_currentLeftView is IStateObserver)
         {
            _currentLeftView.set_stateContext(this);
         }
         _currentLeftView.addEventListener(Event.RESIZE,textInput_leftView_resizeHandler,false,0,true);
         addChild(_currentLeftView);
      }
      
      public function refreshErrorString() : void
      {
         if(errorStringCallout == null)
         {
            return;
         }
         errorStringCallout.set_text(_errorString);
         if(_currentState == TextInputState.FOCUSED && errorStringCallout.parent == null)
         {
            PopUpManager.addPopUp(errorStringCallout,this,false,false);
         }
         else if(_currentState != TextInputState.FOCUSED && errorStringCallout.parent != null)
         {
            errorStringCallout.parent.removeChild(errorStringCallout);
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
         if(_backgroundSkinMeasurements != null)
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
         var _loc8_:Boolean = _ignoreLeftViewResize;
         _ignoreLeftViewResize = true;
         var _loc9_:Boolean = _ignoreRightViewResize;
         _ignoreRightViewResize = true;
         var _loc10_:IMeasureObject = null;
         if(_currentLeftView is IMeasureObject)
         {
            _loc10_ = _currentLeftView;
         }
         if(_currentLeftView is IValidating)
         {
            _currentLeftView.validateNow();
         }
         var _loc11_:IMeasureObject = null;
         if(_currentRightView is IMeasureObject)
         {
            _loc11_ = _currentRightView;
         }
         if(_currentRightView is IValidating)
         {
            _currentRightView.validateNow();
         }
         _ignoreLeftViewResize = _loc8_;
         _ignoreRightViewResize = _loc9_;
         var _loc12_:Object = get_explicitWidth();
         if(_loc1_)
         {
            if(get_autoSizeWidth() || _measureText != null)
            {
               _loc12_ = _textMeasuredWidth;
            }
            else
            {
               _loc12_ = 0;
            }
            if(_prompt != null)
            {
               _loc12_ = Math.max(_loc12_,_promptTextMeasuredWidth);
            }
            if(_loc10_ != null)
            {
               _loc12_ += Number(_loc10_.width) + get_leftViewGap();
            }
            else if(_leftViewMeasurements != null)
            {
               _loc12_ += _leftViewMeasurements.width + get_leftViewGap();
            }
            if(_loc11_ != null)
            {
               _loc12_ += Number(_loc11_.width) + get_rightViewGap();
            }
            else if(_rightViewMeasurements != null)
            {
               _loc12_ += _rightViewMeasurements.width + get_rightViewGap();
            }
            _loc12_ += get_paddingLeft() + get_paddingRight();
            if(_currentBackgroundSkin != null)
            {
               _loc12_ = Math.max(_currentBackgroundSkin.width,_loc12_);
            }
         }
         var _loc13_:Object = get_explicitHeight();
         if(_loc2_)
         {
            _loc13_ = _textMeasuredHeight;
            if(_prompt != null)
            {
               _loc13_ = Math.max(_loc13_,_promptTextMeasuredHeight);
            }
            if(_loc10_ != null && _loc13_ < Number(_loc10_.height))
            {
               _loc13_ = Number(_loc10_.height);
            }
            else if(_leftViewMeasurements != null && _loc13_ < _leftViewMeasurements.height)
            {
               _loc13_ = _leftViewMeasurements.height;
            }
            if(_loc11_ != null && _loc13_ < Number(_loc11_.height))
            {
               _loc13_ = Number(_loc11_.height);
            }
            else if(_rightViewMeasurements != null && _loc13_ < _rightViewMeasurements.height)
            {
               _loc13_ = _rightViewMeasurements.height;
            }
            _loc13_ += get_paddingTop() + get_paddingBottom();
            if(_currentBackgroundSkin != null)
            {
               _loc13_ = Math.max(_currentBackgroundSkin.height,_loc13_);
            }
         }
         var _loc14_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            if(get_autoSizeWidth() || _measureText != null)
            {
               _loc14_ = _textMeasuredWidth;
            }
            else
            {
               _loc14_ = 0;
            }
            if(_prompt != null)
            {
               _loc14_ = Math.max(_loc14_,_promptTextMeasuredWidth);
            }
            if(_loc10_ != null)
            {
               _loc14_ += _loc10_.get_minWidth() + get_leftViewGap();
            }
            else if(_leftViewMeasurements != null)
            {
               _loc14_ += _leftViewMeasurements.minWidth + get_leftViewGap();
            }
            if(_loc11_ != null)
            {
               _loc14_ += _loc11_.get_minWidth() + get_rightViewGap();
            }
            else if(_rightViewMeasurements != null)
            {
               _loc14_ += _rightViewMeasurements.minWidth + get_rightViewGap();
            }
            _loc14_ += get_paddingLeft() + get_paddingRight();
            if(_loc7_ != null)
            {
               _loc14_ = Math.max(_loc7_.get_minWidth(),_loc14_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc14_ = Math.max(_backgroundSkinMeasurements.minWidth,_loc14_);
            }
         }
         var _loc15_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            _loc15_ = _textMeasuredHeight;
            if(_prompt != null)
            {
               _loc15_ = Math.max(_loc15_,_promptTextMeasuredHeight);
            }
            if(_loc10_ != null && _loc15_ < _loc10_.get_minHeight())
            {
               _loc15_ = _loc10_.get_minHeight();
            }
            else if(_leftViewMeasurements != null && _loc15_ < _leftViewMeasurements.minHeight)
            {
               _loc15_ = _leftViewMeasurements.minHeight;
            }
            if(_loc11_ != null && _loc15_ < _loc11_.get_minHeight())
            {
               _loc15_ = _loc11_.get_minHeight();
            }
            else if(_rightViewMeasurements != null && _loc15_ < _rightViewMeasurements.minHeight)
            {
               _loc15_ = _rightViewMeasurements.minHeight;
            }
            _loc15_ += get_paddingTop() + get_paddingBottom();
            if(_loc7_ != null)
            {
               _loc15_ = Math.max(_loc7_.get_minHeight(),_loc15_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc15_ = Math.max(_backgroundSkinMeasurements.minHeight,_loc15_);
            }
         }
         var _loc16_:Object = get_explicitMaxWidth();
         if(_loc5_)
         {
            if(_loc7_ != null)
            {
               _loc16_ = _loc7_.get_maxWidth();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc16_ = _backgroundSkinMeasurements.maxWidth;
            }
            else
            {
               _loc16_ = 1 / 0;
            }
         }
         var _loc17_:Object = get_explicitMaxHeight();
         if(_loc6_)
         {
            if(_loc7_ != null)
            {
               _loc17_ = _loc7_.get_maxHeight();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc17_ = _backgroundSkinMeasurements.maxHeight;
            }
            else
            {
               _loc17_ = 1 / 0;
            }
         }
         return saveMeasurements(_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_);
      }
      
      public function layoutContent() : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as TextField;
         var _loc11_:Number = NaN;
         var _loc1_:Boolean = _ignoreLeftViewResize;
         _ignoreLeftViewResize = true;
         var _loc2_:Boolean = _ignoreRightViewResize;
         _ignoreRightViewResize = true;
         layoutBackgroundSkin();
         var _loc3_:Number = _textMeasuredHeight;
         var _loc4_:Number = actualHeight - get_paddingTop() - get_paddingBottom();
         if(_loc3_ > _loc4_ || get_verticalAlign() == VerticalAlign.JUSTIFY)
         {
            _loc3_ = _loc4_;
         }
         textField.height = _loc3_;
         var _loc5_:Number = 0;
         if(_currentLeftView != null)
         {
            if(_currentLeftView is IValidating)
            {
               _currentLeftView.validateNow();
            }
            _currentLeftView.x = get_paddingLeft();
            _loc6_ = get_paddingTop();
            _loc7_ = get_paddingTop();
            _currentLeftView.y = Math.max(_loc6_,_loc7_ + (_loc4_ - _currentLeftView.height) / 2);
            _loc5_ = _currentLeftView.width + get_leftViewGap();
         }
         _loc6_ = 0;
         if(_currentRightView != null)
         {
            if(_currentRightView is IValidating)
            {
               _currentRightView.validateNow();
            }
            _loc7_ = actualWidth - get_paddingRight();
            _currentRightView.x = _loc7_ - _currentRightView.width;
            _loc8_ = get_paddingTop();
            _loc9_ = get_paddingTop();
            _currentRightView.y = Math.max(_loc8_,_loc9_ + (_loc4_ - _currentRightView.height) / 2);
            _loc6_ = _currentRightView.width + get_rightViewGap();
         }
         _loc7_ = actualWidth - get_paddingLeft() - get_paddingRight() - _loc5_ - _loc6_;
         textField.width = _loc7_;
         _loc8_ = get_paddingLeft();
         textField.x = _loc8_ + _loc5_;
         _loc10_ = textField;
         switch(get_verticalAlign().index)
         {
            case 0:
               _loc10_.y = get_paddingTop();
               break;
            case 2:
               _loc10_.y = actualHeight - get_paddingBottom() - _loc3_;
               break;
            case 3:
               _loc10_.y = get_paddingTop();
               break;
            default:
               _loc10_.y = get_paddingTop() + (_loc4_ - _loc3_) / 2;
         }
         if(promptTextField != null)
         {
            promptTextField.width = _loc7_;
            _loc9_ = _promptTextMeasuredHeight;
            if(_loc9_ > _loc4_ || get_verticalAlign() == VerticalAlign.JUSTIFY)
            {
               _loc9_ = _loc4_;
            }
            promptTextField.height = _loc9_;
            _loc11_ = get_paddingLeft();
            promptTextField.x = _loc11_ + _loc5_;
            _loc10_ = promptTextField;
            switch(get_verticalAlign().index)
            {
               case 0:
                  _loc10_.y = get_paddingTop();
                  break;
               case 2:
                  _loc10_.y = actualHeight - get_paddingBottom() - _loc9_;
                  break;
               case 3:
                  _loc10_.y = get_paddingTop();
                  break;
               default:
                  _loc10_.y = get_paddingTop() + (_loc4_ - _loc9_) / 2;
            }
         }
         _ignoreLeftViewResize = _loc1_;
         _ignoreRightViewResize = _loc2_;
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
      
      public function initializeTextInputTheme() : void
      {
         SteelTextInputStyles.initialize();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(textField == null)
         {
            textField = new TextField();
            textField.tabEnabled = false;
            textField.addEventListener(Event.CHANGE,textField_changeHandler);
            textField.addEventListener(Event.SCROLL,textField_scrollHandler);
            addChild(textField);
         }
      }
      
      public function get_verticalAlign() : VerticalAlign
      {
         return __verticalAlign;
      }
      
      public function get verticalAlign() : VerticalAlign
      {
         return get_verticalAlign();
      }
      
      public function get_textFormat() : feathers.text.TextFormat
      {
         return __textFormat;
      }
      
      public function get textFormat() : feathers.text.TextFormat
      {
         return get_textFormat();
      }
      
      public function get_text() : String
      {
         return _text;
      }
      
      public function get text() : String
      {
         return get_text();
      }
      
      override public function get_styleContext() : Class
      {
         return TextInput;
      }
      
      public function get_stageFocusTarget() : InteractiveObject
      {
         return textField;
      }
      
      public function get stageFocusTarget() : InteractiveObject
      {
         return get_stageFocusTarget();
      }
      
      public function get_selectionAnchorIndex() : int
      {
         if(textField != null && _pendingSelectionAnchorIndex == -1)
         {
            if(textField.caretIndex == textField.selectionBeginIndex)
            {
               return textField.selectionEndIndex;
            }
            return textField.selectionBeginIndex;
         }
         return _pendingSelectionAnchorIndex;
      }
      
      public function get selectionAnchorIndex() : int
      {
         return get_selectionAnchorIndex();
      }
      
      public function get_selectionActiveIndex() : int
      {
         if(textField != null && _pendingSelectionActiveIndex == -1)
         {
            return textField.caretIndex;
         }
         return _pendingSelectionActiveIndex;
      }
      
      public function get selectionActiveIndex() : int
      {
         return get_selectionActiveIndex();
      }
      
      public function get_selectable() : Boolean
      {
         return _selectable;
      }
      
      public function get selectable() : Boolean
      {
         return get_selectable();
      }
      
      public function get_scrollX() : Number
      {
         return _scrollX;
      }
      
      public function get scrollX() : Number
      {
         return get_scrollX();
      }
      
      public function get_rightViewGap() : Number
      {
         return __rightViewGap;
      }
      
      public function get rightViewGap() : Number
      {
         return get_rightViewGap();
      }
      
      public function get_rightView() : DisplayObject
      {
         return __rightView;
      }
      
      public function get rightView() : DisplayObject
      {
         return get_rightView();
      }
      
      public function get_restrict() : String
      {
         return __restrict;
      }
      
      public function get restrict() : String
      {
         return get_restrict();
      }
      
      public function get_promptTextFormat() : feathers.text.TextFormat
      {
         return __promptTextFormat;
      }
      
      public function get promptTextFormat() : feathers.text.TextFormat
      {
         return get_promptTextFormat();
      }
      
      public function get_prompt() : String
      {
         return _prompt;
      }
      
      public function get prompt() : String
      {
         return get_prompt();
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
      
      public function get_measureText() : String
      {
         return _measureText;
      }
      
      public function get measureText() : String
      {
         return get_measureText();
      }
      
      public function get_maxChars() : int
      {
         return _maxChars;
      }
      
      public function get maxChars() : int
      {
         return get_maxChars();
      }
      
      public function get_leftViewGap() : Number
      {
         return __leftViewGap;
      }
      
      public function get leftViewGap() : Number
      {
         return get_leftViewGap();
      }
      
      public function get_leftView() : DisplayObject
      {
         return __leftView;
      }
      
      public function get leftView() : DisplayObject
      {
         return get_leftView();
      }
      
      public function get_errorStringCalloutOpen() : Boolean
      {
         if(errorStringCallout != null)
         {
            return errorStringCallout.parent != null;
         }
         return false;
      }
      
      public function get errorStringCalloutOpen() : Boolean
      {
         return get_errorStringCalloutOpen();
      }
      
      public function get_errorString() : String
      {
         return _errorString;
      }
      
      public function get errorString() : String
      {
         return get_errorString();
      }
      
      public function get_embedFonts() : Boolean
      {
         return __embedFonts;
      }
      
      public function get embedFonts() : Boolean
      {
         return get_embedFonts();
      }
      
      public function get_editable() : Boolean
      {
         return _editable;
      }
      
      public function get editable() : Boolean
      {
         return get_editable();
      }
      
      public function get_displayAsPassword() : Boolean
      {
         return _displayAsPassword;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return get_displayAsPassword();
      }
      
      public function get_disabledTextFormat() : feathers.text.TextFormat
      {
         return __disabledTextFormat;
      }
      
      public function get disabledTextFormat() : feathers.text.TextFormat
      {
         return get_disabledTextFormat();
      }
      
      public function get_customErrorCalloutVariant() : String
      {
         return __customErrorCalloutVariant;
      }
      
      public function get customErrorCalloutVariant() : String
      {
         return get_customErrorCalloutVariant();
      }
      
      public function get_currentState() : *
      {
         return _currentState;
      }
      
      public function get currentState() : *
      {
         return get_currentState();
      }
      
      public function get_baseline() : Number
      {
         var _loc2_:Number = NaN;
         if(textField == null)
         {
            return 0;
         }
         var _loc1_:Boolean = _text != null && _text.length > 0;
         if(!_loc1_)
         {
            textField.text = "​";
            _loc2_ = textField.y + textField.getLineMetrics(0).ascent;
            textField.text = "";
            return _loc2_;
         }
         return textField.y + textField.getLineMetrics(0).ascent;
      }
      
      public function get baseline() : Number
      {
         return get_baseline();
      }
      
      public function get_backgroundSkin() : DisplayObject
      {
         return __backgroundSkin;
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function get_autoSizeWidth() : Boolean
      {
         return __autoSizeWidth;
      }
      
      public function get autoSizeWidth() : Boolean
      {
         return get_autoSizeWidth();
      }
      
      public function getTextFormatForState(param1:TextInputState) : feathers.text.TextFormat
      {
         return _stateToTextFormat._SafeStr_2(param1);
      }
      
      public function getSkinForState(param1:TextInputState) : DisplayObject
      {
         return _stateToSkin._SafeStr_2(param1);
      }
      
      public function getCurrentTextFormat() : feathers.text.TextFormat
      {
         var _loc1_:feathers.text.TextFormat = _stateToTextFormat._SafeStr_2(_currentState);
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         if(!_enabled && get_disabledTextFormat() != null)
         {
            return get_disabledTextFormat();
         }
         return get_textFormat();
      }
      
      public function getCurrentRightView() : DisplayObject
      {
         return get_rightView();
      }
      
      public function getCurrentPromptTextFormat() : feathers.text.TextFormat
      {
         var _loc1_:feathers.text.TextFormat = get_promptTextFormat();
         if(_loc1_ == null)
         {
            _loc1_ = get_textFormat();
         }
         return _loc1_;
      }
      
      public function getCurrentLeftView() : DisplayObject
      {
         return get_leftView();
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
      
      public function createErrorCallout() : void
      {
         if(errorStringCallout != null)
         {
            if(errorStringCallout.parent != null)
            {
               errorStringCallout.parent.removeChild(errorStringCallout);
            }
            errorStringCallout = null;
         }
         if(_errorString == null || _errorString.length == 0)
         {
            return;
         }
         errorStringCallout = new TextCallout();
         if(errorStringCallout.get_variant() == null)
         {
            errorStringCallout.set_variant(get_customErrorCalloutVariant() != null ? get_customErrorCalloutVariant() : TextInput.CHILD_VARIANT_ERROR_CALLOUT);
         }
         errorStringCallout.set_origin(this);
         errorStringCallout.closeOnPointerOutside = false;
      }
      
      public function clearStyle_verticalAlign() : VerticalAlign
      {
         set_verticalAlign(VerticalAlign.MIDDLE);
         return get_verticalAlign();
      }
      
      public function clearStyle_textFormat() : feathers.text.TextFormat
      {
         set_textFormat(null);
         return get_textFormat();
      }
      
      public function clearStyle_rightViewGap() : Number
      {
         set_rightViewGap(0);
         return get_rightViewGap();
      }
      
      public function clearStyle_rightView() : DisplayObject
      {
         set_rightView(null);
         return get_rightView();
      }
      
      public function clearStyle_promptTextFormat() : feathers.text.TextFormat
      {
         set_promptTextFormat(null);
         return get_promptTextFormat();
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
      
      public function clearStyle_leftViewGap() : Number
      {
         set_leftViewGap(0);
         return get_leftViewGap();
      }
      
      public function clearStyle_leftView() : DisplayObject
      {
         set_leftView(null);
         return get_leftView();
      }
      
      public function clearStyle_embedFonts() : Boolean
      {
         set_embedFonts(false);
         return get_embedFonts();
      }
      
      public function clearStyle_disabledTextFormat() : feathers.text.TextFormat
      {
         set_disabledTextFormat(null);
         return get_disabledTextFormat();
      }
      
      public function clearStyle_customErrorCalloutVariant() : String
      {
         set_customErrorCalloutVariant(null);
         return get_customErrorCalloutVariant();
      }
      
      public function clearStyle_backgroundSkin() : DisplayObject
      {
         set_backgroundSkin(null);
         return get_backgroundSkin();
      }
      
      public function clearStyle_autoSizeWidth() : Boolean
      {
         set_autoSizeWidth(false);
         return get_autoSizeWidth();
      }
      
      public function changeState(param1:TextInputState) : void
      {
         if(!_enabled)
         {
            param1 = TextInputState.DISABLED;
         }
         if(_currentState == param1)
         {
            return;
         }
         _currentState = param1;
         setInvalid(InvalidationFlag.STATE);
         FeathersEvent.dispatch(this,"stateChange");
      }
      
      public function alignTextField(param1:TextField, param2:Number, param3:Number) : void
      {
         switch(get_verticalAlign().index)
         {
            case 0:
               param1.y = get_paddingTop();
               break;
            case 2:
               param1.y = actualHeight - get_paddingBottom() - param2;
               break;
            case 3:
               param1.y = get_paddingTop();
               break;
            default:
               param1.y = get_paddingTop() + (param3 - param2) / 2;
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

import feathers.core.InvalidationFlag;


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
