package com.smartfoxserver.v2.bitswarm
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.bitswarm.bbox.BBClient;
   import com.smartfoxserver.v2.bitswarm.bbox.BBEvent;
   import com.smartfoxserver.v2.bitswarm.wsocket.WSClient;
   import com.smartfoxserver.v2.bitswarm.wsocket.WSEvent;
   import com.smartfoxserver.v2.controllers.ExtensionController;
   import com.smartfoxserver.v2.controllers.SystemController;
   import com.smartfoxserver.v2.exceptions.SFSError;
   import com.smartfoxserver.v2.util.ClientDisconnectionReason;
   import com.smartfoxserver.v2.util.ConnectionMode;
   import com.smartfoxserver.v2.util.CryptoKey;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class BitSwarmClient extends EventDispatcher
   {
      
      private var _socket:Socket;
      
      private var _bbClient:BBClient;
      
      private var _wsClient:WSClient;
      
      private var _ioHandler:IoHandler;
      
      private var _controllers:Object;
      
      private var _compressionThreshold:int = 2000000;
      
      private var _maxMessageSize:int = 10000;
      
      private var _sfs:SmartFox;
      
      private var _connected:Boolean;
      
      private var _lastIpAddress:String;
      
      public var _lastTcpPort:int;
      
      private var _reconnectionDelayMillis:int = 1000;
      
      private var _reconnectionSeconds:int = 0;
      
      private var _attemptingReconnection:Boolean = false;
      
      private var _sysController:SystemController;
      
      private var _extController:ExtensionController;
      
      private var _udpManager:IUDPManager;
      
      private var _controllersInited:Boolean = false;
      
      private var _cryptoKey:CryptoKey;
      
      private var _useBlueBox:Boolean = false;
      
      private var _useWebSocket:Boolean = false;
      
      private var _useSSL:Boolean = true;
      
      private var _connectionMode:String;
      
      private var _firstReconnAttempt:Number = -1;
      
      private var _reconnCounter:int = 1;
      
      public function BitSwarmClient(param1:SmartFox = null)
      {
         super();
         this._controllers = {};
         this._sfs = param1;
         this._connected = false;
         this._udpManager = new DefaultUDPManager(param1);
      }
      
      public function get sfs() : SmartFox
      {
         return this._sfs;
      }
      
      public function get connected() : Boolean
      {
         return this._connected;
      }
      
      public function get connectionMode() : String
      {
         return this._connectionMode;
      }
      
      public function get ioHandler() : IoHandler
      {
         return this._ioHandler;
      }
      
      public function set ioHandler(param1:IoHandler) : void
      {
         this._ioHandler = param1;
      }
      
      public function get maxMessageSize() : int
      {
         return this._maxMessageSize;
      }
      
      public function set maxMessageSize(param1:int) : void
      {
         this._maxMessageSize = param1;
      }
      
      public function get compressionThreshold() : int
      {
         return this._compressionThreshold;
      }
      
      public function set compressionThreshold(param1:int) : void
      {
         if(param1 > 100)
         {
            this._compressionThreshold = param1;
            return;
         }
         throw new ArgumentError("Compression threshold cannot be < 100 bytes.");
      }
      
      public function get reconnectionDelayMillis() : int
      {
         return this._reconnectionDelayMillis;
      }
      
      public function get useWebSocket() : Boolean
      {
         return this._useWebSocket;
      }
      
      public function set useWebSocket(param1:Boolean) : void
      {
         this._useWebSocket = param1;
      }
      
      public function get useSSL() : Boolean
      {
         return this._useSSL;
      }
      
      public function set useSSL(param1:Boolean) : void
      {
         this._useSSL = param1;
      }
      
      public function get useBlueBox() : Boolean
      {
         return this._useBlueBox;
      }
      
      public function forceBlueBox(param1:Boolean) : void
      {
         if(!this.connected)
         {
            this._useBlueBox = param1;
            return;
         }
         throw new IllegalOperationError("You can\'t change the BlueBox mode while the connection is running");
      }
      
      public function set reconnectionDelayMillis(param1:int) : void
      {
         this._reconnectionDelayMillis = param1;
      }
      
      public function enableBBoxDebug(param1:Boolean) : void
      {
         this._bbClient.isDebug = param1;
      }
      
      public function init() : void
      {
         if(!this._controllersInited)
         {
            this.initControllers();
            this._controllersInited = true;
         }
         this._socket = new Socket();
         if(this._socket.hasOwnProperty("timeout"))
         {
            this._socket.timeout = 5000;
         }
         this._socket.addEventListener(Event.CONNECT,this.onSocketConnect);
         this._socket.addEventListener(Event.CLOSE,this.onSocketClose);
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketIOError);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         this._bbClient = new BBClient();
         this._bbClient.addEventListener(BBEvent.CONNECT,this.onBBConnect);
         this._bbClient.addEventListener(BBEvent.DATA,this.onBBData);
         this._bbClient.addEventListener(BBEvent.DISCONNECT,this.onBBDisconnect);
         this._bbClient.addEventListener(BBEvent.IO_ERROR,this.onBBError);
         this._bbClient.addEventListener(BBEvent.SECURITY_ERROR,this.onBBError);
         this._wsClient = new WSClient();
         this._wsClient.addEventListener(WSEvent.CONNECT,this.onWSConnect);
         this._wsClient.addEventListener(WSEvent.DATA,this.onWSData);
         this._wsClient.addEventListener(WSEvent.CLOSED,this.onWSClosed);
         this._wsClient.addEventListener(WSEvent.IO_ERROR,this.onWSIOError);
         this._wsClient.addEventListener(WSEvent.SECURITY_ERROR,this.onWSSecurityError);
      }
      
      private function onWSConnect(param1:WSEvent) : void
      {
         this.processConnect();
      }
      
      private function onWSData(param1:WSEvent) : void
      {
         var _loc2_:ByteArray = param1.params.data;
         if(_loc2_ != null)
         {
            this._ioHandler.onDataRead(_loc2_);
         }
      }
      
      private function onWSClosed(param1:WSEvent) : void
      {
         this.processClose(false);
      }
      
      private function onWSIOError(param1:WSEvent) : void
      {
         if(this._attemptingReconnection)
         {
            this.reconnect();
            return;
         }
         trace("## SocketError: " + param1.toString());
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.IO_ERROR);
         _loc2_.params = {"message":param1.toString()};
         dispatchEvent(_loc2_);
      }
      
      private function onWSSecurityError(param1:WSEvent) : void
      {
         if(this._attemptingReconnection)
         {
            this.reconnect();
            return;
         }
         trace("## SecurityError: " + param1.toString());
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.SECURITY_ERROR);
         _loc2_.params = {"message":"Security Error"};
         dispatchEvent(_loc2_);
      }
      
      public function destroy() : void
      {
         this._socket.removeEventListener(Event.CONNECT,this.onSocketConnect);
         this._socket.removeEventListener(Event.CLOSE,this.onSocketClose);
         this._socket.removeEventListener(ProgressEvent.SOCKET_DATA,this.onSocketData);
         this._socket.removeEventListener(IOErrorEvent.IO_ERROR,this.onSocketIOError);
         this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         if(this._socket.connected)
         {
            this._socket.close();
         }
         this._wsClient.removeEventListener(WSEvent.CONNECT,this.onWSConnect);
         this._wsClient.removeEventListener(WSEvent.DATA,this.onWSData);
         this._wsClient.removeEventListener(WSEvent.CLOSED,this.onWSClosed);
         this._wsClient.removeEventListener(WSEvent.IO_ERROR,this.onWSIOError);
         this._wsClient.removeEventListener(WSEvent.SECURITY_ERROR,this.onWSSecurityError);
         if(this._wsClient.connected)
         {
            this._wsClient.close();
         }
         this._socket = null;
      }
      
      public function getController(param1:int) : IController
      {
         return this._controllers[param1] as IController;
      }
      
      public function get systemController() : SystemController
      {
         return this._sysController;
      }
      
      public function get extensionController() : ExtensionController
      {
         return this._extController;
      }
      
      public function get isReconnecting() : Boolean
      {
         return this._attemptingReconnection;
      }
      
      public function set isReconnecting(param1:Boolean) : void
      {
         this._attemptingReconnection = param1;
      }
      
      public function getControllerById(param1:int) : IController
      {
         return this._controllers[param1];
      }
      
      public function get connectionIp() : String
      {
         if(!this.connected)
         {
            return "Not Connected";
         }
         return this._lastIpAddress;
      }
      
      public function get connectionPort() : int
      {
         if(!this.connected)
         {
            return -1;
         }
         return this._lastTcpPort;
      }
      
      public function get cryptoKey() : CryptoKey
      {
         return this._cryptoKey;
      }
      
      public function set cryptoKey(param1:CryptoKey) : void
      {
         this._cryptoKey = param1;
      }
      
      private function addController(param1:int, param2:IController) : void
      {
         if(param2 == null)
         {
            throw new ArgumentError("Controller is null, it can\'t be added.");
         }
         if(this._controllers[param1] != null)
         {
            throw new ArgumentError("A controller with id: " + param1 + " already exists! Controller can\'t be added: " + param2);
         }
         this._controllers[param1] = param2;
      }
      
      public function addCustomController(param1:int, param2:Class) : void
      {
         var _loc3_:IController = param2(this);
         this.addController(param1,_loc3_);
      }
      
      public function connect(param1:String = "127.0.0.1", param2:int = 9933) : void
      {
         this._lastIpAddress = param1;
         this._lastTcpPort = param2;
         if(this._useBlueBox)
         {
            this._bbClient.useHttps = this.sfs.config.forceBlueBoxOverHttps;
            this._bbClient.pollSpeed = this.sfs.config != null ? int(this.sfs.config.blueBoxPollingRate) : int(750);
            this._bbClient.connect(param1,param2);
            this._connectionMode = ConnectionMode.HTTP;
         }
         else if(this._useWebSocket)
         {
            this._wsClient.connect((this._useSSL ? "wss://" : "ws://") + param1 + ":" + param2 + "/BlueBox/websocket");
            this._connectionMode = ConnectionMode.WEB_SOCKET;
         }
         else
         {
            this._socket.connect(param1,param2);
            this._connectionMode = ConnectionMode.SOCKET;
         }
      }
      
      public function send(param1:IMessage) : void
      {
         this._ioHandler.codec.onPacketWrite(param1);
      }
      
      public function get socket() : Socket
      {
         return this._socket;
      }
      
      public function get httpSocket() : BBClient
      {
         return this._bbClient;
      }
      
      public function get webSocket() : WSClient
      {
         return this._wsClient;
      }
      
      public function disconnect(param1:String = null) : void
      {
         if(this._useBlueBox)
         {
            this._bbClient.close();
         }
         else if(this._socket.connected)
         {
            this._socket.close();
         }
         else if(this._wsClient.connected)
         {
            this._wsClient.close();
         }
         this.onSocketClose(new BitSwarmEvent(BitSwarmEvent.DISCONNECT,{"reason":param1}));
      }
      
      public function nextUdpPacketId() : Number
      {
         return this._udpManager.nextUdpPacketId();
      }
      
      public function killConnection() : void
      {
         if(this._socket.connected)
         {
            this._socket.close();
            this.onSocketClose(new Event(Event.CLOSE));
         }
         if(this._wsClient.connected)
         {
            this._wsClient.close();
         }
      }
      
      public function stopReconnection() : void
      {
         this._attemptingReconnection = false;
         this._firstReconnAttempt = -1;
         if(this._socket.connected)
         {
            this._socket.close();
         }
         if(this._wsClient.connected)
         {
            this._wsClient.close();
         }
         this.executeDisconnection(null);
      }
      
      public function get udpManager() : IUDPManager
      {
         return this._udpManager;
      }
      
      public function set udpManager(param1:IUDPManager) : void
      {
         this._udpManager = param1;
      }
      
      private function initControllers() : void
      {
         this._sysController = new SystemController(this);
         this._extController = new ExtensionController(this);
         this.addController(0,this._sysController);
         this.addController(1,this._extController);
      }
      
      public function get reconnectionSeconds() : int
      {
         return this._reconnectionSeconds;
      }
      
      public function set reconnectionSeconds(param1:int) : void
      {
         if(param1 < 0)
         {
            this._reconnectionSeconds = 0;
         }
         else
         {
            this._reconnectionSeconds = param1;
         }
      }
      
      private function onSocketConnect(param1:Event) : void
      {
         this.processConnect();
      }
      
      private function onSocketClose(param1:Event) : void
      {
         var _loc2_:BitSwarmEvent = null;
         if(param1 is BitSwarmEvent)
         {
            _loc2_ = param1 as BitSwarmEvent;
            this.processClose(_loc2_.params.reason == ClientDisconnectionReason.MANUAL,_loc2_);
         }
         else
         {
            this.processClose(false);
         }
      }
      
      private function processConnect() : void
      {
         this._connected = true;
         var _loc1_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.CONNECT);
         _loc1_.params = {
            "success":true,
            "_isReconnection":this._attemptingReconnection
         };
         dispatchEvent(_loc1_);
      }
      
      private function processClose(param1:Boolean, param2:BitSwarmEvent = null) : void
      {
         this._connected = false;
         var _loc3_:Boolean = !this._attemptingReconnection && this.sfs.getReconnectionSeconds() == 0;
         var _loc4_:Boolean = param2 is BitSwarmEvent && (param2 as BitSwarmEvent).params.reason == ClientDisconnectionReason.MANUAL;
         if(_loc3_ || _loc4_ || param1)
         {
            this._udpManager.reset();
            this._firstReconnAttempt = -1;
            this.executeDisconnection(param2);
            return;
         }
         if(this._attemptingReconnection)
         {
            this.reconnect();
         }
         else
         {
            this._attemptingReconnection = true;
            this._firstReconnAttempt = getTimer();
            this._reconnCounter = 1;
            dispatchEvent(new BitSwarmEvent(BitSwarmEvent.RECONNECTION_TRY));
            this.reconnect();
         }
      }
      
      private function reconnect() : void
      {
         var reconnectionSeconds:int;
         var now:int;
         var timeLeft:int;
         if(!this._attemptingReconnection)
         {
            return;
         }
         reconnectionSeconds = this.sfs.getReconnectionSeconds() * 1000;
         now = getTimer();
         timeLeft = this._firstReconnAttempt + reconnectionSeconds - now;
         if(timeLeft > 0)
         {
            this.sfs.logger.info("Reconnection attempt:",this._reconnCounter," - time left:",int(timeLeft / 1000),"sec.");
            setTimeout(function():void
            {
               connect(_lastIpAddress,_lastTcpPort);
            },this._reconnectionDelayMillis);
            ++this._reconnCounter;
         }
         else
         {
            dispatchEvent(new BitSwarmEvent(BitSwarmEvent.DISCONNECT,{"reason":ClientDisconnectionReason.UNKNOWN}));
         }
      }
      
      private function executeDisconnection(param1:Event) : void
      {
         if(param1 is BitSwarmEvent)
         {
            dispatchEvent(param1);
         }
         else
         {
            dispatchEvent(new BitSwarmEvent(BitSwarmEvent.DISCONNECT,{"reason":ClientDisconnectionReason.UNKNOWN}));
         }
      }
      
      private function onSocketData(param1:ProgressEvent) : void
      {
         var event:BitSwarmEvent = null;
         var evt:ProgressEvent = param1;
         var buffer:ByteArray = null;
         event = null;
         try
         {
            buffer = new ByteArray();
            this._socket.readBytes(buffer);
            this._ioHandler.onDataRead(buffer);
         }
         catch(error:SFSError)
         {
            trace("## SocketDataError: " + error.message);
            event = new BitSwarmEvent(BitSwarmEvent.DATA_ERROR);
            event.params = {
               "message":error.message,
               "details":error.details
            };
            dispatchEvent(event);
         }
      }
      
      private function onSocketIOError(param1:IOErrorEvent) : void
      {
         if(this._attemptingReconnection)
         {
            this.reconnect();
            return;
         }
         trace("## SocketError: " + param1.toString());
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.IO_ERROR);
         _loc2_.params = {"message":param1.toString()};
         dispatchEvent(_loc2_);
      }
      
      private function onSocketSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this._attemptingReconnection)
         {
            this.reconnect();
            return;
         }
         trace("## SecurityError: " + param1.toString());
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.SECURITY_ERROR);
         _loc2_.params = {"message":param1.text};
         dispatchEvent(_loc2_);
      }
      
      private function onBBConnect(param1:BBEvent) : void
      {
         this._connected = true;
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.CONNECT);
         _loc2_.params = {"success":true};
         dispatchEvent(_loc2_);
      }
      
      private function onBBData(param1:BBEvent) : void
      {
         var _loc2_:ByteArray = param1.params.data;
         if(_loc2_ != null)
         {
            this._ioHandler.onDataRead(_loc2_);
         }
      }
      
      private function onBBDisconnect(param1:BBEvent) : void
      {
         this._connected = false;
         dispatchEvent(new BitSwarmEvent(BitSwarmEvent.DISCONNECT,{"reason":ClientDisconnectionReason.UNKNOWN}));
      }
      
      private function onBBError(param1:BBEvent) : void
      {
         trace("## BlueBox Error: " + param1.params.message);
         var _loc2_:BitSwarmEvent = new BitSwarmEvent(BitSwarmEvent.IO_ERROR);
         _loc2_.params = {"message":param1.params.message};
         dispatchEvent(_loc2_);
      }
   }
}

