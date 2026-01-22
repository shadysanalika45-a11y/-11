package lime.math._RGBA
{
   import haxe.io.Bytes;
   import lime.utils.ArrayBufferView;
   
   public final class RGBA_Impl_
   {
      
      public static var a16:int;
      
      public static var unmult:Number;
      
      public static var __alpha16:ArrayBufferView = _loc6_;
      
      public static var __clamp:ArrayBufferView = _loc16_;
      
      public function RGBA_Impl_()
      {
      }
      
      public static function _new(param1:int = 0) : int
      {
         return param1;
      }
      
      public static function create(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:int;
         var _loc6_:int = _loc5_ = 0;
         return (param1 & 0xFF) << 24 | (param2 & 0xFF) << 16 | (param3 & 0xFF) << 8 | param4 & 0xFF;
      }
      
      public static function multiplyAlpha(param1:int) : void
      {
         var _loc2_:* = null as ArrayBufferView;
         var _loc3_:* = null as Bytes;
         var _loc4_:* = 0;
         if((param1 & 0xFF) == 0)
         {
            if(param1 != 0)
            {
               param1 = 0;
            }
         }
         else if((param1 & 0xFF) != 255)
         {
            _loc2_ = RGBA_Impl_.__alpha16;
            _loc3_ = _loc2_.buffer;
            _loc4_ = _loc2_.byteOffset + (param1 & 0xFF) * 4;
            RGBA_Impl_.a16 = int(_loc3_.b[_loc4_]) | int(_loc3_.b[_loc4_ + 1]) << 8 | int(_loc3_.b[_loc4_ + 2]) << 16 | int(_loc3_.b[_loc4_ + 3]) << 24;
            param1 = ((param1 >> 24 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 24 | ((param1 >> 16 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 16 | ((param1 >> 8 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 8 | param1 & 0xFF & 0xFF;
         }
      }
      
      public static function readUInt8(param1:int, param2:ArrayBufferView, param3:int, param4:int = 0, param5:Boolean = false) : void
      {
         var _loc6_:* = null as ArrayBufferView;
         var _loc7_:* = null as ArrayBufferView;
         var _loc8_:* = null as ArrayBufferView;
         switch(param4)
         {
            case 0:
               param1 = (int(int(param2.buffer.b[param2.byteOffset + param3])) & 0xFF) << 24 | (int(int(param2.buffer.b[param2.byteOffset + (param3 + 1)])) & 0xFF) << 16 | (int(int(param2.buffer.b[param2.byteOffset + (param3 + 2)])) & 0xFF) << 8 | int(int(param2.buffer.b[param2.byteOffset + (param3 + 3)])) & 0xFF;
               break;
            case 1:
               param1 = (int(int(param2.buffer.b[param2.byteOffset + (param3 + 1)])) & 0xFF) << 24 | (int(int(param2.buffer.b[param2.byteOffset + (param3 + 2)])) & 0xFF) << 16 | (int(int(param2.buffer.b[param2.byteOffset + (param3 + 3)])) & 0xFF) << 8 | int(int(param2.buffer.b[param2.byteOffset + param3])) & 0xFF;
               break;
            case 2:
               param1 = (int(int(param2.buffer.b[param2.byteOffset + (param3 + 2)])) & 0xFF) << 24 | (int(int(param2.buffer.b[param2.byteOffset + (param3 + 1)])) & 0xFF) << 16 | (int(int(param2.buffer.b[param2.byteOffset + param3])) & 0xFF) << 8 | int(int(param2.buffer.b[param2.byteOffset + (param3 + 3)])) & 0xFF;
         }
         if(param5)
         {
            if((param1 & 0xFF) != 0 && (param1 & 0xFF) != 255)
            {
               RGBA_Impl_.unmult = 255 / (param1 & 0xFF);
               _loc6_ = RGBA_Impl_.__clamp;
               _loc7_ = RGBA_Impl_.__clamp;
               _loc8_ = RGBA_Impl_.__clamp;
               param1 = (int(int(_loc6_.buffer.b[_loc6_.byteOffset + int(Math.round((param1 >> 24 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 24 | (int(int(_loc7_.buffer.b[_loc7_.byteOffset + int(Math.round((param1 >> 16 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 16 | (int(int(_loc8_.buffer.b[_loc8_.byteOffset + int(Math.round((param1 >> 8 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 8 | param1 & 0xFF & 0xFF;
            }
         }
      }
      
      public static function _SafeStr_1(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         param1 = (param2 & 0xFF) << 24 | (param3 & 0xFF) << 16 | (param4 & 0xFF) << 8 | param5 & 0xFF;
      }
      
      public static function unmultiplyAlpha(param1:int) : void
      {
         var _loc2_:* = null as ArrayBufferView;
         var _loc3_:* = null as ArrayBufferView;
         var _loc4_:* = null as ArrayBufferView;
         if((param1 & 0xFF) != 0 && (param1 & 0xFF) != 255)
         {
            RGBA_Impl_.unmult = 255 / (param1 & 0xFF);
            _loc2_ = RGBA_Impl_.__clamp;
            _loc3_ = RGBA_Impl_.__clamp;
            _loc4_ = RGBA_Impl_.__clamp;
            param1 = (int(int(_loc2_.buffer.b[_loc2_.byteOffset + int(Math.round((param1 >> 24 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 24 | (int(int(_loc3_.buffer.b[_loc3_.byteOffset + int(Math.round((param1 >> 16 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 16 | (int(int(_loc4_.buffer.b[_loc4_.byteOffset + int(Math.round((param1 >> 8 & 0xFF) * RGBA_Impl_.unmult))])) & 0xFF) << 8 | param1 & 0xFF & 0xFF;
         }
      }
      
      public static function writeUInt8(param1:int, param2:ArrayBufferView, param3:int, param4:int = 0, param5:Boolean = false) : void
      {
         var _loc6_:* = null as ArrayBufferView;
         var _loc7_:* = null as Bytes;
         var _loc8_:* = 0;
         var _loc9_:uint = 0;
         if(param5)
         {
            if((param1 & 0xFF) == 0)
            {
               if(param1 != 0)
               {
                  param1 = 0;
               }
            }
            else if((param1 & 0xFF) != 255)
            {
               _loc6_ = RGBA_Impl_.__alpha16;
               _loc7_ = _loc6_.buffer;
               _loc8_ = _loc6_.byteOffset + (param1 & 0xFF) * 4;
               RGBA_Impl_.a16 = int(_loc7_.b[_loc8_]) | int(_loc7_.b[_loc8_ + 1]) << 8 | int(_loc7_.b[_loc8_ + 2]) << 16 | int(_loc7_.b[_loc8_ + 3]) << 24;
               param1 = ((param1 >> 24 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 24 | ((param1 >> 16 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 16 | ((param1 >> 8 & 0xFF) * RGBA_Impl_.a16 >> 16 & 0xFF) << 8 | param1 & 0xFF & 0xFF;
            }
         }
         switch(param4)
         {
            case 0:
               _loc9_ = uint(param1 >> 24 & 0xFF);
               param2.buffer.b[param2.byteOffset + param3] = _loc9_;
               _loc9_ = uint(param1 >> 16 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 1)] = _loc9_;
               _loc9_ = uint(param1 >> 8 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 2)] = _loc9_;
               _loc9_ = uint(param1 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 3)] = _loc9_;
               break;
            case 1:
               _loc9_ = uint(param1 & 0xFF);
               param2.buffer.b[param2.byteOffset + param3] = _loc9_;
               _loc9_ = uint(param1 >> 24 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 1)] = _loc9_;
               _loc9_ = uint(param1 >> 16 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 2)] = _loc9_;
               _loc9_ = uint(param1 >> 8 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 3)] = _loc9_;
               break;
            case 2:
               _loc9_ = uint(param1 >> 8 & 0xFF);
               param2.buffer.b[param2.byteOffset + param3] = _loc9_;
               _loc9_ = uint(param1 >> 16 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 1)] = _loc9_;
               _loc9_ = uint(param1 >> 24 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 2)] = _loc9_;
               _loc9_ = uint(param1 & 0xFF);
               param2.buffer.b[param2.byteOffset + (param3 + 3)] = _loc9_;
         }
      }
      
      public static function __fromARGB(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = _loc2_;
         return (param1 >> 16 & 0xFF & 0xFF) << 24 | (param1 >> 8 & 0xFF & 0xFF) << 16 | (param1 & 0xFF & 0xFF) << 8 | param1 >> 24 & 0xFF & 0xFF;
      }
      
      public static function __fromBGRA(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = _loc2_;
         return (param1 >> 8 & 0xFF & 0xFF) << 24 | (param1 >> 16 & 0xFF & 0xFF) << 16 | (param1 >> 24 & 0xFF & 0xFF) << 8 | param1 & 0xFF & 0xFF;
      }
      
      public static function get_a(param1:int) : int
      {
         return param1 & 0xFF;
      }
      
      public static function set_a(param1:int, param2:int) : int
      {
         param1 = (param1 >> 24 & 0xFF & 0xFF) << 24 | (param1 >> 16 & 0xFF & 0xFF) << 16 | (param1 >> 8 & 0xFF & 0xFF) << 8 | param2 & 0xFF;
         return param2;
      }
      
      public static function get_b(param1:int) : int
      {
         return param1 >> 8 & 0xFF;
      }
      
      public static function set_b(param1:int, param2:int) : int
      {
         param1 = (param1 >> 24 & 0xFF & 0xFF) << 24 | (param1 >> 16 & 0xFF & 0xFF) << 16 | (param2 & 0xFF) << 8 | param1 & 0xFF & 0xFF;
         return param2;
      }
      
      public static function get_g(param1:int) : int
      {
         return param1 >> 16 & 0xFF;
      }
      
      public static function set_g(param1:int, param2:int) : int
      {
         param1 = (param1 >> 24 & 0xFF & 0xFF) << 24 | (param2 & 0xFF) << 16 | (param1 >> 8 & 0xFF & 0xFF) << 8 | param1 & 0xFF & 0xFF;
         return param2;
      }
      
      public static function get_r(param1:int) : int
      {
         return param1 >> 24 & 0xFF;
      }
      
      public static function set_r(param1:int, param2:int) : int
      {
         param1 = (param2 & 0xFF) << 24 | (param1 >> 16 & 0xFF & 0xFF) << 16 | (param1 >> 8 & 0xFF & 0xFF) << 8 | param1 & 0xFF & 0xFF;
         return param2;
      }
   }
}

import haxe.io.Bytes;
import lime.utils.ArrayBufferView;

0;
null as ArrayBufferView;
0;
null as Bytes;
0;
null as ArrayBufferView;
null;
null;
null;
null;
null;
new ArrayBufferView(256,7);
0;
while(_loc7_ < 256)
{
   _loc7_++;
   RGBA_Impl_.__alpha16;
   uint(int(Math.ceil(_loc8_ * 257.00392156862745)));
   _loc9_.buffer;
   _loc9_.byteOffset + _loc8_ * 4;
   _loc11_.b[_loc12_] = _loc10_ & 0xFF;
   _loc11_.b[_loc12_ + 1] = uint(_loc10_ >> 8) & 0xFF;
   _loc11_.b[_loc12_ + 2] = uint(_loc10_ >> 16) & 0xFF;
   _loc11_.b[_loc12_ + 3] = uint(_loc10_ >>> 24) & 0xFF;
}
null;
null;
null;
null;
null;
new ArrayBufferView(511,4);
0;
while(_loc7_ < 255)
{
   _loc7_++;
   RGBA_Impl_.__clamp;
   var _loc17_:ArrayBufferView;
   _loc17_.buffer.b[_loc17_.byteOffset + _loc8_] = _loc8_;
}
255;
511;
while(_loc7_ < _loc8_)
{
   _loc7_++;
   RGBA_Impl_.__clamp;
   _loc17_.buffer.b[_loc17_.byteOffset + _loc12_] = 255;
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 */
