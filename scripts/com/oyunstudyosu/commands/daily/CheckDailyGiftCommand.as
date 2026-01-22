package com.oyunstudyosu.commands.daily
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   
   public class CheckDailyGiftCommand extends Command
   {
      
      private var campaigns:Array;
      
      public function CheckDailyGiftCommand(param1:Array)
      {
         super();
         this.campaigns = param1;
      }
      
      override public function execute() : void
      {
         Dispatcher.addEventListener("SCENE_LOADED",sceneDataLoaded);
      }
      
      private function sceneDataLoaded(param1:GameEvent) : void
      {
         var _loc3_:PanelVO = null;
         var _loc2_:AlertVo = null;
         Dispatcher.removeEventListener("SCENE_LOADED",sceneDataLoaded);
         if(campaigns.length > 0 && !Sanalika.instance.avatarModel.isTutorialMode)
         {
            _loc3_ = new PanelVO();
            _loc3_.name = "DailyGiftPanel";
            _loc3_.type = "static";
            _loc3_.params = {};
            _loc3_.params.campaigns = campaigns;
            Sanalika.instance.panelModel.openPanel(_loc3_);
         }
         else if(Sanalika.instance.avatarModel.fbToken == "")
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $("infoDailyCampaign");
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         complete();
      }
      
      override public function dispose() : void
      {
         Dispatcher.removeEventListener("SCENE_LOADED",sceneDataLoaded);
      }
   }
}

