package com.smartfoxserver.v2.util
{
   import com.hurlant.util.Base64;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.kernel;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class CryptoInitializer
   {
      
      private const KEY_SESSION_TOKEN:String = "SessToken";
      
      private const TARGET_SERVLET:String = "/BlueBox/CryptoManager";
      
      private var sfs:SmartFox;
      
      private var httpReq:URLRequest;
      
      private var useHttps:Boolean = true;
      
      public function CryptoInitializer(param1:SmartFox)
      {
         super();
         if(!param1.isConnected)
         {
            throw new IllegalOperationError("Cryptography cannot be initialized before connecting to SmartFoxServer!");
         }
         if(param1.kernel::socketEngine.cryptoKey != null)
         {
            throw new IllegalOperationError("Cryptography is already initialized!");
         }
         this.sfs = param1;
         this.run();
      }
      
      private function run() : void
      {
         var _loc1_:String = "https://" + this.sfs.config.host + ":" + this.sfs.config.httpsPort + this.TARGET_SERVLET;
         this.httpReq = new URLRequest(_loc1_);
         this.httpReq.method = URLRequestMethod.POST;
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.onHttpResponse);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onHttpIOError);
         _loc2_.addEventListener(IOErrorEvent.NETWORK_ERROR,this.onHttpIOError);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         var _loc3_:URLVariables = new URLVariables();
         _loc3_[this.KEY_SESSION_TOKEN] = this.sfs.sessionToken;
         this.httpReq.data = _loc3_;
         _loc2_.load(this.httpReq);
      }
      
      private function onHttpResponse(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:String = _loc2_.data as String;
         var _loc4_:ByteArray = Base64.decodeToByteArray(_loc3_);
         var _loc5_:ByteArray = new ByteArray();
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.writeBytes(_loc4_,0,16);
         _loc5_.writeBytes(_loc4_,16,16);
         this.sfs.kernel::socketEngine.cryptoKey = new CryptoKey(_loc5_,_loc6_);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{"success":true}));
      }
      
      private function onHttpIOError(param1:IOErrorEvent) : void
      {
         this.sfs.logger.warn("HTTP I/O ERROR: " + param1.text);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{
            "success":false,
            "errorMsg":param1.text
         }));
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         this.sfs.logger.warn("SECURITY ERROR: " + param1.text);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{
            "success":false,
            "errorMsg":param1.text
         }));
      }
   }
}

