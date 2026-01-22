package com.greensock.loading.core
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.LoaderStatus;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   
   public class LoaderItem extends LoaderCore
   {
      
      protected static var _cacheID:Number = new Date().getTime();
      
      protected var _url:String;
      
      protected var _request:URLRequest;
      
      protected var _scriptAccessDenied:Boolean;
      
      protected var _auditStream:URLStream;
      
      protected var _preferEstimatedBytesInAudit:Boolean;
      
      protected var _httpStatus:int;
      
      protected var _skipAlternateURL:Boolean;
      
      public function LoaderItem(param1:*, param2:Object = null)
      {
         super(param2);
         this._request = param1 is URLRequest ? param1 as URLRequest : new URLRequest(param1);
         this._url = this._request.url;
         this._setRequestURL(this._request,this._url);
      }
      
      protected function _prepRequest() : void
      {
         this._scriptAccessDenied = false;
         this._httpStatus = 0;
         this._closeStream();
         if(Boolean(this.vars.noCache) && (!_isLocal || this._url.substr(0,4) == "http"))
         {
            this._setRequestURL(this._request,this._url,"gsCacheBusterID=" + _cacheID++);
         }
      }
      
      protected function _setRequestURL(param1:URLRequest, param2:String, param3:String = "") : void
      {
         var _loc8_:URLVariables = null;
         var _loc9_:Array = null;
         var _loc4_:Array = this.vars.allowMalformedURL ? [param2] : param2.split("?");
         var _loc5_:String = _loc4_[0];
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ += _loc5_.charAt(_loc7_);
            _loc7_++;
         }
         param1.url = _loc6_;
         if(_loc4_.length >= 2)
         {
            param3 += param3 == "" ? _loc4_[1] : "&" + _loc4_[1];
         }
         if(param3 != "")
         {
            _loc8_ = param1.data is URLVariables ? param1.data as URLVariables : new URLVariables();
            _loc4_ = param3.split("&");
            _loc7_ = int(_loc4_.length);
            while(--_loc7_ > -1)
            {
               _loc9_ = _loc4_[_loc7_].split("=");
               _loc8_[_loc9_.shift()] = _loc9_.join("=");
            }
            param1.data = _loc8_;
         }
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         this._closeStream();
         super._dump(param1,param2,param3);
      }
      
      override public function auditSize() : void
      {
         var _loc1_:URLRequest = null;
         if(this._auditStream == null)
         {
            this._auditStream = new URLStream();
            this._auditStream.addEventListener(ProgressEvent.PROGRESS,this._auditStreamHandler,false,0,true);
            this._auditStream.addEventListener(Event.COMPLETE,this._auditStreamHandler,false,0,true);
            this._auditStream.addEventListener("ioError",this._auditStreamHandler,false,0,true);
            this._auditStream.addEventListener("securityError",this._auditStreamHandler,false,0,true);
            _loc1_ = new URLRequest();
            _loc1_.data = this._request.data;
            _loc1_.method = this._request.method;
            this._setRequestURL(_loc1_,this._url,!_isLocal || this._url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
            this._auditStream.load(_loc1_);
         }
      }
      
      protected function _closeStream() : void
      {
         if(this._auditStream != null)
         {
            this._auditStream.removeEventListener(ProgressEvent.PROGRESS,this._auditStreamHandler);
            this._auditStream.removeEventListener(Event.COMPLETE,this._auditStreamHandler);
            this._auditStream.removeEventListener("ioError",this._auditStreamHandler);
            this._auditStream.removeEventListener("securityError",this._auditStreamHandler);
            try
            {
               this._auditStream.close();
            }
            catch(error:Error)
            {
            }
            this._auditStream = null;
         }
      }
      
      protected function _auditStreamHandler(param1:Event) : void
      {
         var _loc2_:URLRequest = null;
         if(param1 is ProgressEvent)
         {
            _cachedBytesTotal = (param1 as ProgressEvent).bytesTotal;
            if(this._preferEstimatedBytesInAudit && uint(this.vars.estimatedBytes) > _cachedBytesTotal)
            {
               _cachedBytesTotal = uint(this.vars.estimatedBytes);
            }
         }
         else if(param1.type == "ioError" || param1.type == "securityError")
         {
            if(this.vars.alternateURL != undefined && this.vars.alternateURL != "" && this.vars.alternateURL != this._url)
            {
               this._url = this.vars.alternateURL;
               this._setRequestURL(this._request,this._url);
               _loc2_ = new URLRequest();
               _loc2_.data = this._request.data;
               _loc2_.method = this._request.method;
               this._setRequestURL(_loc2_,this._url,!_isLocal || this._url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
               this._auditStream.load(_loc2_);
               _errorHandler(param1);
               return;
            }
            super._failHandler(param1);
         }
         _auditedSize = true;
         this._closeStream();
         dispatchEvent(new Event("auditedSize"));
      }
      
      override protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         if(this.vars.alternateURL != undefined && this.vars.alternateURL != "" && !this._skipAlternateURL)
         {
            this._skipAlternateURL = true;
            this._url = "temp" + Math.random();
            this.url = this.vars.alternateURL;
            _errorHandler(param1);
         }
         else
         {
            super._failHandler(param1,param2);
         }
      }
      
      protected function _httpStatusHandler(param1:Event) : void
      {
         this._httpStatus = (param1 as Object).status;
         dispatchEvent(new LoaderEvent(LoaderEvent.HTTP_STATUS,this));
      }
      
      public function get url() : String
      {
         return this._url;
      }
      
      public function set url(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(this._url != param1)
         {
            this._url = param1;
            this._setRequestURL(this._request,this._url);
            _loc2_ = Boolean(_status == LoaderStatus.LOADING);
            this._dump(1,LoaderStatus.READY,true);
            if(_loc2_)
            {
               _load();
            }
         }
      }
      
      public function get request() : URLRequest
      {
         return this._request;
      }
      
      public function get httpStatus() : int
      {
         return this._httpStatus;
      }
      
      public function get scriptAccessDenied() : Boolean
      {
         return this._scriptAccessDenied;
      }
   }
}

