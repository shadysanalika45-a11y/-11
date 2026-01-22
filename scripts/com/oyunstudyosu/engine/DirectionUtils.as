package com.oyunstudyosu.engine
{
   public class DirectionUtils
   {
      
      private static var key2Value:Object = {
         "1,0":1,
         "1,-1":2,
         "0,-1":3,
         "-1,-1":4,
         "-1,0":5,
         "-1,1":6,
         "0,1":7,
         "1,1":8
      };
      
      private static var value2Key:Array = ["1,0","1,-1","0,-1","-1,-1","-1,0","-1,1","0,1","1,1"];
      
      private static var diagonals:Array = ["1,-1","-1,1"];
      
      public function DirectionUtils()
      {
         super();
      }
      
      public static function getKey(param1:int) : String
      {
         return value2Key[param1 - 1];
      }
      
      public static function getValue(param1:String) : int
      {
         return key2Value[param1];
      }
      
      public static function isDiagonal(param1:String) : Boolean
      {
         return diagonals.indexOf(param1) > -1;
      }
      
      public static function sign(param1:Number) : int
      {
         return param1 > 0 ? 1 : (param1 < 0 ? -1 : 0);
      }
   }
}

