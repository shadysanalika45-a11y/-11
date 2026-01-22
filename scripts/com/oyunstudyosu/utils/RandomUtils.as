package com.oyunstudyosu.utils
{
   public class RandomUtils
   {
      
      public function RandomUtils()
      {
         super();
      }
      
      public static function integer(param1:int, param2:int) : int
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public static function string(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:* = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += String.fromCharCode(integer(97,122));
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

