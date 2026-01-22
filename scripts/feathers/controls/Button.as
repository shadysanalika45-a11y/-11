package feathers.controls
{
   import feathers.core.IFocusManager;
   import feathers.core.IFocusObject;
   import feathers.core.IHTMLTextControl;
   import feathers.core.IMeasureObject;
   import feathers.core.IStateContext;
   import feathers.core.IStateObserver;
   import feathers.core.ITextControl;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.layout.HorizontalAlign;
   import feathers.layout.Measurements;
   import feathers.layout.RelativePosition;
   import feathers.layout.VerticalAlign;
   import feathers.skins.IProgrammaticSkin;
   import feathers.text.TextFormat;
   import feathers.themes.steel.components.SteelButtonStyles;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   
   public class Button extends BasicButton implements IFocusObject, IHTMLTextControl, ITextControl
   {
      
      public static var __meta__:* = {
         "obj":{"defaultXmlProperty":["text"]},
         "fields":{
            "setTextFormatForState":{"style":null},
            "setIconForState":{"style":null}
         }
      };
      
      public static var VARIANT_PRIMARY:String = "primary";
      
      public static var VARIANT_DANGER:String = "danger";
      
      public var textField:TextField;
      
      public var _wrappedOnMeasure:Boolean;
      
      public var _updatedTextStyles:Boolean;
      
      public var _textMeasuredWidth:Number;
      
      public var _textMeasuredHeight:Number;
      
      public var _text:String;
      
      public var _stateToTextFormat:IMap;
      
      public var _stateToIcon:IMap;
      
      public var _previousTextFormat:feathers.text.TextFormat;
      
      public var _previousText:String;
      
      public var _previousSimpleTextFormat:flash.text.TextFormat;
      
      public var _previousHTMLText:String;
      
      public var _ignoreIconResizes:Boolean;
      
      public var _iconMeasurements:Measurements;
      
      public var _htmlText:String;
      
      public var _currentIcon:DisplayObject;
      
      public var __wordWrap:Boolean;
      
      public var __verticalAlign:VerticalAlign;
      
      public var __textOffsetY:Number;
      
      public var __textOffsetX:Number;
      
      public var __textFormat:feathers.text.TextFormat;
      
      public var __styleSheet:StyleSheet;
      
      public var __showText:Boolean;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __minGap:Number;
      
      public var __iconPosition:RelativePosition;
      
      public var __iconOffsetY:Number;
      
      public var __iconOffsetX:Number;
      
      public var __icon:DisplayObject;
      
      public var __horizontalAlign:HorizontalAlign;
      
      public var __gap:Number;
      
      public var __embedFonts:Boolean;
      
      public var __disabledTextFormat:feathers.text.TextFormat;
      
      public function Button(param1:String = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __showText = true;
         __textOffsetY = 0;
         __textOffsetX = 0;
         __iconOffsetY = 0;
         __iconOffsetX = 0;
         __minGap = 0;
         __gap = 0;
         __iconPosition = RelativePosition.LEFT;
         __verticalAlign = VerticalAlign.MIDDLE;
         __horizontalAlign = HorizontalAlign.CENTER;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         __icon = null;
         __wordWrap = false;
         __embedFonts = false;
         __disabledTextFormat = null;
         __styleSheet = null;
         __textFormat = null;
         _stateToTextFormat = new EnumValueMap();
         _wrappedOnMeasure = false;
         _ignoreIconResizes = false;
         _currentIcon = null;
         _iconMeasurements = null;
         _stateToIcon = new EnumValueMap();
         _htmlText = null;
         _updatedTextStyles = false;
         _previousSimpleTextFormat = null;
         _previousTextFormat = null;
         _previousHTMLText = null;
         _previousText = null;
         initializeButtonTheme();
         super(param2);
         set_text(param1);
         tabEnabled = true;
         tabChildren = false;
         focusRect = false;
         addEventListener(KeyboardEvent.KEY_DOWN,button_keyDownHandler);
         addEventListener(FocusEvent.FOCUS_IN,button_focusInHandler);
         addEventListener(FocusEvent.FOCUS_OUT,button_focusOutHandler);
      }
      
      public function set_wordWrap(param1:Boolean) : Boolean
      {
         if(!setStyle("wordWrap"))
         {
            return __wordWrap;
         }
         if(__wordWrap == param1)
         {
            return __wordWrap;
         }
         _previousClearStyle = clearStyle_wordWrap;
         __wordWrap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         set_wordWrap(param1);
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
      
      public function set_textOffsetY(param1:Number) : Number
      {
         if(!setStyle("textOffsetY"))
         {
            return __textOffsetY;
         }
         if(__textOffsetY == param1)
         {
            return __textOffsetY;
         }
         _previousClearStyle = clearStyle_textOffsetY;
         __textOffsetY = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __textOffsetY;
      }
      
      public function set textOffsetY(param1:Number) : void
      {
         set_textOffsetY(param1);
      }
      
      public function set_textOffsetX(param1:Number) : Number
      {
         if(!setStyle("textOffsetX"))
         {
            return __textOffsetX;
         }
         if(__textOffsetX == param1)
         {
            return __textOffsetX;
         }
         _previousClearStyle = clearStyle_textOffsetX;
         __textOffsetX = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __textOffsetX;
      }
      
      public function set textOffsetX(param1:Number) : void
      {
         set_textOffsetX(param1);
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
         if(_text == param1)
         {
            return _text;
         }
         _text = param1;
         setInvalid(InvalidationFlag.DATA);
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         set_text(param1);
      }
      
      public function set_styleSheet(param1:StyleSheet) : StyleSheet
      {
         if(!setStyle("styleSheet"))
         {
            return __styleSheet;
         }
         if(__styleSheet == param1)
         {
            return __styleSheet;
         }
         _previousClearStyle = clearStyle_styleSheet;
         __styleSheet = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __styleSheet;
      }
      
      public function set styleSheet(param1:StyleSheet) : void
      {
         set_styleSheet(param1);
      }
      
      public function set_showText(param1:Boolean) : Boolean
      {
         if(!setStyle("showText"))
         {
            return __showText;
         }
         if(__showText == param1)
         {
            return __showText;
         }
         _previousClearStyle = clearStyle_showText;
         __showText = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __showText;
      }
      
      public function set showText(param1:Boolean) : void
      {
         set_showText(param1);
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
      
      public function set_minGap(param1:Number) : Number
      {
         if(!setStyle("minGap"))
         {
            return __minGap;
         }
         if(__minGap == param1)
         {
            return __minGap;
         }
         _previousClearStyle = clearStyle_minGap;
         __minGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __minGap;
      }
      
      public function set minGap(param1:Number) : void
      {
         set_minGap(param1);
      }
      
      public function set_iconPosition(param1:RelativePosition) : RelativePosition
      {
         if(!setStyle("iconPosition"))
         {
            return __iconPosition;
         }
         if(__iconPosition == param1)
         {
            return __iconPosition;
         }
         _previousClearStyle = clearStyle_iconPosition;
         __iconPosition = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __iconPosition;
      }
      
      public function set iconPosition(param1:RelativePosition) : void
      {
         set_iconPosition(param1);
      }
      
      public function set_iconOffsetY(param1:Number) : Number
      {
         if(!setStyle("iconOffsetY"))
         {
            return __iconOffsetY;
         }
         if(__iconOffsetY == param1)
         {
            return __iconOffsetY;
         }
         _previousClearStyle = clearStyle_iconOffsetY;
         __iconOffsetY = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __iconOffsetY;
      }
      
      public function set iconOffsetY(param1:Number) : void
      {
         set_iconOffsetY(param1);
      }
      
      public function set_iconOffsetX(param1:Number) : Number
      {
         if(!setStyle("iconOffsetX"))
         {
            return __iconOffsetX;
         }
         if(__iconOffsetX == param1)
         {
            return __iconOffsetX;
         }
         _previousClearStyle = clearStyle_iconOffsetX;
         __iconOffsetX = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __iconOffsetX;
      }
      
      public function set iconOffsetX(param1:Number) : void
      {
         set_iconOffsetX(param1);
      }
      
      public function set_icon(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("icon"))
         {
            return __icon;
         }
         if(__icon == param1)
         {
            return __icon;
         }
         _previousClearStyle = clearStyle_icon;
         __icon = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __icon;
      }
      
      public function set icon(param1:DisplayObject) : void
      {
         set_icon(param1);
      }
      
      public function set_htmlText(param1:String) : String
      {
         if(_htmlText == param1)
         {
            return _htmlText;
         }
         _htmlText = param1;
         setInvalid(InvalidationFlag.DATA);
         return _htmlText;
      }
      
      public function set htmlText(param1:String) : void
      {
         set_htmlText(param1);
      }
      
      public function set_horizontalAlign(param1:HorizontalAlign) : HorizontalAlign
      {
         if(!setStyle("horizontalAlign"))
         {
            return __horizontalAlign;
         }
         if(__horizontalAlign == param1)
         {
            return __horizontalAlign;
         }
         _previousClearStyle = clearStyle_horizontalAlign;
         __horizontalAlign = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __horizontalAlign;
      }
      
      public function set horizontalAlign(param1:HorizontalAlign) : void
      {
         set_horizontalAlign(param1);
      }
      
      public function set_gap(param1:Number) : Number
      {
         if(!setStyle("gap"))
         {
            return __gap;
         }
         if(__gap == param1)
         {
            return __gap;
         }
         _previousClearStyle = clearStyle_gap;
         __gap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __gap;
      }
      
      public function set gap(param1:Number) : void
      {
         set_gap(param1);
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
      
      public function setTextFormatForState(param1:ButtonState, param2:feathers.text.TextFormat) : void
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
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function setIconForState(param1:ButtonState, param2:DisplayObject) : void
      {
         if(!setStyle("setIconForState",param1))
         {
            return;
         }
         var _loc3_:DisplayObject = _stateToIcon._SafeStr_2(param1);
         if(_loc3_ != null && _loc3_ == _currentIcon)
         {
            removeCurrentIcon(_loc3_);
            _currentIcon = null;
         }
         if(param2 == null)
         {
            _stateToIcon.remove(param1);
         }
         else
         {
            _stateToIcon._SafeStr_1(param1,param2);
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function removeCurrentIcon(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(Event.RESIZE,button_icon_resizeHandler);
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(null);
         }
         _iconMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
      }
      
      public function refreshTextStyles() : void
      {
         if(textField.wordWrap != get_wordWrap())
         {
            textField.wordWrap = get_wordWrap();
            _updatedTextStyles = true;
         }
         if(textField.embedFonts != get_embedFonts())
         {
            textField.embedFonts = get_embedFonts();
            _updatedTextStyles = true;
         }
         if(textField.styleSheet != get_styleSheet())
         {
            textField.styleSheet = get_styleSheet();
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
            _previousTextFormat.removeEventListener(Event.CHANGE,button_textFormat_changeHandler);
         }
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.CHANGE,button_textFormat_changeHandler,false,0,true);
            textField.defaultTextFormat = _loc2_;
            _updatedTextStyles = true;
         }
         _previousTextFormat = _loc1_;
         _previousSimpleTextFormat = _loc2_;
      }
      
      public function refreshTextFieldDimensions(param1:Boolean) : void
      {
         var _loc7_:* = null as Object;
         var _loc8_:* = null as Object;
         var _loc9_:Number = NaN;
         var _loc2_:Boolean = _ignoreIconResizes;
         _ignoreIconResizes = true;
         if(_currentIcon is IValidating)
         {
            _currentIcon.validateNow();
         }
         _ignoreIconResizes = _loc2_;
         var _loc3_:Boolean = get_showText() && _text != null;
         var _loc4_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         if(!_loc3_ && !_loc4_)
         {
            return;
         }
         var _loc5_:Number = actualWidth;
         var _loc6_:Number = actualHeight;
         if(param1)
         {
            _loc5_ = 0;
            _loc7_ = get_explicitWidth();
            if(_loc7_ == null)
            {
               _loc7_ = get_explicitMaxWidth();
            }
            if(_loc7_ != null)
            {
               _loc5_ = Number(_loc7_);
            }
            _loc6_ = 0;
            _loc8_ = get_explicitHeight();
            if(_loc8_ == null)
            {
               _loc8_ = get_explicitMaxHeight();
            }
            if(_loc8_ != null)
            {
               _loc6_ = Number(_loc8_);
            }
         }
         _loc5_ -= get_paddingLeft() + get_paddingRight();
         _loc6_ -= get_paddingTop() + get_paddingBottom();
         if(_currentIcon != null)
         {
            _loc9_ = get_gap();
            if(_loc9_ == 1 / 0)
            {
               _loc9_ = get_minGap();
            }
            if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               _loc5_ -= _currentIcon.width + _loc9_;
            }
            if(get_iconPosition() == RelativePosition.TOP || get_iconPosition() == RelativePosition.BOTTOM)
            {
               _loc6_ -= _currentIcon.height + _loc9_;
            }
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         if(_loc5_ > _textMeasuredWidth)
         {
            _loc5_ = _textMeasuredWidth;
         }
         if(_loc6_ > _textMeasuredHeight)
         {
            _loc6_ = _textMeasuredHeight;
         }
         textField.width = _loc5_;
         var _loc10_:Boolean = get_wordWrap();
         if(_loc10_ && !_wrappedOnMeasure && _loc5_ >= _textMeasuredWidth)
         {
            _loc10_ = false;
         }
         if(textField.wordWrap != _loc10_)
         {
            textField.wordWrap = _loc10_;
         }
         textField.height = _loc6_;
      }
      
      public function refreshText(param1:Boolean) : void
      {
         var _loc4_:* = null as Object;
         var _loc2_:Boolean = get_showText() && _text != null && _text.length > 0;
         var _loc3_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         textField.visible = _loc2_ || _loc3_;
         if(_text == _previousText && _htmlText == _previousHTMLText && !_updatedTextStyles && !param1)
         {
            return;
         }
         textField.autoSize = "left";
         if(_loc3_)
         {
            textField.htmlText = _htmlText;
         }
         else if(_loc2_)
         {
            textField.text = _text;
         }
         else
         {
            textField.text = "​";
         }
         if(get_wordWrap())
         {
            textField.wordWrap = false;
         }
         _textMeasuredWidth = textField.textWidth + 4;
         _wrappedOnMeasure = false;
         if(get_wordWrap())
         {
            _loc4_ = calculateExplicitWidthForTextMeasurement();
            if(_loc4_ != null && _textMeasuredWidth > _loc4_)
            {
               textField.wordWrap = true;
               textField.width = _loc4_;
               _textMeasuredWidth = textField.width;
               _wrappedOnMeasure = true;
            }
         }
         _textMeasuredHeight = textField.height;
         textField.autoSize = "none";
         if(textField.wordWrap != get_wordWrap())
         {
            textField.wordWrap = get_wordWrap();
         }
         if(!_loc2_ && !_loc3_)
         {
            textField.text = "";
         }
         _previousText = _text;
         _previousHTMLText = _htmlText;
      }
      
      public function refreshIcon() : void
      {
         var _loc1_:DisplayObject = _currentIcon;
         _currentIcon = getCurrentIcon();
         if(_currentIcon == _loc1_)
         {
            return;
         }
         removeCurrentIcon(_loc1_);
         addCurrentIcon(_currentIcon);
      }
      
      public function positionTextAndIcon() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(get_iconPosition() == RelativePosition.TOP)
         {
            if(get_gap() == 1 / 0)
            {
               _currentIcon.y = get_paddingTop();
               _loc1_ = actualHeight - get_paddingBottom();
               textField.y = _loc1_ - textField.height;
            }
            else
            {
               if(get_verticalAlign() == VerticalAlign.TOP)
               {
                  _temp_1.y += _currentIcon.height + get_gap();
               }
               else if(get_verticalAlign() == VerticalAlign.MIDDLE)
               {
                  _temp_2.y += (_currentIcon.height + get_gap()) / 2;
               }
               _loc1_ = textField.y - _currentIcon.height;
               _loc2_ = get_gap();
               _currentIcon.y = _loc1_ - _loc2_;
            }
         }
         else if(get_iconPosition() == RelativePosition.RIGHT)
         {
            if(get_gap() == 1 / 0)
            {
               textField.x = get_paddingLeft();
               _loc1_ = actualWidth - get_paddingRight();
               _currentIcon.x = _loc1_ - _currentIcon.width;
            }
            else
            {
               if(get_horizontalAlign() == HorizontalAlign.RIGHT)
               {
                  _temp_3.x -= _currentIcon.width + get_gap();
               }
               else if(get_horizontalAlign() == HorizontalAlign.CENTER)
               {
                  _temp_4.x -= (_currentIcon.width + get_gap()) / 2;
               }
               _loc1_ = textField.x + textField.width;
               _loc2_ = get_gap();
               _currentIcon.x = _loc1_ + _loc2_;
            }
         }
         else if(get_iconPosition() == RelativePosition.BOTTOM)
         {
            if(get_gap() == 1 / 0)
            {
               textField.y = get_paddingTop();
               _loc1_ = actualHeight - get_paddingBottom();
               _currentIcon.y = _loc1_ - _currentIcon.height;
            }
            else
            {
               if(get_verticalAlign() == VerticalAlign.BOTTOM)
               {
                  _temp_5.y -= _currentIcon.height + get_gap();
               }
               else if(get_verticalAlign() == VerticalAlign.MIDDLE)
               {
                  _temp_6.y -= (_currentIcon.height + get_gap()) / 2;
               }
               _loc1_ = textField.y + textField.height;
               _loc2_ = get_gap();
               _currentIcon.y = _loc1_ + _loc2_;
            }
         }
         else if(get_iconPosition() == RelativePosition.LEFT)
         {
            if(get_gap() == 1 / 0)
            {
               _currentIcon.x = get_paddingLeft();
               _loc1_ = actualWidth - get_paddingRight();
               textField.x = _loc1_ - textField.width;
            }
            else
            {
               if(get_horizontalAlign() == HorizontalAlign.LEFT)
               {
                  _temp_7.x += get_gap() + _currentIcon.width;
               }
               else if(get_horizontalAlign() == HorizontalAlign.CENTER)
               {
                  _temp_8.x += (get_gap() + _currentIcon.width) / 2;
               }
               _loc1_ = textField.x - get_gap();
               _currentIcon.x = _loc1_ - _currentIcon.width;
            }
         }
         if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
         {
            if(get_verticalAlign() == VerticalAlign.TOP)
            {
               _currentIcon.y = get_paddingTop();
            }
            else if(get_verticalAlign() == VerticalAlign.BOTTOM)
            {
               _loc1_ = actualHeight - get_paddingBottom();
               _currentIcon.y = _loc1_ - _currentIcon.height;
            }
            else
            {
               _loc1_ = get_paddingTop();
               _loc2_ = (actualHeight - get_paddingTop() - get_paddingBottom() - _currentIcon.height) / 2;
               _currentIcon.y = _loc1_ + _loc2_;
            }
         }
         else if(get_horizontalAlign() == HorizontalAlign.LEFT)
         {
            _currentIcon.x = get_paddingLeft();
         }
         else if(get_horizontalAlign() == HorizontalAlign.RIGHT)
         {
            _loc1_ = actualWidth - get_paddingRight();
            _currentIcon.x = _loc1_ - _currentIcon.width;
         }
         else
         {
            _loc1_ = get_paddingLeft();
            _loc2_ = (actualWidth - get_paddingLeft() - get_paddingRight() - _currentIcon.width) / 2;
            _currentIcon.x = _loc1_ + _loc2_;
         }
      }
      
      public function positionSingleChild(param1:DisplayObject) : void
      {
         if(get_horizontalAlign() == HorizontalAlign.LEFT)
         {
            param1.x = get_paddingLeft();
         }
         else if(get_horizontalAlign() == HorizontalAlign.RIGHT)
         {
            param1.x = actualWidth - get_paddingRight() - param1.width;
         }
         else
         {
            param1.x = get_paddingLeft() + (actualWidth - get_paddingLeft() - get_paddingRight() - param1.width) / 2;
         }
         if(get_verticalAlign() == VerticalAlign.TOP)
         {
            param1.y = get_paddingTop();
         }
         else if(get_verticalAlign() == VerticalAlign.BOTTOM)
         {
            param1.y = actualHeight - get_paddingBottom() - param1.height;
         }
         else
         {
            param1.y = get_paddingTop() + (actualHeight - get_paddingTop() - get_paddingBottom() - param1.height) / 2;
         }
      }
      
      public function measureContentWidth() : Number
      {
         var _loc1_:Number = get_gap();
         if(_loc1_ == 1 / 0)
         {
            _loc1_ = get_minGap();
         }
         var _loc2_:Boolean = get_showText() && _text != null;
         var _loc3_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         var _loc4_:Number = _loc2_ || _loc3_ ? _textMeasuredWidth : 0;
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               if(_loc2_ || _loc3_)
               {
                  _loc4_ += _loc1_;
               }
               _loc4_ += _currentIcon.width;
            }
            else if(get_iconPosition() == RelativePosition.TOP || get_iconPosition() == RelativePosition.BOTTOM)
            {
               _loc4_ = Math.max(_loc4_,_currentIcon.width);
            }
         }
         return _loc4_;
      }
      
      public function measureContentMinWidth() : Number
      {
         var _loc1_:Number = get_gap();
         if(_loc1_ == 1 / 0)
         {
            _loc1_ = get_minGap();
         }
         var _loc2_:Boolean = get_showText() && _text != null;
         var _loc3_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         var _loc4_:Number = _loc2_ || _loc3_ ? _textMeasuredWidth : 0;
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               if(_loc2_ || _loc3_)
               {
                  _loc4_ += _loc1_;
               }
               _loc4_ += _currentIcon.width;
            }
            else if(get_iconPosition() == RelativePosition.TOP || get_iconPosition() == RelativePosition.BOTTOM)
            {
               _loc4_ = Math.max(_loc4_,_currentIcon.width);
            }
         }
         return _loc4_;
      }
      
      public function measureContentMinHeight() : Number
      {
         var _loc1_:Number = get_gap();
         if(_loc1_ == 1 / 0)
         {
            _loc1_ = get_minGap();
         }
         var _loc2_:Boolean = get_showText() && _text != null;
         var _loc3_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         var _loc4_:Number = _loc2_ || _loc3_ ? _textMeasuredHeight : 0;
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.TOP || get_iconPosition() == RelativePosition.BOTTOM)
            {
               if(_loc2_ || _loc3_)
               {
                  _loc4_ += _loc1_;
               }
               _loc4_ += _currentIcon.height;
            }
            else if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               _loc4_ = Math.max(_loc4_,_currentIcon.height);
            }
         }
         return _loc4_;
      }
      
      public function measureContentHeight() : Number
      {
         var _loc1_:Number = get_gap();
         if(_loc1_ == 1 / 0)
         {
            _loc1_ = get_minGap();
         }
         var _loc2_:Boolean = get_showText() && _text != null;
         var _loc3_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         var _loc4_:Number = _loc2_ || _loc3_ ? _textMeasuredHeight : 0;
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.TOP || get_iconPosition() == RelativePosition.BOTTOM)
            {
               if(_loc2_ || _loc3_)
               {
                  _loc4_ += _loc1_;
               }
               _loc4_ += _currentIcon.height;
            }
            else if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               _loc4_ = Math.max(_loc4_,_currentIcon.height);
            }
         }
         return _loc4_;
      }
      
      override public function measure() : Boolean
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
         var _loc7_:Boolean = get_showText() && _text != null;
         var _loc8_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         if(_loc7_ || _loc8_)
         {
            refreshTextFieldDimensions(true);
         }
         if(_currentBackgroundSkin != null)
         {
            MeasurementsUtil.resetFluidlyWithParent(_backgroundSkinMeasurements,_currentBackgroundSkin,this);
         }
         var _loc9_:IMeasureObject = null;
         if(_currentBackgroundSkin is IMeasureObject)
         {
            _loc9_ = _currentBackgroundSkin;
         }
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
         if(_currentIcon is IValidating)
         {
            _currentIcon.validateNow();
         }
         var _loc10_:Object = get_explicitWidth();
         if(_loc1_)
         {
            _loc10_ = measureContentWidth();
            _loc10_ = _loc10_ + (get_paddingLeft() + get_paddingRight());
            if(_currentBackgroundSkin != null)
            {
               _loc10_ = Math.max(_currentBackgroundSkin.width,_loc10_);
            }
         }
         var _loc11_:Object = get_explicitHeight();
         if(_loc2_)
         {
            _loc11_ = measureContentHeight();
            _loc11_ = _loc11_ + (get_paddingTop() + get_paddingBottom());
            if(_currentBackgroundSkin != null)
            {
               _loc11_ = Math.max(_currentBackgroundSkin.height,_loc11_);
            }
         }
         var _loc12_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            _loc12_ = measureContentMinWidth();
            _loc12_ = _loc12_ + (get_paddingLeft() + get_paddingRight());
            if(_loc9_ != null)
            {
               _loc12_ = Math.max(_loc9_.get_minWidth(),_loc12_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc12_ = Math.max(_backgroundSkinMeasurements.minWidth,_loc12_);
            }
         }
         var _loc13_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            _loc13_ = measureContentMinHeight();
            _loc13_ = _loc13_ + (get_paddingTop() + get_paddingBottom());
            if(_loc9_ != null)
            {
               _loc13_ = Math.max(_loc9_.get_minHeight(),_loc13_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc13_ = Math.max(_backgroundSkinMeasurements.minHeight,_loc13_);
            }
         }
         var _loc14_:Object = get_explicitMaxWidth();
         if(_loc5_)
         {
            if(_loc9_ != null)
            {
               _loc14_ = _loc9_.get_maxWidth();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc14_ = _backgroundSkinMeasurements.maxWidth;
            }
            else
            {
               _loc14_ = 1 / 0;
            }
         }
         var _loc15_:Object = get_explicitMaxHeight();
         if(_loc6_)
         {
            if(_loc9_ != null)
            {
               _loc15_ = _loc9_.get_maxHeight();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc15_ = _backgroundSkinMeasurements.maxHeight;
            }
            else
            {
               _loc15_ = 1 / 0;
            }
         }
         return saveMeasurements(_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_);
      }
      
      override public function layoutContent() : void
      {
         super.layoutContent();
         layoutChildren();
      }
      
      public function layoutChildren() : void
      {
         refreshTextFieldDimensions(false);
         var _loc1_:Boolean = get_showText() && _text != null;
         var _loc2_:Boolean = get_showText() && _htmlText != null && _htmlText.length > 0;
         var _loc3_:Boolean = _currentIcon != null && get_iconPosition() != RelativePosition.MANUAL;
         if((_loc1_ || _loc2_) && _loc3_)
         {
            positionSingleChild(textField);
            positionTextAndIcon();
         }
         else if(_loc1_ || _loc2_)
         {
            positionSingleChild(textField);
         }
         else if(_loc3_)
         {
            positionSingleChild(_currentIcon);
         }
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.MANUAL)
            {
               _currentIcon.x = get_paddingLeft();
               _currentIcon.y = get_paddingTop();
            }
            _temp_1.x += get_iconOffsetX();
            _temp_2.y += get_iconOffsetY();
         }
         if(_loc1_ || _loc2_)
         {
            _temp_3.x += get_textOffsetX();
            _temp_4.y += get_textOffsetY();
         }
      }
      
      public function initializeButtonTheme() : void
      {
         SteelButtonStyles.initialize();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(textField == null)
         {
            textField = new TextField();
            textField.selectable = false;
            textField.multiline = true;
            addChild(textField);
         }
      }
      
      public function get_wordWrap() : Boolean
      {
         return __wordWrap;
      }
      
      public function get wordWrap() : Boolean
      {
         return get_wordWrap();
      }
      
      public function get_verticalAlign() : VerticalAlign
      {
         return __verticalAlign;
      }
      
      public function get verticalAlign() : VerticalAlign
      {
         return get_verticalAlign();
      }
      
      public function get_textOffsetY() : Number
      {
         return __textOffsetY;
      }
      
      public function get textOffsetY() : Number
      {
         return get_textOffsetY();
      }
      
      public function get_textOffsetX() : Number
      {
         return __textOffsetX;
      }
      
      public function get textOffsetX() : Number
      {
         return get_textOffsetX();
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
      
      public function get_styleSheet() : StyleSheet
      {
         return __styleSheet;
      }
      
      public function get styleSheet() : StyleSheet
      {
         return get_styleSheet();
      }
      
      override public function get_styleContext() : Class
      {
         return Button;
      }
      
      public function get_showText() : Boolean
      {
         return __showText;
      }
      
      public function get showText() : Boolean
      {
         return get_showText();
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
      
      public function get_minGap() : Number
      {
         return __minGap;
      }
      
      public function get minGap() : Number
      {
         return get_minGap();
      }
      
      public function get_iconPosition() : RelativePosition
      {
         return __iconPosition;
      }
      
      public function get iconPosition() : RelativePosition
      {
         return get_iconPosition();
      }
      
      public function get_iconOffsetY() : Number
      {
         return __iconOffsetY;
      }
      
      public function get iconOffsetY() : Number
      {
         return get_iconOffsetY();
      }
      
      public function get_iconOffsetX() : Number
      {
         return __iconOffsetX;
      }
      
      public function get iconOffsetX() : Number
      {
         return get_iconOffsetX();
      }
      
      public function get_icon() : DisplayObject
      {
         return __icon;
      }
      
      public function get icon() : DisplayObject
      {
         return get_icon();
      }
      
      public function get_htmlText() : String
      {
         return _htmlText;
      }
      
      public function get htmlText() : String
      {
         return get_htmlText();
      }
      
      public function get_horizontalAlign() : HorizontalAlign
      {
         return __horizontalAlign;
      }
      
      public function get horizontalAlign() : HorizontalAlign
      {
         return get_horizontalAlign();
      }
      
      public function get_gap() : Number
      {
         return __gap;
      }
      
      public function get gap() : Number
      {
         return get_gap();
      }
      
      public function get_embedFonts() : Boolean
      {
         return __embedFonts;
      }
      
      public function get embedFonts() : Boolean
      {
         return get_embedFonts();
      }
      
      public function get_disabledTextFormat() : feathers.text.TextFormat
      {
         return __disabledTextFormat;
      }
      
      public function get disabledTextFormat() : feathers.text.TextFormat
      {
         return get_disabledTextFormat();
      }
      
      public function get_baseline() : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(textField == null)
         {
            return 0;
         }
         var _loc1_:Boolean = _text != null && _text.length > 0;
         var _loc2_:Boolean = _htmlText != null && _htmlText.length > 0;
         if(!get_showText() || !_loc1_ && !_loc2_)
         {
            _loc3_ = textField.y;
            if(!get_showText() || _text == null && _htmlText == null)
            {
               if(_currentIcon != null)
               {
                  _loc3_ = _currentIcon.y + (_currentIcon.height - _textMeasuredHeight) / 2;
               }
               else
               {
                  if(_currentBackgroundSkin == null)
                  {
                     return 0;
                  }
                  _loc3_ = (_currentBackgroundSkin.height - _textMeasuredHeight) / 2;
               }
            }
            textField.text = "​";
            _loc4_ = _loc3_ + textField.getLineMetrics(0).ascent;
            textField.text = "";
            return _loc4_;
         }
         return textField.y + textField.getLineMetrics(0).ascent;
      }
      
      public function get baseline() : Number
      {
         return get_baseline();
      }
      
      public function getTextFormatForState(param1:ButtonState) : feathers.text.TextFormat
      {
         return _stateToTextFormat._SafeStr_2(param1);
      }
      
      public function getIconForState(param1:ButtonState) : DisplayObject
      {
         return _stateToIcon._SafeStr_2(param1);
      }
      
      public function getCurrentTextFormat() : feathers.text.TextFormat
      {
         if(get_styleSheet() != null)
         {
            return null;
         }
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
      
      public function getCurrentIcon() : DisplayObject
      {
         var _loc1_:DisplayObject = _stateToIcon._SafeStr_2(_currentState);
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         return get_icon();
      }
      
      override public function commitChanges() : void
      {
         super.commitChanges();
         var _loc1_:Boolean = isInvalid(InvalidationFlag.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc4_:Boolean = isInvalid(InvalidationFlag.STYLES);
         _updatedTextStyles = false;
         if(_loc4_ || _loc3_)
         {
            refreshIcon();
         }
         if(_loc4_ || _loc3_)
         {
            refreshTextStyles();
         }
         if(_loc1_ || _loc4_ || _loc3_ || _loc2_)
         {
            refreshText(_loc2_);
         }
      }
      
      public function clearStyle_wordWrap() : Boolean
      {
         set_wordWrap(false);
         return get_wordWrap();
      }
      
      public function clearStyle_verticalAlign() : VerticalAlign
      {
         set_verticalAlign(VerticalAlign.MIDDLE);
         return get_verticalAlign();
      }
      
      public function clearStyle_textOffsetY() : Number
      {
         set_textOffsetY(0);
         return get_textOffsetY();
      }
      
      public function clearStyle_textOffsetX() : Number
      {
         set_textOffsetX(0);
         return get_textOffsetX();
      }
      
      public function clearStyle_textFormat() : feathers.text.TextFormat
      {
         set_textFormat(null);
         return get_textFormat();
      }
      
      public function clearStyle_styleSheet() : StyleSheet
      {
         set_styleSheet(null);
         return get_styleSheet();
      }
      
      public function clearStyle_showText() : Boolean
      {
         set_showText(true);
         return get_showText();
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
      
      public function clearStyle_minGap() : Number
      {
         set_minGap(0);
         return get_minGap();
      }
      
      public function clearStyle_iconPosition() : RelativePosition
      {
         set_iconPosition(RelativePosition.LEFT);
         return get_iconPosition();
      }
      
      public function clearStyle_iconOffsetY() : Number
      {
         set_iconOffsetY(0);
         return get_iconOffsetY();
      }
      
      public function clearStyle_iconOffsetX() : Number
      {
         set_iconOffsetX(0);
         return get_iconOffsetX();
      }
      
      public function clearStyle_icon() : DisplayObject
      {
         set_icon(null);
         return get_icon();
      }
      
      public function clearStyle_horizontalAlign() : HorizontalAlign
      {
         set_horizontalAlign(HorizontalAlign.CENTER);
         return get_horizontalAlign();
      }
      
      public function clearStyle_gap() : Number
      {
         set_gap(0);
         return get_gap();
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
      
      public function calculateExplicitWidthForTextMeasurement() : Object
      {
         var _loc1_:Object = null;
         if(get_explicitWidth() != null)
         {
            _loc1_ = get_explicitWidth();
         }
         else if(get_explicitMaxWidth() != null)
         {
            _loc1_ = get_explicitMaxWidth();
         }
         else if(_backgroundSkinMeasurements != null && _backgroundSkinMeasurements.maxWidth != null)
         {
            _loc1_ = _backgroundSkinMeasurements.maxWidth;
         }
         if(_loc1_ == null)
         {
            return _loc1_;
         }
         _loc1_ -= get_paddingLeft() + get_paddingRight();
         var _loc2_:Number = get_gap();
         if(_loc2_ == 1 / 0)
         {
            _loc2_ = get_minGap();
         }
         if(_currentIcon != null)
         {
            if(get_iconPosition() == RelativePosition.LEFT || get_iconPosition() == RelativePosition.RIGHT)
            {
               if(_currentIcon is IValidating)
               {
                  _currentIcon.validateNow();
               }
               _loc1_ -= _currentIcon.width + _loc2_;
            }
         }
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function button_textFormat_changeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function button_keyDownHandler(param1:KeyboardEvent) : void
      {
         if(!_enabled || buttonMode && focusRect == true)
         {
            return;
         }
         if(_focusManager != null && _focusManager.get_focus() != this)
         {
            return;
         }
         if(param1.keyCode != 32 && param1.keyCode != 13)
         {
            return;
         }
         param1.preventDefault();
         dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function button_icon_resizeHandler(param1:Event) : void
      {
         if(_ignoreIconResizes)
         {
            return;
         }
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function button_focusOutHandler(param1:FocusEvent) : void
      {
         _keyToState.set_enabled(false);
      }
      
      public function button_focusInHandler(param1:FocusEvent) : void
      {
         _keyToState.set_enabled(_enabled);
      }
      
      public function addCurrentIcon(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            _iconMeasurements = null;
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(_iconMeasurements == null)
         {
            _iconMeasurements = new Measurements(param1);
         }
         else
         {
            _iconMeasurements.save(param1);
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         if(param1 is IStateObserver)
         {
            param1.set_stateContext(this);
         }
         param1.addEventListener(Event.RESIZE,button_icon_resizeHandler,false,0,true);
         var _loc2_:int = getChildIndex(textField);
         addChildAt(param1,_loc2_);
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
