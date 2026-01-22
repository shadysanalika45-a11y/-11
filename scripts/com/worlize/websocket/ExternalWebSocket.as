package com.worlize.websocket
{
   import com.hurlant.util.Base64;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.system.Security;
   import flash.utils.ByteArray;
   
   public class ExternalWebSocket extends EventDispatcher
   {
      
      private var uri:String;
      
      public function ExternalWebSocket(param1:String, param2:String, param3:* = null, param4:uint = 10000)
      {
         super();
         this.uri = param1;
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         ExternalInterface.addCallback("onClose",this.onClose);
         ExternalInterface.addCallback("onMessage",this.onMessage);
         ExternalInterface.addCallback("onConnect",this.onConnect);
      }
      
      private function onClose() : *
      {
         var _loc1_:WebSocketEvent = new WebSocketEvent(WebSocketEvent.CLOSED);
         dispatchEvent(_loc1_);
      }
      
      private function onMessage(param1:String) : void
      {
         var _loc2_:WebSocketEvent = new WebSocketEvent(WebSocketEvent.MESSAGE);
         _loc2_.message = new WebSocketMessage();
         _loc2_.message.type = WebSocketMessage.TYPE_BINARY;
         _loc2_.message.binaryData = Base64.decodeToByteArray(param1);
         dispatchEvent(_loc2_);
      }
      
      private function onConnect() : *
      {
         dispatchEvent(new WebSocketEvent(WebSocketEvent.OPEN));
      }
      
      public function sendBytes(param1:ByteArray) : void
      {
         ExternalInterface.call("sendBytes",Base64.encodeByteArray(param1));
      }
      
      public function connect() : *
      {
         ExternalInterface.call("connect",this.uri);
      }
      
      public function close() : *
      {
         ExternalInterface.call("close");
      }
      
      public function get connected() : Boolean
      {
         return this.connected;
      }
   }
}

