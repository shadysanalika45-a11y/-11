package haxe.io
{
   import flash.Boot;
   import flash.utils.ByteArray;
   import haxe.Exception;
   import haxe._Int64.___Int64;
   
   public class Bytes
   {
      
      public var length:int;
      
      public var b:ByteArray;
      
      public function Bytes(param1:int = 0, param2:ByteArray = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         length = param1;
         b = param2;
         param2.endian = "littleEndian";
      }
      
      public static function alloc(param1:int) : Bytes
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.length = param1;
         return new Bytes(param1,_loc2_);
      }
      
      public static function ofString(param1:String, param2:Encoding = undefined) : Bytes
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         return new Bytes(_loc3_.length,_loc3_);
      }
      
      public static function ofData(param1:ByteArray) : Bytes
      {
         return new Bytes(param1.length,param1);
      }
      
      public static function ofHex(param1:String) : Bytes
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc2_:int = param1.length;
         if((_loc2_ & 1) != 0)
         {
            throw Exception.thrown("Not a hex string (odd number of digits)");
         }
         var _loc3_:Bytes = Bytes.alloc(_loc2_ >> 1);
         var _loc4_:int = 0;
         var _loc5_:int = _loc3_.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc7_ = int(param1.charCodeAt(_loc6_ * 2));
            _loc8_ = int(param1.charCodeAt(_loc6_ * 2 + 1));
            _loc7_ = (_loc7_ & 0x0F) + ((_loc7_ & 0x40) >> 6) * 9;
            _loc8_ = (_loc8_ & 0x0F) + ((_loc8_ & 0x40) >> 6) * 9;
            _loc3_.b[_loc6_] = (_loc7_ << 4 | _loc8_) & 0xFF;
         }
         return _loc3_;
      }
      
      public static function fastGet(param1:ByteArray, param2:int) : int
      {
         return int(param1[param2]);
      }
      
      public function toString() : String
      {
         b.position = 0;
         return b.toString();
      }
      
      public function toHex() : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:String = "";
         var _loc2_:Array = [];
         var _loc3_:String = "0123456789abcdef";
         var _loc4_:int = 0;
         var _loc5_:int = _loc3_.length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc2_.push(_loc3_.charCodeAt(_loc6_));
         }
         _loc4_ = 0;
         _loc5_ = length;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc7_ = int(b[_loc6_]);
            _loc8_ = int(_loc2_[_loc7_ >> 4]);
            _loc1_ += _loc8_ < 65536 ? String["fromCharCode"](_loc8_) : Boot.fromCodePoint(_loc8_);
            _loc8_ = int(_loc2_[_loc7_ & 0x0F]);
            _loc1_ += _loc8_ < 65536 ? String["fromCharCode"](_loc8_) : Boot.fromCodePoint(_loc8_);
         }
         return _loc1_;
      }
      
      public function sub(param1:int, param2:int) : Bytes
      {
         if(param1 < 0 || param2 < 0 || param1 + param2 > length)
         {
            throw Exception.thrown(haxe.io.Error.OutsideBounds);
         }
         b.position = param1;
         var _loc3_:ByteArray = new ByteArray();
         b.readBytes(_loc3_,0,param2);
         return new Bytes(param2,_loc3_);
      }
      
      public function setUInt16(param1:int, param2:int) : void
      {
         b[param1] = param2;
         b[param1 + 1] = param2 >> 8;
      }
      
      public function setInt64(param1:int, param2:___Int64) : void
      {
         var _loc3_:* = param2.low;
         b[param1] = _loc3_ & 0xFF;
         b[param1 + 1] = _loc3_ >> 8 & 0xFF;
         b[param1 + 2] = _loc3_ >> 16 & 0xFF;
         b[param1 + 3] = _loc3_ >>> 24 & 0xFF;
         _loc3_ = param1 + 4;
         var _loc4_:int = param2.high;
         b[_loc3_] = _loc4_ & 0xFF;
         b[_loc3_ + 1] = _loc4_ >> 8 & 0xFF;
         b[_loc3_ + 2] = _loc4_ >> 16 & 0xFF;
         b[_loc3_ + 3] = _loc4_ >>> 24 & 0xFF;
      }
      
      public function setInt32(param1:int, param2:int) : void
      {
         b[param1] = param2 & 0xFF;
         b[param1 + 1] = param2 >> 8 & 0xFF;
         b[param1 + 2] = param2 >> 16 & 0xFF;
         b[param1 + 3] = param2 >>> 24 & 0xFF;
      }
      
      public function setFloat(param1:int, param2:Number) : void
      {
         b.position = param1;
         b.writeFloat(param2);
      }
      
      public function setDouble(param1:int, param2:Number) : void
      {
         b.position = param1;
         b.writeDouble(param2);
      }
      
      public function _SafeStr_1(param1:int, param2:int) : void
      {
         b[param1] = param2;
      }
      
      public function readString(param1:int, param2:int) : String
      {
         return getString(param1,param2);
      }
      
      public function getUInt16(param1:int) : int
      {
         return int(b[param1]) | int(b[param1 + 1]) << 8;
      }
      
      public function getString(param1:int, param2:int, param3:Encoding = undefined) : String
      {
         if(param1 < 0 || param2 < 0 || param1 + param2 > length)
         {
            throw Exception.thrown(haxe.io.Error.OutsideBounds);
         }
         b.position = param1;
         return b.readUTFBytes(param2);
      }
      
      public function getInt64(param1:int) : ___Int64
      {
         var _loc2_:* = param1 + 4;
         return new ___Int64(int(b[_loc2_]) | int(b[_loc2_ + 1]) << 8 | int(b[_loc2_ + 2]) << 16 | int(b[_loc2_ + 3]) << 24,int(b[param1]) | int(b[param1 + 1]) << 8 | int(b[param1 + 2]) << 16 | int(b[param1 + 3]) << 24);
      }
      
      public function getInt32(param1:int) : int
      {
         return int(b[param1]) | int(b[param1 + 1]) << 8 | int(b[param1 + 2]) << 16 | int(b[param1 + 3]) << 24;
      }
      
      public function getFloat(param1:int) : Number
      {
         b.position = param1;
         return b.readFloat();
      }
      
      public function getDouble(param1:int) : Number
      {
         b.position = param1;
         return b.readDouble();
      }
      
      public function getData() : ByteArray
      {
         return b;
      }
      
      public function _SafeStr_2(param1:int) : int
      {
         return int(b[param1]);
      }
      
      public function fill(param1:int, param2:int, param3:int) : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = param3 & 0xFF;
         _loc4_ |= _loc4_ << 8;
         _loc4_ |= _loc4_ << 16;
         b.position = param1;
         var _loc5_:int = 0;
         var _loc6_:* = param2 >> 2;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            b.writeUnsignedInt(_loc4_);
         }
         param1 += param2 & -4;
         _loc5_ = 0;
         _loc6_ = param2 & 3;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            b[param1++] = param3;
         }
      }
      
      public function compare(param1:Bytes) : int
      {
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc2_:int = length < param1.length ? length : param1.length;
         var _loc3_:ByteArray = b;
         var _loc4_:ByteArray = param1.b;
         _loc3_.position = 0;
         _loc4_.position = 0;
         _loc3_.endian = "bigEndian";
         _loc4_.endian = "bigEndian";
         var _loc5_:int = 0;
         var _loc6_:* = _loc2_ >> 2;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            if(_loc3_.readUnsignedInt() != _loc4_.readUnsignedInt())
            {
               _loc3_.position -= 4;
               _loc4_.position -= 4;
               _loc8_ = uint(_loc3_.readUnsignedInt() - _loc4_.readUnsignedInt());
               _loc3_.endian = "littleEndian";
               _loc4_.endian = "littleEndian";
               return _loc8_;
            }
         }
         _loc5_ = 0;
         _loc6_ = _loc2_ & 3;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            if(_loc3_.readUnsignedByte() != _loc4_.readUnsignedByte())
            {
               _loc3_.endian = "littleEndian";
               _loc4_.endian = "littleEndian";
               return int(_loc3_[uint(_loc3_.position - 1)]) - int(_loc4_[uint(_loc4_.position - 1)]);
            }
         }
         _loc3_.endian = "littleEndian";
         _loc4_.endian = "littleEndian";
         return length - param1.length;
      }
      
      public function blit(param1:int, param2:Bytes, param3:int, param4:int) : void
      {
         if(param1 < 0 || param3 < 0 || param4 < 0 || param1 + param4 > length || param3 + param4 > param2.length)
         {
            throw Exception.thrown(haxe.io.Error.OutsideBounds);
         }
         b.position = param1;
         if(param4 > 0)
         {
            b.writeBytes(param2.b,param3,param4);
         }
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
