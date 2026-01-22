package feathers.text
{
   import feathers.events.FeathersEvent;
   import feathers.utils.TextFormatUtil;
   import flash.Boot;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.text.TextFormat;
   
   public class TextFormat extends EventDispatcher
   {
      
      public var _textFormat:flash.text.TextFormat;
      
      public function TextFormat(param1:String = undefined, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined, param6:Object = undefined, param7:String = undefined, param8:String = undefined, param9:String = undefined, param10:Object = undefined, param11:Object = undefined, param12:Object = undefined, param13:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         _textFormat = new flash.text.TextFormat(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
      }
      
      public function toSimpleTextFormat() : flash.text.TextFormat
      {
         return _textFormat;
      }
      
      public function set_url(param1:String) : String
      {
         if(_textFormat.url == param1)
         {
            return _textFormat.url;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.url = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.url;
      }
      
      public function set url(param1:String) : void
      {
         set_url(param1);
      }
      
      public function set_underline(param1:Object) : Object
      {
         if(_textFormat.underline == param1)
         {
            return _textFormat.underline;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.underline = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.underline;
      }
      
      public function set underline(param1:Object) : void
      {
         set_underline(param1);
      }
      
      public function set_target(param1:String) : String
      {
         if(_textFormat.target == param1)
         {
            return _textFormat.target;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.target = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.target;
      }
      
      public function set target(param1:String) : void
      {
         set_target(param1);
      }
      
      public function set_tabStops(param1:Array) : Array
      {
         if(_textFormat.tabStops == param1)
         {
            return _textFormat.tabStops;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.tabStops = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.tabStops;
      }
      
      public function set tabStops(param1:Array) : void
      {
         set_tabStops(param1);
      }
      
      public function set_size(param1:Object) : int
      {
         if(_textFormat.size == param1)
         {
            return _textFormat.size;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.size = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.size;
      }
      
      public function set size(param1:Object) : void
      {
         set_size(param1);
      }
      
      public function set_rightMargin(param1:Object) : int
      {
         if(_textFormat.rightMargin == param1)
         {
            return _textFormat.rightMargin;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.rightMargin = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.rightMargin;
      }
      
      public function set rightMargin(param1:Object) : void
      {
         set_rightMargin(param1);
      }
      
      public function set_letterSpacing(param1:Object) : Object
      {
         if(_textFormat.letterSpacing == param1)
         {
            return _textFormat.letterSpacing;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.letterSpacing = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.letterSpacing;
      }
      
      public function set letterSpacing(param1:Object) : void
      {
         set_letterSpacing(param1);
      }
      
      public function set_leftMargin(param1:Object) : int
      {
         if(_textFormat.leftMargin == param1)
         {
            return _textFormat.leftMargin;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.leftMargin = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.leftMargin;
      }
      
      public function set leftMargin(param1:Object) : void
      {
         set_leftMargin(param1);
      }
      
      public function set_leading(param1:Object) : int
      {
         if(_textFormat.leading == param1)
         {
            return _textFormat.leading;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.leading = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.leading;
      }
      
      public function set leading(param1:Object) : void
      {
         set_leading(param1);
      }
      
      public function set_kerning(param1:Object) : Object
      {
         if(_textFormat.kerning == param1)
         {
            return _textFormat.kerning;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.kerning = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.kerning;
      }
      
      public function set kerning(param1:Object) : void
      {
         set_kerning(param1);
      }
      
      public function set_italic(param1:Object) : Object
      {
         if(_textFormat.italic == param1)
         {
            return _textFormat.italic;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.italic = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.italic;
      }
      
      public function set italic(param1:Object) : void
      {
         set_italic(param1);
      }
      
      public function set_indent(param1:Object) : int
      {
         if(_textFormat.indent == param1)
         {
            return _textFormat.indent;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.indent = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.indent;
      }
      
      public function set indent(param1:Object) : void
      {
         set_indent(param1);
      }
      
      public function set_font(param1:String) : String
      {
         if(_textFormat.font == param1)
         {
            return _textFormat.font;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.font = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.font;
      }
      
      public function set font(param1:String) : void
      {
         set_font(param1);
      }
      
      public function set_color(param1:Object) : int
      {
         if(_textFormat.color == param1)
         {
            return _textFormat.color;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.color = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.color;
      }
      
      public function set color(param1:Object) : void
      {
         set_color(param1);
      }
      
      public function set_bullet(param1:Object) : Object
      {
         if(_textFormat.bullet == param1)
         {
            return _textFormat.bullet;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.bullet = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.bullet;
      }
      
      public function set bullet(param1:Object) : void
      {
         set_bullet(param1);
      }
      
      public function set_bold(param1:Object) : Object
      {
         if(_textFormat.bold == param1)
         {
            return _textFormat.bold;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.bold = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.bold;
      }
      
      public function set bold(param1:Object) : void
      {
         set_bold(param1);
      }
      
      public function set_blockIndent(param1:Object) : int
      {
         if(_textFormat.blockIndent == param1)
         {
            return _textFormat.blockIndent;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.blockIndent = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.blockIndent;
      }
      
      public function set blockIndent(param1:Object) : void
      {
         set_blockIndent(param1);
      }
      
      public function set_align(param1:String) : String
      {
         if(_textFormat.align == param1)
         {
            return _textFormat.align;
         }
         _textFormat = TextFormatUtil.clone(_textFormat);
         _textFormat.align = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _textFormat.align;
      }
      
      public function set align(param1:String) : void
      {
         set_align(param1);
      }
      
      public function get_url() : String
      {
         return _textFormat.url;
      }
      
      public function get url() : String
      {
         return get_url();
      }
      
      public function get_underline() : Object
      {
         return _textFormat.underline;
      }
      
      public function get underline() : Object
      {
         return get_underline();
      }
      
      public function get_target() : String
      {
         return _textFormat.target;
      }
      
      public function get target() : String
      {
         return get_target();
      }
      
      public function get_tabStops() : Array
      {
         return _textFormat.tabStops;
      }
      
      public function get tabStops() : Array
      {
         return get_tabStops();
      }
      
      public function get_size() : Object
      {
         return _textFormat.size;
      }
      
      public function get size() : Object
      {
         return get_size();
      }
      
      public function get_rightMargin() : Object
      {
         return _textFormat.rightMargin;
      }
      
      public function get rightMargin() : Object
      {
         return get_rightMargin();
      }
      
      public function get_letterSpacing() : Object
      {
         return _textFormat.letterSpacing;
      }
      
      public function get letterSpacing() : Object
      {
         return get_letterSpacing();
      }
      
      public function get_leftMargin() : Object
      {
         return _textFormat.leftMargin;
      }
      
      public function get leftMargin() : Object
      {
         return get_leftMargin();
      }
      
      public function get_leading() : Object
      {
         return _textFormat.leading;
      }
      
      public function get leading() : Object
      {
         return get_leading();
      }
      
      public function get_kerning() : Object
      {
         return _textFormat.kerning;
      }
      
      public function get kerning() : Object
      {
         return get_kerning();
      }
      
      public function get_italic() : Object
      {
         return _textFormat.italic;
      }
      
      public function get italic() : Object
      {
         return get_italic();
      }
      
      public function get_indent() : Object
      {
         return _textFormat.indent;
      }
      
      public function get indent() : Object
      {
         return get_indent();
      }
      
      public function get_font() : String
      {
         return _textFormat.font;
      }
      
      public function get font() : String
      {
         return get_font();
      }
      
      public function get_color() : Object
      {
         return _textFormat.color;
      }
      
      public function get color() : Object
      {
         return get_color();
      }
      
      public function get_bullet() : Object
      {
         return _textFormat.bullet;
      }
      
      public function get bullet() : Object
      {
         return get_bullet();
      }
      
      public function get_bold() : Object
      {
         return _textFormat.bold;
      }
      
      public function get bold() : Object
      {
         return get_bold();
      }
      
      public function get_blockIndent() : Object
      {
         return _textFormat.blockIndent;
      }
      
      public function get blockIndent() : Object
      {
         return get_blockIndent();
      }
      
      public function get_align() : String
      {
         return _textFormat.align;
      }
      
      public function get align() : String
      {
         return get_align();
      }
      
      public function clone() : feathers.text.TextFormat
      {
         var _loc1_:feathers.text.TextFormat = new feathers.text.TextFormat(get_font(),get_size(),get_color(),get_bold(),get_italic(),get_underline(),get_url(),get_target(),get_align(),get_leftMargin(),get_rightMargin(),get_indent(),get_leading());
         _loc1_._textFormat.blockIndent = get_blockIndent();
         _loc1_._textFormat.bullet = get_bullet();
         _loc1_._textFormat.kerning = get_kerning();
         _loc1_._textFormat.letterSpacing = get_letterSpacing();
         _loc1_._textFormat.tabStops = get_tabStops();
         return _loc1_;
      }
   }
}

