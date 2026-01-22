package com.oyunstudyosu.utils
{
   import flash.external.ExternalInterface;
   
   public class Logger
   {
      
      public function Logger()
      {
         super();
      }
      
      public static function log(param1:String, param2:Boolean = false) : void
      {
         trace(param1);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("console.error",param1);
         }
         if(param2)
         {
            Tracker.track("runtime","main","log",param1);
         }
      }
   }
}

