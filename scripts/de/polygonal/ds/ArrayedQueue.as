package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class ArrayedQueue implements Queue
   {
      
      public var reuseIterator:Boolean;
      
      public var maxSize:int = -1;
      
      public var key:int;
      
      public var _sizeLevel:int = 0;
      
      public var _size:int = _front = 0;
      
      public var _iterator:ArrayedQueueIterator = null;
      
      public var _isResizable:Boolean;
      
      public var _front:int;
      
      public var _capacity:int;
      
      public var _a:Array = _loc5_ = new Array(_capacity);
      
      public function ArrayedQueue(param1:int, param2:Boolean = true, param3:int = -1)
      {
         _capacity = param1;
         _isResizable = param2;
         var _temp_4:* = §§findproperty(key);
         var _temp_2:* = HashKey;
         var _loc4_:int;
         _temp_2._counter = (_loc4_ = int(_temp_2._counter)) + 1;
         key = _loc4_;
         reuseIterator = false;
      }
      
      public function walk(param1:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = _capacity;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = (_loc4_ + _front) % _capacity;
            _a[_loc5_] = param1(_a[_loc5_],_loc4_);
         }
      }
      
      public function toString() : String
      {
         var _loc4_:int = 0;
         var _loc1_:String = Sprintf.format("{ArrayedQueue, size/capacity: %d/%d}",[_size,_capacity]);
         if(_size == 0)
         {
            return _loc1_;
         }
         _loc1_ += "\n|< front\n";
         var _loc2_:int = 0;
         var _loc3_:int = _size;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc1_ += Sprintf.format("  %4d -> %s\n",[_loc4_,hx.Std.string(_a[int((_loc4_ + _front) % _capacity)])]);
         }
         return _loc1_ + ">|";
      }
      
      public function toDA() : DA
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:DA = new DA(_size);
         var _loc2_:int = 0;
         var _loc3_:int = _size;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = _loc1_._size;
            _loc1_._a[_loc5_] = _a[int((_loc4_ + _front) % _capacity)];
            if(_loc5_ >= _loc1_._size)
            {
               ++_loc1_._size;
            }
         }
         return _loc1_;
      }
      
      public function toArray() : Array
      {
         var _loc5_:int = 0;
         var _loc2_:Array = new Array(_size);
         var _loc1_:Array = _loc2_;
         var _loc3_:int = 0;
         var _loc4_:int = _size;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc1_[_loc5_] = _a[int((_loc5_ + _front) % _capacity)];
         }
         return _loc1_;
      }
      
      public function swp(param1:int, param2:int) : void
      {
         var _loc3_:Object = _a[int((param1 + _front) % _capacity)];
         _a[int((param1 + _front) % _capacity)] = _a[int((param2 + _front) % _capacity)];
         _a[int((param2 + _front) % _capacity)] = _loc3_;
      }
      
      public function size() : int
      {
         return _size;
      }
      
      public function shuffle(param1:DA = undefined) : void
      {
         var _loc3_:* = null as Class;
         var _loc4_:int = 0;
         var _loc5_:* = null as Object;
         var _loc6_:int = 0;
         var _loc2_:int = _size;
         if(param1 == null)
         {
            _loc3_ = Math;
            while(_loc2_ > 1)
            {
               _loc4_ = (int(Number((--_loc3_).random()) * _loc2_) + _front) % _capacity;
               _loc5_ = _a[_loc2_];
               _a[_loc2_] = _a[_loc4_];
               _a[_loc4_] = _loc5_;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc2_ > 1)
            {
               _loc6_ = (int(Number((--param1)._a[_loc4_++]) * _loc2_) + _front) % _capacity;
               _loc5_ = _a[_loc2_];
               _a[_loc2_] = _a[_loc6_];
               _a[_loc6_] = _loc5_;
            }
         }
      }
      
      public function _SafeStr_1(param1:int, param2:Object) : void
      {
         _a[int((param1 + _front) % _capacity)] = param2;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null as Array;
         var _loc13_:* = null as Array;
         var _loc2_:Object = param1;
         if(_size == 0)
         {
            return false;
         }
         var _loc3_:int = _size;
         var _loc4_:Boolean = false;
         while(_size > 0)
         {
            _loc4_ = false;
            _loc5_ = 0;
            _loc6_ = _size;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               if(_a[int((_loc7_ + _front) % _capacity)] == _loc2_)
               {
                  _loc4_ = true;
                  _a[int((_loc7_ + _front) % _capacity)] = null;
                  if(_loc7_ == 0)
                  {
                     if((_front = _front + 1) == _capacity)
                     {
                        _front = 0;
                     }
                     --_size;
                     break;
                  }
                  if(_loc7_ == _size - 1)
                  {
                     --_size;
                     break;
                  }
                  _loc8_ = _front + _loc7_;
                  _loc9_ = _front + _size - 1;
                  _loc10_ = _loc8_;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc10_++;
                     _a[int(_loc11_ % _capacity)] = _a[int((_loc11_ + 1) % _capacity)];
                  }
                  _a[int(_loc9_ % _capacity)] = null;
                  --_size;
                  break;
               }
            }
            if(!_loc4_)
            {
               break;
            }
         }
         if(_isResizable && _size < _loc3_)
         {
            if(_sizeLevel > 0 && _capacity > 2)
            {
               _loc5_ = _capacity;
               while(_size <= _loc5_ >> 2)
               {
                  _loc5_ >>= 2;
                  --_sizeLevel;
               }
               _loc12_ = _loc13_ = new Array(_loc5_);
               _loc6_ = 0;
               _loc7_ = _size;
               while(_loc6_ < _loc7_)
               {
                  _loc8_ = _loc6_++;
                  var _temp_6:* = _loc12_;
                  var _temp_5:* = _loc8_;
                  var _temp_4:* = _a;
                  _front = (_loc9_ = _front) + 1;
                  _temp_6[_temp_5] = _temp_4[_loc9_];
                  if(_front == _capacity)
                  {
                     _front = 0;
                  }
               }
               _a = _loc12_;
               _front = 0;
               _capacity = _loc5_;
            }
         }
         return _size < _loc3_;
      }
      
      public function peek() : Object
      {
         return _a[_front];
      }
      
      public function pack() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = _front + _size;
         var _loc2_:int = 0;
         var _loc3_:* = _capacity - _size;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _a[int((_loc4_ + _loc1_) % _capacity)] = null;
         }
      }
      
      public function iterator() : Itr
      {
         var _loc1_:* = null as ArrayedQueueIterator;
         var _loc2_:* = null as Array;
         var _loc3_:* = null as Array;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(reuseIterator)
         {
            if(_iterator == null)
            {
               _iterator = new ArrayedQueueIterator(this);
            }
            else
            {
               _loc1_ = _iterator;
               §§push(_loc1_);
               _loc2_ = _loc1_._f._a;
               _loc3_ = [];
               _loc4_ = 0;
               _loc5_ = -1;
               if(_loc5_ == -1)
               {
                  _loc5_ = int(_loc2_.length);
               }
               _loc6_ = 0;
               _loc7_ = _loc4_;
               while(_loc7_ < _loc5_)
               {
                  _loc8_ = _loc7_++;
                  _loc3_[_loc6_++] = _loc2_[_loc8_];
               }
               §§pop()._a = _loc3_;
               _loc1_._front = _loc1_._f._front;
               _loc1_._capacity = _loc1_._f._capacity;
               _loc1_._size = _loc1_._f._size;
               _loc1_._i = 0;
               _loc1_;
            }
            return _iterator;
         }
         return new ArrayedQueueIterator(this);
      }
      
      public function isFull() : Boolean
      {
         return _size == _capacity;
      }
      
      public function isEmpty() : Boolean
      {
         return _size == 0;
      }
      
      public function getCapacity() : int
      {
         return _capacity;
      }
      
      public function _SafeStr_2(param1:int) : Object
      {
         return _a[int((param1 + _front) % _capacity)];
      }
      
      public function free() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = _capacity;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_++;
            _a[_loc3_] = null;
         }
         _a = null;
         _iterator = null;
      }
      
      public function fill(param1:Object, param2:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = param2 > 0 ? param2 : _capacity;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc4_++;
            _a[int((_loc5_ + _front) % _capacity)] = param1;
         }
         _size = _loc3_;
      }
      
      public function enqueue(param1:Object) : void
      {
         var _loc3_:* = null as Array;
         var _loc4_:* = null as Array;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Object = param1;
         if(_capacity == _size)
         {
            if(_isResizable)
            {
               ++_sizeLevel;
               _loc3_ = _loc4_ = new Array(_capacity << 1);
               _loc5_ = 0;
               _loc6_ = _size;
               while(_loc5_ < _loc6_)
               {
                  _loc7_ = _loc5_++;
                  var _temp_5:* = _loc3_;
                  var _temp_4:* = _loc7_;
                  var _temp_3:* = _a;
                  _front = (_loc8_ = _front) + 1;
                  _temp_5[_temp_4] = _temp_3[_loc8_];
                  if(_front == _capacity)
                  {
                     _front = 0;
                  }
               }
               _a = _loc3_;
               _front = 0;
               _capacity <<= 1;
            }
         }
         var _temp_7:* = _a;
         _size = (_loc5_ = _size) + 1;
         _temp_7[int((_loc5_ + _front) % _capacity)] = _loc2_;
      }
      
      public function dispose() : void
      {
         _a[(_front == 0 ? _capacity : _front) - 1] = null;
      }
      
      public function dequeue() : Object
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Array;
         var _loc4_:* = null as Array;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _temp_2:* = _a;
         _front = (_loc2_ = _front) + 1;
         var _loc1_:Object = _temp_2[_loc2_];
         if(_front == _capacity)
         {
            _front = 0;
         }
         --_size;
         if(_isResizable && _sizeLevel > 0)
         {
            if(_size == _capacity >> 2)
            {
               --_sizeLevel;
               _loc3_ = _loc4_ = new Array(_capacity >> 2);
               _loc2_ = 0;
               _loc5_ = _size;
               while(_loc2_ < _loc5_)
               {
                  _loc6_ = _loc2_++;
                  var _temp_7:* = _loc3_;
                  var _temp_6:* = _loc6_;
                  var _temp_5:* = _a;
                  _front = (_loc7_ = _front) + 1;
                  _temp_7[_temp_6] = _temp_5[_loc7_];
                  if(_front == _capacity)
                  {
                     _front = 0;
                  }
               }
               _a = _loc3_;
               _front = 0;
               _capacity >>= 2;
            }
         }
         return _loc1_;
      }
      
      public function cpy(param1:int, param2:int) : void
      {
         _a[int((param1 + _front) % _capacity)] = _a[int((param2 + _front) % _capacity)];
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:int = 0;
         var _loc4_:int = _size;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            if(_a[int((_loc5_ + _front) % _capacity)] == _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function clone(param1:Boolean = true, param2:Function = undefined) : Collection
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as Cloneable;
         var _loc3_:Function = param2;
         var _loc4_:ArrayedQueue = new ArrayedQueue(_capacity,_isResizable,maxSize);
         _loc4_._sizeLevel = _sizeLevel;
         if(_capacity == 0)
         {
            return _loc4_;
         }
         var _loc5_:Array = _loc4_._a;
         if(param1)
         {
            _loc6_ = 0;
            _loc7_ = _size;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _loc5_[_loc8_] = _a[_loc8_];
            }
         }
         else if(_loc3_ == null)
         {
            _loc9_ = null;
            _loc6_ = 0;
            _loc7_ = _size;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _loc9_ = _a[_loc8_];
               _loc5_[_loc8_] = _loc9_.clone();
            }
         }
         else
         {
            _loc6_ = 0;
            _loc7_ = _size;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _loc5_[_loc8_] = _loc3_(_a[_loc8_]);
            }
         }
         _loc4_._front = _front;
         _loc4_._size = _size;
         return _loc4_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as Array;
         if(param1)
         {
            _loc2_ = _front;
            _loc3_ = 0;
            _loc4_ = _size;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc3_++;
               _a[int(_loc2_++ % _capacity)] = null;
            }
            if(_isResizable && _sizeLevel > 0)
            {
               _capacity >>= _sizeLevel;
               _sizeLevel = 0;
               _a = _loc6_ = new Array(_capacity);
            }
         }
         _front = _size = 0;
      }
      
      public function back() : Object
      {
         return _a[int((_size - 1 + _front) % _capacity)];
      }
      
      public function assign(param1:Class, param2:Array = undefined, param3:int = 0) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = param3 > 0 ? param3 : _capacity;
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc5_++;
            _a[int((_loc6_ + _front) % _capacity)] = hx.Type.createInstance(param1,param2);
         }
         _size = _loc4_;
      }
      
      public function _pack(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = new Array(param1);
         var _loc2_:Array = _loc3_;
         var _loc4_:int = 0;
         var _loc5_:int = _size;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            var _temp_4:* = _loc2_;
            var _temp_3:* = _loc6_;
            var _temp_2:* = _a;
            _front = (_loc7_ = _front) + 1;
            _temp_4[_temp_3] = _temp_2[_loc7_];
            if(_front == _capacity)
            {
               _front = 0;
            }
         }
         _a = _loc2_;
      }
      
      public function __set(param1:int, param2:Object) : void
      {
         _a[param1] = param2;
      }
      
      public function __get(param1:int) : Object
      {
         return _a[param1];
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
