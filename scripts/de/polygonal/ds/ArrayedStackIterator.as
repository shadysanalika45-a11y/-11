package de.polygonal.ds
{
   public class ArrayedStackIterator implements Itr
   {
      
      public var _i:int;
      
      public var _f:ArrayedStack;
      
      public var _a:Array = _f._a;
      
      public function ArrayedStackIterator(param1:ArrayedStack)
      {
         _f = param1;
         _i = _f._top - 1;
         this;
      }
      
      public function reset() : Itr
      {
         _a = _f._a;
         _i = _f._top - 1;
         return this;
      }
      
      public function remove() : void
      {
         var _loc1_:* = _i + 1;
         var _loc2_:* = _f._top - 1;
         if(_loc1_ == _loc2_)
         {
            _f._top = _loc2_;
         }
         else
         {
            while(_loc1_ < _loc2_)
            {
               _a[_loc1_++] = _a[_loc1_];
            }
            _f._top = _loc2_;
         }
      }
      
      public function next() : Object
      {
         var _temp_2:* = _a;
         var _loc1_:int;
         _i = (_loc1_ = _i) - 1;
         return _temp_2[_loc1_];
      }
      
      public function hasNext() : Boolean
      {
         return _i >= 0;
      }
      
      public function __setTop(param1:Object, param2:int) : int
      {
         return param1._top = param2;
      }
      
      public function __getTop(param1:Object) : int
      {
         return int(param1._top);
      }
      
      public function __a(param1:Object) : Array
      {
         return param1._a;
      }
   }
}

