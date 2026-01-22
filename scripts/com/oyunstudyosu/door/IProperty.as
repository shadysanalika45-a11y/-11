package com.oyunstudyosu.door
{
   public interface IProperty
   {
      
      function execute(param1:String = "") : void;
      
      function dispose() : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
   }
}

