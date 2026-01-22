package com.oyunstudyosu.timer
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ServerTimerModel
   {
      
      private var callbackList:Dictionary;
      
      public function ServerTimerModel()
      {
         super();
         callbackList = new Dictionary();
         Sanalika.instance.stage.addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:ServerTimerVo = null;
         if(!SyncTimer.inited)
         {
            return;
         }
         var _loc3_:Vector.<String> = new Vector.<String>();
         for(var _loc4_ in callbackList)
         {
            _loc2_ = callbackList[_loc4_];
            trace(SyncTimer.timestamp + " >= " + _loc2_.targetTimestamp);
            if(SyncTimer.timestamp >= _loc2_.targetTimestamp)
            {
               _loc2_.callback();
               _loc3_.push(_loc4_);
            }
         }
         for each(_loc4_ in _loc3_)
         {
            delete callbackList[_loc4_];
         }
      }
      
      public function create(param1:String, param2:Function, param3:int) : void
      {
         var _loc4_:ServerTimerVo = new ServerTimerVo();
         _loc4_.callback = param2;
         _loc4_.targetTimestamp = param3;
         callbackList[param1] = _loc4_;
      }
      
      public function remove(param1:String) : void
      {
         delete callbackList[param1];
      }
   }
}

