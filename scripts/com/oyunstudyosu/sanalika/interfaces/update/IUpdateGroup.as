package com.oyunstudyosu.sanalika.interfaces.update
{
   public interface IUpdateGroup
   {
      
      function add(param1:IUpdate) : void;
      
      function remove(param1:IUpdate) : void;
      
      function addFunction(param1:Function) : void;
      
      function removeFunction(param1:Function) : void;
   }
}

