package com.oyunstudyosu.utils
{
   import com.hurlant.util.Base64;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class Tracker
   {
      
      private static var urlVars:URLVariables;
      
      private static var url:String = "https://t.sanalika.com/track.php";
      
      private static var request:URLRequest = new URLRequest(url);
      
      public static var domain:String = "";
      
      public static var avatarId:String = "1";
      
      public static var playerId:String = "1";
      
      public static var gender:String = "";
      
      public static var platform:String = "";
      
      public static var instance:String = "";
      
      public static var isActive:Boolean = false;
      
      public static var roomKey:String = "";
      
      public function Tracker()
      {
         super();
      }
      
      public static function track(param1:String = null, param2:String = null, param3:String = null, param4:String = null) : void
      {
         if(isActive && param1 == "ad")
         {
            record(param1,param2,param3,param4);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("Sanalika.track",param1,param2,param3,param4);
         }
      }
      
      private static function record(param1:String, param2:String, param3:String, param4:Object) : void
      {
         urlVars = new URLVariables();
         urlVars.category = param1;
         urlVars.action = param2;
         urlVars.label = param3;
         urlVars.value = param4 == null ? "" : param4.toString();
         urlVars.instance = instance;
         urlVars.trackType = "event";
         urlVars.domain = domain;
         urlVars.media = "";
         urlVars.room = roomKey;
         urlVars.avatarID = avatarId;
         urlVars.playerID = playerId;
         urlVars.gender = gender;
         urlVars.platform = platform;
         trace(JSON.stringify(urlVars));
         request.data = Base64.encode(urlVars.toString());
         request.url = url + "?c=" + param1 + "&a=" + param2;
         request.method = URLRequestMethod.POST;
         request.contentType = "application/xml;charset=utf-8";
         var _loc5_:URLLoader = new URLLoader();
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,onError);
         _loc5_.addEventListener(Event.COMPLETE,onComplete);
         _loc5_.load(request);
      }
      
      protected static function onComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,onError);
         _loc2_.removeEventListener(Event.COMPLETE,onComplete);
         trace("Tracker.complete : " + _loc2_.data);
      }
      
      protected static function onError(param1:IOErrorEvent) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,onError);
         _loc2_.removeEventListener(Event.COMPLETE,onComplete);
         trace("Tracker.error : " + param1.text);
      }
   }
}

