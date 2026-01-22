package com.oyunstudyosu.bot
{
   import com.oyunstudyosu.door.IProperty;
   
   public interface IBotMessage
   {
      
      function init() : void;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function get property() : IProperty;
      
      function set property(param1:IProperty) : void;
      
      function dispose() : void;
   }
}

