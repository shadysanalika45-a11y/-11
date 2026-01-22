package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class LinkedQueue implements Queue
   {
      
      public var reuseIterator:Boolean;
      
      public var maxSize:int;
      
      public var key:int;
      
      public var _tailPool:LinkedQueueNode;
      
      public var _tail:LinkedQueueNode;
      
      public var _size:int;
      
      public var _reservedSize:int;
      
      public var _poolSize:int;
      
      public var _iterator:LinkedQueueIterator;
      
      public var _headPool:LinkedQueueNode;
      
      public var _head:LinkedQueueNode;
      
      public function LinkedQueue(param1:int = 0, param2:int = -1)
      {
         var _loc3_:* = null as LinkedQueueNode;
         maxSize = -1;
         _reservedSize = param1;
         _size = 0;
         _poolSize = 0;
         _iterator = null;
         _head = null;
         _tail = null;
         if(param1 > 0)
         {
            _headPool = _tailPool = new LinkedQueueNode(null);
         }
         else
         {
            _headPool = null;
            _tailPool = null;
         }
         var _temp_4:* = §§findproperty(key);
         var _temp_2:* = HashKey;
         var _loc4_:int;
         _temp_2._counter = (_loc4_ = int(_temp_2._counter)) + 1;
         key = _loc4_;
         reuseIterator = false;
      }
      
      public function toString() : String
      {
         var _loc1_:String = Sprintf.format("{LinkedQueue size: %d}",[_size]);
         if(_size == 0)
         {
            return _loc1_;
         }
         _loc1_ += "\n|<\n";
         var _loc2_:LinkedQueueNode = _head;
         var _loc3_:int = 0;
         while(_loc2_ != null)
         {
            _loc1_ += Sprintf.format("  %4d -> %s\n",[_loc3_++,hx.Std.string(_loc2_.val)]);
            _loc2_ = _loc2_.next;
         }
         return _loc1_ + ">|";
      }
      
      public function toDA() : DA
      {
         var _loc3_:int = 0;
         var _loc1_:DA = new DA(_size);
         var _loc2_:LinkedQueueNode = _head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc1_._size;
            _loc1_._a[_loc3_] = _loc2_.val;
            if(_loc3_ >= _loc1_._size)
            {
               ++_loc1_._size;
            }
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function toArray() : Array
      {
         var _loc2_:Array = new Array(_size);
         var _loc1_:Array = _loc2_;
         var _loc3_:int = 0;
         var _loc4_:LinkedQueueNode = _head;
         while(_loc4_ != null)
         {
            _loc1_[_loc3_++] = _loc4_.val;
            _loc4_ = _loc4_.next;
         }
         return _loc1_;
      }
      
      public function size() : int
      {
         return _size;
      }
      
      public function shuffle(param1:DA = undefined) : void
      {
         var _loc3_:* = null as Class;
         var _loc4_:int = 0;
         var _loc5_:* = null as LinkedQueueNode;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Object;
         var _loc9_:* = null as LinkedQueueNode;
         var _loc10_:int = 0;
         var _loc2_:int = _size;
         if(param1 == null)
         {
            _loc3_ = Math;
            while(_loc2_ > 1)
            {
               _loc4_ = Number((--_loc3_).random()) * _loc2_;
               _loc5_ = _head;
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc7_ = _loc6_++;
                  _loc5_ = _loc5_.next;
               }
               _loc8_ = _loc5_.val;
               _loc9_ = _head;
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  _loc7_ = _loc6_++;
                  _loc9_ = _loc9_.next;
               }
               _loc5_.val = _loc9_.val;
               _loc9_.val = _loc8_;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc2_ > 1)
            {
               _loc6_ = Number((--param1)._a[_loc4_++]) * _loc2_;
               _loc5_ = _head;
               _loc7_ = 0;
               while(_loc7_ < _loc2_)
               {
                  _loc10_ = _loc7_++;
                  _loc5_ = _loc5_.next;
               }
               _loc8_ = _loc5_.val;
               _loc9_ = _head;
               _loc7_ = 0;
               while(_loc7_ < _loc6_)
               {
                  _loc10_ = _loc7_++;
                  _loc9_ = _loc9_.next;
               }
               _loc5_.val = _loc9_.val;
               _loc9_.val = _loc8_;
            }
         }
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc6_:* = null as LinkedQueueNode;
         var _loc7_:* = null as Object;
         var _loc8_:* = null as LinkedQueueNode;
         var _loc9_:* = null as LinkedQueueNode;
         var _loc2_:Object = param1;
         if(_size == 0)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         var _loc4_:LinkedQueueNode = _head;
         var _loc5_:LinkedQueueNode = _head.next;
         if(_head == _tail)
         {
            if(_head.val == _loc2_)
            {
               _size = 0;
               _loc6_ = _head;
               _loc7_ = _loc6_.val;
               if(_reservedSize > 0 && _poolSize < _reservedSize)
               {
                  _tailPool = _tailPool.next = _loc6_;
                  _loc6_.val = null;
                  _loc6_.next = null;
                  ++_poolSize;
               }
               _loc7_;
               _head = null;
               _tail = null;
               return true;
            }
            return false;
         }
         while(_loc5_ != null)
         {
            if(_loc5_.val == _loc2_)
            {
               _loc3_ = true;
               if(_loc5_ == _tail)
               {
                  _tail = _loc4_;
               }
               _loc6_ = _loc5_.next;
               _loc4_.next = _loc6_;
               _loc7_ = _loc5_.val;
               if(_reservedSize > 0 && _poolSize < _reservedSize)
               {
                  _tailPool = _tailPool.next = _loc5_;
                  _loc5_.val = null;
                  _loc5_.next = null;
                  ++_poolSize;
               }
               _loc7_;
               _loc5_ = _loc6_;
               --_size;
            }
            else
            {
               _loc4_ = _loc5_;
               _loc5_ = _loc5_.next;
            }
         }
         if(_head.val == _loc2_)
         {
            _loc3_ = true;
            _loc6_ = _head.next;
            _loc8_ = _head;
            _loc7_ = _loc8_.val;
            if(_reservedSize > 0 && _poolSize < _reservedSize)
            {
               _tailPool = _tailPool.next = _loc8_;
               _loc8_.val = null;
               _loc8_.next = null;
               ++_poolSize;
            }
            _loc7_;
            _head = _loc6_;
            if(_head == null)
            {
               _tail = null;
            }
            --_size;
         }
         return _loc3_;
      }
      
      public function peek() : Object
      {
         return _head.val;
      }
      
      public function iterator() : Itr
      {
         var _loc1_:* = null as LinkedQueueIterator;
         if(reuseIterator)
         {
            if(_iterator == null)
            {
               return new LinkedQueueIterator(this);
            }
            _loc1_ = _iterator;
            _loc1_._walker = _loc1_._f._head;
            _loc1_._hook = null;
            _loc1_;
            return _iterator;
         }
         return new LinkedQueueIterator(this);
      }
      
      public function isEmpty() : Boolean
      {
         return _size == 0;
      }
      
      public function free() : void
      {
         var _loc2_:* = null as LinkedQueueNode;
         var _loc3_:* = null as LinkedQueueNode;
         var _loc1_:LinkedQueueNode = _head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.next;
            _loc1_.next = null;
            _loc1_.val = null;
            _loc1_ = _loc2_;
         }
         _head = _tail = null;
         _loc2_ = _headPool;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.next;
            _loc2_.next = null;
            _loc2_.val = null;
            _loc2_ = _loc3_;
         }
         _headPool = _tailPool = null;
         _iterator = null;
      }
      
      public function fill(param1:Object, param2:int = 0) : void
      {
         var _loc5_:int = 0;
         if(param2 <= 0)
         {
            param2 = _size;
         }
         var _loc3_:LinkedQueueNode = _head;
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = _loc4_++;
            _loc3_.val = param1;
            _loc3_ = _loc3_.next;
         }
      }
      
      public function enqueue(param1:Object) : void
      {
         var _loc4_:* = null as LinkedQueueNode;
         var _loc2_:Object = param1;
         ++_size;
         var _loc3_:LinkedQueueNode = _reservedSize == 0 || _poolSize == 0 ? new LinkedQueueNode(_loc2_) : (_loc4_ = _headPool,_headPool = _headPool.next,--_poolSize,_loc4_.val = _loc2_,_loc4_);
         if(_head == null)
         {
            _head = _tail = _loc3_;
            _head.next = null;
         }
         else
         {
            _tail.next = _loc3_;
            _tail = _loc3_;
         }
      }
      
      public function dequeue() : Object
      {
         var _loc3_:* = null as LinkedQueueNode;
         --_size;
         var _loc1_:LinkedQueueNode = _head;
         if(_head == _tail)
         {
            _head = null;
            _tail = null;
         }
         else
         {
            _head = _head.next;
         }
         var _loc2_:Object = _loc1_.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = _loc1_;
            _loc1_.val = null;
            _loc1_.next = null;
            ++_poolSize;
         }
         return _loc2_;
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc2_:Object = param1;
         var _loc3_:LinkedQueueNode = _head;
         while(_loc3_ != null)
         {
            if(_loc3_.val == _loc2_)
            {
               return true;
            }
            _loc3_ = _loc3_.next;
         }
         return false;
      }
      
      public function clone(param1:Boolean = true, param2:Function = undefined) : Collection
      {
         var _loc5_:* = null as LinkedQueueNode;
         var _loc6_:* = null as LinkedQueueNode;
         var _loc7_:* = null as LinkedQueueNode;
         var _loc8_:* = null as Cloneable;
         var _loc3_:Function = param2;
         var _loc4_:LinkedQueue = new LinkedQueue(_reservedSize,maxSize);
         if(_size == 0)
         {
            return _loc4_;
         }
         if(param1)
         {
            _loc5_ = _head;
            if(_loc5_ != null)
            {
               _loc4_._head = _loc4_._tail = new LinkedQueueNode(_loc5_.val);
               _loc4_._head.next = _loc4_._tail;
            }
            if(_size > 1)
            {
               _loc5_ = _loc5_.next;
               while(_loc5_ != null)
               {
                  _loc6_ = new LinkedQueueNode(_loc5_.val);
                  _loc4_._tail = _loc4_._tail.next = _loc6_;
                  _loc5_ = _loc5_.next;
               }
            }
         }
         else if(_loc3_ == null)
         {
            _loc5_ = _head;
            if(_loc5_ != null)
            {
               _loc8_ = _loc5_.val;
               _loc4_._head = _loc4_._tail = new LinkedQueueNode(_loc8_.clone());
               _loc4_._head.next = _loc4_._tail;
            }
            if(_size > 1)
            {
               _loc5_ = _loc5_.next;
               while(_loc5_ != null)
               {
                  _loc8_ = _loc5_.val;
                  _loc6_ = new LinkedQueueNode(_loc8_.clone());
                  _loc4_._tail = _loc4_._tail.next = _loc6_;
                  _loc5_ = _loc5_.next;
               }
            }
         }
         else
         {
            _loc5_ = _head;
            if(_loc5_ != null)
            {
               _loc4_._head = _loc4_._tail = new LinkedQueueNode(_loc3_(_loc5_.val));
               _loc4_._head.next = _loc4_._tail;
            }
            if(_size > 1)
            {
               _loc5_ = _loc5_.next;
               while(_loc5_ != null)
               {
                  _loc6_ = new LinkedQueueNode(_loc3_(_loc5_.val));
                  _loc4_._tail = _loc4_._tail.next = _loc6_;
                  _loc5_ = _loc5_.next;
               }
            }
         }
         _loc4_._size = _size;
         return _loc4_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc2_:* = null as LinkedQueueNode;
         var _loc3_:* = null as LinkedQueueNode;
         var _loc4_:* = null as Object;
         var _loc5_:* = null as LinkedQueueNode;
         if(param1 || _reservedSize > 0)
         {
            _loc2_ = _head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.next;
               _loc4_ = _loc2_.val;
               if(_reservedSize > 0 && _poolSize < _reservedSize)
               {
                  _tailPool = _tailPool.next = _loc2_;
                  _loc2_.val = null;
                  _loc2_.next = null;
                  ++_poolSize;
               }
               _loc4_;
               _loc2_ = _loc2_.next;
            }
         }
         _head = _tail = null;
         _size = 0;
      }
      
      public function back() : Object
      {
         return _tail.val;
      }
      
      public function assign(param1:Class, param2:Array = undefined, param3:int = 0) : void
      {
         var _loc6_:int = 0;
         if(param3 <= 0)
         {
            param3 = _size;
         }
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc4_:LinkedQueueNode = _head;
         var _loc5_:int = 0;
         while(_loc5_ < param3)
         {
            _loc6_ = _loc5_++;
            _loc4_.val = hx.Type.createInstance(param1,param2);
            _loc4_ = _loc4_.next;
         }
      }
      
      public function _removeNode(param1:LinkedQueueNode) : void
      {
         var _loc4_:* = null as LinkedQueueNode;
         var _loc2_:LinkedQueueNode = _head;
         if(param1 == _loc2_)
         {
            _head = param1.next;
            if(param1 == _tail)
            {
               _tail = null;
            }
         }
         else
         {
            while(_loc2_.next != param1)
            {
               _loc2_ = _loc2_.next;
            }
            if(param1 == _tail)
            {
               _tail = null;
            }
            _loc2_.next = param1.next;
         }
         var _loc3_:Object = param1.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = param1;
            param1.val = null;
            param1.next = null;
            ++_poolSize;
         }
         _loc3_;
         --_size;
      }
      
      public function _putNode(param1:LinkedQueueNode) : Object
      {
         var _loc3_:* = null as LinkedQueueNode;
         var _loc2_:Object = param1.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = param1;
            param1.val = null;
            param1.next = null;
            ++_poolSize;
         }
         return _loc2_;
      }
      
      public function _getNode(param1:Object) : LinkedQueueNode
      {
         var _loc2_:* = null as LinkedQueueNode;
         if(_reservedSize == 0 || _poolSize == 0)
         {
            return new LinkedQueueNode(param1);
         }
         _loc2_ = _headPool;
         _headPool = _headPool.next;
         --_poolSize;
         _loc2_.val = param1;
         return _loc2_;
      }
   }
}

