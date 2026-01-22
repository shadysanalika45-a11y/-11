package com.smartfoxserver.v2.util
{
   import com.smartfoxserver.v2.core.SFSEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ConfigLoader extends EventDispatcher
   {
      
      public function ConfigLoader()
      {
         super();
      }
      
      public function loadConfig(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onConfigLoadSuccess);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onConfigLoadFailure);
         _loc2_.load(new URLRequest(param1));
      }
      
      private function onConfigLoadSuccess(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:ConfigData = null;
         var _loc4_:URLLoader = param1.target as URLLoader;
         _loc2_ = new XML(_loc4_.data);
         _loc3_ = new ConfigData();
         _loc3_.host = _loc2_.ip;
         _loc3_.port = int(_loc2_.port);
         _loc3_.udpHost = _loc2_.udpIp;
         _loc3_.udpPort = int(_loc2_.udpPort);
         _loc3_.zone = _loc2_.zone;
         if(_loc2_.debug != undefined)
         {
            _loc3_.debug = _loc2_.debug.toLowerCase() == "true" ? Boolean(true) : Boolean(false);
         }
         if(_loc2_.useBlueBox != undefined)
         {
            _loc3_.useBlueBox = _loc2_.useBlueBox.toLowerCase() == "true" ? Boolean(true) : Boolean(false);
         }
         if(_loc2_.httpPort != undefined)
         {
            _loc3_.httpPort = int(_loc2_.httpPort);
         }
         if(_loc2_.httpsPort != undefined)
         {
            _loc3_.httpsPort = int(_loc2_.httpsPort);
         }
         if(_loc2_.blueBoxPollingRate != undefined)
         {
            _loc3_.blueBoxPollingRate = int(_loc2_.blueBoxPollingRate);
         }
         if(_loc2_.forceBlueBoxOverHttps != undefined)
         {
            _loc3_.forceBlueBoxOverHttps = _loc2_.forceBlueBoxOverHttps.toLowerCase() == "true" ? Boolean(true) : Boolean(false);
         }
         var _loc5_:SFSEvent = new SFSEvent(SFSEvent.CONFIG_LOAD_SUCCESS,{"cfg":_loc3_});
         dispatchEvent(_loc5_);
      }
      
      private function onConfigLoadFailure(param1:IOErrorEvent) : void
      {
         var _loc2_:Object = {"message":param1.text};
         var _loc3_:SFSEvent = new SFSEvent(SFSEvent.CONFIG_LOAD_FAILURE,_loc2_);
         dispatchEvent(_loc3_);
      }
   }
}

