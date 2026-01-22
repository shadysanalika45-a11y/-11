package de.polygonal.ds
{
   public class HashKey
   {
      
      public static var _counter:int = 0;
      
      public function HashKey()
      {
      }
      
      public static function next() : int
      {
         var _temp_1:* = HashKey;
         var _loc1_:int;
         _temp_1._counter = (_loc1_ = int(_temp_1._counter)) + 1;
         return _loc1_;
      }
   }
}

