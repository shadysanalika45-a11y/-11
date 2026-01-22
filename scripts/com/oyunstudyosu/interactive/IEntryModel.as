package com.oyunstudyosu.interactive
{
   import flash.utils.Dictionary;
   
   public interface IEntryModel
   {
      
      function get entryItems() : Dictionary;
      
      function executeItem(param1:int) : void;
      
      function getObjectById(param1:String) : IEntryVo;
      
      function loadJSON(param1:String, param2:Object) : void;
      
      function dispose() : void;
      
      function removeObjectById(param1:String) : void;
   }
}

