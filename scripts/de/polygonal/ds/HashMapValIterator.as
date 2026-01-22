package de.polygonal.ds
{
   import flash.utils.Dictionary;
   
   public class HashMapValIterator implements Itr
   {
      
      public var _s:int;
      
      public var _map:Dictionary;
      
      public var _keys:Array;
      
      public var _i:int;
      
      public var _f:HashMap;
      
      public function HashMapValIterator(param1:HashMap)
      {
         _f = param1;
         _map = _f._map;
         §§push(§§findproperty(_keys));
         var _loc3_:* = 0;
         var _loc2_:Array = [];
         var _loc4_:* = _map;
         for(_loc3_ in _loc4_)
         {
            _loc2_.push(_loc3_);
         }
         §§pop()._keys = _loc2_;
         _i = 0;
         _s = int(_keys.length);
         this;
      }
      
      public function reset() : Itr
      {
         _map = _f._map;
         §§push(§§findproperty(_keys));
         var _loc2_:* = 0;
         var _loc1_:Array = [];
         var _loc3_:* = _map;
         for(_loc2_ in _loc3_)
         {
            _loc1_.push(_loc2_);
         }
         §§pop()._keys = _loc1_;
         _i = 0;
         _s = int(_keys.length);
         return this;
      }
      
      public function remove() : void
      {
         _f.remove(_map[_keys[_i - 1]]);
      }
      
      public function next() : Object
      {
         var _temp_3:* = _map;
         var _temp_2:* = _keys;
         var _loc1_:int;
         _i = (_loc1_ = _i) + 1;
         return _temp_3[_temp_2[_loc1_]];
      }
      
      public function hasNext() : Boolean
      {
         return _i < _s;
      }
      
      public function __map(param1:Object) : Dictionary
      {
         return param1._map;
      }
   }
}

