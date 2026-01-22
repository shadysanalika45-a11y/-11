package de.polygonal.ds
{
   public class ArrayedQueueIterator implements Itr
   {
      
      public var _size:int;
      
      public var _i:int;
      
      public var _front:int;
      
      public var _f:ArrayedQueue;
      
      public var _capacity:int;
      
      public var _a:Array;
      
      public function ArrayedQueueIterator(param1:ArrayedQueue)
      {
         var _loc8_:int = 0;
         _f = param1;
         §§push(§§findproperty(_a));
         var _loc2_:Array = _f._a;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         var _loc5_:int = -1;
         if(_loc5_ == -1)
         {
            _loc5_ = int(_loc2_.length);
         }
         var _loc6_:int = 0;
         var _loc7_:int = _loc4_;
         while(_loc7_ < _loc5_)
         {
            _loc8_ = _loc7_++;
            _loc3_[_loc6_++] = _loc2_[_loc8_];
         }
         §§pop()._a = _loc3_;
         _front = _f._front;
         _capacity = _f._capacity;
         _size = _f._size;
         _i = 0;
         this;
      }
      
      public function reset() : Itr
      {
         var _loc7_:int = 0;
         §§push(§§findproperty(_a));
         var _loc1_:Array = _f._a;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         var _loc4_:int = -1;
         if(_loc4_ == -1)
         {
            _loc4_ = int(_loc1_.length);
         }
         var _loc5_:int = 0;
         var _loc6_:int = _loc3_;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc6_++;
            _loc2_[_loc5_++] = _loc1_[_loc7_];
         }
         §§pop()._a = _loc2_;
         _front = _f._front;
         _capacity = _f._capacity;
         _size = _f._size;
         _i = 0;
         return this;
      }
      
      public function remove() : void
      {
         _f.remove(_a[int((_i - 1 + _front) % _capacity)]);
      }
      
      public function next() : Object
      {
         var _temp_2:* = _a;
         var _loc1_:int;
         _i = (_loc1_ = _i) + 1;
         return _temp_2[int((_loc1_ + _front) % _capacity)];
      }
      
      public function hasNext() : Boolean
      {
         return _i < _size;
      }
      
      public function __size(param1:Object) : int
      {
         return int(param1._capacity);
      }
      
      public function __front(param1:Object) : int
      {
         return int(param1._front);
      }
      
      public function __count(param1:Object) : int
      {
         return int(param1._size);
      }
      
      public function __a(param1:Object) : Array
      {
         return param1._a;
      }
   }
}

