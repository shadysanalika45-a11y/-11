package com.greensock.loading
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.core.LoaderItem;
   import com.greensock.loading.display.ContentDisplay;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.media.SoundTransform;
   import flash.media.Video;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class VideoLoader extends LoaderItem
   {
      
      private static var _classActivated:Boolean = _activateClass("VideoLoader",VideoLoader,"flv,f4v,mp4,mov");
      
      public static const VIDEO_COMPLETE:String = "videoComplete";
      
      public static const VIDEO_BUFFER_FULL:String = "videoBufferFull";
      
      public static const VIDEO_BUFFER_EMPTY:String = "videoBufferEmpty";
      
      public static const VIDEO_PAUSE:String = "videoPause";
      
      public static const VIDEO_PLAY:String = "videoPlay";
      
      public static const VIDEO_CUE_POINT:String = "videoCuePoint";
      
      public static const PLAY_PROGRESS:String = "playProgress";
      
      protected var _ns:NetStream;
      
      protected var _nc:NetConnection;
      
      protected var _auditNS:NetStream;
      
      protected var _video:Video;
      
      protected var _sound:SoundTransform;
      
      protected var _videoPaused:Boolean;
      
      protected var _videoComplete:Boolean;
      
      protected var _forceTime:Number;
      
      protected var _duration:Number;
      
      protected var _pausePending:Boolean;
      
      protected var _volume:Number;
      
      protected var _sprite:Sprite;
      
      protected var _initted:Boolean;
      
      protected var _bufferMode:Boolean;
      
      protected var _repeatCount:uint;
      
      protected var _bufferFull:Boolean;
      
      protected var _dispatchPlayProgress:Boolean;
      
      protected var _prevTime:Number;
      
      protected var _firstCuePoint:CuePoint;
      
      protected var _renderedOnce:Boolean;
      
      protected var _timer:Timer;
      
      public var metaData:Object;
      
      public var autoAdjustBuffer:Boolean;
      
      public function VideoLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _type = "VideoLoader";
         this._nc = new NetConnection();
         this._nc.connect(null);
         this._nc.addEventListener("asyncError",_failHandler,false,0,true);
         this._nc.addEventListener("securityError",_failHandler,false,0,true);
         this._timer = new Timer(50,0);
         this._timer.addEventListener(TimerEvent.TIMER,this._renderHandler,false,0,true);
         this._video = new Video(int(this.vars.width) || 320,int(this.vars.height) || 240);
         this._video.smoothing = Boolean(this.vars.smoothing != false);
         this._video.deblocking = uint(this.vars.deblocking);
         this._video.addEventListener(Event.ADDED_TO_STAGE,this._videoAddedToStage,false,0,true);
         this._video.addEventListener(Event.REMOVED_FROM_STAGE,this._videoRemovedFromStage,false,0,true);
         this._refreshNetStream();
         this._duration = isNaN(this.vars.estimatedDuration) ? 200 : Number(this.vars.estimatedDuration);
         this._bufferMode = _preferEstimatedBytesInAudit = Boolean(this.vars.bufferMode == true);
         this._videoPaused = this._pausePending = Boolean(this.vars.autoPlay == false);
         this.autoAdjustBuffer = this.vars.autoAdjustBuffer != false;
         this.volume = "volume" in this.vars ? Number(this.vars.volume) : 1;
         if(LoaderMax.contentDisplayClass is Class)
         {
            this._sprite = new LoaderMax.contentDisplayClass(this);
            if(!this._sprite.hasOwnProperty("rawContent"))
            {
               throw new Error("LoaderMax.contentDisplayClass must be set to a class with a \'rawContent\' property, like com.greensock.loading.display.ContentDisplay");
            }
         }
         else
         {
            this._sprite = new ContentDisplay(this);
         }
         Object(this._sprite).rawContent = null;
      }
      
      protected function _refreshNetStream() : void
      {
         if(this._ns != null)
         {
            this._ns.pause();
            try
            {
               this._ns.close();
            }
            catch(error:Error)
            {
            }
            this._sprite.removeEventListener(Event.ENTER_FRAME,this._playProgressHandler);
            this._video.attachNetStream(null);
            this._video.clear();
            this._ns.client = {};
            this._ns.removeEventListener(NetStatusEvent.NET_STATUS,this._statusHandler);
            this._ns.removeEventListener("ioError",_failHandler);
            this._ns.removeEventListener("asyncError",_failHandler);
            this._ns.removeEventListener(Event.RENDER,this._renderHandler);
         }
         this._prevTime = 0;
         this._ns = this.vars.netStream is NetStream ? this.vars.netStream : new NetStream(this._nc);
         this._ns.checkPolicyFile = Boolean(this.vars.checkPolicyFile == true);
         this._ns.client = {
            "onMetaData":this._metaDataHandler,
            "onCuePoint":this._cuePointHandler
         };
         this._ns.addEventListener(NetStatusEvent.NET_STATUS,this._statusHandler,false,0,true);
         this._ns.addEventListener("ioError",_failHandler,false,0,true);
         this._ns.addEventListener("asyncError",_failHandler,false,0,true);
         this._ns.bufferTime = isNaN(this.vars.bufferTime) ? 5 : Number(this.vars.bufferTime);
         this._sound = this._ns.soundTransform;
      }
      
      override protected function _load() : void
      {
         _prepRequest();
         this._repeatCount = 0;
         this._prevTime = 0;
         this._bufferFull = false;
         this._renderedOnce = false;
         this.metaData = null;
         this._pausePending = this._videoPaused;
         if(this._videoPaused)
         {
            this._setForceTime(0);
            this._sound.volume = 0;
            this._ns.soundTransform = this._sound;
         }
         else
         {
            this.volume = this._volume;
         }
         this._sprite.addEventListener(Event.ENTER_FRAME,this._loadingProgressCheck);
         this._waitForRender();
         this._videoComplete = this._initted = false;
         this._ns.play(_request.url);
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         this._sprite.removeEventListener(Event.ENTER_FRAME,this._loadingProgressCheck);
         this._sprite.removeEventListener(Event.ENTER_FRAME,this._playProgressHandler);
         this._sprite.removeEventListener(Event.ENTER_FRAME,this._detachNS);
         this._ns.removeEventListener(Event.RENDER,this._renderHandler);
         this._timer.stop();
         this._forceTime = NaN;
         this._prevTime = 0;
         this._initted = false;
         this._renderedOnce = false;
         this.metaData = null;
         if(param1 != 2)
         {
            this._refreshNetStream();
            (this._sprite as Object).rawContent = null;
            if(this._video.parent != null)
            {
               this._video.parent.removeChild(this._video);
            }
         }
         if(param1 >= 2)
         {
            if(param1 == 3)
            {
               (this._sprite as Object).dispose(false,false);
            }
            this._timer.removeEventListener(TimerEvent.TIMER,this._renderHandler);
            this._nc.removeEventListener("asyncError",_failHandler);
            this._nc.removeEventListener("securityError",_failHandler);
            this._ns.removeEventListener(NetStatusEvent.NET_STATUS,this._statusHandler);
            this._ns.removeEventListener("ioError",_failHandler);
            this._ns.removeEventListener("asyncError",_failHandler);
            this._video.removeEventListener(Event.ADDED_TO_STAGE,this._videoAddedToStage);
            this._video.removeEventListener(Event.REMOVED_FROM_STAGE,this._videoRemovedFromStage);
            this._firstCuePoint = null;
            (this._sprite as Object).gcProtect = param1 == 3 ? null : this._ns;
            this._ns.client = {};
            this._video = null;
            this._ns = null;
            this._nc = null;
            this._sound = null;
            (this._sprite as Object).loader = null;
            this._sprite = null;
            this._timer = null;
         }
         super._dump(param1,param2,param3);
      }
      
      public function setContentDisplay(param1:Sprite) : void
      {
         this._sprite = param1;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(param1 == PLAY_PROGRESS)
         {
            this._dispatchPlayProgress = true;
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      override protected function _calculateProgress() : void
      {
         _cachedBytesLoaded = this._ns.bytesLoaded;
         if(_cachedBytesLoaded > 1)
         {
            if(this._bufferMode)
            {
               _cachedBytesTotal = this._ns.bytesTotal * (this._ns.bufferTime / this._duration);
               if(this._ns.bufferLength > 0)
               {
                  _cachedBytesLoaded = this._ns.bufferLength / this._ns.bufferTime * _cachedBytesTotal;
               }
            }
            else
            {
               _cachedBytesTotal = this._ns.bytesTotal;
            }
            if(_cachedBytesTotal <= _cachedBytesLoaded)
            {
               _cachedBytesTotal = this.metaData != null && this._renderedOnce && this._initted || getTimer() - _time >= 10000 ? _cachedBytesLoaded : uint(int(1.01 * _cachedBytesLoaded) + 1);
            }
            if(!_auditedSize)
            {
               _auditedSize = true;
               dispatchEvent(new Event("auditedSize"));
            }
         }
         _cacheIsDirty = false;
      }
      
      public function addASCuePoint(param1:Number, param2:String = "", param3:Object = null) : Object
      {
         var _loc4_:CuePoint = this._firstCuePoint;
         if(_loc4_ != null && _loc4_.time > param1)
         {
            _loc4_ = null;
         }
         else
         {
            while(_loc4_ && _loc4_.time <= param1 && _loc4_.next && _loc4_.next.time <= param1)
            {
               _loc4_ = _loc4_.next;
            }
         }
         var _loc5_:CuePoint = new CuePoint(param1,param2,param3,_loc4_);
         if(_loc4_ == null)
         {
            if(this._firstCuePoint != null)
            {
               this._firstCuePoint.prev = _loc5_;
               _loc5_.next = this._firstCuePoint;
            }
            this._firstCuePoint = _loc5_;
         }
         return _loc5_;
      }
      
      public function removeASCuePoint(param1:*) : Object
      {
         var _loc2_:CuePoint = this._firstCuePoint;
         while(_loc2_)
         {
            if(_loc2_ == param1 || _loc2_.time == param1 || _loc2_.name == param1)
            {
               if(_loc2_.next)
               {
                  _loc2_.next.prev = _loc2_.prev;
               }
               if(_loc2_.prev)
               {
                  _loc2_.prev.next = _loc2_.next;
               }
               else if(_loc2_ == this._firstCuePoint)
               {
                  this._firstCuePoint = _loc2_.next;
               }
               _loc2_.next = _loc2_.prev = null;
               _loc2_.gc = true;
               return _loc2_;
            }
            _loc2_ = _loc2_.next;
         }
         return null;
      }
      
      public function getCuePointTime(param1:String) : Number
      {
         var _loc3_:int = 0;
         if(this.metaData != null && this.metaData.cuePoints is Array)
         {
            _loc3_ = int(this.metaData.cuePoints.length);
            while(--_loc3_ > -1)
            {
               if(param1 == this.metaData.cuePoints[_loc3_].name)
               {
                  return Number(this.metaData.cuePoints[_loc3_].time);
               }
            }
         }
         var _loc2_:CuePoint = this._firstCuePoint;
         while(_loc2_)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_.time;
            }
            _loc2_ = _loc2_.next;
         }
         return NaN;
      }
      
      public function gotoVideoCuePoint(param1:String, param2:Boolean = false, param3:Boolean = true) : Number
      {
         return this.gotoVideoTime(this.getCuePointTime(param1),param2,param3);
      }
      
      public function pauseVideo(param1:Event = null) : void
      {
         this.videoPaused = true;
      }
      
      public function playVideo(param1:Event = null) : void
      {
         this.videoPaused = false;
      }
      
      public function gotoVideoTime(param1:Number, param2:Boolean = false, param3:Boolean = true) : Number
      {
         if(isNaN(param1))
         {
            return NaN;
         }
         if(param1 > this._duration)
         {
            param1 = this._duration;
         }
         var _loc4_:* = param1 != this.videoTime;
         if(this._initted && this._renderedOnce && _loc4_)
         {
            this._ns.seek(param1);
            this._bufferFull = false;
         }
         this._videoComplete = false;
         this._setForceTime(param1);
         if(_loc4_)
         {
            if(!param3)
            {
               this._playProgressHandler(null);
            }
            else
            {
               this._prevTime = param1;
            }
         }
         if(param2)
         {
            this.playVideo();
         }
         if(_loc4_ && param3 && this._dispatchPlayProgress)
         {
            dispatchEvent(new LoaderEvent(PLAY_PROGRESS,this));
         }
         return param1;
      }
      
      protected function _setForceTime(param1:Number) : void
      {
         if(!(this._forceTime || this._forceTime == 0))
         {
            this._waitForRender();
         }
         this._forceTime = param1;
      }
      
      protected function _waitForRender() : void
      {
         this._ns.addEventListener(Event.RENDER,this._renderHandler,false,0,true);
         this._timer.reset();
         this._timer.start();
      }
      
      protected function _onBufferFull() : void
      {
         if(!this._renderedOnce && !this._timer.running)
         {
            this._waitForRender();
            return;
         }
         if(this._pausePending)
         {
            if(!this._initted && getTimer() - _time < 10000)
            {
               this._video.attachNetStream(null);
               return;
            }
            if(this._renderedOnce)
            {
               this._applyPendingPause();
            }
         }
         if(!this._bufferFull)
         {
            this._bufferFull = true;
            dispatchEvent(new LoaderEvent(VIDEO_BUFFER_FULL,this));
         }
      }
      
      protected function _applyPendingPause() : void
      {
         this._pausePending = false;
         this.volume = this._volume;
         this._ns.seek(this._forceTime || 0);
         if(this._video.stage != null)
         {
            this._video.attachNetStream(this._ns);
         }
         this._ns.pause();
      }
      
      protected function _forceInit() : void
      {
         if(this._ns.bufferTime >= this._duration)
         {
            this._ns.bufferTime = uint(this._duration - 1);
         }
         this._initted = true;
         if(!this._bufferFull && this._ns.bufferLength >= this._ns.bufferTime)
         {
            this._onBufferFull();
         }
         (this._sprite as Object).rawContent = this._video;
         if(!this._bufferFull && this._pausePending && this._renderedOnce)
         {
            this._video.attachNetStream(null);
         }
      }
      
      protected function _metaDataHandler(param1:Object) : void
      {
         if(this.metaData == null || this.metaData.cuePoints == null)
         {
            this.metaData = param1;
         }
         this._duration = param1.duration;
         if("width" in param1)
         {
            this._video.width = Number(param1.width);
            this._video.height = Number(param1.height);
         }
         this._forceInit();
         dispatchEvent(new LoaderEvent(LoaderEvent.INIT,this,"",param1));
      }
      
      protected function _cuePointHandler(param1:Object) : void
      {
         if(!this._videoPaused)
         {
            dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT,this,"",param1));
         }
      }
      
      protected function _playProgressHandler(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:CuePoint = null;
         var _loc4_:CuePoint = null;
         if(!this._bufferFull && this._ns.bufferLength >= this._ns.bufferTime)
         {
            this._onBufferFull();
         }
         if(Boolean(this._firstCuePoint) || this._dispatchPlayProgress)
         {
            _loc2_ = this._prevTime;
            this._prevTime = this.videoTime;
            _loc4_ = this._firstCuePoint;
            while(_loc4_)
            {
               _loc3_ = _loc4_.next;
               if(_loc4_.time > _loc2_ && _loc4_.time <= this._prevTime && !_loc4_.gc)
               {
                  dispatchEvent(new LoaderEvent(VIDEO_CUE_POINT,this,"",_loc4_));
               }
               _loc4_ = _loc3_;
            }
            if(this._dispatchPlayProgress && _loc2_ != this._prevTime)
            {
               dispatchEvent(new LoaderEvent(PLAY_PROGRESS,this));
            }
         }
      }
      
      protected function _statusHandler(param1:NetStatusEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:String = param1.info.code;
         if(_loc2_ == "NetStream.Play.Start")
         {
            if(!this._pausePending)
            {
               this._sprite.addEventListener(Event.ENTER_FRAME,this._playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PLAY,this));
            }
         }
         dispatchEvent(new LoaderEvent(NetStatusEvent.NET_STATUS,this,_loc2_,param1.info));
         if(_loc2_ == "NetStream.Play.Stop")
         {
            this._bufferFull = false;
            if(this._videoPaused)
            {
               return;
            }
            if(this.vars.repeat == -1 || uint(this.vars.repeat) > this._repeatCount)
            {
               ++this._repeatCount;
               dispatchEvent(new LoaderEvent(VIDEO_COMPLETE,this));
               this.gotoVideoTime(0,true,true);
            }
            else
            {
               this._videoComplete = true;
               this.videoPaused = true;
               this._playProgressHandler(null);
               dispatchEvent(new LoaderEvent(VIDEO_COMPLETE,this));
            }
         }
         else if(_loc2_ == "NetStream.Buffer.Full")
         {
            this._onBufferFull();
         }
         else if(_loc2_ == "NetStream.Buffer.Empty")
         {
            this._bufferFull = false;
            _loc3_ = this.duration - this.videoTime;
            _loc4_ = 1 / this.progress * this.loadTime;
            if(this.autoAdjustBuffer && _loc4_ > _loc3_)
            {
               this._ns.bufferTime = _loc3_ * (1 - _loc3_ / _loc4_) * 0.9;
            }
            dispatchEvent(new LoaderEvent(VIDEO_BUFFER_EMPTY,this));
         }
         else if(_loc2_ == "NetStream.Play.StreamNotFound" || _loc2_ == "NetConnection.Connect.Failed" || _loc2_ == "NetStream.Play.Failed" || _loc2_ == "NetStream.Play.FileStructureInvalid" || _loc2_ == "The MP4 doesn\'t contain any supported tracks")
         {
            _failHandler(new LoaderEvent(LoaderEvent.ERROR,this,_loc2_));
         }
      }
      
      protected function _loadingProgressCheck(param1:Event) : void
      {
         var _loc2_:uint = _cachedBytesLoaded;
         var _loc3_:uint = _cachedBytesTotal;
         if(!this._bufferFull && this._ns.bufferLength >= this._ns.bufferTime)
         {
            this._onBufferFull();
         }
         this._calculateProgress();
         if(_cachedBytesLoaded == _cachedBytesTotal)
         {
            this._sprite.removeEventListener(Event.ENTER_FRAME,this._loadingProgressCheck);
            if(!this._bufferFull)
            {
               this._onBufferFull();
            }
            if(!this._initted)
            {
               this._forceInit();
               _errorHandler(new LoaderEvent(LoaderEvent.ERROR,this,"No metaData was received."));
            }
            _completeHandler(param1);
         }
         else if(_dispatchProgress && _cachedBytesLoaded / _cachedBytesTotal != _loc2_ / _loc3_)
         {
            dispatchEvent(new LoaderEvent(LoaderEvent.PROGRESS,this));
         }
      }
      
      override public function auditSize() : void
      {
         var _loc1_:URLRequest = null;
         if(_url.substr(0,4) == "http" && _url.indexOf("://") != -1)
         {
            super.auditSize();
         }
         else if(this._auditNS == null)
         {
            this._auditNS = new NetStream(this._nc);
            this._auditNS.bufferTime = isNaN(this.vars.bufferTime) ? 5 : Number(this.vars.bufferTime);
            this._auditNS.client = {
               "onMetaData":this._auditHandler,
               "onCuePoint":this._auditHandler
            };
            this._auditNS.addEventListener(NetStatusEvent.NET_STATUS,this._auditHandler,false,0,true);
            this._auditNS.addEventListener("ioError",this._auditHandler,false,0,true);
            this._auditNS.addEventListener("asyncError",this._auditHandler,false,0,true);
            this._auditNS.soundTransform = new SoundTransform(0);
            _loc1_ = new URLRequest();
            _loc1_.data = _request.data;
            _setRequestURL(_loc1_,_url,!_isLocal || _url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
            this._auditNS.play(_loc1_.url);
         }
      }
      
      protected function _auditHandler(param1:Event = null) : void
      {
         var _loc4_:URLRequest = null;
         var _loc2_:String = param1 == null ? "" : param1.type;
         var _loc3_:String = param1 == null || !(param1 is NetStatusEvent) ? "" : NetStatusEvent(param1).info.code;
         if(param1 != null && "duration" in param1)
         {
            this._duration = Object(param1).duration;
         }
         if(this._auditNS != null)
         {
            _cachedBytesTotal = this._auditNS.bytesTotal;
            if(this._bufferMode && this._duration != 0)
            {
               _cachedBytesTotal *= this._auditNS.bufferTime / this._duration;
            }
         }
         if(_loc2_ == "ioError" || _loc2_ == "asyncError" || _loc3_ == "NetStream.Play.StreamNotFound" || _loc3_ == "NetConnection.Connect.Failed" || _loc3_ == "NetStream.Play.Failed" || _loc3_ == "NetStream.Play.FileStructureInvalid" || _loc3_ == "The MP4 doesn\'t contain any supported tracks")
         {
            if(this.vars.alternateURL != undefined && this.vars.alternateURL != "" && this.vars.alternateURL != _url)
            {
               _url = this.vars.alternateURL;
               _setRequestURL(_request,_url);
               _loc4_ = new URLRequest();
               _loc4_.data = _request.data;
               _setRequestURL(_loc4_,_url,!_isLocal || _url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
               this._auditNS.play(_loc4_.url);
               _errorHandler(new LoaderEvent(LoaderEvent.ERROR,this,_loc3_));
               return;
            }
            super._failHandler(new LoaderEvent(LoaderEvent.ERROR,this,_loc3_));
         }
         _auditedSize = true;
         this._closeStream();
         dispatchEvent(new Event("auditedSize"));
      }
      
      override protected function _closeStream() : void
      {
         if(this._auditNS != null)
         {
            this._auditNS.pause();
            try
            {
               this._auditNS.close();
            }
            catch(error:Error)
            {
            }
            this._auditNS.client = {};
            this._auditNS.removeEventListener(NetStatusEvent.NET_STATUS,this._auditHandler);
            this._auditNS.removeEventListener("ioError",this._auditHandler);
            this._auditNS.removeEventListener("asyncError",this._auditHandler);
            this._auditNS = null;
         }
         else
         {
            super._closeStream();
         }
      }
      
      override protected function _auditStreamHandler(param1:Event) : void
      {
         if(param1 is ProgressEvent && this._bufferMode)
         {
            (param1 as ProgressEvent).bytesTotal *= this._ns.bufferTime / this._duration;
         }
         super._auditStreamHandler(param1);
      }
      
      protected function _renderHandler(param1:Event) : void
      {
         this._renderedOnce = true;
         if(!this._videoPaused || this._initted)
         {
            this._forceTime = NaN;
            this._timer.stop();
            this._ns.removeEventListener(Event.RENDER,this._renderHandler);
         }
         if(this._pausePending)
         {
            if(this._bufferFull)
            {
               this._applyPendingPause();
            }
            else
            {
               this._sprite.addEventListener(Event.ENTER_FRAME,this._detachNS,false,100,true);
            }
         }
      }
      
      private function _detachNS(param1:Event) : void
      {
         this._sprite.removeEventListener(Event.ENTER_FRAME,this._detachNS);
         if(!this._bufferFull && this._pausePending)
         {
            this._video.attachNetStream(null);
         }
      }
      
      protected function _videoAddedToStage(param1:Event) : void
      {
         this._video.attachNetStream(this._ns);
         this._ns.seek(this.videoTime);
      }
      
      protected function _videoRemovedFromStage(param1:Event) : void
      {
         this._video.attachNetStream(null);
         this._video.clear();
      }
      
      override public function get content() : *
      {
         return this._sprite;
      }
      
      public function get rawContent() : Video
      {
         return this._video;
      }
      
      public function get netStream() : NetStream
      {
         return this._ns;
      }
      
      public function get videoPaused() : Boolean
      {
         return this._videoPaused;
      }
      
      public function set videoPaused(param1:Boolean) : void
      {
         var _loc2_:Boolean = Boolean(param1 != this._videoPaused);
         this._videoPaused = param1;
         if(this._videoPaused)
         {
            if(!this._renderedOnce)
            {
               this._setForceTime(0);
               this._pausePending = true;
               this._sound.volume = 0;
               this._ns.soundTransform = this._sound;
            }
            else
            {
               this._pausePending = false;
               this.volume = this._volume;
               this._ns.pause();
            }
            if(_loc2_)
            {
               this._sprite.removeEventListener(Event.ENTER_FRAME,this._playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PAUSE,this));
            }
         }
         else
         {
            if(this._pausePending || !this._bufferFull)
            {
               if(this._video.stage != null)
               {
                  this._video.attachNetStream(this._ns);
               }
               if(this._initted && this._renderedOnce)
               {
                  this._ns.seek(this.videoTime);
                  this._bufferFull = false;
               }
               this._pausePending = false;
            }
            this.volume = this._volume;
            this._ns.resume();
            if(_loc2_)
            {
               this._sprite.addEventListener(Event.ENTER_FRAME,this._playProgressHandler);
               dispatchEvent(new LoaderEvent(VIDEO_PLAY,this));
            }
         }
      }
      
      public function get bufferProgress() : Number
      {
         if(uint(this._ns.bytesTotal) < 5)
         {
            return 0;
         }
         return this._ns.bufferLength > this._ns.bufferTime ? 1 : this._ns.bufferLength / this._ns.bufferTime;
      }
      
      public function get playProgress() : Number
      {
         return this._videoComplete ? 1 : this.videoTime / this._duration;
      }
      
      public function set playProgress(param1:Number) : void
      {
         if(this._duration != 0)
         {
            this.gotoVideoTime(param1 * this._duration,!this._videoPaused,true);
         }
      }
      
      public function get volume() : Number
      {
         return this._volume;
      }
      
      public function set volume(param1:Number) : void
      {
         this._sound.volume = this._volume = param1;
         this._ns.soundTransform = this._sound;
      }
      
      public function get videoTime() : Number
      {
         if(this._videoComplete)
         {
            return this._duration;
         }
         if(Boolean(this._forceTime) || this._forceTime == 0)
         {
            return this._forceTime;
         }
         if(this._ns.time > this._duration)
         {
            return this._duration * 0.995;
         }
         return this._ns.time;
      }
      
      public function set videoTime(param1:Number) : void
      {
         this.gotoVideoTime(param1,!this._videoPaused,true);
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function get bufferMode() : Boolean
      {
         return this._bufferMode;
      }
      
      public function set bufferMode(param1:Boolean) : void
      {
         this._bufferMode = param1;
         _preferEstimatedBytesInAudit = this._bufferMode;
         this._calculateProgress();
         if(_cachedBytesLoaded < _cachedBytesTotal && _status == LoaderStatus.COMPLETED)
         {
            _status = LoaderStatus.LOADING;
            this._sprite.addEventListener(Event.ENTER_FRAME,this._loadingProgressCheck);
         }
      }
   }
}

class CuePoint
{
   
   public var next:CuePoint;
   
   public var prev:CuePoint;
   
   public var time:Number;
   
   public var name:String;
   
   public var parameters:Object;
   
   public var gc:Boolean;
   
   public function CuePoint(param1:Number, param2:String, param3:Object, param4:CuePoint)
   {
      super();
      this.time = param1;
      this.name = param2;
      this.parameters = param3;
      if(param4)
      {
         this.prev = param4;
         if(param4.next)
         {
            param4.next.prev = this;
            this.next = param4.next;
         }
         param4.next = this;
      }
   }
}
