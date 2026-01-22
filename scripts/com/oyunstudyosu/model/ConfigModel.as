package com.oyunstudyosu.model
{
   import flash.utils.Dictionary;
   
   public class ConfigModel
   {
      
      private var callbackList:Dictionary;
      
      private var configData:Dictionary;
      
      public function ConfigModel()
      {
         super();
         callbackList = new Dictionary();
         configData = new Dictionary();
         Sanalika.instance.serviceModel.listenExtension("config",function(param1:*):*
         {
            onConfigData(param1,false);
         });
         Sanalika.instance.serviceModel.listenExtension("updateConfig",function(param1:*):*
         {
            onConfigData(param1,true);
         });
      }
      
      private function onConfigData(param1:Object, param2:Boolean) : void
      {
         var _loc5_:* = undefined;
         for(var _loc3_ in param1)
         {
            _loc5_ = param1[_loc3_];
            if(callbackList[_loc3_] != null && configData[_loc3_] != _loc5_)
            {
               configData[_loc3_] = _loc5_;
               if(param2)
               {
                  for each(var _loc4_ in callbackList[_loc3_])
                  {
                     _loc4_(_loc5_);
                  }
               }
            }
         }
      }
      
      public function getVariable(param1:String, param2:* = null) : *
      {
         var _loc3_:* = configData[param1];
         if(_loc3_ == null)
         {
            return param2;
         }
         return _loc3_;
      }
      
      public function listenVariable(param1:String, param2:*) : void
      {
         if(callbackList[param1] == null)
         {
            callbackList[param1] = [];
         }
         callbackList[param1].push(param2);
      }
   }
}

