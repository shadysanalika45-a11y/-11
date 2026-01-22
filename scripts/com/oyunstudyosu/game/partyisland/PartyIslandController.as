package com.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   
   public class PartyIslandController
   {
      
      public function PartyIslandController()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("continuePartyIslandGame",continuePartyIslandGame);
      }
      
      private function continuePartyIslandGame(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = Sanalika.instance.localizationModel.translate("continuePartyIslandGame");
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
   }
}

