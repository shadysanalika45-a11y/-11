package com.smartfoxserver.v2.util
{
   import flash.utils.ByteArray;
   
   public class CryptoKey
   {
      
      private var _iv:ByteArray;
      
      private var _key:ByteArray;
      
      public function CryptoKey(param1:ByteArray, param2:ByteArray)
      {
         super();
         this._iv = param1;
         this._key = param2;
      }
      
      public function get iv() : ByteArray
      {
         return this._iv;
      }
      
      public function get key() : ByteArray
      {
         return this._key;
      }
   }
}

