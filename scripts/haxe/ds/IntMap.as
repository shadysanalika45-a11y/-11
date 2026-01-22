package haxe.ds
{
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.IMap;
   import haxe.ds._IntMap.IntMapKeysIterator;
   
   public class IntMap implements IMap
   {
      
      public var h:Dictionary;
      
      public function IntMap()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         h = new Dictionary();
      }
      
      public function _SafeStr_1(param1:Object, param2:Object) : void
      {
         var _loc3_:int = int(param1);
         h[_loc3_] = param2;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc2_:int = int(param1);
         if(!(_loc2_ in h))
         {
            return false;
         }
         delete h[_loc2_];
         return true;
      }
      
      public function keys() : Object
      {
         return new IntMapKeysIterator(h);
      }
      
      public function _SafeStr_2(param1:Object) : Object
      {
         var _loc2_:int = int(param1);
         return h[_loc2_];
      }
      
      public function exists(param1:Object) : Boolean
      {
         var _loc2_:int = int(param1);
         return _loc2_ in h;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
