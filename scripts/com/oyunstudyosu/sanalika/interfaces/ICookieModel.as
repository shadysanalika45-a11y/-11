package com.oyunstudyosu.sanalika.interfaces
{
   public interface ICookieModel
   {
      
      function startCheck() : void;
      
      function stopCheck() : void;
      
      function stampDate(param1:String) : void;
      
      function checkDate(param1:String) : Boolean;
      
      function open(param1:String) : Boolean;
      
      function write(param1:String, param2:Object) : Boolean;
      
      function clear(param1:String) : Boolean;
      
      function read(param1:String) : Object;
   }
}

