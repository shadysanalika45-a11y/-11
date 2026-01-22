package de.polygonal.ds
{
   public class DAIterator implements Itr
   {
      
      public var _s:int;
      
      public var _i:int = 0;
      
      public var _f:DA;
      
      public var _a:Array = _f._a;
      
      public function DAIterator(param1:DA)
      {
         _f = param1;
         _s = _f._size;
         this;
      }
      
      public function reset() : Itr
      {
         _a = _f._a;
         _s = _f._size;
         _i = 0;
         return this;
      }
      
      public function remove() : void
      {
         var _loc1_:DA = _f;
         var _loc2_:int = _i = _i - 1;
         var _loc4_:Object = _loc1_._a[_loc2_];
         var _loc3_:* = _loc1_._size - 1;
         var _loc5_:int = _loc2_;
         while(_loc5_ < _loc3_)
         {
            _loc1_._a[_loc5_++] = _loc1_._a[_loc5_];
         }
         --_loc1_._size;
         _loc4_;
         --_s;
      }
      
      public function next() : Object
      {
         var _temp_2:* = _a;
         var _loc1_:int;
         _i = (_loc1_ = _i) + 1;
         return _temp_2[_loc1_];
      }
      
      public function hasNext() : Boolean
      {
         return _i < _s;
      }
      
      public function __size(param1:Object) : int
      {
         return int(param1._size);
      }
      
      public function __a(param1:Object) : Array
      {
         return param1._a;
      }
   }
}

