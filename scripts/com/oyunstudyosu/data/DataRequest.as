package com.oyunstudyosu.data
{
   import flash.net.URLLoader;
   
   public class DataRequest implements IDataRequest
   {
      
      private var _name:String;
      
      private var _root:String;
      
      private var _loadedFunction:Function;
      
      private var _assetId:String;
      
      private var _type:String;
      
      private var _data:Object;
      
      private var _loader:URLLoader;
      
      private var _errorFunction:Function;
      
      private var _progressFunction:Function;
      
      public function DataRequest()
      {
         super();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get root() : String
      {
         return this._root;
      }
      
      public function set root(param1:String) : void
      {
         if(this._root == param1)
         {
            return;
         }
         this._root = param1;
      }
      
      public function set name(param1:String) : void
      {
         if(this._name == param1)
         {
            return;
         }
         this._name = param1;
      }
      
      public function get loadedFunction() : Function
      {
         return this._loadedFunction;
      }
      
      public function set loadedFunction(param1:Function) : void
      {
         if(this._loadedFunction == param1)
         {
            return;
         }
         this._loadedFunction = param1;
      }
      
      public function get assetId() : String
      {
         return this._assetId;
      }
      
      public function set assetId(param1:String) : void
      {
         if(this._assetId == param1)
         {
            return;
         }
         this._assetId = param1;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function set data(param1:*) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = param1;
      }
      
      public function get loader() : URLLoader
      {
         return this._loader;
      }
      
      public function set loader(param1:URLLoader) : void
      {
         if(this._loader == param1)
         {
            return;
         }
         this._loader = param1;
      }
      
      public function dispose() : void
      {
         this._data = null;
         this._loadedFunction = null;
         this._loader.close();
         this._loader = null;
      }
      
      public function get errorFunction() : Function
      {
         return this._errorFunction;
      }
      
      public function set errorFunction(param1:Function) : void
      {
         if(this._errorFunction == param1)
         {
            return;
         }
         this._errorFunction = param1;
      }
      
      public function get progressFunction() : Function
      {
         return this._progressFunction;
      }
      
      public function set progressFunction(param1:Function) : void
      {
         if(this._progressFunction == param1)
         {
            return;
         }
         this._progressFunction = param1;
      }
   }
}

