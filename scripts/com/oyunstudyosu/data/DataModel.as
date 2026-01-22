package com.oyunstudyosu.data
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class DataModel implements IDataModel
   {
      
      protected var ROOT:String;
      
      protected var queue:Dictionary;
      
      protected var pendingList:Dictionary;
      
      protected var loadingList:Dictionary;
      
      public function DataModel(param1:String = null)
      {
         super();
         this.ROOT = param1 ? param1 : "";
         this.queue = new Dictionary();
         this.pendingList = new Dictionary();
         this.loadingList = new Dictionary();
      }
      
      public function request(param1:IDataRequest) : void
      {
         var loader:URLLoader = null;
         var list:Array = null;
         var request:IDataRequest = param1;
         try
         {
            loader = this.loadingList[request.assetId];
            if(loader)
            {
               trace("Asset currently loading. > " + (request.root ? request.root : this.ROOT) + request.assetId);
               list = this.pendingList[request.assetId];
               if(list)
               {
                  list.push(request);
               }
               else
               {
                  list = [];
                  list.push(request);
                  this.pendingList[request.assetId] = list;
               }
            }
            else
            {
               trace("Asset Load Start. > " + (request.root ? request.root : this.ROOT) + request.assetId);
               loader = new URLLoader();
               request.loader = loader;
               this.loadingList[request.assetId] = loader;
               this.queue[loader] = request;
               loader.addEventListener(Event.COMPLETE,this.onLoaded);
               loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
               loader.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
               loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
               if(request.root != null)
               {
                  loader.load(new URLRequest(request.root + request.assetId));
               }
               else
               {
                  loader.load(new URLRequest(this.ROOT + request.assetId));
               }
            }
         }
         catch(error:Error)
         {
            trace("Request error.");
         }
      }
      
      protected function onProgress(param1:ProgressEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:IDataRequest = this.queue[_loc2_] as IDataRequest;
         if(_loc3_.progressFunction != null)
         {
            _loc3_.progressFunction(param1.bytesLoaded * 100 / param1.bytesTotal);
         }
      }
      
      protected function onLoaded(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:IDataRequest = this.queue[_loc2_] as IDataRequest;
         trace("Asset Loaded. > " + _loc3_.assetId);
         delete this.loadingList[_loc3_.assetId];
         _loc3_.data = _loc2_.data;
         if(_loc3_.loadedFunction != null)
         {
            _loc3_.loadedFunction(_loc3_);
         }
         var _loc4_:Array = this.pendingList[_loc3_.assetId];
         if(_loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc3_ = _loc4_[_loc5_] as IDataRequest;
               _loc3_.data = _loc2_.data;
               if(_loc3_.loadedFunction != null)
               {
                  _loc3_.loadedFunction(_loc3_);
               }
               _loc5_++;
            }
         }
         delete this.pendingList[_loc3_.assetId];
         _loc2_.removeEventListener(Event.COMPLETE,this.onLoaded);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         _loc2_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:IDataRequest = this.queue[_loc2_] as IDataRequest;
         trace("Security error." + param1.text);
         this.deleteRequest(_loc3_);
         if(_loc3_.errorFunction != null)
         {
            _loc3_.errorFunction(_loc3_);
         }
         else
         {
            _loc3_.dispose();
         }
      }
      
      protected function onError(param1:IOErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:IDataRequest = this.queue[_loc2_] as IDataRequest;
         trace("Error loading " + (_loc3_.root ? _loc3_.root : this.ROOT) + _loc3_.assetId);
         this.deleteRequest(_loc3_);
         if(_loc3_.errorFunction != null)
         {
            _loc3_.errorFunction(_loc3_);
         }
         else
         {
            _loc3_.dispose();
         }
      }
      
      private function deleteRequest(param1:IDataRequest) : void
      {
         param1.loader.removeEventListener(Event.COMPLETE,this.onLoaded);
         param1.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         param1.loader.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
         param1.loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         delete this.queue[param1.loader];
         delete this.loadingList[param1.assetId];
      }
   }
}

