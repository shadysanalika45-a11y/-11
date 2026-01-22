package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class Array2 implements Collection
   {
      
      public var reuseIterator:Boolean;
      
      public var key:int;
      
      public var _w:int;
      
      public var _iterator:Array2Iterator = null;
      
      public var _h:int;
      
      public var _a:Array = new Array(_w * _h);
      
      public function Array2(param1:int, param2:int)
      {
         _w = param1;
         _h = param2;
         var _temp_3:* = §§findproperty(key);
         var _temp_1:* = HashKey;
         var _loc4_:int;
         _temp_1._counter = (_loc4_ = int(_temp_1._counter)) + 1;
         key = _loc4_;
         reuseIterator = false;
      }
      
      public function walk(param1:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc2_:int = 0;
         var _loc3_:int = _h;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = 0;
            _loc6_ = _w;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _loc8_ = _loc4_ * _w + _loc7_;
               _a[_loc8_] = param1(_a[_loc8_],_loc7_,_loc4_);
            }
         }
      }
      
      public function transpose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = null as Object;
         var _loc10_:* = null as Array;
         if(_w == _h)
         {
            _loc1_ = 0;
            _loc2_ = _h;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = _loc1_++;
               _loc4_ = _loc3_ + 1;
               _loc5_ = _w;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = _loc4_++;
                  _loc7_ = _loc3_ * _w + _loc6_;
                  _loc8_ = _loc6_ * _w + _loc3_;
                  _loc9_ = _a[_loc7_];
                  _a[_loc7_] = _a[_loc8_];
                  _a[_loc8_] = _loc9_;
               }
            }
         }
         else
         {
            _loc10_ = [];
            _loc1_ = 0;
            _loc2_ = _h;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = _loc1_++;
               _loc4_ = 0;
               _loc5_ = _w;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = _loc4_++;
                  _loc10_[_loc6_ * _h + _loc3_] = _a[_loc3_ * _w + _loc6_];
               }
            }
            _a = _loc10_;
            _w ^= _h;
            _h ^= _w;
            _w ^= _h;
         }
      }
      
      public function toString() : String
      {
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null as String;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         var _loc3_:* = _w * _h;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = hx.Std.string(_a[_loc4_]);
            _loc1_ = Math.max(_loc5_.length,_loc1_);
         }
         _loc5_ = Sprintf.format("{Array2, %dx%d}",[_w,_h]);
         _loc5_ = _loc5_ + "\n|<\n";
         _loc3_ = 0;
         _loc4_ = _h;
         while(_loc3_ < _loc4_)
         {
            _loc7_ = _loc3_++;
            _loc5_ += "  ";
            _loc2_ = _loc7_ * _w;
            _loc8_ = 0;
            _loc9_ = _w;
            while(_loc8_ < _loc9_)
            {
               _loc10_ = _loc8_++;
               _loc5_ += Sprintf.format("[%" + _loc1_ + "s]",[hx.Std.string(_a[_loc2_ + _loc10_])]);
            }
            _loc5_ += "\n";
         }
         return _loc5_ + ">|";
      }
      
      public function toDA() : DA
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:DA = new DA(_w * _h);
         var _loc2_:int = 0;
         var _loc3_:* = _w * _h;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc5_ = _loc1_._size;
            _loc1_._a[_loc5_] = _a[_loc4_];
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
         var _loc2_:Array = new Array(_w * _h);
         var _loc1_:Array = _loc2_;
         var _loc3_:int = 0;
         var _loc4_:* = _w * _h;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc1_[_loc5_] = _a[_loc5_];
         }
         return _loc1_;
      }
      
      public function swapRow(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Object;
         var _loc9_:* = 0;
         if(param1 != param2)
         {
            _loc3_ = _w * param1;
            _loc4_ = _w * param2;
            _loc5_ = 0;
            _loc6_ = _w;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _loc8_ = _a[_loc3_ + _loc7_];
               _loc9_ = _loc4_ + _loc7_;
               _a[_loc3_ + _loc7_] = _a[_loc9_];
               _a[_loc9_] = _loc8_;
            }
         }
      }
      
      public function swapCol(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = null as Object;
         if(param1 != param2)
         {
            _loc3_ = 0;
            _loc4_ = _h;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc3_++;
               _loc6_ = _loc5_ * _w;
               _loc7_ = _loc6_ + param1;
               _loc8_ = _loc6_ + param2;
               _loc9_ = _a[_loc7_];
               _a[_loc7_] = _a[_loc8_];
               _a[_loc8_] = _loc9_;
            }
         }
      }
      
      public function swap(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:* = param2 * _w + param1;
         var _loc6_:* = param4 * _w + param3;
         var _loc7_:Object = _a[_loc5_];
         _a[_loc5_] = _a[_loc6_];
         _a[_loc6_] = _loc7_;
      }
      
      public function size() : int
      {
         return _w * _h;
      }
      
      public function shuffle(param1:DA = undefined) : void
      {
         var _loc3_:* = null as Class;
         var _loc4_:int = 0;
         var _loc5_:* = null as Object;
         var _loc6_:int = 0;
         var _loc2_:* = _w * _h;
         if(param1 == null)
         {
            _loc3_ = Math;
            while(--_loc2_ > 1)
            {
               _loc4_ = Number(_loc3_.random()) * _loc2_;
               _loc5_ = _a[_loc2_];
               _a[_loc2_] = _a[_loc4_];
               _a[_loc4_] = _loc5_;
            }
         }
         else
         {
            _loc4_ = 0;
            while(--_loc2_ > 1)
            {
               _loc6_ = Number(param1._a[_loc4_++]) * _loc2_;
               _loc5_ = _a[_loc2_];
               _a[_loc2_] = _a[_loc6_];
               _a[_loc6_] = _loc5_;
            }
         }
      }
      
      public function shiftW() : void
      {
         var _loc1_:* = null as Object;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = _h;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc2_ = _loc5_ * _w;
            _loc1_ = _a[_loc2_];
            _loc6_ = 1;
            _loc7_ = _w;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc6_++;
               _a[_loc2_ + _loc8_ - 1] = _a[_loc2_ + _loc8_];
            }
            _a[_loc2_ + _w - 1] = _loc1_;
         }
      }
      
      public function shiftS() : void
      {
         var _loc1_:* = null as Object;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = _h - 1;
         var _loc5_:* = _loc4_ * _w;
         var _loc6_:int = 0;
         var _loc7_:int = _w;
         while(_loc6_ < _loc7_)
         {
            _loc8_ = _loc6_++;
            _loc1_ = _a[_loc5_ + _loc8_];
            _loc3_ = _loc4_;
            while(_loc3_-- > 0)
            {
               _a[(_loc3_ + 1) * _w + _loc8_] = _a[_loc3_ * _w + _loc8_];
            }
            _a[_loc8_] = _loc1_;
         }
      }
      
      public function shiftN() : void
      {
         var _loc1_:* = null as Object;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = _h - 1;
         var _loc3_:* = (_h - 1) * _w;
         var _loc4_:int = 0;
         var _loc5_:int = _w;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc1_ = _a[_loc6_];
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = _loc7_++;
               _a[_loc8_ * _w + _loc6_] = _a[(_loc8_ + 1) * _w + _loc6_];
            }
            _a[_loc3_ + _loc6_] = _loc1_;
         }
      }
      
      public function shiftE() : void
      {
         var _loc1_:* = null as Object;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = _h;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _loc3_ = _loc6_ * _w;
            _loc1_ = _a[_loc3_ + _w - 1];
            _loc2_ = _w - 1;
            while(_loc2_-- > 0)
            {
               _a[_loc3_ + _loc2_ + 1] = _a[_loc3_ + _loc2_];
            }
            _a[_loc3_] = _loc1_;
         }
      }
      
      public function setW(param1:int) : void
      {
         resize(param1,_h);
      }
      
      public function setRow(param1:int, param2:Array) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = param1 * _w;
         var _loc4_:int = 0;
         var _loc5_:int = _w;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            _a[_loc3_ + _loc6_] = param2[_loc6_];
         }
      }
      
      public function setNestedArray(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as Array;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = int(param1[0].length);
         var _loc3_:int = 0;
         var _loc4_:int = int(param1.length);
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _loc6_ = param1[_loc5_];
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc8_ = _loc7_++;
               _a[_loc5_ * _w + _loc8_] = _loc6_[_loc8_];
            }
         }
      }
      
      public function setH(param1:int) : void
      {
         resize(_w,param1);
      }
      
      public function setCol(param1:int, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = _h;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _a[_loc5_ * _w + param1] = param2[_loc5_];
         }
      }
      
      public function setAtIndex(param1:int, param2:Object) : void
      {
         _a[int(param1 / _w) * _w + int(param1 % _w)] = param2;
      }
      
      public function _SafeStr_1(param1:int, param2:int, param3:Object) : void
      {
         _a[param2 * _w + param1] = param3;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(param1 == _w && param2 == _h)
         {
            return;
         }
         var _loc3_:Array = _a;
         var _loc4_:Array;
         _a = _loc4_ = new Array(param1 * param2);
         var _loc5_:int = param1 < _w ? param1 : _w;
         var _loc6_:int = param2 < _h ? param2 : _h;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc7_++;
            _loc9_ = _loc8_ * param1;
            _loc10_ = _loc8_ * _w;
            _loc11_ = 0;
            while(_loc11_ < _loc5_)
            {
               _loc12_ = _loc11_++;
               _a[_loc9_ + _loc12_] = _loc3_[_loc10_ + _loc12_];
            }
         }
         _w = param1;
         _h = param2;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc6_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:* = _w * _h;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            if(_a[_loc6_] == _loc2_)
            {
               _a[_loc6_] = null;
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function prependRow(param1:Array) : void
      {
         ++_h;
         var _loc2_:* = _w * _h;
         while(_loc2_-- > _w)
         {
            _a[_loc2_] = _a[_loc2_ - _w];
         }
         _loc2_++;
         while(_loc2_-- > 0)
         {
            _a[_loc2_] = param1[_loc2_];
         }
      }
      
      public function prependCol(param1:Array) : void
      {
         var _loc2_:* = _w * _h;
         var _loc3_:* = _loc2_ + _h;
         var _loc4_:* = _h - 1;
         var _loc5_:int = _h;
         var _loc6_:int = 0;
         var _loc7_:int = _loc3_;
         while(_loc7_-- > 0)
         {
            if(++_loc6_ > _w)
            {
               _loc6_ = 0;
               _loc5_--;
               _a[_loc7_] = param1[_loc4_--];
            }
            else
            {
               _a[_loc7_] = _a[_loc7_ - _loc5_];
            }
         }
         ++_w;
      }
      
      public function iterator() : Itr
      {
         var _loc1_:* = null as Array2Iterator;
         var _loc2_:* = null;
         if(reuseIterator)
         {
            if(_iterator == null)
            {
               _iterator = new Array2Iterator(this);
            }
            else
            {
               _loc1_ = _iterator;
               _loc1_._a = _loc1_._f._a;
               var _temp_1:* = _loc1_;
               _loc2_ = _loc1_._f;
               _temp_1._s = int(_loc2_._w) * int(_loc2_._h);
               _loc1_._i = 0;
               _loc1_;
            }
            return _iterator;
         }
         return new Array2Iterator(this);
      }
      
      public function isEmpty() : Boolean
      {
         return false;
      }
      
      public function indexToCell(param1:int, param2:Array2Cell) : Array2Cell
      {
         param2.y = int(param1 / _w);
         param2.x = int(param1 % _w);
         return param2;
      }
      
      public function indexOf(param1:Object) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = _w * _h;
         while(_loc2_ < _loc3_)
         {
            if(_a[_loc2_] == param1)
            {
               break;
            }
            _loc2_++;
         }
         return _loc2_ == _loc3_ ? -1 : _loc2_;
      }
      
      public function inRange(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param1 < _w && param2 >= 0 && param2 < _h;
      }
      
      public function getW() : int
      {
         return _w;
      }
      
      public function getRow(param1:int, param2:Array) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:* = param1 * _w;
         var _loc4_:int = 0;
         var _loc5_:int = _w;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = _loc4_++;
            param2[_loc6_] = _a[_loc3_ + _loc6_];
         }
         return param2;
      }
      
      public function getIndex(param1:int, param2:int) : int
      {
         return param2 * _w + param1;
      }
      
      public function getH() : int
      {
         return _h;
      }
      
      public function getCol(param1:int, param2:Array) : Array
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = _h;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            param2[_loc5_] = _a[_loc5_ * _w + param1];
         }
         return param2;
      }
      
      public function getAtIndex(param1:int) : Object
      {
         return _a[int(param1 / _w) * _w + int(param1 % _w)];
      }
      
      public function getAt(param1:Array2Cell) : Object
      {
         return _a[param1.y * _w + param1.x];
      }
      
      public function getArray() : Array
      {
         return _a;
      }
      
      public function _SafeStr_2(param1:int, param2:int) : Object
      {
         return _a[param2 * _w + param1];
      }
      
      public function free() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = _w * _h;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_++;
            _a[_loc3_] = null;
         }
         _a = null;
         _iterator = null;
      }
      
      public function fill(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = _w * _h;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _a[_loc4_] = param1;
         }
      }
      
      public function copyRow(param1:int, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param1 != param2)
         {
            _loc3_ = _w * param1;
            _loc4_ = _w * param2;
            _loc5_ = 0;
            _loc6_ = _w;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _a[_loc4_ + _loc7_] = _a[_loc3_ + _loc7_];
            }
         }
      }
      
      public function copyCol(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         if(param1 != param2)
         {
            _loc3_ = 0;
            _loc4_ = _h;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc3_++;
               _loc6_ = _loc5_ * _w;
               _a[_loc6_ + param2] = _a[_loc6_ + param1];
            }
         }
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc5_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:int = 0;
         var _loc4_:* = _w * _h;
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
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Cloneable;
         var _loc9_:* = null as Object;
         var _loc3_:Function = param2;
         var _loc4_:Array2 = new Array2(_w,_h);
         if(param1)
         {
            _loc5_ = 0;
            _loc6_ = _w * _h;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _loc4_._a[_loc7_] = _a[_loc7_];
            }
         }
         else if(_loc3_ == null)
         {
            _loc8_ = null;
            _loc5_ = 0;
            _loc6_ = _w * _h;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _loc8_ = _a[_loc7_];
               _loc9_ = _loc8_.clone();
               _loc4_._a[_loc7_] = _loc9_;
            }
         }
         else
         {
            _loc5_ = 0;
            _loc6_ = _w * _h;
            while(_loc5_ < _loc6_)
            {
               _loc7_ = _loc5_++;
               _loc4_._a[_loc7_] = _loc3_(_a[_loc7_]);
            }
         }
         return _loc4_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = _w * _h;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _a[_loc4_] = null;
         }
      }
      
      public function cellToIndex(param1:Array2Cell) : int
      {
         return param1.y * _w + param1.x;
      }
      
      public function cellOf(param1:Object, param2:Array2Cell) : Array2Cell
      {
         var _loc4_:int = 0;
         var _loc5_:* = _w * _h;
         while(_loc4_ < _loc5_)
         {
            if(_a[_loc4_] == param1)
            {
               break;
            }
            _loc4_++;
         }
         var _loc3_:int = _loc4_ == _loc5_ ? -1 : _loc4_;
         if(_loc3_ == -1)
         {
            return null;
         }
         param2.y = int(_loc3_ / _w);
         param2.x = int(_loc3_ % _w);
         return param2;
      }
      
      public function assign(param1:Class, param2:Array = undefined) : void
      {
         var _loc5_:int = 0;
         if(param2 == null)
         {
            param2 = [];
         }
         var _loc3_:int = 0;
         var _loc4_:* = _w * _h;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _a[_loc5_] = hx.Type.createInstance(param1,param2);
         }
      }
      
      public function appendRow(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _temp_2:* = _w;
         var _loc3_:int;
         _h = (_loc3_ = _h) + 1;
         var _loc2_:* = _temp_2 * _loc3_;
         _loc3_ = 0;
         var _loc4_:int = _w;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            _a[_loc2_ + _loc5_] = param1[_loc5_];
         }
      }
      
      public function appendCol(param1:Array) : void
      {
         var _loc2_:* = _w * _h;
         var _loc3_:* = _loc2_ + _h;
         var _loc4_:* = _h - 1;
         var _loc5_:int = _h;
         var _loc6_:int = _w;
         var _loc7_:int = _loc3_;
         while(_loc7_-- > 0)
         {
            if(++_loc6_ > _w)
            {
               _loc6_ = 0;
               _loc5_--;
               _a[_loc7_] = param1[_loc4_--];
            }
            else
            {
               _a[_loc7_] = _a[_loc7_ - _loc5_];
            }
         }
         ++_w;
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
