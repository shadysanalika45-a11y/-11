package com.oyunstudyosu.displayAd
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.utils.Logger;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   import flash.utils.Dictionary;
   
   public class AdBot extends Character
   {
      
      public static const MALE:String = "male";
      
      public static const FEMALE:String = "female";
      
      private var clothSet:Dictionary;
      
      private var position:Point;
      
      private var direction:int;
      
      private var activeClothes:Array;
      
      private var request:AssetRequest;
      
      public var data:Object;
      
      public var handItem:MovieClip;
      
      public var adClip:MovieClip;
      
      private var cookieModel:ICookieModel;
      
      public var botGender:String;
      
      private var assetPath:String = "/static/pubs/";
      
      public function AdBot(param1:*)
      {
         super();
         this.data = param1;
      }
      
      public function execute() : void
      {
         this.position = new Point(45,18);
         if(Sanalika.instance.roomModel.key == "street03" || Sanalika.instance.roomModel.key == "street10")
         {
            this.position = new Point(45,23);
         }
         if(Sanalika.instance.roomModel.key == "street02")
         {
            this.position = new Point(44,22);
         }
         if(Sanalika.instance.roomModel.key == "street04")
         {
            this.position = new Point(46,12);
         }
         this.direction = 5;
         clothSet = new Dictionary();
         clothSet["male"] = ["A_1","B_1","C_1","2_5","6_6","7_1","13_3"];
         clothSet["female"] = ["C_2","B_2","A_2","7_10","3_7","5_1","11_6"];
         if(Sanalika.instance.avatarModel.gender != "m")
         {
            activeClothes = clothSet["male"];
            botGender = "m";
         }
         else
         {
            activeClothes = clothSet["female"];
            botGender = "f";
         }
         init($("TutorialCharName"),Sanalika.instance.engine.scene as IsoScene,0,botGender,activeClothes);
         reLocate(position.x,position.y,direction);
         avatarName = $("TutorialCharName");
         isNPC = true;
         useHandItem("dL4WAYyX");
         var _loc1_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         _loc1_.addChar(this);
         if(data)
         {
            TweenMax.delayedCall(3,loadAdAsset);
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
         request.type = "ModuleType.AD_BOT";
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
         handItem = this.getHandItem();
         if(handItem)
         {
            adClip = new MovieClip();
            try
            {
               adClip.addChild(param1.display);
            }
            catch(e:Error)
            {
               Logger.log("BotError: " + e.message);
            }
            if(adClip)
            {
               adClip.buttonMode = true;
               adClip.addEventListener("click",adClicked);
               adClip.addEventListener("mouseOver",adOver);
               adClip.addEventListener("mouseOut",adOut);
            }
            TweenMax.delayedCall(1,walkk);
         }
         param1.dispose();
         addAd();
      }
      
      public function addAd() : void
      {
         var _loc1_:MovieClip = null;
         handItem = this.getHandItem();
         if(handItem)
         {
            _loc1_ = handItem.getChildByName("display") as MovieClip;
            _loc1_.addChild(adClip);
         }
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
         Tracker.track("ad","clickUrl",data.alias,"");
         navigateToURL(new URLRequest(data.clickUrl),"_blank");
         Sanalika.instance.cookieModel.write("ad_" + data.alias,(Sanalika.instance.cookieModel.read("ad_" + data.alias) as int) + 1);
         this.removeHandItem();
         TweenMax.delayedCall(10,bye);
      }
      
      public function walkk() : void
      {
         if(Sanalika.instance.roomModel.key == "street03" || Sanalika.instance.roomModel.key == "street10")
         {
            this.walk(8,23);
         }
         else if(Sanalika.instance.roomModel.key == "street02")
         {
            this.walk(6,22);
         }
         else if(Sanalika.instance.roomModel.key == "street04")
         {
            this.walk(6,12);
         }
         else
         {
            this.walk(8,18);
         }
         TweenMax.delayedCall(16,walkk2);
      }
      
      public function walkk2() : void
      {
         if(Sanalika.instance.roomModel.key == "street03" || Sanalika.instance.roomModel.key == "street10")
         {
            this.walk(45,23);
         }
         else if(Sanalika.instance.roomModel.key == "street02")
         {
            this.walk(44,22);
         }
         else if(Sanalika.instance.roomModel.key == "street04")
         {
            this.walk(46,12);
         }
         else
         {
            this.walk(45,18);
         }
         TweenMax.delayedCall(10,walkk);
      }
      
      private function bye() : void
      {
         var _loc1_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         _loc1_.removeWithCharacter(this);
      }
      
      override public function terminate(param1:Boolean = true) : void
      {
         TweenMax.killDelayedCallsTo(walkk);
         TweenMax.killDelayedCallsTo(loadAdAsset);
         TweenMax.killDelayedCallsTo(bye);
         data = null;
         if(adClip != null)
         {
            adClip.removeEventListener("mouseOver",adOver);
            adClip.removeEventListener("mouseOut",adOut);
            adClip.removeEventListener("click",adClicked);
            adClip = null;
         }
         super.terminate(param1);
      }
   }
}

