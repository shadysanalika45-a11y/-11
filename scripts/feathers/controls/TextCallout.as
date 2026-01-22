package feathers.controls
{
   import feathers.core.IHTMLTextControl;
   import feathers.core.ITextControl;
   import feathers.core.InvalidationFlag;
   import feathers.text.TextFormat;
   import feathers.themes.steel.components.SteelTextCalloutStyles;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.text.StyleSheet;
   
   public class TextCallout extends Callout implements IHTMLTextControl, ITextControl
   {
      
      public static var __meta__:* = {"obj":{"defaultXmlProperty":["text"]}};
      
      public static var VARIANT_DANGER:String = "danger";
      
      public var label:Label;
      
      public var _text:String;
      
      public var _htmlText:String;
      
      public var __textFormat:TextFormat;
      
      public var __styleSheet:StyleSheet;
      
      public var __embedFonts:Boolean;
      
      public var __disabledTextFormat:TextFormat;
      
      public function TextCallout(param1:String = undefined)
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(Boot.skip_constructor)
         {
            return;
         }
         __disabledTextFormat = null;
         __embedFonts = false;
         __styleSheet = null;
         __textFormat = null;
         _htmlText = null;
         initializeTextCalloutTheme();
         super();
         set_text(param1);
      }
      
      public static function show(param1:String, param2:DisplayObject, param3:Array = undefined, param4:Boolean = true) : TextCallout
      {
         var _loc5_:TextCallout = new TextCallout(param1);
         return Callout.showCallout(_loc5_,param2,param3,param4);
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.DATA);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.STYLES);
         if(_loc3_ || _loc2_)
         {
            refreshTextStyles();
         }
         if(_loc1_ || _loc3_ || _loc2_)
         {
            refreshText();
         }
         super.update();
      }
      
      public function set_textFormat(param1:TextFormat) : TextFormat
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
      
      public function set textFormat(param1:TextFormat) : void
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
      
      public function set_disabledTextFormat(param1:TextFormat) : TextFormat
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
      
      public function set disabledTextFormat(param1:TextFormat) : void
      {
         set_disabledTextFormat(param1);
      }
      
      public function refreshTextStyles() : void
      {
         label.set_textFormat(get_textFormat());
         label.set_disabledTextFormat(get_disabledTextFormat());
         label.set_embedFonts(get_embedFonts());
         label.set_styleSheet(get_styleSheet());
      }
      
      public function refreshText() : void
      {
         label.set_text(_text);
         label.set_htmlText(_htmlText);
      }
      
      public function initializeTextCalloutTheme() : void
      {
         SteelTextCalloutStyles.initialize();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         if(label == null)
         {
            label = new Label();
            addChild(label);
            set_content(label);
         }
      }
      
      public function get_textFormat() : TextFormat
      {
         return __textFormat;
      }
      
      public function get textFormat() : TextFormat
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
         return TextCallout;
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
      
      public function get_disabledTextFormat() : TextFormat
      {
         return __disabledTextFormat;
      }
      
      public function get disabledTextFormat() : TextFormat
      {
         return get_disabledTextFormat();
      }
      
      public function get_baseline() : Number
      {
         if(label == null)
         {
            return 0;
         }
         return label.y + label.get_baseline();
      }
      
      public function get baseline() : Number
      {
         return get_baseline();
      }
      
      public function clearStyle_textFormat() : TextFormat
      {
         set_textFormat(null);
         return get_textFormat();
      }
      
      public function clearStyle_styleSheet() : StyleSheet
      {
         set_styleSheet(null);
         return get_styleSheet();
      }
      
      public function clearStyle_embedFonts() : Boolean
      {
         set_embedFonts(false);
         return get_embedFonts();
      }
      
      public function clearStyle_disabledTextFormat() : TextFormat
      {
         set_disabledTextFormat(null);
         return get_disabledTextFormat();
      }
   }
}

