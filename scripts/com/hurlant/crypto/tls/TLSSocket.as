package com.hurlant.crypto.tls
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.ObjectEncoding;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TLSSocket extends EventDispatcher implements IDataInput, IDataOutput
   {
      
      private var _endian:String;
      
      private var _objectEncoding:uint;
      
      private var _iStream:ByteArray;
      
      private var _oStream:ByteArray;
      
      private var _iStream_cursor:uint;
      
      private var _socket:Socket;
      
      private var _engine:TLSEngine;
      
      private var _ready:Boolean;
      
      private var _writeScheduler:uint;
      
      public function TLSSocket(param1:String = null, param2:int = 0, param3:TLSConfig = null)
      {
         super();
         if(param1 != null && param2 != 0)
         {
            this.connect(param1,param2,param3);
         }
      }
      
      public function get bytesAvailable() : uint
      {
         return this._iStream.bytesAvailable;
      }
      
      public function get connected() : Boolean
      {
         return this._socket.connected;
      }
      
      public function get endian() : String
      {
         return this._endian;
      }
      
      public function set endian(param1:String) : void
      {
         this._endian = param1;
         this._iStream.endian = param1;
         this._oStream.endian = param1;
      }
      
      public function get objectEncoding() : uint
      {
         return this._objectEncoding;
      }
      
      public function set objectEncoding(param1:uint) : void
      {
         this._objectEncoding = param1;
         this._iStream.objectEncoding = param1;
         this._oStream.objectEncoding = param1;
      }
      
      private function onTLSData(param1:TLSEvent) : void
      {
         if(this._iStream.position == this._iStream.length)
         {
            this._iStream.position = 0;
            this._iStream.length = 0;
            this._iStream_cursor = 0;
         }
         var _loc2_:uint = this._iStream.position;
         this._iStream.position = this._iStream_cursor;
         this._iStream.writeBytes(param1.data);
         this._iStream_cursor = this._iStream.position;
         this._iStream.position = _loc2_;
         dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA,false,false,param1.data.length));
      }
      
      private function onTLSReady(param1:TLSEvent) : void
      {
         this._ready = true;
         this.scheduleWrite();
      }
      
      private function onTLSClose(param1:Event) : void
      {
         dispatchEvent(param1);
         this.close();
      }
      
      private function scheduleWrite() : void
      {
         if(this._writeScheduler != 0)
         {
            return;
         }
         this._writeScheduler = setTimeout(this.commitWrite,0);
      }
      
      private function commitWrite() : void
      {
         clearTimeout(this._writeScheduler);
         this._writeScheduler = 0;
         if(this._ready)
         {
            this._engine.sendApplicationData(this._oStream);
            this._oStream.length = 0;
         }
      }
      
      public function close() : void
      {
         this._ready = false;
         this._engine.close();
         this._socket.flush();
         this._socket.close();
      }
      
      public function connect(param1:String, param2:int, param3:TLSConfig = null) : void
      {
         this.init(new Socket(),param3,param1);
         this._socket.connect(param1,param2);
         this._engine.start();
      }
      
      public function startTLS(param1:Socket, param2:String, param3:TLSConfig = null) : void
      {
         if(!param1.connected)
         {
            throw new Error("Cannot STARTTLS on a socket that isn\'t connected.");
         }
         this.init(param1,param3,param2);
         this._engine.start();
      }
      
      private function init(param1:Socket, param2:TLSConfig, param3:String) : void
      {
         var socket:Socket = param1;
         var config:TLSConfig = param2;
         var host:String = param3;
         this._iStream = new ByteArray();
         this._oStream = new ByteArray();
         this._iStream_cursor = 0;
         this.objectEncoding = ObjectEncoding.DEFAULT;
         this.endian = Endian.BIG_ENDIAN;
         this._socket = socket;
         this._socket.addEventListener(Event.CONNECT,dispatchEvent);
         this._socket.addEventListener(IOErrorEvent.IO_ERROR,dispatchEvent);
         this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,dispatchEvent);
         this._socket.addEventListener(Event.CLOSE,dispatchEvent);
         if(config == null)
         {
            config = new TLSConfig(TLSEngine.CLIENT);
         }
         this._engine = new TLSEngine(config,this._socket,this._socket,host);
         this._engine.addEventListener(TLSEvent.DATA,this.onTLSData);
         this._engine.addEventListener(TLSEvent.READY,this.onTLSReady);
         this._engine.addEventListener(Event.CLOSE,this.onTLSClose);
         this._engine.addEventListener(ProgressEvent.SOCKET_DATA,function(param1:*):void
         {
            _socket.flush();
         });
         this._socket.addEventListener(ProgressEvent.SOCKET_DATA,this._engine.dataAvailable);
         this._ready = false;
      }
      
      public function flush() : void
      {
         this.commitWrite();
         this._socket.flush();
      }
      
      public function readBoolean() : Boolean
      {
         return this._iStream.readBoolean();
      }
      
      public function readByte() : int
      {
         return this._iStream.readByte();
      }
      
      public function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         return this._iStream.readBytes(param1,param2,param3);
      }
      
      public function readDouble() : Number
      {
         return this._iStream.readDouble();
      }
      
      public function readFloat() : Number
      {
         return this._iStream.readFloat();
      }
      
      public function readInt() : int
      {
         return this._iStream.readInt();
      }
      
      public function readMultiByte(param1:uint, param2:String) : String
      {
         return this._iStream.readMultiByte(param1,param2);
      }
      
      public function readObject() : *
      {
         return this._iStream.readObject();
      }
      
      public function readShort() : int
      {
         return this._iStream.readShort();
      }
      
      public function readUnsignedByte() : uint
      {
         return this._iStream.readUnsignedByte();
      }
      
      public function readUnsignedInt() : uint
      {
         return this._iStream.readUnsignedInt();
      }
      
      public function readUnsignedShort() : uint
      {
         return this._iStream.readUnsignedShort();
      }
      
      public function readUTF() : String
      {
         return this._iStream.readUTF();
      }
      
      public function readUTFBytes(param1:uint) : String
      {
         return this._iStream.readUTFBytes(param1);
      }
      
      public function writeBoolean(param1:Boolean) : void
      {
         this._oStream.writeBoolean(param1);
         this.scheduleWrite();
      }
      
      public function writeByte(param1:int) : void
      {
         this._oStream.writeByte(param1);
         this.scheduleWrite();
      }
      
      public function writeBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         this._oStream.writeBytes(param1,param2,param3);
         this.scheduleWrite();
      }
      
      public function writeDouble(param1:Number) : void
      {
         this._oStream.writeDouble(param1);
         this.scheduleWrite();
      }
      
      public function writeFloat(param1:Number) : void
      {
         this._oStream.writeFloat(param1);
         this.scheduleWrite();
      }
      
      public function writeInt(param1:int) : void
      {
         this._oStream.writeInt(param1);
         this.scheduleWrite();
      }
      
      public function writeMultiByte(param1:String, param2:String) : void
      {
         this._oStream.writeMultiByte(param1,param2);
         this.scheduleWrite();
      }
      
      public function writeObject(param1:*) : void
      {
         this._oStream.writeObject(param1);
         this.scheduleWrite();
      }
      
      public function writeShort(param1:int) : void
      {
         this._oStream.writeShort(param1);
         this.scheduleWrite();
      }
      
      public function writeUnsignedInt(param1:uint) : void
      {
         this._oStream.writeUnsignedInt(param1);
         this.scheduleWrite();
      }
      
      public function writeUTF(param1:String) : void
      {
         this._oStream.writeUTF(param1);
         this.scheduleWrite();
      }
      
      public function writeUTFBytes(param1:String) : void
      {
         this._oStream.writeUTFBytes(param1);
         this.scheduleWrite();
      }
   }
}

