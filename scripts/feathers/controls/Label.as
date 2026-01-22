package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IFocusObject;
   import feathers.core.IHTMLTextControl;
   import feathers.core.IMeasureObject;
   import feathers.core.IStageFocusDelegate;
   import feathers.core.ITextControl;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.layout.Measurements;
   import feathers.layout.VerticalAlign;
   import feathers.skins.IProgrammaticSkin;
   import feathers.text.TextFormat;
   import feathers.themes.steel.components.SteelLabelStyles;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.text.StyleSheet;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class Label extends FeathersControl implements IStageFocusDelegate, IFocusObject, IHTMLTextControl, ITextControl
   {
      
      public static var __meta__:* = {"obj":{"defaultXmlProperty":["text"]}};
      
      public static var VARIANT_HEADING:String = "heading";
      
      public static var VARIANT_DETAIL:String = "detail";
      
      public var textField:TextField;
      
      public var _wrappedOnMeasure:Boolean;
      
      public var _updatedTextStyles:Boolean;
      
      public var _textMeasuredWidth:Number;
      
      public var _textMeasuredHeight:Number;
      
      public var _text:String;
      
      public var _selectable:Boolean;
      
      public var _previousTextFormat:feathers.text.TextFormat;
      
      public var _previousText:String;
      
      public var _previousSimpleTextFormat:flash.text.TextFormat;
      
      public var _previousHTMLText:String;
      
      public var _htmlText:String;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var __wordWrap:Boolean;
      
      public var __verticalAlign:VerticalAlign;
      
      public var __textFormat:feathers.text.TextFormat;
      
      public var __styleSheet:StyleSheet;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __embedFonts:Boolean;
      
      public var __disabledTextFormat:feathers.text.TextFormat;
      
      public var __disabledBackgroundSkin:DisplayObject;
      
      public var __backgroundSkin:DisplayObject;
      
      public function Label(param1:String = undefined)
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(Boot.skip_constructor)
         {
            return;
         }
         __disabledBackgroundSkin = null;
         __backgroundSkin = null;
         __wordWrap = false;
         __verticalAlign = VerticalAlign.TOP;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         __disabledTextFormat = null;
         __embedFonts = false;
         __styleSheet = null;
         __textFormat = null;
         _backgroundSkinMeasurements = null;
         _currentBackgroundSkin = null;
         _selectable = false;
         _htmlText = null;
         _wrappedOnMeasure = false;
         _updatedTextStyles = false;
         _previousSimpleTextFormat = null;
         _previousTextFormat = null;
         _previousHTMLText = null;
         _previousText = null;
         initializeLabelTheme();
         super();
         set_text(param1);
         tabEnabled = false;
         tabChildren = false;
         addEventListener(FocusEvent.FOCUS_IN,label_focusInHandler);
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.SELECTION);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc4_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc5_:Boolean = isInvalid(InvalidationFlag.STYLES);
         _updatedTextStyles = false;
         if(_loc5_ || _loc4_)
         {
            refreshBackgroundSkin();
         }
         if(_loc5_ || _loc4_)
         {
            refreshTextStyles();
         }
         if(_loc1_ || _loc5_ || _loc4_ || _loc3_)
         {
            refreshText(_loc3_);
         }
         if(_loc1_ || _loc5_ || _loc2_)
         {
            refreshSelection();
         }
         if(measure())
         {
            _loc3_ = true;
         }
         if(_loc5_ || _loc4_ || _loc1_ || _loc3_)
         {
            layoutContent();
         }
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
      
      public function set_selectable(param1:Boolean) : Boolean
      {
         if(_selectable == param1)
         {
            return _selectable;
         }
         _selectable = param1;
         setInvalid(InvalidationFlag.SELECTION);
         return _selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         set_selectable(param1);
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
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
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
            _previousTextFormat.removeEventListener(Event.CHANGE,label_textFormat_changeHandler);
         }
         if(textField.caretIndex != -1 && textField.selectionBeginIndex != textField.selectionEndIndex)
         {
            textField.setSelection(0,0);
         }
         if(_loc1_ != null)
         {
            _loc1_.addEventListener(Event.CHANGE,label_textFormat_changeHandler,false,0,true);
            textField.defaultTextFormat = _loc2_;
            _updatedTextStyles = true;
         }
         _previousTextFormat = _loc1_;
         _previousSimpleTextFormat = _loc2_;
      }
      
      public function refreshText(param1:Boolean) : void
      {
         var _loc4_:* = null as Object;
         var _loc2_:Boolean = _text != null && _text.length > 0;
         var _loc3_:Boolean = _htmlText != null && _htmlText.length > 0;
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
      
      public function refreshSelection() : void
      {
         var _loc1_:Boolean = _selectable && _enabled;
         if(textField.selectable != _loc1_)
         {
            textField.selectable = _loc1_;
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
            _loc8_ = _textMeasuredWidth + get_paddingLeft() + get_paddingRight();
            if(_currentBackgroundSkin != null)
            {
               _loc8_ = Math.max(_currentBackgroundSkin.width,_loc8_);
            }
         }
         var _loc9_:Object = get_explicitHeight();
         if(_loc2_)
         {
            _loc9_ = _textMeasuredHeight + get_paddingTop() + get_paddingBottom();
            if(_currentBackgroundSkin != null)
            {
               _loc9_ = Math.max(_currentBackgroundSkin.height,_loc9_);
            }
         }
         var _loc10_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            _loc10_ = _textMeasuredWidth + get_paddingLeft() + get_paddingRight();
            if(_loc7_ != null)
            {
               _loc10_ = Math.max(_loc7_.get_minWidth(),_loc10_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc10_ = Math.max(_backgroundSkinMeasurements.minWidth,_loc10_);
            }
         }
         var _loc11_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            _loc11_ = _textMeasuredHeight + get_paddingTop() + get_paddingBottom();
            if(_loc7_ != null)
            {
               _loc11_ = Math.max(_loc7_.get_minHeight(),_loc11_);
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc11_ = Math.max(_backgroundSkinMeasurements.minHeight,_loc11_);
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
         var _loc5_:Number = NaN;
         layoutBackgroundSkin();
         var _loc1_:Number = actualWidth - get_paddingLeft() - get_paddingRight();
         textField.x = get_paddingLeft();
         textField.width = _loc1_;
         var _loc2_:Boolean = get_wordWrap();
         if(_loc2_ && !_wrappedOnMeasure && _loc1_ >= _textMeasuredWidth)
         {
            _loc2_ = false;
         }
         if(textField.wordWrap != _loc2_)
         {
            textField.wordWrap = _loc2_;
         }
         var _loc3_:Number = _textMeasuredHeight;
         var _loc4_:Number = actualHeight - get_paddingTop() - get_paddingBottom();
         if(_loc3_ > _loc4_)
         {
            _loc3_ = _loc4_;
         }
         textField.height = _loc3_;
         switch(get_verticalAlign().index)
         {
            case 0:
               textField.y = get_paddingTop();
               break;
            case 2:
               _loc5_ = actualHeight - get_paddingBottom();
               textField.y = _loc5_ - _loc3_;
               break;
            default:
               _loc5_ = get_paddingTop();
               textField.y = _loc5_ + (_loc4_ - _loc3_) / 2;
         }
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
      
      public function label_textFormat_changeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function label_focusInHandler(param1:FocusEvent) : void
      {
         if(stage != null && stage.focus != textField)
         {
            param1.stopImmediatePropagation();
            stage.focus = textField;
         }
      }
      
      public function initializeLabelTheme() : void
      {
         SteelLabelStyles.initialize();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(textField == null)
         {
            textField = new TextField();
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
      
      override public function get tabEnabled() : Boolean
      {
         if(_selectable && _enabled)
         {
            return get_rawTabEnabled();
         }
         return false;
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
         return Label;
      }
      
      public function get_stageFocusTarget() : InteractiveObject
      {
         return textField;
      }
      
      public function get stageFocusTarget() : InteractiveObject
      {
         return get_stageFocusTarget();
      }
      
      public function get_selectionEndIndex() : int
      {
         if(!_selectable)
         {
            return -1;
         }
         if(textField == null)
         {
            return 0;
         }
         return textField.selectionEndIndex;
      }
      
      public function get selectionEndIndex() : int
      {
         return get_selectionEndIndex();
      }
      
      public function get_selectionBeginIndex() : int
      {
         if(!_selectable)
         {
            return -1;
         }
         if(textField == null)
         {
            return 0;
         }
         return textField.selectionBeginIndex;
      }
      
      public function get selectionBeginIndex() : int
      {
         return get_selectionBeginIndex();
      }
      
      public function get_selectable() : Boolean
      {
         return _selectable;
      }
      
      public function get selectable() : Boolean
      {
         return get_selectable();
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
      
      public function get_htmlText() : String
      {
         return _htmlText;
      }
      
      public function get htmlText() : String
      {
         return get_htmlText();
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
      
      public function get_disabledBackgroundSkin() : DisplayObject
      {
         return __disabledBackgroundSkin;
      }
      
      public function get disabledBackgroundSkin() : DisplayObject
      {
         return get_disabledBackgroundSkin();
      }
      
      public function get_baseline() : Number
      {
         var _loc3_:Number = NaN;
         if(textField == null)
         {
            return 0;
         }
         var _loc1_:Boolean = _text != null && _text.length > 0;
         var _loc2_:Boolean = _htmlText != null && _htmlText.length > 0;
         if(!_loc1_ && !_loc2_)
         {
            textField.text = "​";
            _loc3_ = textField.y + textField.getLineMetrics(0).ascent;
            textField.text = "";
            return _loc3_;
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
      
      public function getCurrentTextFormat() : feathers.text.TextFormat
      {
         if(get_styleSheet() != null)
         {
            return null;
         }
         if(!_enabled && get_disabledTextFormat() != null)
         {
            return get_disabledTextFormat();
         }
         return get_textFormat();
      }
      
      public function getCurrentBackgroundSkin() : DisplayObject
      {
         if(!_enabled && get_disabledBackgroundSkin() != null)
         {
            return get_disabledBackgroundSkin();
         }
         return get_backgroundSkin();
      }
      
      public function clearStyle_wordWrap() : Boolean
      {
         set_wordWrap(false);
         return get_wordWrap();
      }
      
      public function clearStyle_verticalAlign() : VerticalAlign
      {
         set_verticalAlign(VerticalAlign.TOP);
         return get_verticalAlign();
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
         return _loc1_ - (get_paddingLeft() + get_paddingRight());
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

