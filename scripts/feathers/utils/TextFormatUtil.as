package feathers.utils
{
   import flash.text.TextFormat;
   
   public class TextFormatUtil
   {
      
      public function TextFormatUtil()
      {
      }
      
      public static function clone(param1:TextFormat) : TextFormat
      {
         var _loc2_:TextFormat = new TextFormat(param1.font,param1.size,param1.color,param1.bold,param1.italic,param1.underline,param1.url,param1.target,param1.align,param1.leftMargin,param1.rightMargin,param1.indent,param1.leading);
         _loc2_.blockIndent = param1.blockIndent;
         _loc2_.bullet = param1.bullet;
         _loc2_.kerning = param1.kerning;
         _loc2_.letterSpacing = param1.letterSpacing;
         _loc2_.tabStops = param1.tabStops;
         return _loc2_;
      }
   }
}

