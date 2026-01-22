package com.oyunstudyosu.utils
{
   public class NumberUtils
   {
      
      public function NumberUtils()
      {
         super();
      }
      
      public static function setPrecision(param1:Number, param2:int) : Number
      {
         param2 = Math.pow(10,param2);
         return Math.round(param1 * param2) / param2;
      }
      
      public static function randRange(param1:int, param2:int) : int
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public static function getNumberWithPercent(param1:Number, param2:int = 2) : Number
      {
         return Number(int(param1 * 100) / 100);
      }
      
      public static function leadingZero(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return "" + param1;
      }
   }
}

