package haxe.crypto
{
   import haxe.io.Bytes;
   
   public class Base64
   {
      
      public static var CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      
      public static var BYTES:Bytes = Bytes.ofString(Base64.CHARS);
      
      public function Base64()
      {
      }
      
      public static function decode(param1:String, param2:Boolean = true) : Bytes
      {
         if(param2)
         {
            while(param1.charCodeAt(param1.length - 1) == 61)
            {
               param1 = param1.substr(0,-1);
            }
         }
         return new BaseCode(Base64.BYTES).decodeBytes(Bytes.ofString(param1));
      }
   }
}

import haxe.io.Bytes;

