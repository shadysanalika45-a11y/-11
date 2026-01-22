package com.oyunstudyosu.model
{
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class WalkModel
   {
      
      private var walkTimeout:uint = 0;
      
      public function WalkModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("walkrequest",onWalkStart);
      }
      
      private function onWalkStart(param1:Object) : void
      {
         if(param1.delay != null)
         {
            clearTimeout(walkTimeout);
            walkTimeout = setTimeout(walkTimerComplete,parseInt(param1.delay));
         }
      }
      
      private function walkTimerComplete() : void
      {
         Sanalika.instance.serviceModel.requestData("walkfinalrequest",{},null);
      }
   }
}

