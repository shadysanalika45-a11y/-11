package com.oyunstudyosu.displayAd
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.bot.Davulcu;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.utils.Tracker;
   import flash.utils.getTimer;
   
   public class AdModel implements IAdModel
   {
      
      public var displayAdList:Array;
      
      private var cookieModel:ICookieModel;
      
      private var currentRepeatCount:int = 0;
      
      private var adBot:AdBot;
      
      private var npcBot:NpcBot;
      
      private var davulcu:Davulcu;
      
      private var botList:Array;
      
      private var adBillboard:AdBillboard;
      
      private var adAirship:AdAirship;
      
      private var adSkin:AdSkin;
      
      private var skipSecond:int;
      
      private var id:int;
      
      private var assetUrl:String;
      
      private var length:int;
      
      private var clickUrl:String;
      
      private var alias:String;
      
      public function AdModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("displayAd",onDisplayAd);
         Dispatcher.addEventListener("TERMINATE_SCENE",onTerminateScene);
         cookieModel = Sanalika.instance.cookieModel;
      }
      
      private function ddf(param1:uint) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1 + "";
      }
      
      private function onDisplayAd(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.ads;
         if(!_loc2_)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            executeAd(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function executeAd(param1:Object) : void
      {
         if(Sanalika.instance.avatarModel.permission.check(4) && param1.type == "VIDEO")
         {
            return;
         }
         if(cookieModel.read("ad_" + param1.alias))
         {
            currentRepeatCount = cookieModel.read("ad_" + param1.alias) as int;
         }
         if(currentRepeatCount < param1.repeat || param1.repeat == 0)
         {
            if(param1.type == "VIDEO" || param1.type == "VIPVIDEO")
            {
               displayVideo(param1);
            }
            if(param1.type == "BOT")
            {
               displayBot(param1);
            }
            if(param1.type == "BILLBOARD")
            {
               displayBillboard(param1);
            }
            if(param1.type == "PANEL")
            {
               TweenMax.delayedCall(5 + Math.random() * 10,displayPanel,[param1]);
            }
            if(param1.type == "AIRSHIP")
            {
               displayAirship(param1);
            }
            if(param1.type == "DAVULCU")
            {
               displayDavulcu(param1);
            }
            if(param1.type == "PAYMENTPANEL")
            {
               TweenMax.delayedCall(5 + Math.random() * 10,displayPaymentPanel,[param1]);
            }
         }
      }
      
      private function displayAirship(param1:Object) : void
      {
         adAirship = new AdAirship(param1);
         adAirship.execute();
      }
      
      private function displayBillboard(param1:Object) : void
      {
         adBillboard = new AdBillboard(param1);
         adBillboard.execute();
      }
      
      private function displaySkin() : void
      {
         adSkin = new AdSkin();
         adSkin.execute();
      }
      
      public function displayBot(param1:Object) : ICharacter
      {
         adBot = new AdBot(param1);
         adBot.execute();
         return adBot;
      }
      
      public function displayNpc(param1:Object) : ICharacter
      {
         npcBot = new NpcBot(param1);
         adBot.execute();
         return npcBot;
      }
      
      public function displayDavulcu(param1:Object) : ICharacter
      {
         davulcu = new Davulcu(param1);
         davulcu.execute();
         return davulcu;
      }
      
      public function onVideoClose(param1:int) : void
      {
         cookieModel.write("ad_" + alias,(cookieModel.read("ad_" + alias) as int) + 1);
         Tracker.track("ad","closeVP",alias,videoPoint(param1));
      }
      
      public function onLinkClicked() : void
      {
         Tracker.track("ad","clickUrl",alias,"");
      }
      
      private function displayVideo(param1:Object) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = param1;
         _loc2_.name = "VideoPanel";
         _loc2_.type = "hud";
         if(param1.alias == "2019Isbank")
         {
            _loc2_.name = "Isbank2019VideoPanel";
         }
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function videoPoint(param1:*) : String
      {
         var _loc2_:int = (getTimer() - param1) / 1000;
         if(_loc2_ / length < 0.02)
         {
            return "B00";
         }
         if(_loc2_ / length < 0.35)
         {
            return "B25";
         }
         if(_loc2_ / length < 0.65)
         {
            return "B50";
         }
         if(_loc2_ / length < 0.85)
         {
            return "B75";
         }
         return "B100";
      }
      
      private function displayPanel(param1:Object) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = param1;
         _loc2_.name = param1.assetUrl;
         _loc2_.type = "static";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function displayPaymentPanel(param1:Object) : void
      {
         var _loc2_:PanelVO = new PanelVO();
         _loc2_.params = param1;
         _loc2_.params.booth = param1.assetUrl;
         _loc2_.name = "PaymentPanel";
         _loc2_.type = "hud";
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function onTerminateScene(param1:GameEvent) : void
      {
         if(adBot)
         {
            adBot = null;
         }
         if(npcBot)
         {
            npcBot = null;
         }
         if(davulcu)
         {
            davulcu = null;
         }
         if(adBillboard)
         {
            adBillboard.dispose();
            adBillboard = null;
         }
         if(adAirship)
         {
            adAirship.dispose();
            adAirship = null;
         }
         if(adSkin)
         {
            adSkin.dispose();
            adSkin = null;
         }
      }
   }
}

