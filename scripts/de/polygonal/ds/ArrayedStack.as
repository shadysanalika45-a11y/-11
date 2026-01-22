package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class ArrayedStack implements Stack
   {
      
      public var reuseIterator:Boolean;
      
      public var maxSize:int;
      
      public var key:int;
      
      public var _top:int;
      
      public var _iterator:ArrayedStackIterator;
      
      public var _a:Array;
      
      public function ArrayedStack(param1:int = 0, param2:int = -1)
      {
         var _loc3_:* = null as Array;
         if(param1 > 0)
         {
            _a = new Array(param1);
         }
         else
         {
            _a = [];
         }
         _top = 0;
         _iterator = null;
         var _temp_3:* = §§findproperty(key);
         var _temp_1:* = HashKey;
         var _loc4_:int;
         _temp_1._counter = (_loc4_ = int(_temp_1._counter)) + 1;
         key = _loc4_;
         reuseIterator = false;
         maxSize = -1;
      }
      
      public function walk(param1:Function) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = _top;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _a[_loc4_] = param1(_a[_loc4_],_loc4_);
         }
      }
      
      public function top() : Object
      {
         return _a[_top - 1];
      }
      
      public function toString() : String
      {
         var _loc1_:String = Sprintf.format("{ArrayedStack, size: %d}",[_top]);
         if(_top == 0)
         {
            return _loc1_;
         }
         _loc1_ += "\n|< top\n";
         var _loc2_:* = _top - 1;
         var _loc3_:* = _top - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ += Sprintf.format("  %4d -> %s\n",[_loc3_--,hx.Std.string(_a[_loc2_--])]);
         }
         return _loc1_ + ">|";
      }
      
      public function toDA() : DA
      {
         var _loc3_:int = 0;
         var _loc1_:DA = new DA(_top);
         var _loc2_:int = _top;
         while(_loc2_ > 0)
         {
            _loc3_ = _loc1_._size;
            _loc1_._a[_loc3_] = _a[--_loc2_];
            if(_loc3_ >= _loc1_._size)
            {
               ++_loc1_._size;
            }
         }
         return _loc1_;
      }
      
      public function toArray() : Array
      {
         var _loc2_:Array = new Array(_top);
         var _loc1_:Array = _loc2_;
         var _loc3_:int = _top;
         var _loc4_:int = 0;
         while(_loc3_ > 0)
         {
            _loc1_[_loc4_++] = _a[--_loc3_];
         }
         return _loc1_;
      }
      
      public function swp(param1:int, param2:int) : void
      {
         var _loc3_:Object = _a[param1];
         _a[param1] = _a[param2];
         _a[param2] = _loc3_;
      }
      
      public function size() : int
      {
         return _top;
      }
      
      public function shuffle(param1:DA = undefined) : void
      {
         var _loc3_:* = null as Class;
         var _loc4_:int = 0;
         var _loc5_:* = null as Object;
         var _loc6_:int = 0;
         var _loc2_:int = _top;
         if(param1 == null)
         {
            _loc3_ = Math;
            while(_loc2_ > 1)
            {
               _loc4_ = Number(_loc3_.random()) * --_loc2_;
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
               _loc6_ = Number(param1._a[_loc4_++]) * --_loc2_;
               _loc5_ = _a[_loc2_];
               _a[_loc2_] = _a[_loc6_];
               _a[_loc6_] = _loc5_;
            }
         }
      }
      
      public function _SafeStr_1(param1:int, param2:Object) : void
      {
         _a[param1] = param2;
      }
      
      public function rotRight(param1:int) : void
      {
         var _loc2_:* = _top - param1;
         var _loc3_:* = _top - 1;
         var _loc4_:Object = _a[_loc2_];
         while(_loc2_ < _loc3_)
         {
            _a[_loc2_] = _a[_loc2_ + 1];
            _loc2_++;
         }
         _a[_top - 1] = _loc4_;
      }
      
      public function rotLeft(param1:int) : void
      {
         var _loc2_:* = _top - 1;
         var _loc3_:* = _top - param1;
         var _loc4_:Object = _a[_loc2_];
         while(_loc2_ > _loc3_)
         {
            _a[_loc2_] = _a[_loc2_ - 1];
            _loc2_--;
         }
         _a[_top - param1] = _loc4_;
      }
      
      public function reserve(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(_top == param1)
         {
            return;
         }
         var _loc2_:Array = _a;
         _a = new Array(param1);
         if(_top < param1)
         {
            _loc4_ = 0;
            _loc5_ = _top;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = _loc4_++;
               _a[_loc6_] = _loc2_[_loc6_];
            }
         }
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Object = param1;
         if(_top == 0)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         while(_top > 0)
         {
            _loc3_ = false;
            _loc4_ = 0;
            _loc5_ = _top;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = _loc4_++;
               if(_a[_loc6_] == _loc2_)
               {
                  _loc7_ = _top - 1;
                  _loc8_ = _loc6_;
                  while(_loc8_ < _loc7_)
                  {
                     _a[_loc8_++] = _a[_loc8_];
                  }
                  _a[_top = _top - 1] = null;
                  _loc3_ = true;
                  break;
               }
            }
            if(!_loc3_)
            {
               break;
            }
         }
         return _loc3_;
      }
      
      public function push(param1:Object) : void
      {
         var _loc2_:Object = param1;
         var _temp_2:* = _a;
         var _loc3_:int;
         _top = (_loc3_ = _top) + 1;
         _temp_2[_loc3_] = _loc2_;
      }
      
      public function pop() : Object
      {
         return _a[_top = _top - 1];
      }
      
      public function pack() : void
      {
         var _loc5_:int = 0;
         if(int(_a.length) == _top)
         {
            return;
         }
         var _loc1_:Array = _a;
         _a = new Array(_top);
         var _loc3_:int = 0;
         var _loc4_:int = _top;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _a[_loc5_] = _loc1_[_loc5_];
         }
         _loc3_ = _top;
         _loc4_ = int(_loc1_.length);
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc1_[_loc5_] = null;
         }
      }
      
      public function iterator() : Itr
      {
         var _loc1_:* = null as ArrayedStackIterator;
         if(reuseIterator)
         {
            if(_iterator == null)
            {
               _iterator = new ArrayedStackIterator(this);
            }
            else
            {
               _loc1_ = _iterator;
               _loc1_._a = _loc1_._f._a;
               _loc1_._i = _loc1_._f._top - 1;
               _loc1_;
            }
            return _iterator;
         }
         return new ArrayedStackIterator(this);
      }
      
      public function isEmpty() : Boolean
      {
         return _top == 0;
      }
      
      public function _SafeStr_2(param1:int) : Object
      {
         return _a[param1];
      }
      
      public function free() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = int(_a.length);
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
         var _loc4_:int = 0;
         if(param2 <= 0)
         {
            param2 = _top;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = _loc3_++;
            _a[_loc4_] = param1;
         }
         _top = param2;
      }
      
      public function exchange() : void
      {
         var _loc1_:* = _top - 1;
         var _loc2_:* = _loc1_ - 1;
         var _loc3_:Object = _a[_loc1_];
         _a[_loc1_] = _a[_loc2_];
         _a[_loc2_] = _loc3_;
      }
      
      public function dup() : void
      {
         _a[_top] = _a[_top - 1];
         ++_top;
      }
      
      public function dispose() : void
      {
         _a[_top] = null;
      }
      
      public function cpy(param1:int, param2:int) : void
      {
         _a[param1] = _a[param2];
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:int = 0;
         var _loc4_:int = _top;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            if(_a[_loc5_] == _loc2_)
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
         var _loc4_:ArrayedStack = new ArrayedStack(_top,maxSize);
         if(_top == 0)
         {
            return _loc4_;
         }
         var _loc5_:Array = _loc4_._a;
         if(param1)
         {
            _loc6_ = 0;
            _loc7_ = _top;
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
            _loc7_ = _top;
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
            _loc7_ = _top;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _loc5_[_loc8_] = _loc3_(_a[_loc8_]);
            }
         }
         _loc4_._top = _top;
         return _loc4_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc2_ = 0;
            _loc3_ = int(_a.length);
            while(_loc2_ < _loc3_)
            {
               _loc4_ = _loc2_++;
               _a[_loc4_] = null;
            }
         }
         _top = 0;
      }
      
      public function assign(param1:Class, param2:Array = undefined, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         if(param3 <= 0)
         {
            param3 = _top;
         }
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc4_:int = 0;
         while(_loc4_ < param3)
         {
            _loc5_ = _loc4_++;
            _a[_loc5_] = hx.Type.createInstance(param1,param2);
         }
         _top = param3;
      }
      
      public function __set(param1:int, param2:Object) : void
      {
         _a[param1] = param2;
      }
      
      public function __get(param1:int) : Object
      {
         return _a[param1];
      }
      
      public function __cpy(param1:int, param2:int) : void
      {
         _a[param1] = _a[param2];
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
