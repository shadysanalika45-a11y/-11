package com.oyunstudyosu.engine.core
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.chat.SpeechBalloon;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.sanalika.interfaces.IBotEntry;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.xml.XMLNode;
   import org.oyunstudyosu.assets.clips.BotPlaceHolder;
   
   public class BotEntry extends MapEntry implements IBotEntry
   {
      
      private var frameNumber:int;
      
      private var speechBalloon:SpeechBalloon;
      
      private var speechBalloons:Array;
      
      public var name:String;
      
      private var swfPath:String;
      
      private var request:IAssetRequest;
      
      private var botClip:MovieClip;
      
      private var botPlaceHolder:MovieClip;
      
      private var i:int = 0;
      
      private var _questIcons:Dictionary;
      
      private var _questCount:int = 0;
      
      public function BotEntry(param1:XMLNode = null)
      {
         super(param1);
         speechBalloons = [];
         _questIcons = new Dictionary();
      }
      
      public function get questIcons() : Dictionary
      {
         return _questIcons;
      }
      
      public function get questCount() : int
      {
         return _questCount;
      }
      
      public function set questCount(param1:int) : void
      {
         _questCount = param1;
      }
      
      override public function init(param1:IScene) : void
      {
         super.init(param1);
         botPlaceHolder = new BotPlaceHolder();
         clip.addChildAt(botPlaceHolder,0);
         var _loc2_:LoaderContext = new LoaderContext();
         _loc2_.checkPolicyFile = true;
         _loc2_.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         _loc2_.securityDomain = null;
         _loc2_.allowCodeImport = false;
         _loc2_.imageDecodingPolicy = "onLoad";
         swfPath = Sanalika.instance.moduleModel.getPath(definition,"ModuleType.BOT") + "?v" + version;
         request = new AssetRequest();
         request.assetId = swfPath;
         trace("swfPath",swfPath,"i",i);
         i = i + 1;
         request.type = "ModuleType.BOT";
         request.loadedFunction = onLoaded;
         request.errorFunction = onError;
         request.context = _loc2_;
         request.priority = 99;
         Sanalika.instance.assetModel.request(request);
      }
      
      private function onError(param1:Object) : void
      {
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Class = DefinitionUtils.getClass(param1.context.applicationDomain,definition);
         if(_loc2_)
         {
            botClip = new _loc2_();
            clip.removeChild(botPlaceHolder);
            botPlaceHolder = null;
            clip.addChildAt(botClip,0);
            botClip.gotoAndStop(1);
         }
         TweenMax.delayedCall(2,addQuestIcon);
         param1.dispose();
         param1.context.applicationDomain = null;
      }
      
      private function addQuestIcon() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < clip.numChildren)
         {
            if(clip.getChildAt(_loc2_).name.indexOf("questIcon") == 0)
            {
               TweenMax.to(clip.getChildAt(_loc2_),0.5,{
                  "glowFilter":{
                     "color":16777215,
                     "alpha":1,
                     "blurX":15,
                     "blurY":15,
                     "strength":2
                  },
                  "repeat":10,
                  "yoyo":true
               });
               TweenMax.to(clip.getChildAt(_loc2_),2,{"alpha":1});
               clip.getChildAt(_loc2_).y = -height;
               clip.getChildAt(_loc2_).x = _loc1_;
               _loc1_ += 30;
            }
            _loc2_++;
         }
      }
      
      public function talk(param1:String, param2:int = 1, param3:Number = 1, param4:Boolean = true) : void
      {
         if(param2 == 1)
         {
            param2 = 5;
         }
         if(speechBalloons.length > 1)
         {
            speechBalloon = speechBalloons.shift();
            speechBalloon.completeDelay();
         }
         speechBalloon = new SpeechBalloon();
         speechBalloon.setType(param2);
         if(!element)
         {
            return;
         }
         speechBalloon.initUI(0,-80,element.canvasPosition,name,param1,param3);
         speechBalloon.addEventListener("disappeared",speechBalloonDisappeared);
         clip.addChild(speechBalloon);
         SpeechBalloon.updateIntersectingSpeechBalloons(speechBalloon.getRect(Sanalika.instance.engine.scene.container));
         Sanalika.instance.engine.scene.speechBalloons.push(speechBalloon);
         speechBalloons.push(speechBalloon);
      }
      
      private function speechBalloonDisappeared(param1:Event) : void
      {
         if(Sanalika.instance.engine.scene == null)
         {
            return;
         }
         removeSpeechBalloon(param1.target as SpeechBalloon);
      }
      
      public function removeSpeechBalloon(param1:SpeechBalloon) : void
      {
         if(param1 && Sanalika.instance.engine.scene.speechBalloons.indexOf(param1) > -1)
         {
            param1.removeEventListener("disappeared",speechBalloonDisappeared);
            Sanalika.instance.engine.scene.speechBalloons.splice(Sanalika.instance.engine.scene.speechBalloons.indexOf(param1),1);
            speechBalloons.splice(speechBalloons.indexOf(param1),1);
            param1 = null;
         }
      }
      
      public function getClip() : Sprite
      {
         return clip;
      }
      
      override public function dispose() : void
      {
         TweenMax.killDelayedCallsTo(addQuestIcon);
         if(request)
         {
            request.dispose();
            request = null;
         }
         botClip = null;
         super.dispose();
      }
   }
}

