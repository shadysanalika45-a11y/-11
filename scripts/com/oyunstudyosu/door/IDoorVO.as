package com.oyunstudyosu.door
{
   public interface IDoorVO
   {
      
      function get key() : String;
      
      function set key(param1:String) : void;
      
      function get x() : int;
      
      function set x(param1:int) : void;
      
      function get y() : int;
      
      function set y(param1:int) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
      
      function get property() : IProperty;
      
      function setProperty(param1:Object) : void;
      
      function dispose() : void;
   }
}

