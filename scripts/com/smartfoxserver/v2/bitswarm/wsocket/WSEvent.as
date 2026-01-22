package com.smartfoxserver.v2.bitswarm.wsocket
{
   import com.smartfoxserver.v2.core.BaseEvent;
   
   public class WSEvent extends BaseEvent
   {
      
      public static const CONNECT:String = "ws-connect";
      
      public static const CLOSED:String = "ws-closed";
      
      public static const DATA:String = "ws-data";
      
      public static const IO_ERROR:String = "ws-ioError";
      
      public static const SECURITY_ERROR:String = "ws-securityError";
      
      public function WSEvent(param1:String, param2:Object = null)
      {
         super(param1);
         this.params = param2;
      }
   }
}

