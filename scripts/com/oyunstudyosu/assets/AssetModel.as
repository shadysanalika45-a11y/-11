package com.oyunstudyosu.assets
{
   import com.adobe.crypto.MD5;
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.BinaryDataLoader;
   import com.greensock.loading.LoaderMax;
   import com.oyunstudyosu.enums.ModuleType;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.ImageDecodingPolicy;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AssetModel implements IAssetModel
   {
      
      private var FileStream:Class;
      
      private var File:Class;
      
      private var stage:Stage;
      
      public var queueLength:int = 0;
      
      public var queueLimit:int = 7;
      
      public var queue:Array;
      
      public var requestList:Dictionary;
      
      public var fileStreamQueue:Dictionary;
      
      public var pendingList:Dictionary;
      
      public var loadingList:Dictionary;
      
      protected var context:LoaderContext;
      
      private var allowedModuleTypes:Vector.<String>;
      
      public var assetList:Vector.<AssetData> = new Vector.<AssetData>();
      
      public function AssetModel(param1:Stage)
      {
         super();
         this.stage = param1;
         this.queue = new Array();
         this.fileStreamQueue = new Dictionary();
         this.requestList = new Dictionary();
         this.pendingList = new Dictionary();
         this.loadingList = new Dictionary();
         this.context = new LoaderContext();
         this.context.checkPolicyFile = true;
         this.context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         this.context.securityDomain = null;
         this.context.allowCodeImport = false;
         this.context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         this.allowedModuleTypes = new Vector.<String>();
         this.allowedModuleTypes.push(ModuleType.CLOTH_PNG);
         this.allowedModuleTypes.push("BG");
         this.allowedModuleTypes.push(ModuleType.PNG);
         this.allowedModuleTypes.push("BMP");
         this.allowedModuleTypes.push(ModuleType.PANEL);
         this.allowedModuleTypes.push("OTHER");
         this.allowedModuleTypes.push(ModuleType.EXTENSION);
         this.allowedModuleTypes.push(ModuleType.FURNITURE_EDITOR);
         this.allowedModuleTypes.push(ModuleType.AD_AIRSHIP);
         this.allowedModuleTypes.push(ModuleType.AD_BILLBOARD);
         this.allowedModuleTypes.push(ModuleType.AD_BOT);
         this.allowedModuleTypes.push(ModuleType.AD_SKIN);
         this.allowedModuleTypes.push(ModuleType.SMILEY);
         this.allowedModuleTypes.push(ModuleType.PROFILE_SKIN);
      }
      
      public function get ROOT() : String
      {
         return Connectr.instance.gameModel.fileServer;
      }
      
      public function getAsset(param1:String, param2:String) : AssetData
      {
         var _loc3_:AssetData = null;
         for each(_loc3_ in this.assetList)
         {
            if(_loc3_.assetId == param1 && _loc3_.type == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function requestQueue(param1:AssetRequestQueue) : void
      {
         var _loc2_:AssetRequest = null;
         if(param1.isCompleted)
         {
            throw "Already completed queue cannot be requeued.";
         }
         for each(_loc2_ in param1.queue)
         {
            this.request(_loc2_);
         }
      }
      
      public function request(param1:IAssetRequest) : void
      {
         if(Connectr.instance != null && Connectr.instance.airModel != null && Boolean(Connectr.instance.airModel.isAir()))
         {
            this.File = this.stage.loaderInfo.applicationDomain.getDefinition("flash.filesystem.File") as Class;
            this.FileStream = this.stage.loaderInfo.applicationDomain.getDefinition("flash.filesystem.FileStream") as Class;
         }
         var _loc2_:* = this.pendingList[param1.assetId] != null;
         this.addPendingList(param1);
         if(!_loc2_)
         {
            this.addQueue(param1);
         }
         this.handleQueue();
      }
      
      public function addQueue(param1:IAssetRequest) : void
      {
         this.queue.push(param1);
      }
      
      public function handleQueue() : void
      {
         var _loc1_:IAssetRequest = null;
         if(this.queue.length == 0 || this.queueLength >= this.queueLimit)
         {
            return;
         }
         this.queue.sortOn("priority");
         this.queue.reverse();
         for each(_loc1_ in this.queue)
         {
            if(this.queueLength >= this.queueLimit)
            {
               break;
            }
            this.startLoad(_loc1_);
            this.queue.removeAt(this.queue.indexOf(_loc1_));
         }
      }
      
      protected function startLoad(param1:IAssetRequest) : void
      {
         var _loc2_:BinaryDataLoader = null;
         var _loc3_:* = undefined;
         var _loc4_:Loader = null;
         ++this.queueLength;
         if(Connectr.instance.airModel.isAir())
         {
            _loc3_ = null;
            if(Connectr.instance.cacheModel.resolvePath() != null)
            {
               _loc3_ = Connectr.instance.cacheModel.resolvePath().resolvePath(MD5.hash(param1.assetId));
            }
            if(_loc3_ != null && _loc3_.exists && Boolean(Connectr.instance.cacheModel.isAvailable))
            {
               _loc2_ = new BinaryDataLoader(_loc3_.url);
            }
            else if(param1.root != null || param1.root == "")
            {
               _loc2_ = new BinaryDataLoader(param1.root + param1.assetId);
            }
            else
            {
               _loc2_ = new BinaryDataLoader(this.ROOT + param1.assetId);
            }
            this.loadingList[param1.assetId] = _loc2_;
            this.requestList[_loc2_] = param1;
            _loc2_.addEventListener(LoaderEvent.COMPLETE,this.onBinaryLoaded);
            _loc2_.addEventListener(LoaderEvent.ERROR,this.onBinaryError);
            _loc2_.addEventListener(LoaderEvent.FAIL,this.onBinaryError);
            _loc2_.load();
         }
         else
         {
            _loc4_ = new Loader();
            param1.loader = _loc4_;
            this.loadingList[param1.assetId] = _loc4_;
            this.requestList[_loc4_] = param1;
            _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded);
            _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            _loc4_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            _loc4_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
            if(param1.context == null)
            {
               param1.context = this.context;
            }
            if(param1.root != null || param1.root == "")
            {
               _loc4_.load(new URLRequest(param1.root + param1.assetId),param1.context);
            }
            else
            {
               _loc4_.load(new URLRequest(this.ROOT + param1.assetId),param1.context);
            }
         }
      }
      
      protected function onBinaryLoaded(param1:Event) : void
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:BinaryDataLoader = LoaderMax.getLoader(param1.target.name);
         var _loc3_:IAssetRequest = this.requestList[_loc2_] as IAssetRequest;
         var _loc4_:Loader = new Loader();
         if(_loc3_.context == null)
         {
            _loc3_.context = new LoaderContext();
            _loc3_.context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         }
         var _loc5_:LoaderContext = _loc3_.context;
         _loc5_.allowCodeImport = true;
         _loc5_.securityDomain = null;
         _loc5_.checkPolicyFile = false;
         _loc5_.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
         _loc3_.loader = _loc4_;
         this.loadingList[_loc3_.assetId] = _loc4_;
         this.requestList[_loc4_] = _loc3_;
         var _loc6_:ByteArray = new ByteArray();
         _loc6_ = param1.target.content;
         delete this.requestList[_loc2_];
         _loc2_.unload();
         _loc2_.dispose(true);
         _loc2_ = null;
         if(_loc6_.length != 0)
         {
            _loc4_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            _loc4_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
            _loc4_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
            _loc4_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded);
            _loc4_.loadBytes(_loc6_,_loc5_);
            if(Connectr.instance.cacheModel.isAvailable)
            {
               try
               {
                  _loc7_ = Connectr.instance.cacheModel.resolvePath().resolvePath(MD5.hash(_loc3_.assetId) + ".tmp");
                  _loc8_ = Connectr.instance.cacheModel.resolvePath().resolvePath(MD5.hash(_loc3_.assetId));
                  if(!_loc7_.exists && !_loc8_.exists)
                  {
                     _loc9_ = new this.FileStream();
                     _loc9_.addEventListener(Event.CLOSE,this.onFileClosed);
                     _loc9_.openAsync(_loc7_,"write");
                     _loc9_.writeBytes(_loc6_,0,_loc6_.length);
                     _loc9_.close();
                     this.fileStreamQueue[_loc9_] = new Array(_loc7_,_loc8_);
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
      }
      
      private function onFileClosed(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         try
         {
            _loc2_ = param1.target;
            _loc3_ = this.fileStreamQueue[_loc2_];
            _loc4_ = _loc3_[0];
            _loc5_ = _loc3_[1];
            _loc4_.moveToAsync(_loc5_);
            delete this.fileStreamQueue[_loc2_];
         }
         catch(e:Error)
         {
         }
      }
      
      protected function addPendingList(param1:IAssetRequest) : void
      {
         if(param1.root != null || param1.root == "")
         {
         }
         var _loc2_:Array = this.pendingList[param1.assetId];
         if(_loc2_)
         {
            _loc2_.push(param1);
         }
         else
         {
            _loc2_ = [];
            _loc2_.push(param1);
            this.pendingList[param1.assetId] = _loc2_;
         }
      }
      
      protected function onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Loader = (param1.target as LoaderInfo).loader;
         var _loc3_:IAssetRequest = this.requestList[_loc2_] as IAssetRequest;
         if(_loc3_.progressFunction != null)
         {
            _loc3_.progressFunction(param1.bytesLoaded * 100 / param1.bytesTotal);
         }
      }
      
      protected function onLoaded(param1:Event) : void
      {
         var list:Array;
         var copyBytes:ByteArray = null;
         var subContentArray:Array = null;
         var i:int = 0;
         var subRequest:IAssetRequest = null;
         var displayObject:DisplayObject = null;
         var subRequestLoader:Loader = null;
         var cloneSubRequest:AssetRequest = null;
         var bitmap:Bitmap = null;
         var event:Event = param1;
         var loader:Loader = (event.target as LoaderInfo).loader;
         var loaderInfo:LoaderInfo = event.target as LoaderInfo;
         var content:MovieClip = loaderInfo.content as MovieClip;
         var request:IAssetRequest = this.requestList[loader] as IAssetRequest;
         delete this.loadingList[request.assetId];
         list = this.pendingList[request.assetId];
         if(list)
         {
            copyBytes = null;
            subContentArray = new Array();
            i = 0;
            for(; i < list.length; i++)
            {
               subRequest = list[i] as IAssetRequest;
               subRequest.context = request.context;
               if(subRequest.loadedFunction != null)
               {
                  if(this.isRequestDisplaySupported(subRequest))
                  {
                     displayObject = loader.content;
                     if(subRequest.clone && i > 0)
                     {
                        if(displayObject is MovieClip)
                        {
                           subRequestLoader = new Loader();
                           cloneSubRequest = subRequest.cloneRequest();
                           cloneSubRequest.loader = subRequestLoader;
                           subContentArray.push(cloneSubRequest);
                           subRequestLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):*
                           {
                              var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
                              var _loc3_:AssetRequest = subContentArray.pop();
                              _loc3_.display = _loc2_.loader.content;
                              _loc3_.loadedFunction(_loc3_);
                           });
                           subRequestLoader.loadBytes(loader.contentLoaderInfo.bytes,subRequest.context);
                           continue;
                        }
                     }
                     if(i > 0 && displayObject is Bitmap)
                     {
                        bitmap = displayObject as Bitmap;
                        displayObject = new Bitmap(bitmap.bitmapData);
                     }
                     subRequest.display = displayObject;
                  }
                  subRequest.loadedFunction(subRequest);
               }
            }
         }
         delete this.pendingList[request.assetId];
         delete this.requestList[loader];
         this.deleteRequest(request);
         if(!(request.type == ModuleType.SMILEY || request.type == ModuleType.PANEL))
         {
            loader.unloadAndStop();
         }
         if(!request.isQueueRequest)
         {
            request.dispose();
         }
         loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaded);
         loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         loader = null;
         loaderInfo = null;
      }
      
      protected function isRequestDisplaySupported(param1:IAssetRequest) : Boolean
      {
         if(param1.type == null)
         {
            return true;
         }
         return this.allowedModuleTypes.indexOf(param1.type) != -1;
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:IAssetRequest = null;
         var _loc2_:Loader = (param1.target as LoaderInfo).loader;
         var _loc3_:IAssetRequest = this.requestList[_loc2_] as IAssetRequest;
         trace("Security error." + param1.text);
         Tracker.track("asset","load","error","Security error." + param1.text);
         var _loc4_:Array = this.pendingList[_loc3_.assetId];
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_] as IAssetRequest;
               if(_loc6_.errorFunction != null)
               {
                  _loc6_.errorFunction(_loc6_);
               }
               else if(!_loc6_.isQueueRequest)
               {
                  _loc6_.dispose();
               }
               _loc5_++;
            }
         }
         this.deleteRequest(_loc3_);
      }
      
      protected function onBinaryError(param1:LoaderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:IAssetRequest = null;
         var _loc2_:BinaryDataLoader = LoaderMax.getLoader(param1.target.name);
         trace("binaryLoader: " + _loc2_);
         var _loc3_:IAssetRequest = this.requestList[_loc2_] as IAssetRequest;
         trace("Error loading " + (_loc3_.root ? _loc3_.root : this.ROOT) + _loc3_.assetId);
         Tracker.track("asset","load","error","Error loading " + (_loc3_.root ? _loc3_.root : this.ROOT) + _loc3_.assetId);
         var _loc4_:Array = this.pendingList[_loc3_.assetId];
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_] as IAssetRequest;
               if(_loc6_.errorFunction != null)
               {
                  _loc6_.errorFunction(_loc6_);
               }
               else if(!_loc6_.isQueueRequest)
               {
                  _loc6_.dispose();
               }
               _loc5_++;
            }
         }
         this.deleteRequest(_loc3_);
      }
      
      protected function onError(param1:IOErrorEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:IAssetRequest = null;
         var _loc2_:Loader = (param1.target as LoaderInfo).loader;
         var _loc3_:IAssetRequest = this.requestList[_loc2_] as IAssetRequest;
         trace("Error loading " + (_loc3_.root ? _loc3_.root : this.ROOT) + _loc3_.assetId);
         Tracker.track("asset","load","error","Error loading " + (_loc3_.root ? _loc3_.root : this.ROOT) + _loc3_.assetId);
         var _loc4_:Array = this.pendingList[_loc3_.assetId];
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc6_ = _loc4_[_loc5_] as IAssetRequest;
               if(_loc6_.errorFunction != null)
               {
                  _loc6_.errorFunction(_loc6_);
               }
               else if(!_loc6_.isQueueRequest)
               {
                  _loc6_.dispose();
               }
               _loc5_++;
            }
         }
         this.deleteRequest(_loc3_);
      }
      
      private function deleteRequest(param1:IAssetRequest) : void
      {
         --this.queueLength;
         this.handleQueue();
         try
         {
            param1.loader.removeEventListener(LoaderEvent.COMPLETE,this.onBinaryLoaded);
            param1.loader.removeEventListener(LoaderEvent.ERROR,this.onBinaryError);
            param1.loader.removeEventListener(LoaderEvent.FAIL,this.onBinaryError);
         }
         catch(e:Error)
         {
         }
         try
         {
            param1.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaded);
            param1.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
            param1.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            param1.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         }
         catch(e:Error)
         {
         }
         try
         {
            delete this.pendingList[param1.assetId];
            delete this.requestList[param1.loader];
            delete this.loadingList[param1.assetId];
         }
         catch(e:Error)
         {
         }
      }
   }
}

