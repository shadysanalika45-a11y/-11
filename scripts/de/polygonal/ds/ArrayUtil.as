package de.polygonal.ds
{
   import hx.Type;
   
   public class ArrayUtil
   {
      
      public function ArrayUtil()
      {
      }
      
      public static function alloc(param1:int) : Array
      {
         return new Array(param1);
      }
      
      public static function shrink(param1:Array, param2:int) : Array
      {
         if(int(param1.length) > param2)
         {
            param1.length = param2;
         }
         return param1;
      }
      
      public static function copy(param1:Array, param2:Array, param3:int = 0, param4:int = -1) : Array
      {
         var _loc7_:int = 0;
         if(param4 == -1)
         {
            param4 = int(param1.length);
         }
         var _loc5_:int = 0;
         var _loc6_:int = param3;
         while(_loc6_ < param4)
         {
            _loc7_ = _loc6_++;
            param2[_loc5_++] = param1[_loc7_];
         }
         return param2;
      }
      
      public static function fill(param1:Array, param2:Object, param3:int = -1) : void
      {
         var _loc5_:int = 0;
         if(param3 == -1)
         {
            param3 = int(param1.length);
         }
         var _loc4_:int = 0;
         while(_loc4_ < param3)
         {
            _loc5_ = _loc4_++;
            param1[_loc5_] = param2;
         }
      }
      
      public static function assign(param1:Array, param2:Class, param3:Array = undefined, param4:int = -1) : void
      {
         var _loc6_:int = 0;
         if(param4 == -1)
         {
            param4 = int(param1.length);
         }
         if(param3 == null)
         {
            param3 = [];
         }
         var _loc5_:int = 0;
         while(_loc5_ < param4)
         {
            _loc6_ = _loc5_++;
            param1[_loc6_] = hx.Type.createInstance(param2,param3);
         }
      }
      
      public static function memmove(param1:Array, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param3 == param2)
         {
            return;
         }
         if(param3 <= param2)
         {
            _loc5_ = param3 + param4;
            _loc6_ = param2 + param4;
            _loc7_ = 0;
            while(_loc7_ < param4)
            {
               _loc8_ = _loc7_++;
               _loc5_--;
               (--param1)[_loc6_] = param1[_loc5_];
            }
         }
         else
         {
            _loc5_ = param3;
            _loc6_ = param2;
            _loc7_ = 0;
            while(_loc7_ < param4)
            {
               _loc8_ = _loc7_++;
               param1[_loc6_] = param1[_loc5_];
               _loc5_++;
               _loc6_++;
            }
         }
      }
      
      public static function bsearchComparator(param1:Array, param2:Object, param3:int, param4:int, param5:Function) : int
      {
         var _loc7_:* = 0;
         var _loc6_:* = param3;
         var _loc8_:* = param4 + 1;
         while(_loc6_ < _loc8_)
         {
            _loc7_ = _loc6_ + (_loc8_ - _loc6_ >> 1);
            if(param5(param1[_loc7_],param2) < 0)
            {
               _loc6_ = _loc7_ + 1;
            }
            else
            {
               _loc8_ = _loc7_;
            }
         }
         if(_loc6_ <= param4 && param5(param1[_loc6_],param2) == 0)
         {
            return _loc6_;
         }
         return ~_loc6_;
      }
      
      public static function bsearchInt(param1:Array, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:* = 0;
         var _loc5_:* = param3;
         var _loc7_:* = param4 + 1;
         while(_loc5_ < _loc7_)
         {
            _loc6_ = _loc5_ + (_loc7_ - _loc5_ >> 1);
            if(int(param1[_loc6_]) < param2)
            {
               _loc5_ = _loc6_ + 1;
            }
            else
            {
               _loc7_ = _loc6_;
            }
         }
         if(_loc5_ <= param4 && int(param1[_loc5_]) == param2)
         {
            return _loc5_;
         }
         return ~_loc5_;
      }
      
      public static function bsearchFloat(param1:Array, param2:Number, param3:int, param4:int) : int
      {
         var _loc6_:* = 0;
         var _loc5_:* = param3;
         var _loc7_:* = param4 + 1;
         while(_loc5_ < _loc7_)
         {
            _loc6_ = _loc5_ + (_loc7_ - _loc5_ >> 1);
            if(Number(param1[_loc6_]) < param2)
            {
               _loc5_ = _loc6_ + 1;
            }
            else
            {
               _loc7_ = _loc6_;
            }
         }
         if(_loc5_ <= param4 && Number(param1[_loc5_]) == param2)
         {
            return _loc5_;
         }
         return ~_loc5_;
      }
      
      public static function shuffle(param1:Array, param2:Array = undefined) : void
      {
         var _loc4_:* = null as Class;
         var _loc5_:int = 0;
         var _loc6_:* = null as Object;
         var _loc7_:int = 0;
         var _loc3_:int = int(param1.length);
         if(param2 == null)
         {
            _loc4_ = Math;
            while(--_loc3_ > 1)
            {
               _loc5_ = Number(_loc4_.random()) * _loc3_;
               _loc6_ = param1[_loc3_];
               param1[_loc3_] = param1[_loc5_];
               param1[_loc5_] = _loc6_;
            }
         }
         else
         {
            _loc5_ = 0;
            while(--_loc3_ > 1)
            {
               _loc7_ = Number(param2[_loc5_++]) * _loc3_;
               _loc6_ = param1[_loc3_];
               param1[_loc3_] = param1[_loc7_];
               param1[_loc7_] = _loc6_;
            }
         }
      }
      
      public static function sortRange(param1:Array, param2:Function, param3:Boolean, param4:int, param5:int) : void
      {
         var _loc6_:int = int(param1.length);
         if(_loc6_ > 1)
         {
            if(param3)
            {
               ArrayUtil._insertionSort(param1,param4,param5,param2);
            }
            else
            {
               ArrayUtil._quickSort(param1,param4,param5,param2);
            }
         }
      }
      
      public static function quickPerm(param1:int) : Array
      {
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:Array = [];
         var _loc8_:int = 0;
         while(_loc8_ < param1)
         {
            _loc9_ = _loc8_++;
            _loc3_[_loc9_] = _loc9_ + 1;
            _loc4_[_loc9_] = 0;
         }
         _loc2_.push(_loc3_.copy());
         var _loc5_:int = 1;
         while(_loc5_ < param1)
         {
            if(int(_loc4_[_loc5_]) < _loc5_)
            {
               _loc6_ = int(_loc5_ % 2) * int(_loc4_[_loc5_]);
               _loc7_ = int(_loc3_[_loc6_]);
               _loc3_[_loc6_] = int(_loc3_[_loc5_]);
               _loc3_[_loc5_] = _loc7_;
               _loc2_.push(_loc3_.copy());
               ++_loc4_[_loc5_];
               _loc5_ = 1;
            }
            else
            {
               _loc4_[_loc5_] = 0;
               _loc5_++;
            }
         }
         return _loc2_;
      }
      
      public static function equals(param1:Array, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         if(int(param1.length) != int(param2.length))
         {
            return false;
         }
         var _loc3_:int = 0;
         var _loc4_:int = int(param1.length);
         while(_loc3_ < _loc4_)
         {
            _loc5_ = _loc3_++;
            if(param1[_loc5_] != param2[_loc5_])
            {
               return false;
            }
         }
         return true;
      }
      
      public static function split(param1:Array, param2:int, param3:int) : Array
      {
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         while(_loc6_ < param2)
         {
            _loc7_ = _loc6_++;
            if(int(_loc7_ % param3) == 0)
            {
               _loc4_[int(_loc7_ / param3)] = _loc5_ = [];
            }
            _loc5_.push(param1[_loc7_]);
         }
         return _loc4_;
      }
      
      public static function _insertionSort(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc5_:* = param2 + 1;
         var _loc6_:* = param2 + param3;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            _loc8_ = Number(param1[_loc7_]);
            _loc9_ = _loc7_;
            while(_loc9_ > param2)
            {
               _loc10_ = Number(param1[_loc9_ - 1]);
               if(param4(_loc10_,_loc8_) <= 0)
               {
                  break;
               }
               param1[_loc9_] = _loc10_;
               _loc9_--;
            }
            param1[_loc9_] = _loc8_;
         }
      }
      
      public static function _quickSort(param1:Array, param2:int, param3:int, param4:Function) : void
      {
         var _loc8_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:Number = NaN;
         var _loc5_:* = param2 + param3 - 1;
         var _loc6_:int = param2;
         var _loc7_:int = _loc5_;
         if(param3 > 1)
         {
            _loc8_ = param2;
            _loc9_ = _loc8_ + (param3 >> 1);
            _loc10_ = _loc8_ + param3 - 1;
            _loc11_ = Number(param1[_loc8_]);
            _loc12_ = Number(param1[_loc9_]);
            _loc13_ = Number(param1[_loc10_]);
            _loc15_ = param4(_loc11_,_loc13_);
            if(_loc15_ < 0 && param4(_loc11_,_loc12_) < 0)
            {
               _loc14_ = param4(_loc12_,_loc13_) < 0 ? _loc9_ : _loc10_;
            }
            else if(param4(_loc12_,_loc11_) < 0 && param4(_loc12_,_loc13_) < 0)
            {
               _loc14_ = _loc15_ < 0 ? _loc8_ : _loc10_;
            }
            else
            {
               _loc14_ = param4(_loc13_,_loc11_) < 0 ? _loc9_ : _loc8_;
            }
            _loc16_ = Number(param1[_loc14_]);
            param1[_loc14_] = Number(param1[param2]);
            while(_loc6_ < _loc7_)
            {
               while(param4(_loc16_,Number(param1[_loc7_])) < 0 && _loc6_ < _loc7_)
               {
                  _loc7_--;
               }
               if(_loc7_ != _loc6_)
               {
                  param1[_loc6_] = Number(param1[_loc7_]);
                  _loc6_++;
               }
               while(param4(_loc16_,Number(param1[_loc6_])) > 0 && _loc6_ < _loc7_)
               {
                  _loc6_++;
               }
               if(_loc7_ != _loc6_)
               {
                  param1[_loc7_] = Number(param1[_loc6_]);
                  _loc7_--;
               }
            }
            param1[_loc6_] = _loc16_;
            ArrayUtil._quickSort(param1,param2,_loc6_ - param2,param4);
            ArrayUtil._quickSort(param1,_loc6_ + 1,_loc5_ - _loc6_,param4);
         }
      }
   }
}

