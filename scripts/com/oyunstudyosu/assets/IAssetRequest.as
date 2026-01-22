package com.oyunstudyosu.assets
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   
   public interface IAssetRequest
   {
      
      function get isQueueRequest() : Boolean;
      
      function set isQueueRequest(param1:Boolean) : void;
      
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
      
      function get priority() : int;
      
      function set priority(param1:int) : void;
      
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get root() : String;
      
      function set root(param1:String) : void;
      
      function get display() : DisplayObject;
      
      function set display(param1:DisplayObject) : void;
      
      function get loader() : Loader;
      
      function set loader(param1:Loader) : void;
      
      function get context() : LoaderContext;
      
      function set context(param1:LoaderContext) : void;
      
      function get data() : *;
      
      function set data(param1:*) : void;
      
      function get clone() : Boolean;
      
      function set clone(param1:Boolean) : void;
      
      function dispose() : void;
      
      function cloneRequest() : AssetRequest;
   }
}

