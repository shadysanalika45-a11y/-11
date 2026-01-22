package de.polygonal.ds
{
   public interface Map extends Collection
   {
      
      function toValSet() : Set;
      
      function toKeySet() : Set;
      
      function _SafeStr_1(param1:Object, param2:Object) : Boolean;
      
      function remap(param1:Object, param2:Object) : Boolean;
      
      function keys() : Itr;
      
      function hasKey(param1:Object) : Boolean;
      
      function has(param1:Object) : Boolean;
      
      function _SafeStr_2(param1:Object) : Object;
      
      function clr(param1:Object) : Boolean;
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
