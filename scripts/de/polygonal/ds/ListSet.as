package de.polygonal.ds
{
   import de.polygonal.core.fmt.Sprintf;
   import hx.Std;
   import hx.Type;
   
   public class ListSet implements Set
   {
      
      public var reuseIterator:Boolean;
      
      public var key:int;
      
      public var _a:DA = new DA();
      
      public function ListSet()
      {
         var _temp_3:* = §§findproperty(key);
         var _temp_1:* = HashKey;
         var _loc1_:int;
         _temp_1._counter = (_loc1_ = int(_temp_1._counter)) + 1;
         key = _loc1_;
         reuseIterator = false;
      }
      
      public function toString() : String
      {
         var _loc4_:int = 0;
         var _loc1_:String = Sprintf.format("{ListSet, size: %d}",[size()]);
         if(isEmpty())
         {
            return _loc1_;
         }
         _loc1_ += "\n|<\n";
         var _loc2_:int = 0;
         var _loc3_:int = size();
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_++;
            _loc1_ += Sprintf.format("  %s\n",[hx.Std.string(_a._a[_loc4_])]);
         }
         return _loc1_ + ">|";
      }
      
      public function toDA() : DA
      {
         return _a.toDA();
      }
      
      public function toArray() : Array
      {
         return _a.toArray();
      }
      
      public function size() : int
      {
         return _a._size;
      }
      
      public function _SafeStr_1(param1:Object) : Boolean
      {
         var _loc3_:* = null as DA;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Object = param1;
         _loc3_ = _a;
         var _loc4_:Boolean = false;
         _loc5_ = 0;
         var _loc6_:int = _loc3_._size;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            if(_loc3_._a[_loc7_] == _loc2_)
            {
               _loc4_ = true;
               break;
            }
         }
         if(_loc4_)
         {
            return false;
         }
         _loc3_ = _a;
         _loc5_ = _loc3_._size;
         _loc3_._a[_loc5_] = _loc2_;
         if(_loc5_ >= _loc3_._size)
         {
            ++_loc3_._size;
         }
         return true;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc2_:Object = param1;
         return _a.remove(_loc2_);
      }
      
      public function merge(param1:Set, param2:Boolean, param3:Function = undefined) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null as Object;
         if(param2)
         {
            _loc4_ = param1.iterator();
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               _SafeStr_1(_loc5_);
            }
         }
         else if(param3 != null)
         {
            _loc4_ = param1.iterator();
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               _SafeStr_1(param3(_loc5_));
            }
         }
         else
         {
            _loc4_ = param1.iterator();
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               _SafeStr_1(_loc5_.clone());
            }
         }
      }
      
      public function iterator() : Itr
      {
         _a.reuseIterator = reuseIterator;
         return _a.iterator();
      }
      
      public function isEmpty() : Boolean
      {
         return _a._size == 0;
      }
      
      public function has(param1:Object) : Boolean
      {
         var _loc7_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:DA = _a;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = _loc3_._size;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            if(_loc3_._a[_loc7_] == _loc2_)
            {
               _loc4_ = true;
               break;
            }
         }
         return _loc4_;
      }
      
      public function free() : void
      {
         _a.free();
         _a = null;
      }
      
      public function contains(param1:Object) : Boolean
      {
         var _loc7_:int = 0;
         var _loc2_:Object = param1;
         var _loc3_:DA = _a;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = _loc3_._size;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc5_++;
            if(_loc3_._a[_loc7_] == _loc2_)
            {
               _loc4_ = true;
               break;
            }
         }
         return _loc4_;
      }
      
      public function clone(param1:Boolean = true, param2:Function = undefined) : Collection
      {
         var _loc3_:Function = param2;
         var _loc4_:ListSet = hx.Type.createEmptyInstance(ListSet);
         var _temp_4:* = _loc4_;
         var _temp_2:* = HashKey;
         var _loc5_:int;
         _temp_2._counter = (_loc5_ = int(_temp_2._counter)) + 1;
         _temp_4.key = _loc5_;
         _loc4_._a = _a.clone(param1,_loc3_);
         return _loc4_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:DA = _a;
         if(param1)
         {
            _loc3_ = 0;
            _loc4_ = int(_loc2_._a.length);
            while(_loc3_ < _loc4_)
            {
               _loc5_ = _loc3_++;
               _loc2_._a[_loc5_] = null;
            }
         }
         _loc2_._size = 0;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 */
