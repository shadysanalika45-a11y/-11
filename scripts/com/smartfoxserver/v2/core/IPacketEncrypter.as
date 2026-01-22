package com.smartfoxserver.v2.core
{
   import flash.utils.ByteArray;
   
   public interface IPacketEncrypter
   {
      
      function encrypt(param1:ByteArray) : void;
      
      function decrypt(param1:ByteArray) : void;
   }
}

