package com.oyunstudyosu.controller
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   
   public class MatchmakingController
   {
      
      public function MatchmakingController()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("matchmakingStart",onStartMatchmaking);
         Sanalika.instance.serviceModel.listenExtension("matchmakingCancel",onCancelMatchmaking);
      }
      
      private function onStartMatchmaking(param1:Object) : void
      {
         var _loc2_:HudEvent = new HudEvent("HudEvent.SHOW_MATCHMAKING");
         Dispatcher.dispatchEvent(_loc2_);
         Sanalika.instance.matchmakingModel.isMatchmaking = true;
      }
      
      private function onCancelMatchmaking(param1:Object) : void
      {
         var _loc2_:HudEvent = new HudEvent("HudEvent.HIDE_MATCHMAKING");
         Dispatcher.dispatchEvent(_loc2_);
         Sanalika.instance.matchmakingModel.isMatchmaking = false;
      }
   }
}

