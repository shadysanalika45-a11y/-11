package lime._internal.format
{
   import haxe.io.Bytes;
   import lime.graphics.Image;
   
   public class PNG
   {
      
      public function PNG()
      {
      }
      
      public static function decodeBytes(param1:Bytes, param2:Boolean = true) : Image
      {
         return null;
      }
      
      public static function decodeFile(param1:String, param2:Boolean = true) : Image
      {
         return null;
      }
      
      public static function encode(param1:Image) : Bytes
      {
         if(param1.get_premultiplied() || param1.get_format() != 0)
         {
            param1 = param1.clone();
            param1.set_premultiplied(false);
            param1.set_format(0);
         }
         return null;
      }
   }
}

