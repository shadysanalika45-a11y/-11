package com.oyunstudyosu.controller
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.utils.Logger;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Timer;
   
   public class ReloadController
   {
      
      private var timeoutId:uint;
      
      private var reloadTime:int;
      
      private var timer:Timer;
      
      private var percent:int;
      
      private var progressVo:ProgressVo;
      
      public function ReloadController()
      {
         super();
         Dispatcher.addEventListener("RELOAD",onReload);
         timer = new Timer(1000,0);
         progressVo = ProgressVo.LOADING;
      }
      
      private function onReload(param1:GameEvent) : void
      {
         progressVo.percent = 100;
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",progressVo));
         Dispatcher.dispatchEvent(new GameEvent("TERMINATE_GAME"));
         reloadTime = 25 - int(Math.random() * 10);
         percent = 150 / reloadTime;
         timer.addEventListener("timer",onTimer);
         timer.start();
      }
      
      protected function onTimer(param1:TimerEvent) : void
      {
         if(timer.currentCount >= reloadTime)
         {
            timer.stop();
            timer.removeEventListener("timer",onTimer);
            progressVo.percent = 100;
            if(ExternalInterface.available)
            {
               Logger.log("Sanalika.reload");
               ExternalInterface.call("Sanalika.reload");
            }
            return;
         }
         progressVo.percent = percent;
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",progressVo));
      }
   }
}

