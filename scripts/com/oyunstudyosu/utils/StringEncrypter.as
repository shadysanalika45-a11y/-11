package com.oyunstudyosu.utils
{
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   
   public class StringEncrypter
   {
      
      public function StringEncrypter()
      {
         super();
      }
      
      private static function applyXor(param1:ByteArray, param2:String) : ByteArray
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(param2);
         var _loc5_:int = 0;
         while(param1.bytesAvailable)
         {
            _loc5_ = param1.position % _loc4_.length;
            _loc6_ = int(param1.readUnsignedByte());
            _loc8_ = int(_loc4_[_loc5_]);
            _loc7_ = _loc8_ ^ _loc6_;
            _loc3_.writeByte(_loc7_);
         }
         return _loc3_;
      }
      
      public static function encode(param1:String, param2:String = "snlk") : String
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         _loc3_.position = 0;
         var _loc4_:ByteArray = applyXor(_loc3_,param2);
         return Base64.encodeByteArray(_loc4_);
      }
      
      public static function decode(param1:String, param2:String = "snlk") : String
      {
         var _loc3_:ByteArray = Base64.decodeToByteArray(param1);
         var _loc4_:ByteArray = applyXor(_loc3_,param2);
         _loc4_.position = 0;
         return _loc4_.readUTFBytes(_loc4_.length);
      }
   }
}

