package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class LinkedStack implements Stack
   {
      
      public var reuseIterator:Boolean;
      
      public var maxSize:int;
      
      public var key:int;
      
      public var _top:int;
      
      public var _tailPool:LinkedStackNode;
      
      public var _reservedSize:int;
      
      public var _poolSize:int;
      
      public var _iterator:LinkedStackIterator;
      
      public var _headPool:LinkedStackNode;
      
      public var _head:LinkedStackNode;
      
      public function LinkedStack(param1:int = 0, param2:int = -1)
      {
         var _loc3_:* = null as LinkedStackNode;
         maxSize = -1;
         _reservedSize = param1;
         _top = 0;
         _poolSize = 0;
         _head = null;
         _iterator = null;
         if(param1 > 0)
         {
            _headPool = _tailPool = new LinkedStackNode(null);
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
      
      public function top() : Object
      {
         return _head.val;
      }
      
      public function toString() : String
      {
         var _loc1_:String = Sprintf.format("{LinkedStack size: %d}",[_top]);
         if(_top == 0)
         {
            return _loc1_;
         }
         _loc1_ += "\n|< top\n";
         var _loc2_:LinkedStackNode = _head;
         var _loc3_:* = _top - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ += Sprintf.format("  %d -> %s\n",[_loc3_--,hx.Std.string(_loc2_.val)]);
            _loc2_ = _loc2_.next;
         }
         return _loc1_ + ">|";
      }
      
      public function toDA() : DA
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc1_:DA = new DA(_top);
         _loc1_.fill(null,_top);
         var _loc2_:Array = [];
         var _loc3_:LinkedStackNode = _head;
         var _loc4_:int = 0;
         var _loc5_:int = _top;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc7_ = _top - _loc6_ - 1;
            _loc1_._a[_loc7_] = _loc3_.val;
            if(_loc7_ >= _loc1_._size)
            {
               ++_loc1_._size;
            }
            _loc3_ = _loc3_.next;
         }
         return _loc1_;
      }
      
      public function toArray() : Array
      {
         var _loc6_:int = 0;
         var _loc2_:Array = new Array(_top);
         var _loc1_:Array = _loc2_;
         var _loc3_:Object = null;
         var _loc4_:int = _top;
         if(_loc4_ == -1)
         {
            _loc4_ = int(_loc1_.length);
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc5_++;
            _loc1_[_loc6_] = _loc3_;
         }
         var _loc7_:LinkedStackNode = _head;
         _loc4_ = 0;
         _loc5_ = _top;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc1_[_top - _loc6_ - 1] = _loc7_.val;
            _loc7_ = _loc7_.next;
         }
         return _loc1_;
      }
      
      public function swp(param1:int, param2:int) : void
      {
         var _loc3_:LinkedStackNode = _head;
         if(param1 < param2)
         {
            param1 ^= param2;
            param2 ^= param1;
            param1 ^= param2;
         }
         var _loc4_:* = _top - 1;
         while(_loc4_ > param1)
         {
            _loc3_ = _loc3_.next;
            _loc4_--;
         }
         var _loc5_:LinkedStackNode = _loc3_;
         while(_loc4_ > param2)
         {
            _loc3_ = _loc3_.next;
            _loc4_--;
         }
         var _loc6_:Object = _loc5_.val;
         _loc5_.val = _loc3_.val;
         _loc3_.val = _loc6_;
      }
      
      public function size() : int
      {
         return _top;
      }
      
      public function shuffle(param1:DA = undefined) : void
      {
         var _loc3_:* = null as Class;
         var _loc4_:int = 0;
         var _loc5_:* = null as LinkedStackNode;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Object;
         var _loc9_:* = null as LinkedStackNode;
         var _loc10_:int = 0;
         var _loc2_:int = _top;
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
      
      public function _SafeStr_1(param1:int, param2:Object) : void
      {
         var _loc3_:LinkedStackNode = _head;
         param1 = _top - param1;
         while(--param1 > 0)
         {
            _loc3_ = _loc3_.next;
         }
         _loc3_.val = param2;
      }
      
      public function rotRight(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:LinkedStackNode = _head;
         var _loc3_:int = 0;
         var _loc4_:* = param1 - 2;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc2_ = _loc2_.next;
         }
         var _loc6_:LinkedStackNode = _loc2_.next;
         _loc2_.next = _loc6_.next;
         _loc6_.next = _head;
         _head = _loc6_;
      }
      
      public function rotLeft(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc2_:LinkedStackNode = _head;
         _head = _head.next;
         var _loc3_:LinkedStackNode = _head;
         var _loc4_:int = 0;
         var _loc5_:* = param1 - 2;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc3_ = _loc3_.next;
         }
         _loc2_.next = _loc3_.next;
         _loc3_.next = _loc2_;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc6_:* = null as LinkedStackNode;
         var _loc7_:* = null as Object;
         var _loc8_:* = null as LinkedStackNode;
         var _loc9_:* = null as LinkedStackNode;
         var _loc2_:Object = param1;
         if(_top == 0)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         var _loc4_:LinkedStackNode = _head;
         var _loc5_:LinkedStackNode = _head.next;
         while(_loc5_ != null)
         {
            if(_loc5_.val == _loc2_)
            {
               _loc3_ = true;
               _loc6_ = _loc5_.next;
               _loc4_.next = _loc6_;
               _loc7_ = _loc5_.val;
               if(_reservedSize > 0 && _poolSize < _reservedSize)
               {
                  _tailPool = _tailPool.next = _loc5_;
                  _loc5_.next = null;
                  _loc5_.val = null;
                  ++_poolSize;
               }
               _loc7_;
               _loc5_ = _loc6_;
               --_top;
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
               _loc8_.next = null;
               _loc8_.val = null;
               ++_poolSize;
            }
            _loc7_;
            _head = _loc6_;
            --_top;
         }
         return _loc3_;
      }
      
      public function push(param1:Object) : void
      {
         var _loc4_:* = null as LinkedStackNode;
         var _loc2_:Object = param1;
         var _loc3_:LinkedStackNode = _reservedSize == 0 || _poolSize == 0 ? new LinkedStackNode(_loc2_) : (_loc4_ = _headPool,_headPool = _headPool.next,--_poolSize,_loc4_.val = _loc2_,_loc4_);
         _loc3_.next = _head;
         _head = _loc3_;
         ++_top;
      }
      
      public function pop() : Object
      {
         var _loc3_:* = null as LinkedStackNode;
         --_top;
         var _loc1_:LinkedStackNode = _head;
         _head = _head.next;
         var _loc2_:Object = _loc1_.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = _loc1_;
            _loc1_.next = null;
            _loc1_.val = null;
            ++_poolSize;
         }
         return _loc2_;
      }
      
      public function iterator() : Itr
      {
         var _loc1_:* = null as LinkedStackIterator;
         if(reuseIterator)
         {
            if(_iterator == null)
            {
               return new LinkedStackIterator(this);
            }
            _loc1_ = _iterator;
            _loc1_._walker = _loc1_._f._head;
            _loc1_._hook = null;
            _loc1_;
            return _iterator;
         }
         return new LinkedStackIterator(this);
      }
      
      public function isEmpty() : Boolean
      {
         return _top == 0;
      }
      
      public function _SafeStr_2(param1:int) : Object
      {
         var _loc2_:LinkedStackNode = _head;
         param1 = _top - param1;
         while(--param1 > 0)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_.val;
      }
      
      public function free() : void
      {
         var _loc2_:* = null as LinkedStackNode;
         var _loc3_:* = null as LinkedStackNode;
         var _loc1_:LinkedStackNode = _head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.next;
            _loc1_.next = null;
            _loc1_.val = null;
            _loc1_ = _loc2_;
         }
         _head = null;
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
            param2 = _top;
         }
         var _loc3_:LinkedStackNode = _head;
         var _loc4_:int = 0;
         while(_loc4_ < param2)
         {
            _loc5_ = _loc4_++;
            _loc3_.val = param1;
            _loc3_ = _loc3_.next;
         }
      }
      
      public function exchange() : void
      {
         var _loc1_:Object = _head.val;
         _head.val = _head.next.val;
         _head.next.val = _loc1_;
      }
      
      public function dup() : void
      {
         var _loc3_:* = null as LinkedStackNode;
         var _loc2_:Object = _head.val;
         var _loc1_:LinkedStackNode = _reservedSize == 0 || _poolSize == 0 ? new LinkedStackNode(_loc2_) : (_loc3_ = _headPool,_headPool = _headPool.next,--_poolSize,_loc3_.val = _loc2_,_loc3_);
         _loc1_.next = _head;
         _head = _loc1_;
         ++_top;
      }
      
      public function cpy(param1:int, param2:int) : void
      {
         var _loc3_:LinkedStackNode = _head;
         if(param1 < param2)
         {
            param1 ^= param2;
            param2 ^= param1;
            param1 ^= param2;
         }
         var _loc4_:* = _top - 1;
         while(_loc4_ > param1)
         {
            _loc3_ = _loc3_.next;
            _loc4_--;
         }
         var _loc5_:Object = _loc3_.val;
         while(_loc4_ > param2)
         {
            _loc3_ = _loc3_.next;
            _loc4_--;
         }
         _loc3_.val = _loc5_;
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc2_:Object = param1;
         var _loc3_:LinkedStackNode = _head;
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
         var _loc6_:* = null as LinkedStackNode;
         var _loc7_:* = null as LinkedStackNode;
         var _loc8_:* = null as LinkedStackNode;
         var _loc9_:* = null as Cloneable;
         var _loc3_:Function = param2;
         var _loc4_:LinkedStack = new LinkedStack(_reservedSize,maxSize);
         if(_top == 0)
         {
            return _loc4_;
         }
         var _loc5_:LinkedStack = new LinkedStack(_reservedSize,maxSize);
         _loc5_._top = _top;
         if(param1)
         {
            _loc6_ = _head;
            _loc7_ = _loc5_._head = new LinkedStackNode(_loc6_.val);
            _loc6_ = _loc6_.next;
            while(_loc6_ != null)
            {
               _loc7_ = _loc7_.next = new LinkedStackNode(_loc6_.val);
               _loc6_ = _loc6_.next;
            }
         }
         else if(_loc3_ == null)
         {
            _loc6_ = _head;
            _loc9_ = _loc6_.val;
            _loc7_ = _loc5_._head = new LinkedStackNode(_loc9_.clone());
            _loc6_ = _loc6_.next;
            while(_loc6_ != null)
            {
               _loc9_ = _loc6_.val;
               _loc7_ = _loc7_.next = new LinkedStackNode(_loc9_.clone());
               _loc6_ = _loc6_.next;
            }
         }
         else
         {
            _loc6_ = _head;
            _loc7_ = _loc5_._head = new LinkedStackNode(_loc3_(_loc6_.val));
            _loc6_ = _loc6_.next;
            while(_loc6_ != null)
            {
               _loc7_ = _loc7_.next = new LinkedStackNode(_loc3_(_loc6_.val));
               _loc6_ = _loc6_.next;
            }
         }
         return _loc5_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc2_:* = null as LinkedStackNode;
         var _loc3_:* = null as LinkedStackNode;
         var _loc4_:* = null as Object;
         var _loc5_:* = null as LinkedStackNode;
         if(_top == 0)
         {
            return;
         }
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
                  _loc2_.next = null;
                  _loc2_.val = null;
                  ++_poolSize;
               }
               _loc4_;
               _loc2_ = _loc3_;
            }
         }
         _head.next = null;
         _head.val = null;
         _top = 0;
      }
      
      public function assign(param1:Class, param2:Array = undefined, param3:int = 0) : void
      {
         var _loc6_:int = 0;
         if(param3 <= 0)
         {
            param3 = _top;
         }
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc4_:LinkedStackNode = _head;
         var _loc5_:int = 0;
         while(_loc5_ < param3)
         {
            _loc6_ = _loc5_++;
            _loc4_.val = hx.Type.createInstance(param1,param2);
            _loc4_ = _loc4_.next;
         }
      }
      
      public function _removeNode(param1:LinkedStackNode) : void
      {
         var _loc4_:* = null as LinkedStackNode;
         var _loc2_:LinkedStackNode = _head;
         if(param1 == _loc2_)
         {
            _head = param1.next;
         }
         else
         {
            while(_loc2_.next != param1)
            {
               _loc2_ = _loc2_.next;
            }
            _loc2_.next = param1.next;
         }
         var _loc3_:Object = param1.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = param1;
            param1.next = null;
            param1.val = null;
            ++_poolSize;
         }
         _loc3_;
         --_top;
      }
      
      public function _putNode(param1:LinkedStackNode) : Object
      {
         var _loc3_:* = null as LinkedStackNode;
         var _loc2_:Object = param1.val;
         if(_reservedSize > 0 && _poolSize < _reservedSize)
         {
            _tailPool = _tailPool.next = param1;
            param1.next = null;
            param1.val = null;
            ++_poolSize;
         }
         return _loc2_;
      }
      
      public function _getNode(param1:Object) : LinkedStackNode
      {
         var _loc2_:* = null as LinkedStackNode;
         if(_reservedSize == 0 || _poolSize == 0)
         {
            return new LinkedStackNode(param1);
         }
         _loc2_ = _headPool;
         _headPool = _headPool.next;
         --_poolSize;
         _loc2_.val = param1;
         return _loc2_;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
