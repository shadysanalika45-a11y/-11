package com.oyunstudyosu.engine.core
{
   import com.oyunstudyosu.engine.ICharacter;
   
   public interface ICell
   {
      
      function get x() : Number;
      
      function get y() : Number;
      
      function get f() : Number;
      
      function get sittable() : Boolean;
      
      function get swimmable() : Boolean;
      
      function get usable() : Boolean;
      
      function get isPool() : Boolean;
      
      function get cellType() : int;
      
      function set cellType(param1:int) : void;
      
      function set bit(param1:int) : void;
      
      function get bit() : int;
      
      function isSelectable(param1:ICharacter) : Boolean;
      
      function equals(param1:ICell) : Boolean;
      
      function get objectType() : int;
   }
}

