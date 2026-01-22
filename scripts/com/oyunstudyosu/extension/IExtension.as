package com.oyunstudyosu.extension
{
   import flash.events.IEventDispatcher;
   
   public interface IExtension extends IEventDispatcher
   {
      
      function init(param1:Object = null) : void;
      
      function reload() : void;
      
      function dispose() : void;
      
      function get name() : String;
      
      function set name(param1:String) : void;
   }
}

