package lime._internal.format
{
   import haxe.crypto.Base64;
   import haxe.io.Bytes;
   
   public class Base64
   {
      
      public static var EXTENDED_DICTIONARY:Array;
      
      public static var DICTIONARY:Array = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".split("");
      
      public function Base64()
      {
      }
      
      public static function decode(param1:String) : Bytes
      {
         return haxe.crypto.Base64.decode(param1);
      }
      
      public static function encode(param1:Bytes) : String
      {
         var _loc10_:* = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = lime._internal.format.Base64.DICTIONARY;
         var _loc4_:Array = lime._internal.format.Base64.EXTENDED_DICTIONARY;
         var _loc5_:int = param1.length;
         var _loc6_:int = Math.floor(_loc5_ / 3);
         var _loc7_:* = _loc6_ * 2;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         while(_loc9_ < _loc7_)
         {
            _loc10_ = int(param1.b[_loc8_]) << 16 | int(param1.b[_loc8_ + 1]) << 8 | int(param1.b[_loc8_ + 2]);
            _loc2_[_loc9_] = _loc4_[_loc10_ >> 12 & 0x0FFF];
            _loc2_[_loc9_ + 1] = _loc4_[_loc10_ & 0x0FFF];
            _loc8_ += 3;
            _loc9_ += 2;
         }
         switch(_loc5_ - _loc6_ * 3)
         {
            case 1:
               _loc10_ = int(param1.b[_loc8_]) << 16;
               _loc2_[_loc9_] = _loc4_[_loc10_ >> 12 & 0x0FFF];
               _loc2_[_loc9_ + 1] = "==";
               break;
            case 2:
               _loc10_ = int(param1.b[_loc8_]) << 16 | int(param1.b[_loc8_ + 1]) << 8;
               _loc2_[_loc9_] = _loc4_[_loc10_ >> 12 & 0x0FFF];
               _loc2_[_loc9_ + 1] = _loc3_[_loc10_ >> 6 & 0x3F] + "=";
         }
         return _loc2_.join("");
      }
   }
}

null as String;
0;
null as Array;
null as String;
§§push(lime._internal.format.Base64);
[];
0;
lime._internal.format.Base64.DICTIONARY;
while(_loc2_ < int(_loc3_.length))
{
   _loc3_[_loc2_];
   _loc2_++;
   0;
   lime._internal.format.Base64.DICTIONARY;
   while(_loc5_ < int(_loc6_.length))
   {
      _loc6_[_loc5_];
      (++_loc1_).push(_loc4_ + _loc7_);
   }
}

