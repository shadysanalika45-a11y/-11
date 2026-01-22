package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderCore;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.SecurityDomain;
   import flash.utils.getTimer;
   
   public class XMLLoader extends DataLoader
   {
      
      private static var _classActivated:Boolean = _activateClass("XMLLoader",XMLLoader,"xml,php,jsp,asp,cfm,cfml,aspx");
      
      protected static var _varTypes:Object = {
         "skipFailed":true,
         "skipPaused":true,
         "autoLoad":false,
         "paused":false,
         "load":false,
         "noCache":false,
         "maxConnections":2,
         "autoPlay":false,
         "autoDispose":false,
         "smoothing":false,
         "estimatedBytes":1,
         "x":1,
         "y":1,
         "z":1,
         "rotationX":1,
         "rotationY":1,
         "rotationZ":1,
         "width":1,
         "height":1,
         "scaleX":1,
         "scaleY":1,
         "rotation":1,
         "alpha":1,
         "visible":true,
         "bgColor":0,
         "bgAlpha":0,
         "deblocking":1,
         "repeat":1,
         "checkPolicyFile":false,
         "centerRegistration":false,
         "bufferTime":5,
         "volume":1,
         "bufferMode":false,
         "estimatedDuration":200,
         "crop":false,
         "autoAdjustBuffer":true,
         "suppressInitReparentEvents":true
      };
      
      public static var RAW_LOAD:String = "rawLoad";
      
      protected var _loadingQueue:LoaderMax;
      
      protected var _parsed:LoaderMax;
      
      protected var _initted:Boolean;
      
      public function XMLLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _preferEstimatedBytesInAudit = true;
         _type = "XMLLoader";
         _loader.dataFormat = "text";
      }
      
      protected static function _parseVars(param1:XML) : Object
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:ApplicationDomain = null;
         var _loc8_:XML = null;
         var _loc2_:Object = {"rawXML":param1};
         var _loc7_:XMLList = param1.attributes();
         for each(_loc8_ in _loc7_)
         {
            _loc3_ = _loc8_.name();
            _loc5_ = _loc8_.toString();
            if(_loc3_ != "url")
            {
               if(_loc3_ == "context")
               {
                  _loc2_.context = new LoaderContext(true,_loc5_ == "own" ? ApplicationDomain.currentDomain : (_loc5_ == "separate" ? new ApplicationDomain() : new ApplicationDomain(ApplicationDomain.currentDomain)),!_isLocal ? SecurityDomain.currentDomain : null);
               }
               else
               {
                  _loc4_ = typeof _varTypes[_loc3_];
                  if(_loc4_ == "boolean")
                  {
                     _loc2_[_loc3_] = Boolean(_loc5_ == "true" || _loc5_ == "1");
                  }
                  else if(_loc4_ == "number")
                  {
                     _loc2_[_loc3_] = Number(_loc5_);
                  }
                  else
                  {
                     _loc2_[_loc3_] = _loc5_;
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public static function parseLoaders(param1:XML, param2:LoaderMax, param3:LoaderMax = null) : void
      {
         var _loc4_:XML = null;
         var _loc6_:LoaderMax = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:Class = null;
         var _loc10_:LoaderCore = null;
         var _loc5_:String = String(param1.name()).toLowerCase();
         if(_loc5_ == "loadermax")
         {
            _loc6_ = param2.append(new LoaderMax(_parseVars(param1))) as LoaderMax;
            if(param3 != null && Boolean(_loc6_.vars.load))
            {
               param3.append(_loc6_);
            }
            for each(_loc4_ in param1.children())
            {
               parseLoaders(_loc4_,_loc6_,param3);
            }
            if("replaceURLText" in _loc6_.vars)
            {
               _loc7_ = _loc6_.vars.replaceURLText.split(",");
               _loc8_ = 0;
               while(_loc8_ < _loc7_.length)
               {
                  _loc6_.replaceURLText(_loc7_[_loc8_],_loc7_[_loc8_ + 1],false);
                  _loc8_ += 2;
               }
            }
            if("prependURLs" in _loc6_.vars)
            {
               _loc6_.prependURLs(_loc6_.vars.prependURLs,false);
            }
         }
         else
         {
            if(_loc5_ in _types)
            {
               _loc9_ = _types[_loc5_];
               _loc10_ = param2.append(new _loc9_(param1.@url,_parseVars(param1)));
               if(param3 != null && Boolean(_loc10_.vars.load))
               {
                  param3.append(_loc10_);
               }
            }
            for each(_loc4_ in param1.children())
            {
               parseLoaders(_loc4_,param2,param3);
            }
         }
      }
      
      override protected function _load() : void
      {
         if(!this._initted)
         {
            _prepRequest();
            _loader.load(_request);
         }
         else if(this._loadingQueue != null)
         {
            this._changeQueueListeners(true);
            this._loadingQueue.load(false);
         }
      }
      
      protected function _changeQueueListeners(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(this._loadingQueue != null)
         {
            if(param1 && this.vars.integrateProgress != false)
            {
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     this._loadingQueue.addEventListener(_listenerTypes[_loc2_],this._passThroughEvent,false,-100,true);
                  }
               }
               this._loadingQueue.addEventListener(LoaderEvent.COMPLETE,this._completeHandler,false,-100,true);
               this._loadingQueue.addEventListener(LoaderEvent.PROGRESS,this._progressHandler,false,-100,true);
               this._loadingQueue.addEventListener(LoaderEvent.FAIL,this._failHandler,false,-100,true);
            }
            else
            {
               this._loadingQueue.removeEventListener(LoaderEvent.COMPLETE,this._completeHandler);
               this._loadingQueue.removeEventListener(LoaderEvent.PROGRESS,this._progressHandler);
               this._loadingQueue.removeEventListener(LoaderEvent.FAIL,this._failHandler);
               for(_loc2_ in _listenerTypes)
               {
                  if(_loc2_ != "onProgress" && _loc2_ != "onInit")
                  {
                     this._loadingQueue.removeEventListener(_listenerTypes[_loc2_],this._passThroughEvent);
                  }
               }
            }
         }
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         if(this._loadingQueue != null)
         {
            this._changeQueueListeners(false);
            if(param1 == 0)
            {
               this._loadingQueue.cancel();
            }
            else
            {
               this._loadingQueue.dispose(Boolean(param1 == 3));
               this._loadingQueue = null;
            }
         }
         if(param1 >= 1)
         {
            if(this._parsed != null)
            {
               this._parsed.dispose(Boolean(param1 == 3));
               this._parsed = null;
            }
            this._initted = false;
         }
         _cacheIsDirty = true;
         var _loc4_:* = _content;
         super._dump(param1,param2,param3);
         if(param1 == 0)
         {
            _content = _loc4_;
         }
      }
      
      override protected function _calculateProgress() : void
      {
         _cachedBytesLoaded = _loader.bytesLoaded;
         if(_loader.bytesTotal != 0)
         {
            _cachedBytesTotal = _loader.bytesTotal;
         }
         if(_cachedBytesTotal < _cachedBytesLoaded || this._initted)
         {
            _cachedBytesTotal = _cachedBytesLoaded;
         }
         var _loc1_:uint = uint(this.vars.estimatedBytes);
         if(this.vars.integrateProgress != false)
         {
            if(this._loadingQueue != null && (uint(this.vars.estimatedBytes) < _cachedBytesLoaded || this._loadingQueue.auditedSize))
            {
               if(this._loadingQueue.status <= LoaderStatus.COMPLETED)
               {
                  _cachedBytesLoaded += this._loadingQueue.bytesLoaded;
                  _cachedBytesTotal += this._loadingQueue.bytesTotal;
               }
            }
            else if(uint(this.vars.estimatedBytes) > _cachedBytesLoaded && (!this._initted || this._loadingQueue != null && this._loadingQueue.status <= LoaderStatus.COMPLETED && !this._loadingQueue.auditedSize))
            {
               _cachedBytesTotal = uint(this.vars.estimatedBytes);
            }
         }
         if(!this._initted && _cachedBytesLoaded == _cachedBytesTotal)
         {
            _cachedBytesLoaded = int(_cachedBytesLoaded * 0.99);
         }
         _cacheIsDirty = false;
      }
      
      public function getLoader(param1:String) : *
      {
         return this._parsed != null ? this._parsed.getLoader(param1) : null;
      }
      
      public function getContent(param1:String) : *
      {
         if(param1 == this.name || param1 == _url)
         {
            return _content;
         }
         var _loc2_:LoaderCore = this.getLoader(param1);
         return _loc2_ != null ? _loc2_.content : null;
      }
      
      public function getChildren(param1:Boolean = false, param2:Boolean = false) : Array
      {
         return this._parsed != null ? this._parsed.getChildren(param1,param2) : [];
      }
      
      override protected function _progressHandler(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(_dispatchProgress)
         {
            _loc2_ = _cachedBytesLoaded;
            _loc3_ = _cachedBytesTotal;
            this._calculateProgress();
            if(_cachedBytesLoaded != _cachedBytesTotal && (_loc2_ != _cachedBytesLoaded || _loc3_ != _cachedBytesTotal))
            {
               dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
            }
         }
         else
         {
            _cacheIsDirty = true;
         }
      }
      
      override protected function _passThroughEvent(param1:Event) : void
      {
         if(param1.target != this._loadingQueue)
         {
            super._passThroughEvent(param1);
         }
      }
      
      override protected function _receiveDataHandler(param1:Event) : void
      {
         var loaders:Array = null;
         var i:int = 0;
         var event:Event = param1;
         try
         {
            _content = new XML(_loader.data);
         }
         catch(error:Error)
         {
            _content = _loader.data;
            _failHandler(new LoaderEvent(LoaderEvent.ERROR,this,error.message));
            return;
         }
         dispatchEvent(new LoaderEvent(RAW_LOAD,this,"",_content));
         this._initted = true;
         this._loadingQueue = new LoaderMax({
            "name":this.name + "_Queue",
            "maxConnections":uint(this.vars.maxConnections) || 2,
            "skipFailed":Boolean(this.vars.skipFailed != false),
            "skipPaused":Boolean(this.vars.skipPaused != false)
         });
         this._parsed = new LoaderMax({
            "name":this.name + "_ParsedLoaders",
            "paused":true
         });
         parseLoaders(_content as XML,this._parsed,this._loadingQueue);
         if(this._parsed.numChildren == 0)
         {
            this._parsed.dispose(false);
            this._parsed = null;
         }
         else if("recursivePrependURLs" in this.vars)
         {
            this._parsed.prependURLs(this.vars.recursivePrependURLs,true);
            loaders = this._parsed.getChildren(true,true);
            i = int(loaders.length);
            while(--i > -1)
            {
               if(loaders[i] is XMLLoader)
               {
                  loaders[i].vars.recursivePrependURLs = this.vars.recursivePrependURLs;
               }
            }
         }
         else if("prependURLs" in this.vars)
         {
            this._parsed.prependURLs(this.vars.prependURLs,true);
         }
         if(this._loadingQueue.getChildren(true,true).length == 0)
         {
            this._loadingQueue.empty(false);
            this._loadingQueue.dispose(false);
            this._loadingQueue = null;
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",_content));
         }
         else
         {
            _cacheIsDirty = true;
            this._changeQueueListeners(true);
            dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",_content));
            this._loadingQueue.load(false);
         }
         if(this._loadingQueue == null || this.vars.integrateProgress == false)
         {
            this._completeHandler(event);
         }
      }
      
      override protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         if(param1.target == this._loadingQueue)
         {
            _status = LoaderStatus.FAILED;
            _time = getTimer() - _time;
            dispatchEvent(new LoaderEvent(LoaderEvent.CANCEL,this));
            dispatchEvent(new LoaderEvent(LoaderEvent.FAIL,this,this.toString() + " > " + (param1 as Object).text));
         }
         else
         {
            super._failHandler(param1,param2);
         }
      }
      
      override protected function _completeHandler(param1:Event = null) : void
      {
         this._calculateProgress();
         if(this.progress == 1)
         {
            this._changeQueueListeners(false);
            super._completeHandler(param1);
         }
      }
      
      override public function get progress() : Number
      {
         return this.bytesTotal != 0 ? _cachedBytesLoaded / _cachedBytesTotal : (_status == LoaderStatus.COMPLETED || this._initted ? 1 : 0);
      }
   }
}

