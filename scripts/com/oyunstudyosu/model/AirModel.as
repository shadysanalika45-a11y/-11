package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.IAirModel;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.system.Capabilities;
   import flash.ui.Multitouch;
   import flash.ui.MultitouchInputMode;
   
   public class AirModel implements IAirModel
   {
      
      private var stage:Stage;
      
      private var CacheController:Class = null;
      
      private var NativeApplication:Class = null;
      
      public function AirModel(param1:Stage)
      {
         super();
         if(!this.isAir())
         {
            return;
         }
         this.stage = param1;
         if(param1.loaderInfo.applicationDomain.hasDefinition("flash.desktop.NativeApplication"))
         {
            this.NativeApplication = param1.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeApplication") as Class;
            this.NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,this.onSleep);
            this.NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,this.onActivate);
         }
         if(this.isMobile())
         {
            Multitouch.inputMode = MultitouchInputMode.GESTURE;
            param1.quality = StageQuality.LOW;
            this.NativeApplication.nativeApplication.systemIdleMode = "keepAwake";
            (param1 as Object).autoOrients = true;
            (param1 as Object).setAspectRatio("any");
         }
      }
      
      public function isAir() : Boolean
      {
         return Capabilities.playerType == "Desktop";
      }
      
      public function isDesktop() : Boolean
      {
         return this.isAir() && !this.isMobile();
      }
      
      public function isMobile() : Boolean
      {
         return this.isAndroid() || this.isIos();
      }
      
      public function isAndroid() : Boolean
      {
         return Capabilities.version.substr(0,3) == "AND";
      }
      
      public function isIos() : Boolean
      {
         return Capabilities.version.substr(0,3) == "IOS";
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 116)
         {
            Connectr.instance.reset();
         }
         else if(param1.keyCode == 122)
         {
            if(this.stage.displayState == StageDisplayState.NORMAL)
            {
               this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            }
            else
            {
               this.stage.displayState = StageDisplayState.NORMAL;
            }
         }
      }
      
      private function onSleep(param1:Event) : void
      {
         if(this.isMobile())
         {
            this.NativeApplication.nativeApplication.systemIdleMode = "normal";
         }
      }
      
      private function onActivate(param1:Event) : void
      {
         if(!Connectr.instance.serviceModel.sfs.isConnected)
         {
            Connectr.instance.reset();
         }
         if(this.isMobile())
         {
            this.NativeApplication.nativeApplication.systemIdleMode = "keepAwake";
         }
      }
   }
}

