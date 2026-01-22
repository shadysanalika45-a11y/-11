package com.smartfoxserver.v2.exceptions
{
   public class SFSError extends Error
   {
      
      private var _details:String;
      
      public function SFSError(param1:String, param2:int = 0, param3:String = null)
      {
         super(param1,param2);
         this._details = param3;
      }
      
      public function get details() : String
      {
         return this._details;
      }
   }
}

