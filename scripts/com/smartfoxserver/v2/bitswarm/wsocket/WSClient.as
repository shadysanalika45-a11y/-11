package com.smartfoxserver.v2.bitswarm.wsocket
{
   import com.worlize.websocket.SmartWebSocket;
   import com.worlize.websocket.WebSocketErrorEvent;
   import com.worlize.websocket.WebSocketEvent;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   
   public class WSClient extends EventDispatcher
   {
      
      private var webSocketClient:SmartWebSocket;
      
      private var _debug:Boolean;
      
      public function WSClient(param1:String = "localhost", param2:Boolean = false)
      {
         super();
      }
      
      public function get connected() : Boolean
      {
         if(this.webSocketClient == null)
         {
            return false;
         }
         return this.webSocketClient.connected;
      }
      
      public function get isDebug() : Boolean
      {
         return this._debug;
      }
      
      public function set isDebug(param1:Boolean) : void
      {
         this._debug = param1;
      }
      
      public function connect(param1:String) : void
      {
         trace(param1);
         if(this.connected)
         {
            throw new IllegalOperationError("WebSocket session is already connected");
         }
         if(this.webSocketClient != null)
         {
            this.webSocketClient.removeEventListener(WebSocketEvent.CLOSED,this.handleWebSocketClosed);
            this.webSocketClient.removeEventListener(WebSocketEvent.OPEN,this.handleWebSocketOpen);
            this.webSocketClient.removeEventListener(WebSocketEvent.MESSAGE,this.handleWebSocketMessage);
            this.webSocketClient.removeEventListener(WebSocketErrorEvent.CONNECTION_FAIL,this.handleConnectionFail);
         }
         this.webSocketClient = new SmartWebSocket(param1,"*");
         this.webSocketClient.addEventListener(WebSocketEvent.CLOSED,this.handleWebSocketClosed);
         this.webSocketClient.addEventListener(WebSocketEvent.OPEN,this.handleWebSocketOpen);
         this.webSocketClient.addEventListener(WebSocketEvent.MESSAGE,this.handleWebSocketMessage);
         this.webSocketClient.addEventListener(WebSocketErrorEvent.CONNECTION_FAIL,this.handleConnectionFail);
         this.webSocketClient.connect();
      }
      
      public function send(param1:ByteArray) : void
      {
         this.webSocketClient.sendBytes(param1);
      }
      
      public function close() : void
      {
         this.webSocketClient.close();
      }
      
      private function handleWebSocketOpen(param1:Event) : void
      {
         dispatchEvent(new WSEvent(WSEvent.CONNECT,{}));
      }
      
      private function handleWebSocketClosed(param1:WebSocketEvent) : void
      {
         dispatchEvent(new WSEvent(WSEvent.CLOSED,{}));
      }
      
      private function handleConnectionFail(param1:WebSocketErrorEvent) : void
      {
         var _loc2_:WSEvent = new WSEvent(WSEvent.IO_ERROR,{"message":param1.text});
         dispatchEvent(_loc2_);
      }
      
      private function handleWebSocketMessage(param1:WebSocketEvent) : void
      {
         dispatchEvent(new WSEvent(WSEvent.DATA,{"data":param1.message.binaryData}));
      }
   }
}

