package com.oyunstudyosu.displayAd
{
   import com.greensock.TweenMax;
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.utils.Logger;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   
   public class AdBillboard
   {
      
      private var request:AssetRequest;
      
      public var data:Object;
      
      private var cookieModel:ICookieModel;
      
      private var adClip:MovieClip;
      
      private var assetPath:String = "/static/pubs/";
      
      public function AdBillboard(param1:*)
      {
         super();
         this.data = param1;
      }
      
      public function execute() : void
      {
         try
         {
            Sanalika.instance.engine.scene.bg.mcBillboard;
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
         }
         request = new AssetRequest();
         request.assetId = assetPath + data.assetUrl;
         request.type = "ModuleType.AD_BILLBOARD";
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
         adClip = new MovieClip();
         try
         {
            adClip.addChild(param1.display);
         }
         catch(e:Error)
         {
            Logger.log("BillboardError: " + e.message);
         }
         if(data.clickUrl != null && data.clickUrl != "")
         {
            adClip.buttonMode = true;
            adClip.addEventListener("click",adClicked);
            adClip.addEventListener("mouseOver",adOver);
            adClip.addEventListener("mouseOut",adOut);
         }
         Sanalika.instance.engine.scene.bg.mcBillboard.addChild(adClip);
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
         Cc.info(data);
         Tracker.track("ad","clickBillboard",data.alias,Sanalika.instance.roomModel.key);
         navigateToURL(new URLRequest(data.clickUrl),"_blank");
         param1.stopPropagation();
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

