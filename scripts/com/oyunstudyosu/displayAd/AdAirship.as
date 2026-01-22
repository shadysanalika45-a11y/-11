package com.oyunstudyosu.displayAd
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.utils.Logger;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   
   public class AdAirship
   {
      
      private var request:AssetRequest;
      
      public var data:Object;
      
      private var cookieModel:ICookieModel;
      
      private var adClip:MovieClip;
      
      private var assetPath:String = "/static/pubs/";
      
      public var airship:MovieClip;
      
      private var vo:AlertVo;
      
      public function AdAirship(param1:*)
      {
         super();
         this.data = param1;
         trace(JSON.stringify(param1));
      }
      
      public function execute() : void
      {
         try
         {
            loadAdAsset();
         }
         catch(error:Error)
         {
            return;
         }
      }
      
      public function loadAdAsset() : void
      {
         if(!Sanalika.instance.airModel.isAir())
         {
            Security.allowDomain("http://www.google.com");
            Security.allowDomain("http://tpc.googlesyndication.com");
            Security.allowDomain("http://partner.googleadservices.com");
            Security.allowDomain("https://www.google.com");
            Security.allowDomain("https://tpc.googlesyndication.com");
            Security.allowDomain("https://partner.googleadservices.com");
            Security.allowDomain("http://img-oyunstudyosu.mncdn.com");
            Security.allowDomain("https://fs.sanalika.com");
         }
         request = new AssetRequest();
         request.type = "ModuleType.AD_AIRSHIP";
         request.assetId = assetPath + data.assetUrl;
         request.loadedFunction = onLoaded;
         request.errorFunction = onError;
         request.context = Sanalika.instance.domainModel.assetContext;
         request.priority = 99;
         Sanalika.instance.assetModel.request(request);
      }
      
      private function onError(param1:Object) : void
      {
         request.dispose();
      }
      
      public function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Bitmap = null;
         adClip = new MovieClip();
         try
         {
            _loc2_ = param1.display as Bitmap;
            adClip.addChild(_loc2_);
         }
         catch(e:Error)
         {
            Logger.log("AirshipError: " + e.message);
         }
         adClip.buttonMode = true;
         adClip.addEventListener("click",adClicked);
         adClip.addEventListener("mouseOver",adOver);
         adClip.addEventListener("mouseOut",adOut);
         param1.dispose();
         adClip.x = -250;
         adClip.y = 250;
         Sanalika.instance.engine.scene.ceilingContainer.addChild(adClip);
         moveShip();
      }
      
      protected function moveShip() : void
      {
         adClip.x = -250;
         adClip.y = 250;
         TweenMax.to(adClip,data.length,{
            "delay":Math.random() * data.skipSecond + 4,
            "x":1000,
            "y":-150,
            "onComplete":moveShip
         });
      }
      
      protected function adOver(param1:MouseEvent) : void
      {
         TweenMax.to(adClip,0,{"glowFilter":{
            "color":16777215,
            "alpha":1,
            "blurX":4,
            "blurY":4,
            "strength":4
         }});
      }
      
      protected function adOut(param1:MouseEvent) : void
      {
         TweenMax.to(adClip,0,{"glowFilter":{
            "color":16777215,
            "alpha":0,
            "blurX":0,
            "blurY":0,
            "strength":0
         }});
      }
      
      protected function adClicked(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         Tracker.track("ad","clickZeplin",data.alias,Sanalika.instance.roomModel.key);
         navigateToURL(new URLRequest(data.clickUrl),"_blank");
         Sanalika.instance.cookieModel.write("ad_" + data.alias,(Sanalika.instance.cookieModel.read("ad_" + data.alias) as int) + 1);
         Connectr.instance.serviceModel.requestData("randomwheel",{
            "command":"play",
            "id":405
         },campaignGiftResponse);
      }
      
      private function campaignGiftResponse(param1:Object) : void
      {
         Connectr.instance.serviceModel.removeRequestData("randomwheel",campaignGiftResponse);
         vo = new AlertVo();
         vo.alertType = "tooltip";
         vo.description = "Hediyen Çantana Eklendi";
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      public function dispose() : void
      {
         data = null;
         if(adClip)
         {
            adClip.removeEventListener("mouseOver",adOver);
            adClip.removeEventListener("mouseOut",adOut);
            adClip.removeEventListener("click",adClicked);
         }
      }
   }
}

