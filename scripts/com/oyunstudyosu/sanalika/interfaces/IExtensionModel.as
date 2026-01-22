package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.extension.IExtension;
   import flash.utils.Dictionary;
   
   public interface IExtensionModel
   {
      
      function loadExtension(param1:String, param2:Object, param3:int) : void;
      
      function loadExtensionList(param1:Dictionary, param2:int) : void;
      
      function getExtensionByName(param1:String) : IExtension;
      
      function getExtensionsByType(param1:int) : Array;
      
      function addExtension(param1:String, param2:Class, param3:Object, param4:int) : void;
      
      function removeExtension(param1:String) : void;
   }
}

