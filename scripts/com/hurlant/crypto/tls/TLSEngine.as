package com.hurlant.crypto.tls
{
   import com.hurlant.crypto.cert.X509Certificate;
   import com.hurlant.crypto.cert.X509CertificateCollection;
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.util.ArrayUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TLSEngine extends EventDispatcher
   {
      
      public static const SERVER:uint = 0;
      
      public static const CLIENT:uint = 1;
      
      public static const TLS_VERSION:uint = 769;
      
      private static const PROTOCOL_HANDSHAKE:uint = 22;
      
      private static const PROTOCOL_ALERT:uint = 21;
      
      private static const PROTOCOL_CHANGE_CIPHER_SPEC:uint = 20;
      
      private static const PROTOCOL_APPLICATION_DATA:uint = 23;
      
      private static const STATE_NEW:uint = 0;
      
      private static const STATE_NEGOTIATING:uint = 1;
      
      private static const STATE_READY:uint = 2;
      
      private static const STATE_CLOSED:uint = 3;
      
      private static const HANDSHAKE_HELLO_REQUEST:uint = 0;
      
      private static const HANDSHAKE_CLIENT_HELLO:uint = 1;
      
      private static const HANDSHAKE_SERVER_HELLO:uint = 2;
      
      private static const HANDSHAKE_CERTIFICATE:uint = 11;
      
      private static const HANDSHAKE_SERVER_KEY_EXCHANGE:uint = 12;
      
      private static const HANDSHAKE_CERTIFICATE_REQUEST:uint = 13;
      
      private static const HANDSHAKE_HELLO_DONE:uint = 14;
      
      private static const HANDSHAKE_CERTIFICATE_VERIFY:uint = 15;
      
      private static const HANDSHAKE_CLIENT_KEY_EXCHANGE:uint = 16;
      
      private static const HANDSHAKE_FINISHED:uint = 20;
      
      private var _entity:uint;
      
      private var _currentReadState:TLSConnectionState;
      
      private var _iStream:IDataInput;
      
      private var _oStream:IDataOutput;
      
      private var _state:uint;
      
      private var _pendingReadState:TLSConnectionState;
      
      private var _packetQueue:Array;
      
      private var _writeScheduler:uint;
      
      private var _handshakePayloads:ByteArray;
      
      private var _currentWriteState:TLSConnectionState;
      
      private var _otherCertificate:X509Certificate;
      
      private var _config:TLSConfig;
      
      private var _securityParameters:TLSSecurityParameters;
      
      private var _pendingWriteState:TLSConnectionState;
      
      private var _otherIdentity:String;
      
      private var _store:X509CertificateCollection;
      
      public function TLSEngine(param1:TLSConfig, param2:IDataInput, param3:IDataOutput, param4:String = null)
      {
         var _loc5_:Object = null;
         _packetQueue = [];
         super();
         _entity = param1.entity;
         _config = param1;
         _iStream = param2;
         _oStream = param3;
         _otherIdentity = param4;
         _state = STATE_NEW;
         _securityParameters = new TLSSecurityParameters(_entity);
         _loc5_ = _securityParameters.getConnectionStates();
         _currentReadState = _loc5_.read;
         _currentWriteState = _loc5_.write;
         _handshakePayloads = new ByteArray();
         _store = new X509CertificateCollection();
      }
      
      private function parseHandshake(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:ByteArray = null;
         var _loc10_:uint = 0;
         var _loc11_:ByteArray = null;
         var _loc12_:ByteArray = null;
         if(param1.length < 4)
         {
            trace("Handshake packet is way too short. bailing.");
            return null;
         }
         param1.position = 0;
         _loc2_ = param1;
         _loc3_ = _loc2_.readUnsignedByte();
         _loc4_ = _loc2_.readUnsignedByte();
         _loc5_ = uint(_loc4_ << 16 | _loc2_.readUnsignedShort());
         if(_loc5_ + 4 > param1.length)
         {
            trace("Handshake packet is incomplete. bailing.");
            return null;
         }
         if(param1[0] != HANDSHAKE_FINISHED)
         {
            _handshakePayloads.writeBytes(param1,0,_loc5_ + 4);
         }
         switch(_loc3_)
         {
            case HANDSHAKE_HELLO_REQUEST:
               if(enforceClient())
               {
                  if(_state != STATE_READY)
                  {
                     trace("Received an HELLO_REQUEST before being in state READY. ignoring.");
                     break;
                  }
                  _handshakePayloads = new ByteArray();
                  startHandshake();
               }
               break;
            case HANDSHAKE_CLIENT_HELLO:
               if(enforceServer())
               {
                  _loc6_ = parseHandshakeHello(_loc3_,_loc5_,_loc2_);
                  sendServerHello(_loc6_);
                  sendCertificate();
                  sendServerHelloDone();
               }
               break;
            case HANDSHAKE_SERVER_HELLO:
               if(enforceClient())
               {
                  _loc6_ = parseHandshakeHello(_loc3_,_loc5_,_loc2_);
                  _securityParameters.setCipher(_loc6_.suites[0]);
                  _securityParameters.setCompression(_loc6_.compressions[0]);
                  _securityParameters.setServerRandom(_loc6_.random);
               }
               break;
            case HANDSHAKE_CERTIFICATE:
               _loc4_ = uint(_loc2_.readByte());
               _loc7_ = uint(_loc4_ << 16 | _loc2_.readShort());
               _loc8_ = [];
               while(_loc7_ > 0)
               {
                  _loc4_ = uint(_loc2_.readByte());
                  _loc10_ = uint(_loc4_ << 16 | _loc2_.readShort());
                  _loc11_ = new ByteArray();
                  _loc2_.readBytes(_loc11_,0,_loc10_);
                  _loc8_.push(_loc11_);
                  _loc7_ -= 3 + _loc10_;
               }
               loadCertificates(_loc8_);
               break;
            case HANDSHAKE_SERVER_KEY_EXCHANGE:
               if(enforceClient())
               {
                  throw new TLSError("Server Key Exchange Not Implemented",TLSError.internal_error);
               }
               break;
            case HANDSHAKE_CERTIFICATE_REQUEST:
               if(enforceClient())
               {
                  throw new TLSError("Certificate Request Not Implemented",TLSError.internal_error);
               }
               break;
            case HANDSHAKE_HELLO_DONE:
               if(enforceClient())
               {
                  sendClientAck();
               }
               break;
            case HANDSHAKE_CLIENT_KEY_EXCHANGE:
               if(enforceServer())
               {
                  parseHandshakeClientKeyExchange(_loc3_,_loc5_,_loc2_);
               }
               break;
            case HANDSHAKE_CERTIFICATE_VERIFY:
               if(enforceServer())
               {
                  throw new TLSError("Certificate Verify not implemented",TLSError.internal_error);
               }
               break;
            case HANDSHAKE_FINISHED:
               _loc9_ = new ByteArray();
               _loc2_.readBytes(_loc9_,0,12);
               verifyHandshake(_loc9_);
         }
         if(_loc5_ + 4 < param1.length)
         {
            _loc12_ = new ByteArray();
            _loc12_.writeBytes(param1,_loc5_ + 4,param1.length - (_loc5_ + 4));
            return _loc12_;
         }
         return null;
      }
      
      private function findMatch(param1:Array, param2:Array) : int
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = uint(param1[_loc3_]);
            if(param2.indexOf(_loc4_) > -1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function handleTLSError(param1:TLSError) : void
      {
         close(param1);
      }
      
      private function sendClientAck() : void
      {
         sendClientKeyExchange();
         sendChangeCipherSpec();
         sendFinished();
      }
      
      private function scheduleWrite() : void
      {
         if(_writeScheduler != 0)
         {
            return;
         }
         _writeScheduler = setTimeout(commitWrite,0);
      }
      
      private function sendFinished() : void
      {
         var _loc1_:ByteArray = null;
         _loc1_ = _securityParameters.computeVerifyData(_entity,_handshakePayloads);
         _loc1_.position = 0;
         sendHandshake(HANDSHAKE_FINISHED,_loc1_.length,_loc1_);
      }
      
      private function sendClientHello() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Random = null;
         var _loc3_:ByteArray = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         _loc1_ = new ByteArray();
         _loc1_.writeShort(TLS_VERSION);
         _loc2_ = new Random();
         _loc3_ = new ByteArray();
         _loc2_.nextBytes(_loc3_,32);
         _securityParameters.setClientRandom(_loc3_);
         _loc1_.writeBytes(_loc3_,0,32);
         _loc1_.writeByte(32);
         _loc2_.nextBytes(_loc1_,32);
         _loc4_ = _config.cipherSuites;
         _loc1_.writeShort(2 * _loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.writeShort(_loc4_[_loc5_]);
            _loc5_++;
         }
         _loc4_ = _config.compressions;
         _loc1_.writeByte(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_.writeByte(_loc4_[_loc5_]);
            _loc5_++;
         }
         _loc1_.position = 0;
         sendHandshake(HANDSHAKE_CLIENT_HELLO,_loc1_.length,_loc1_);
      }
      
      private function parseChangeCipherSpec(param1:ByteArray) : void
      {
         param1.readUnsignedByte();
         if(_pendingReadState == null)
         {
            throw new TLSError("Not ready to Change Cipher Spec, damnit.",TLSError.unexpected_message);
         }
         _currentReadState = _pendingReadState;
         _pendingReadState = null;
      }
      
      private function sendServerHello(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:Random = null;
         var _loc6_:ByteArray = null;
         _loc2_ = findMatch(_config.cipherSuites,param1.suites);
         if(_loc2_ == -1)
         {
            throw new TLSError("No compatible cipher found.",TLSError.handshake_failure);
         }
         _securityParameters.setCipher(_loc2_);
         _loc3_ = findMatch(_config.compressions,param1.compressions);
         if(_loc3_ == 1)
         {
            throw new TLSError("No compatible compression method found.",TLSError.handshake_failure);
         }
         _securityParameters.setCompression(_loc3_);
         _securityParameters.setClientRandom(param1.random);
         _loc4_ = new ByteArray();
         _loc4_.writeShort(TLS_VERSION);
         _loc5_ = new Random();
         _loc6_ = new ByteArray();
         _loc5_.nextBytes(_loc6_,32);
         _securityParameters.setServerRandom(_loc6_);
         _loc4_.writeBytes(_loc6_,0,32);
         _loc4_.writeByte(32);
         _loc5_.nextBytes(_loc4_,32);
         _loc4_.writeShort(param1.suites[0]);
         _loc4_.writeByte(param1.compressions[0]);
         _loc4_.position = 0;
         sendHandshake(HANDSHAKE_SERVER_HELLO,_loc4_.length,_loc4_);
      }
      
      private function parseHandshakeHello(param1:uint, param2:uint, param3:IDataInput) : Object
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:uint = 0;
         var _loc8_:ByteArray = null;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Array = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:ByteArray = null;
         _loc5_ = uint(param3.readShort());
         if(_loc5_ != TLS_VERSION)
         {
            throw new TLSError("Unsupported TLS version: " + _loc5_.toString(16),TLSError.protocol_version);
         }
         _loc6_ = new ByteArray();
         param3.readBytes(_loc6_,0,32);
         _loc7_ = uint(param3.readByte());
         _loc8_ = new ByteArray();
         param3.readBytes(_loc8_,0,_loc7_);
         _loc9_ = [];
         if(param1 == HANDSHAKE_CLIENT_HELLO)
         {
            _loc11_ = uint(param3.readShort());
            _loc12_ = 0;
            while(_loc12_ < _loc11_ / 2)
            {
               _loc9_.push(param3.readShort());
               _loc12_++;
            }
         }
         else
         {
            _loc9_.push(param3.readShort());
         }
         _loc10_ = [];
         if(param1 == HANDSHAKE_CLIENT_HELLO)
         {
            _loc13_ = uint(param3.readByte());
            _loc12_ = 0;
            while(_loc12_ < _loc13_)
            {
               _loc10_.push(param3.readByte());
               _loc12_++;
            }
         }
         else
         {
            _loc10_.push(param3.readByte());
         }
         _loc4_ = {
            "random":_loc6_,
            "session":_loc8_,
            "suites":_loc9_,
            "compressions":_loc10_
         };
         if(param1 == HANDSHAKE_CLIENT_HELLO)
         {
            _loc14_ = uint(2 + 32 + 1 + _loc7_ + 2 + _loc11_ + 1 + _loc13_);
            _loc15_ = [];
            if(_loc14_ < param2)
            {
               _loc16_ = uint(param3.readShort());
               while(_loc16_ > 0)
               {
                  _loc17_ = uint(param3.readShort());
                  _loc18_ = uint(param3.readShort());
                  _loc19_ = new ByteArray();
                  param3.readBytes(_loc19_,0,_loc18_);
                  _loc16_ -= 4 + _loc18_;
                  _loc15_.push({
                     "type":_loc17_,
                     "length":_loc18_,
                     "data":_loc19_
                  });
               }
            }
            _loc4_.ext = _loc15_;
         }
         return _loc4_;
      }
      
      private function sendClientKeyExchange() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:Random = null;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:ByteArray = null;
         var _loc6_:Object = null;
         if(_securityParameters.useRSA)
         {
            _loc1_ = new ByteArray();
            _loc1_.writeShort(TLS_VERSION);
            _loc2_ = new Random();
            _loc2_.nextBytes(_loc1_,46);
            _loc1_.position = 0;
            _loc3_ = new ByteArray();
            _loc3_.writeBytes(_loc1_,0,_loc1_.length);
            _securityParameters.setPreMasterSecret(_loc3_);
            _loc4_ = new ByteArray();
            _otherCertificate.getPublicKey().encrypt(_loc1_,_loc4_,_loc1_.length);
            _loc5_ = new ByteArray();
            _loc5_.writeShort(_loc4_.length);
            _loc5_.writeBytes(_loc4_,0,_loc4_.length);
            _loc5_.position = 0;
            sendHandshake(HANDSHAKE_CLIENT_KEY_EXCHANGE,_loc5_.length,_loc5_);
            _loc6_ = _securityParameters.getConnectionStates();
            _pendingReadState = _loc6_.read;
            _pendingWriteState = _loc6_.write;
            return;
         }
         throw new TLSError("Non-RSA Client Key Exchange not implemented.",TLSError.internal_error);
      }
      
      private function startHandshake() : void
      {
         _state = STATE_NEGOTIATING;
         sendClientHello();
      }
      
      public function dataAvailable(param1:* = null) : void
      {
         var e:* = param1;
         if(_state == STATE_CLOSED)
         {
            return;
         }
         try
         {
            parseRecord(_iStream);
         }
         catch(e:TLSError)
         {
            handleTLSError(e);
         }
      }
      
      private function enforceServer() : Boolean
      {
         if(_entity == CLIENT)
         {
            trace("Invalid state for a TLS client.");
            return false;
         }
         return true;
      }
      
      private function sendServerHelloDone() : void
      {
         var _loc1_:ByteArray = null;
         _loc1_ = new ByteArray();
         sendHandshake(HANDSHAKE_HELLO_DONE,_loc1_.length,_loc1_);
      }
      
      private function parseHandshakeClientKeyExchange(param1:uint, param2:uint, param3:ByteArray) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:Object = null;
         if(_securityParameters.useRSA)
         {
            _loc4_ = uint(param3.readShort());
            _loc5_ = new ByteArray();
            param3.readBytes(_loc5_,0,_loc4_);
            _loc6_ = new ByteArray();
            _config.privateKey.decrypt(_loc5_,_loc6_,_loc4_);
            _securityParameters.setPreMasterSecret(_loc6_);
            _loc7_ = _securityParameters.getConnectionStates();
            _pendingReadState = _loc7_.read;
            _pendingWriteState = _loc7_.write;
            return;
         }
         throw new TLSError("parseHandshakeClientKeyExchange not implemented for DH modes.",TLSError.internal_error);
      }
      
      private function sendHandshake(param1:uint, param2:uint, param3:IDataInput) : void
      {
         var _loc4_:ByteArray = null;
         _loc4_ = new ByteArray();
         _loc4_.writeByte(param1);
         _loc4_.writeByte(0);
         _loc4_.writeShort(param2);
         param3.readBytes(_loc4_,_loc4_.position,param2);
         _handshakePayloads.writeBytes(_loc4_,0,_loc4_.length);
         sendRecord(PROTOCOL_HANDSHAKE,_loc4_);
      }
      
      private function loadCertificates(param1:Array) : void
      {
         var _loc2_:X509Certificate = null;
         var _loc3_:int = 0;
         var _loc4_:X509Certificate = null;
         _loc2_ = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = new X509Certificate(param1[_loc3_]);
            _store.addCertificate(_loc4_);
            if(_loc2_ == null)
            {
               _loc2_ = _loc4_;
            }
            _loc3_++;
         }
         if(_loc2_.isSigned(_store,_config.CAStore))
         {
            if(_otherIdentity == null)
            {
               trace("TLS WARNING: No check made on the certificate\'s identity.");
               _otherCertificate = _loc2_;
            }
            else
            {
               if(_loc2_.getCommonName() != _otherIdentity)
               {
                  throw new TLSError("Invalid common name: " + _loc2_.getCommonName() + ", expected " + _otherIdentity,TLSError.bad_certificate);
               }
               _otherCertificate = _loc2_;
            }
            return;
         }
         throw new TLSError("Cannot verify certificate",TLSError.bad_certificate);
      }
      
      private function enforceClient() : Boolean
      {
         if(_entity == SERVER)
         {
            trace("Invalid state for a TLS server.");
            return false;
         }
         return true;
      }
      
      public function start() : void
      {
         if(_entity == CLIENT)
         {
            try
            {
               startHandshake();
            }
            catch(e:TLSError)
            {
               handleTLSError(e);
            }
         }
      }
      
      private function parseRecord(param1:IDataInput) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         while(_state != STATE_CLOSED && param1.bytesAvailable > 4)
         {
            if(_packetQueue.length > 0)
            {
               _loc7_ = _packetQueue.shift();
               _loc2_ = _loc7_.data;
               if(param1.bytesAvailable + _loc2_.length >= _loc7_.length)
               {
                  param1.readBytes(_loc2_,_loc2_.length,_loc7_.length - _loc2_.length);
                  parseOneRecord(_loc7_.type,_loc7_.length,_loc2_);
               }
               else
               {
                  param1.readBytes(_loc2_,_loc2_.length,param1.bytesAvailable);
                  _packetQueue.push(_loc7_);
               }
            }
            else
            {
               _loc3_ = uint(param1.readByte());
               _loc4_ = uint(param1.readShort());
               _loc5_ = uint(param1.readShort());
               if(_loc5_ > 16384 + 2048)
               {
                  throw new TLSError("Excessive TLS Record length: " + _loc5_,TLSError.record_overflow);
               }
               if(_loc4_ != TLS_VERSION)
               {
                  throw new TLSError("Unsupported TLS version: " + _loc4_.toString(16),TLSError.protocol_version);
               }
               if(param1.bytesAvailable < _loc5_)
               {
               }
               _loc2_ = new ByteArray();
               _loc6_ = Math.min(param1.bytesAvailable,_loc5_);
               param1.readBytes(_loc2_,0,_loc6_);
               if(_loc6_ == _loc5_)
               {
                  parseOneRecord(_loc3_,_loc5_,_loc2_);
               }
               else
               {
                  _packetQueue.push({
                     "type":_loc3_,
                     "length":_loc5_,
                     "data":_loc2_
                  });
               }
            }
         }
      }
      
      private function sendChangeCipherSpec() : void
      {
         var _loc1_:ByteArray = null;
         _loc1_ = new ByteArray();
         _loc1_[0] = 1;
         sendRecord(PROTOCOL_CHANGE_CIPHER_SPEC,_loc1_);
         _currentWriteState = _pendingWriteState;
         _pendingWriteState = null;
      }
      
      private function parseApplicationData(param1:ByteArray) : void
      {
         dispatchEvent(new TLSEvent(TLSEvent.DATA,param1));
      }
      
      private function commitWrite() : void
      {
         clearTimeout(_writeScheduler);
         _writeScheduler = 0;
         if(_state != STATE_CLOSED)
         {
            dispatchEvent(new ProgressEvent(ProgressEvent.SOCKET_DATA));
         }
      }
      
      private function parseOneRecord(param1:uint, param2:uint, param3:ByteArray) : void
      {
         param3 = _currentReadState.decrypt(param1,param2,param3);
         if(param3.length > 16384)
         {
            throw new TLSError("Excessive Decrypted TLS Record length: " + param3.length,TLSError.record_overflow);
         }
         switch(param1)
         {
            case PROTOCOL_APPLICATION_DATA:
               if(_state == STATE_READY)
               {
                  parseApplicationData(param3);
                  break;
               }
               throw new TLSError("Too soon for data!",TLSError.unexpected_message);
               break;
            case PROTOCOL_HANDSHAKE:
               while(param3 != null)
               {
                  param3 = parseHandshake(param3);
               }
               break;
            case PROTOCOL_ALERT:
               parseAlert(param3);
               break;
            case PROTOCOL_CHANGE_CIPHER_SPEC:
               parseChangeCipherSpec(param3);
               break;
            default:
               throw new TLSError("Unsupported TLS Record Content Type: " + param1.toString(16),TLSError.unexpected_message);
         }
      }
      
      private function parseAlert(param1:ByteArray) : void
      {
         trace("GOT ALERT! type=" + param1[1]);
         close();
      }
      
      public function sendApplicationData(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void
      {
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         _loc4_ = new ByteArray();
         _loc5_ = param3;
         while(_loc5_ > 16384)
         {
            _loc4_.position = 0;
            _loc4_.writeBytes(param1,param2,16384);
            _loc4_.position = 0;
            sendRecord(PROTOCOL_APPLICATION_DATA,_loc4_);
            param2 += 16384;
            _loc5_ -= 16384;
         }
         _loc4_.position = 0;
         _loc4_.writeBytes(param1,param2,_loc5_);
         _loc4_.position = 0;
         sendRecord(PROTOCOL_APPLICATION_DATA,_loc4_);
      }
      
      private function sendCertificate() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:ByteArray = null;
         _loc1_ = _config.certificate;
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.length;
         _loc3_ = uint(_loc2_ + 3);
         _loc4_ = new ByteArray();
         _loc4_.writeByte(_loc3_ >> 16);
         _loc4_.writeShort(_loc3_ & 0xFFFF);
         _loc4_.writeByte(_loc2_ >> 16);
         _loc4_.writeShort(_loc2_ & 0xFFFF);
         _loc4_.writeBytes(_loc1_);
         _loc4_.position = 0;
         sendHandshake(HANDSHAKE_CERTIFICATE,_loc4_.length,_loc4_);
      }
      
      public function close(param1:TLSError = null) : void
      {
         var _loc2_:ByteArray = null;
         if(_state == STATE_CLOSED)
         {
            return;
         }
         _loc2_ = new ByteArray();
         if(param1 == null && _state != STATE_READY)
         {
            _loc2_[0] = 1;
            _loc2_[1] = TLSError.user_canceled;
            sendRecord(PROTOCOL_ALERT,_loc2_);
         }
         _loc2_[0] = 2;
         if(param1 == null)
         {
            _loc2_[1] = TLSError.close_notify;
         }
         else
         {
            _loc2_[1] = param1.errorID;
            trace("TLSEngine shutdown triggered by " + param1);
         }
         sendRecord(PROTOCOL_ALERT,_loc2_);
         _state = STATE_CLOSED;
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function sendRecord(param1:uint, param2:ByteArray) : void
      {
         param2 = _currentWriteState.encrypt(param1,param2);
         _oStream.writeByte(param1);
         _oStream.writeShort(TLS_VERSION);
         _oStream.writeShort(param2.length);
         _oStream.writeBytes(param2,0,param2.length);
         scheduleWrite();
      }
      
      private function verifyHandshake(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = _securityParameters.computeVerifyData(1 - _entity,_handshakePayloads);
         if(ArrayUtil.equals(param1,_loc2_))
         {
            _state = STATE_READY;
            dispatchEvent(new TLSEvent(TLSEvent.READY));
            return;
         }
         throw new TLSError("Invalid Finished mac.",TLSError.bad_record_mac);
      }
   }
}

