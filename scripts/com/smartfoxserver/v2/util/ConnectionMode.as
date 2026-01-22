package com.smartfoxserver.v2.util
{
   public class ConnectionMode
   {
      
      public static const SOCKET:String = "socket";
      
      public static const HTTP:String = "http";
      
      public static const WEB_SOCKET:String = "ws";
      
      public function ConnectionMode()
      {
         super();
         throw new ArgumentError("The ConnectionMode class has no constructor!");
      }
   }
}

