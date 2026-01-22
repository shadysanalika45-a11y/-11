package com.worlize.websocket
{
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   
   public class SmartWebSocket
   {
      
      private var currentWebSocket:Object;
      
      public function SmartWebSocket(param1:String, param2:String, param3:* = null, param4:uint = 10000)
      {
         super();
         if(ExternalInterface.available)
         {
            this.currentWebSocket = new ExternalWebSocket(param1,param2,param3,param4);
         }
         else
         {
            this.currentWebSocket = new WebSocket(param1,param2,param3,param4);
         }
         trace("SmartWebSocket");
      }
      
      public function sendBytes(param1:ByteArray) : void
      {
         this.currentWebSocket.sendBytes(param1);
      }
      
      public function connect() : *
      {
         this.currentWebSocket.connect();
      }
      
      public function close() : *
      {
         this.currentWebSocket.close();
      }
      
      public function get connected() : Boolean
      {
         return this.currentWebSocket.connected;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : *
      {
         this.currentWebSocket.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : *
      {
         this.currentWebSocket.removeEventListener(param1,param2,param3);
      }
   }
}

