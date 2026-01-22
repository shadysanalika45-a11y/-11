package com.oyunstudyosu.auth
{
   import com.hurlant.util.Base64;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class PermissionUtils
   {
      
      public function PermissionUtils()
      {
         super();
      }
      
      public static function atLeastOne(param1:IPermission, param2:IPermission) : Boolean
      {
         var _loc3_:Array = param2.grantedIndexes();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(param1.check(_loc3_[_loc4_]))
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function allOfThem(param1:IPermission, param2:IPermission) : Boolean
      {
         var _loc3_:Array = param2.grantedIndexes();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(!param1.check(_loc3_[_loc4_]))
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public static function grantedIndexes(param1:String) : Array
      {
         var _loc4_:uint = 0;
         var _loc7_:int = 0;
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc3_:uint = _loc2_.length;
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_ = -1;
            while(_loc7_ < 7)
            {
               _loc4_ = 0;
               if(_loc7_ == -1)
               {
                  _loc4_ = uint(1 << 7);
               }
               else
               {
                  _loc4_ |= 1 << _loc7_;
               }
               if(_loc2_[_loc6_] & _loc4_)
               {
                  _loc5_.push(_loc6_ * 8 + (_loc7_ == -1 ? 8 : _loc7_ + 1));
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public static function toString(param1:IPermission) : String
      {
         return byteArrayToBinaryString(param1.data);
      }
      
      private static function padString(param1:String, param2:int, param3:String, param4:Boolean = true) : String
      {
         var _loc5_:int = param2 - param1.length;
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ += param3;
            _loc7_++;
         }
         return (param4 ? _loc6_ : "") + param1 + (!param4 ? _loc6_ : "");
      }
      
      private static function byteArrayToBinaryString(param1:ByteArray) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = int(param1.length);
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ += padString(param1[_loc4_].toString(2),8,"0");
            _loc4_--;
         }
         return _loc2_;
      }
   }
}

