package com.oyunstudyosu.data
{
   import flash.net.URLLoader;
   
   public interface IDataRequest
   {
      
      function get name() : String;
      
      function set name(param1:String) : void;
      
      function get loadedFunction() : Function;
      
      function set loadedFunction(param1:Function) : void;
      
      function get errorFunction() : Function;
      
      function set errorFunction(param1:Function) : void;
      
      function get progressFunction() : Function;
      
      function set progressFunction(param1:Function) : void;
      
      function get assetId() : String;
      
      function set assetId(param1:String) : void;
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get root() : String;
      
      function set root(param1:String) : void;
      
      function get loader() : URLLoader;
      
      function set loader(param1:URLLoader) : void;
      
      function get data() : *;
      
      function set data(param1:*) : void;
      
      function dispose() : void;
   }
}

