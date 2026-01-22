package com.oyunstudyosu.assets
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.system.LoaderContext;
   
   public class AssetRequest implements IAssetRequest
   {
      
      private var _isQueueRequest:Boolean = false;
      
      private var _name:String;
      
      private var _root:String;
      
      private var _loadedFunction:Function;
      
      private var _assetId:String;
      
      private var _type:String;
      
      private var _display:DisplayObject;
      
      private var _data:Object;
      
      private var _clone:Boolean;
      
      private var _priority:int = 50;
      
      private var _loader:Loader;
      
      private var _context:LoaderContext;
      
      public var error:Boolean = false;
      
      private var _errorFunction:Function;
      
      private var _progressFunction:Function;
      
      public function AssetRequest()
      {
         super();
      }
      
      public function get isQueueRequest() : Boolean
      {
         return this._isQueueRequest;
      }
      
      public function set isQueueRequest(param1:Boolean) : void
      {
         this._isQueueRequest = param1;
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
      
      public function get display() : DisplayObject
      {
         return this._display;
      }
      
      public function set display(param1:DisplayObject) : void
      {
         if(this._display == param1)
         {
            return;
         }
         this._display = param1;
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
      
      public function get clone() : Boolean
      {
         return this._clone;
      }
      
      public function set clone(param1:Boolean) : void
      {
         if(this._clone == param1)
         {
            return;
         }
         this._clone = param1;
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(param1:int) : void
      {
         if(this._priority == param1)
         {
            return;
         }
         this._priority = param1;
      }
      
      public function get loader() : Loader
      {
         return this._loader;
      }
      
      public function set loader(param1:Loader) : void
      {
         if(this._loader == param1)
         {
            return;
         }
         this._loader = param1;
      }
      
      public function get context() : LoaderContext
      {
         return this._context;
      }
      
      public function set context(param1:LoaderContext) : void
      {
         if(this._context == param1)
         {
            return;
         }
         this._context = param1;
      }
      
      public function dispose() : void
      {
         this._data = null;
         this._loadedFunction = null;
         this._progressFunction = null;
         this._errorFunction = null;
         if(this._loader)
         {
            this._loader = null;
         }
         if(this._display)
         {
            if(this._display is Bitmap)
            {
               return;
            }
         }
         this._display = null;
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
      
      public function cloneRequest() : AssetRequest
      {
         var _loc1_:AssetRequest = new AssetRequest();
         _loc1_.isQueueRequest = this.isQueueRequest;
         _loc1_.name = this.name;
         _loc1_.loadedFunction = this.loadedFunction;
         _loc1_.errorFunction = this.errorFunction;
         _loc1_.progressFunction = this.progressFunction;
         _loc1_.assetId = this.assetId;
         _loc1_.priority = this.priority;
         _loc1_.type = this.type;
         _loc1_.root = this.root;
         _loc1_.display = this.display;
         _loc1_.loader = this.loader;
         _loc1_.context = this.context;
         _loc1_.data = this.data;
         _loc1_.clone = this.clone;
         return _loc1_;
      }
   }
}

