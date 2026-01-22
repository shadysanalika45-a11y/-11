package com.smartfoxserver.v2.core
{
   import com.hurlant.crypto.Crypto;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IPad;
   import com.hurlant.crypto.symmetric.IVMode;
   import com.hurlant.crypto.symmetric.PKCS5;
   import com.smartfoxserver.v2.bitswarm.BitSwarmClient;
   import com.smartfoxserver.v2.util.CryptoKey;
   import flash.utils.ByteArray;
   
   public class DefaultPacketEncrypter implements IPacketEncrypter
   {
      
      private var bitSwarm:BitSwarmClient;
      
      private const ALGORITHM:String = "aes-cbc";
      
      public function DefaultPacketEncrypter(param1:BitSwarmClient)
      {
         super();
         this.bitSwarm = param1;
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:CryptoKey = this.bitSwarm.cryptoKey;
         var _loc3_:IPad = new PKCS5();
         var _loc4_:ICipher = Crypto.getCipher(this.ALGORITHM,_loc2_.key,_loc3_);
         var _loc5_:IVMode = _loc4_ as IVMode;
         _loc5_.IV = _loc2_.iv;
         _loc4_.encrypt(param1);
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:CryptoKey = this.bitSwarm.cryptoKey;
         var _loc3_:IPad = new PKCS5();
         var _loc4_:ICipher = Crypto.getCipher(this.ALGORITHM,_loc2_.key,_loc3_);
         var _loc5_:IVMode = _loc4_ as IVMode;
         _loc5_.IV = _loc2_.iv;
         _loc4_.decrypt(param1);
      }
   }
}

