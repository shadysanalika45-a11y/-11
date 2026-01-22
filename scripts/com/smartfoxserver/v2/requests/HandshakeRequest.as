package com.smartfoxserver.v2.requests
{
   public class HandshakeRequest extends BaseRequest
   {
      
      public static const KEY_SESSION_TOKEN:String = "tk";
      
      public static const KEY_API:String = "api";
      
      public static const KEY_COMPRESSION_THRESHOLD:String = "ct";
      
      public static const KEY_RECONNECTION_TOKEN:String = "rt";
      
      public static const KEY_CLIENT_TYPE:String = "cl";
      
      public static const KEY_MAX_MESSAGE_SIZE:String = "ms";
      
      public function HandshakeRequest(param1:String, param2:String, param3:String = null)
      {
         super(BaseRequest.Handshake);
         _sfso.putUtfString(KEY_API,param1);
         _sfso.putUtfString(KEY_CLIENT_TYPE,param2);
         if(param3 != null)
         {
            _sfso.putUtfString(KEY_RECONNECTION_TOKEN,param3);
         }
      }
   }
}

