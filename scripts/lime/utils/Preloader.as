package lime.utils
{
   import flash.Boot;
   import flash.Lib;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import haxe.IMap;
   import haxe.ds.ObjectMap;
   import haxe.ds.StringMap;
   import lime.app._Event_Int_Int_Void;
   import lime.app._Event_Void_Void;
   
   public class Preloader extends Sprite
   {
      
      public var simulateProgress:Boolean;
      
      public var preloadStarted:Boolean;
      
      public var preloadComplete:Boolean;
      
      public var onProgress:_Event_Int_Int_Void;
      
      public var onComplete:_Event_Void_Void;
      
      public var loadedStage:Boolean;
      
      public var loadedLibraries:int;
      
      public var libraryNames:Array;
      
      public var libraries:Array;
      
      public var initLibraryNames:Boolean;
      
      public var complete:Boolean;
      
      public var bytesTotalCache:IMap;
      
      public var bytesTotal:int;
      
      public var bytesLoadedCache2:IMap;
      
      public var bytesLoadedCache:ObjectMap;
      
      public var bytesLoaded:int;
      
      public function Preloader()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         bytesTotalCache = new StringMap();
         bytesLoadedCache2 = new StringMap();
         bytesLoadedCache = new ObjectMap();
         onProgress = new _Event_Int_Int_Void();
         onComplete = new _Event_Void_Void();
         super();
         bytesLoaded = 0;
         bytesTotal = 0;
         libraries = [];
         libraryNames = [];
         onProgress.add(update);
         Lib.current.addChild(this);
         Lib.current.loaderInfo.addEventListener(Event.COMPLETE,loaderInfo_onComplete);
         Lib.current.loaderInfo.addEventListener(Event.INIT,loaderInfo_onInit);
         Lib.current.loaderInfo.addEventListener(ProgressEvent.PROGRESS,loaderInfo_onProgress);
         Lib.current.addEventListener(Event.ENTER_FRAME,current_onEnter);
      }
      
      public function updateProgress() : void
      {
         if(!simulateProgress)
         {
            onProgress.dispatch(bytesLoaded,bytesTotal);
         }
         if(!simulateProgress && loadedStage && loadedLibraries == int(libraries.length) + int(libraryNames.length))
         {
            if(!preloadComplete)
            {
               preloadComplete = true;
               Log.verbose("Preload complete",{
                  "fileName":"lime/utils/Preloader.hx",
                  "lineNumber":306,
                  "className":"lime.utils.Preloader",
                  "methodName":"updateProgress"
               });
            }
            start();
         }
      }
      
      public function update(param1:int, param2:int) : void
      {
      }
      
      public function start() : void
      {
         if(complete || simulateProgress || !preloadComplete)
         {
            return;
         }
         complete = true;
         if(Lib.current.contains(this))
         {
            Lib.current.removeChild(this);
         }
         onComplete.dispatch();
      }
      
      public function loaderInfo_onProgress(param1:ProgressEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as StringMap;
         var _loc5_:* = null as StringMap;
         var _loc2_:StringMap = bytesTotalCache;
         if(("_root" in StringMap.reserved ? _loc2_.getReserved("_root") : _loc2_.h["_root"]) > 0)
         {
            _loc3_ = int(Lib.current.loaderInfo.bytesLoaded);
            _loc4_ = bytesLoadedCache2;
            bytesLoaded += _loc3_ - ("_root" in StringMap.reserved ? _loc4_.getReserved("_root") : _loc4_.h["_root"]);
            _loc5_ = bytesLoadedCache2;
            if("_root" in StringMap.reserved)
            {
               _loc5_.setReserved("_root",_loc3_);
            }
            else
            {
               _loc5_.h["_root"] = _loc3_;
            }
            updateProgress();
         }
      }
      
      public function loaderInfo_onInit(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = null as StringMap;
         bytesTotal += Lib.current.loaderInfo.bytesTotal;
         _loc2_ = int(Lib.current.loaderInfo.bytesTotal);
         var _loc3_:StringMap = bytesTotalCache;
         if("_root" in StringMap.reserved)
         {
            _loc3_.setReserved("_root",_loc2_);
         }
         else
         {
            _loc3_.h["_root"] = _loc2_;
         }
         _loc3_ = bytesTotalCache;
         if(("_root" in StringMap.reserved ? _loc3_.getReserved("_root") : _loc3_.h["_root"]) > 0)
         {
            _loc2_ = int(Lib.current.loaderInfo.bytesLoaded);
            bytesLoaded += _loc2_;
            _loc4_ = bytesLoadedCache2;
            if("_root" in StringMap.reserved)
            {
               _loc4_.setReserved("_root",_loc2_);
            }
            else
            {
               _loc4_.h["_root"] = _loc2_;
            }
            updateProgress();
         }
      }
      
      public function loaderInfo_onComplete(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as StringMap;
         var _loc5_:* = null as StringMap;
         var _loc2_:StringMap = bytesTotalCache;
         if(("_root" in StringMap.reserved ? _loc2_.getReserved("_root") : _loc2_.h["_root"]) > 0)
         {
            _loc3_ = int(Lib.current.loaderInfo.bytesLoaded);
            _loc4_ = bytesLoadedCache2;
            bytesLoaded += _loc3_ - ("_root" in StringMap.reserved ? _loc4_.getReserved("_root") : _loc4_.h["_root"]);
            _loc5_ = bytesLoadedCache2;
            if("_root" in StringMap.reserved)
            {
               _loc5_.setReserved("_root",_loc3_);
            }
            else
            {
               _loc5_.h["_root"] = _loc3_;
            }
            updateProgress();
         }
      }
      
      public function loadedAssetLibrary(param1:String = undefined) : void
      {
         ++loadedLibraries;
         var _loc2_:int = loadedLibraries;
         if(!preloadStarted)
         {
            _loc2_++;
         }
         var _loc3_:* = int(libraries.length) + int(libraryNames.length);
         if(param1 != null)
         {
            Log.verbose("Loaded asset library: " + param1 + " [" + _loc2_ + "/" + _loc3_ + "]",{
               "fileName":"lime/utils/Preloader.hx",
               "lineNumber":197,
               "className":"lime.utils.Preloader",
               "methodName":"loadedAssetLibrary"
            });
         }
         else
         {
            Log.verbose("Loaded asset library [" + _loc2_ + "/" + _loc3_ + "]",{
               "fileName":"lime/utils/Preloader.hx",
               "lineNumber":201,
               "className":"lime.utils.Preloader",
               "methodName":"loadedAssetLibrary"
            });
         }
         updateProgress();
      }
      
      public function load() : void
      {
         var library:Array;
         var _gthis:Preloader;
         var _loc3_:* = null;
         var _loc4_:* = null as String;
         _gthis = this;
         var _loc1_:int = 0;
         var _loc2_:Array = libraries;
         while(_loc1_ < int(_loc2_.length))
         {
            _loc3_ = _loc2_[_loc1_];
            _loc1_++;
            bytesTotal += _loc3_.bytesTotal;
         }
         loadedLibraries = -1;
         preloadStarted = false;
         _loc1_ = 0;
         _loc2_ = libraries;
         while(_loc1_ < int(_loc2_.length))
         {
            library = [_loc2_[_loc1_]];
            _loc1_++;
            Log.verbose("Preloading asset library",{
               "fileName":"lime/utils/Preloader.hx",
               "lineNumber":134,
               "className":"lime.utils.Preloader",
               "methodName":"load"
            });
            library[0].load().onProgress((function(param1:Array):Function
            {
               var library:Array = param1;
               return function(param1:int, param2:*):void
               {
                  if(_gthis.bytesLoadedCache[library[0]] == null)
                  {
                     _gthis.bytesLoaded += param1;
                  }
                  else
                  {
                     _gthis.bytesLoaded += param1 - _gthis.bytesLoadedCache[library[0]];
                  }
                  _gthis.bytesLoadedCache[library[0]] = param1;
                  if(!_gthis.simulateProgress)
                  {
                     _gthis.onProgress.dispatch(_gthis.bytesLoaded,_gthis.bytesTotal);
                  }
               };
            })(library)).onComplete((function(param1:Array):Function
            {
               var library:Array = param1;
               return function(param1:*):void
               {
                  if(_gthis.bytesLoadedCache[library[0]] == null)
                  {
                     _gthis.bytesLoaded += library[0].bytesTotal;
                  }
                  else
                  {
                     _gthis.bytesLoaded += int(library[0].bytesTotal) - _gthis.bytesLoadedCache[library[0]];
                  }
                  _gthis.loadedAssetLibrary();
               };
            })(library)).onError((function():Function
            {
               return function(param1:*):void
               {
                  Log.error(param1,{
                     "fileName":"lime/utils/Preloader.hx",
                     "lineNumber":170,
                     "className":"lime.utils.Preloader",
                     "methodName":"load"
                  });
               };
            })());
         }
         _loc1_ = 0;
         _loc2_ = libraryNames;
         while(_loc1_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc1_];
            _loc1_++;
            bytesTotal += 200;
         }
         ++loadedLibraries;
         preloadStarted = true;
         updateProgress();
      }
      
      public function current_onEnter(param1:Event) : void
      {
         var _loc2_:* = null as StringMap;
         var _loc3_:int = 0;
         var _loc4_:* = null as StringMap;
         var _loc5_:* = null as StringMap;
         if(!loadedStage && Lib.current.loaderInfo.bytesLoaded == Lib.current.loaderInfo.bytesTotal)
         {
            loadedStage = true;
            _loc2_ = bytesTotalCache;
            if(("_root" in StringMap.reserved ? _loc2_.getReserved("_root") : _loc2_.h["_root"]) > 0)
            {
               _loc3_ = int(Lib.current.loaderInfo.bytesLoaded);
               _loc4_ = bytesLoadedCache2;
               bytesLoaded += _loc3_ - ("_root" in StringMap.reserved ? _loc4_.getReserved("_root") : _loc4_.h["_root"]);
               _loc5_ = bytesLoadedCache2;
               if("_root" in StringMap.reserved)
               {
                  _loc5_.setReserved("_root",_loc3_);
               }
               else
               {
                  _loc5_.h["_root"] = _loc3_;
               }
               updateProgress();
            }
         }
         if(loadedStage)
         {
            Lib.current.removeEventListener(Event.ENTER_FRAME,current_onEnter);
            Lib.current.loaderInfo.removeEventListener(Event.COMPLETE,loaderInfo_onComplete);
            Lib.current.loaderInfo.removeEventListener(Event.INIT,loaderInfo_onInit);
            Lib.current.loaderInfo.removeEventListener(ProgressEvent.PROGRESS,loaderInfo_onProgress);
            updateProgress();
         }
      }
      
      public function addLibraryName(param1:String) : void
      {
         if(int(libraryNames.indexOf(param1)) == -1)
         {
            libraryNames.push(param1);
         }
      }
      
      public function addLibrary(param1:*) : void
      {
         libraries.push(param1);
      }
   }
}

