package com.oyunstudyosu.bot
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.CharacterEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Davulcu extends Character
   {
      
      private var position:Point;
      
      private var activeClothes:Array;
      
      private var request:AssetRequest;
      
      private var vo:BotVO;
      
      private var assetPath:String = "/static/pubs/";
      
      private var tileX:int;
      
      private var tileY:int;
      
      private var targetCell:int;
      
      private var walkTimer:Timer;
      
      private var data:Object;
      
      public function Davulcu(param1:Object)
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
         activeClothes = ["davulcu_9"];
         vo = new BotVO();
         vo.setProperty({
            "cn":"PaymentPanelProperty",
            "booth":data.assetUrl
         });
         this.init(Sanalika.instance.localizationModel.translate("TutorialCharName"),Sanalika.instance.engine.scene,0,"m",activeClothes);
         this.direction = 5;
         this.reLocate(int(position.x),int(position.y),direction);
         this.avatarName = Sanalika.instance.localizationModel.translate("bot_ramadan");
         this.isNPC = true;
         container.addEventListener("click",botClicked);
         container.addEventListener("rollOver",botOver);
         container.addEventListener("rollOut",botOut);
         var _loc1_:SceneCharacterComponent = scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         _loc1_.addChar(this);
         Dispatcher.addEventListener("CharacterEvent.CHAR_STOPPED",charStopped);
         TweenMax.delayedCall(1,firstWalk);
      }
      
      override public function update() : void
      {
         super.update();
      }
      
      protected function botOver(param1:MouseEvent) : void
      {
         TweenMax.to(container,0,{"glowFilter":{
            "color":16777215,
            "alpha":1,
            "blurX":4,
            "blurY":4,
            "strength":4
         }});
      }
      
      protected function botOut(param1:MouseEvent) : void
      {
         TweenMax.to(container,0,{"glowFilter":{
            "color":16777215,
            "alpha":0,
            "blurX":0,
            "blurY":0,
            "strength":0
         }});
      }
      
      protected function botClicked(param1:MouseEvent) : void
      {
         vo.property.execute("");
         param1.stopPropagation();
      }
      
      private function firstWalk() : void
      {
         this.speed = 0.7;
         if(walkTimer != null)
         {
            walkTimer.stop();
         }
         walkTimer = new Timer(2,1);
         walkTimer.addEventListener("timerComplete",walkTimer_timercomplete);
         walkTimer.start();
         talkk();
      }
      
      private function talkk() : void
      {
         this.talk(Sanalika.instance.localizationModel.translate("bot_ramadanTalk" + int(Math.random() * 3)),5,1,false);
         TweenMax.delayedCall(Math.random() * 10 + 10,talkk);
      }
      
      private function newPoint() : void
      {
         tileX = Math.random() * Sanalika.instance.roomModel.gridModel.width;
         tileY = Math.random() * Sanalika.instance.roomModel.gridModel.height;
         targetCell = Sanalika.instance.engine.scene.getCellTypeByGrid(tileX,0,tileY);
         while(targetCell != 0)
         {
            tileX = Math.random() * Sanalika.instance.roomModel.gridModel.width;
            tileY = Math.random() * Sanalika.instance.roomModel.gridModel.height;
            targetCell = Sanalika.instance.engine.scene.getCellTypeByGrid(tileX,0,tileY);
         }
      }
      
      private function walkTimer_timercomplete(param1:TimerEvent = null) : void
      {
         newPoint();
         this.walk(tileX,tileY);
      }
      
      private function charStopped(param1:CharacterEvent) : void
      {
         if(param1.char != this)
         {
            return;
         }
         walkTimer.start();
      }
      
      override public function terminate(param1:Boolean = true) : void
      {
         TweenMax.killDelayedCallsTo(firstWalk);
         TweenMax.killDelayedCallsTo(talkk);
         if(walkTimer != null)
         {
            walkTimer.removeEventListener("timerComplete",walkTimer_timercomplete);
            walkTimer.stop();
         }
         Dispatcher.removeEventListener("CharacterEvent.CHAR_STOPPED",charStopped);
         super.terminate(param1);
      }
   }
}

