package com.oyunstudyosu.game.partyisland.components
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.scene.components.*;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import com.oyunstudyosu.utils.RandomUtils;
   import com.oyunstudyosu.utils.TextFieldManager;
   import de.polygonal.core.fmt.Sprintf;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.oyunstudyosu.game.Dice;
   import org.oyunstudyosu.game.DiceArabic;
   import org.oyunstudyosu.game.partyisland.BoardBg;
   import org.oyunstudyosu.game.partyisland.DiceBg;
   import org.oyunstudyosu.game.partyisland.LeaveGameButton;
   import org.oyunstudyosu.game.partyisland.NotifyItem;
   import org.oyunstudyosu.game.partyisland.ProgressBar;
   
   public class IslandSceneHudComponent extends BaseSceneComponent
   {
      
      private var dice1:MovieClip;
      
      private var dice2:MovieClip;
      
      public var diceBg:DiceBg;
      
      private var notifyItem:NotifyItem;
      
      public var progressBar:ProgressBar;
      
      private var boardBg:BoardBg;
      
      private var leaveGameButton:LeaveGameButton;
      
      public var container:Sprite = new Sprite();
      
      public function IslandSceneHudComponent(param1:IScene)
      {
         super(param1);
         Sanalika.instance.hudModel.visible = false;
         if(Sanalika.instance.gameModel.language == "ar")
         {
            dice1 = new DiceArabic();
            dice2 = new DiceArabic();
         }
         else
         {
            dice1 = new Dice();
            dice2 = new Dice();
         }
         trace("IslandSceneHudComponent created");
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
      }
      
      public function sceneLoaded(param1:GameEvent) : void
      {
         Sanalika.instance.layerModel.hudLayer.addChildAt(container,0);
         progressBar = new ProgressBar();
         container.addChild(progressBar);
         boardBg = new BoardBg();
         container.addChild(boardBg);
         diceBg = new DiceBg();
         diceBg.addEventListener("click",onDiceButtonClick);
         container.addChild(diceBg);
         diceBg.addChild(dice1);
         dice1.stop();
         diceBg.addChild(dice2);
         dice2.stop();
         notifyItem = new NotifyItem();
         notifyItem.txtMsg = TextFieldManager.convertAsArabicTextField(notifyItem.txtMsg);
         container.addChild(notifyItem);
         leaveGameButton = new LeaveGameButton();
         leaveGameButton.addEventListener("click",onLeaveGameButtonClick);
         container.addChild(leaveGameButton);
         Dispatcher.addEventListener("UI_SCALE_CHANGED",onUpdateUI);
         Dispatcher.addEventListener("RESIZE",onUpdateUI);
         Sanalika.instance.stage.addEventListener("enterFrame",onUpdate);
         onUpdateUI();
      }
      
      public function highlightTurn(param1:String) : void
      {
         var _loc2_:IslandLeaderboardComponent = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
         _loc2_.highlightTurn(param1);
         boardBg.highlightTurn(param1);
      }
      
      public function updateSpectatorCount(param1:int) : void
      {
         this.boardBg.updateSpectatorCount(param1);
      }
      
      public function updateNotifyText(param1:String, param2:Array = null) : void
      {
         if(param2 == null)
         {
            param2 = [];
         }
         notifyItem.txtMsg.text = Sprintf.format(Sanalika.instance.localizationModel.translate(param1),param2);
      }
      
      private function onLeaveGameButtonClick(param1:MouseEvent) : void
      {
         var vo:AlertVo;
         var e:MouseEvent = param1;
         var sceneCharacterComponent:ISceneCharacterComponent = scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         var islandServiceComponent:IslandServiceComponent = scene.getComponent(IslandServiceComponent) as IslandServiceComponent;
         if(sceneCharacterComponent != null && sceneCharacterComponent.myChar != null && !sceneCharacterComponent.myChar.isSpectator && islandServiceComponent != null && (!islandServiceComponent.isBuddyGame() || islandServiceComponent.isGameStarted()) && !islandServiceComponent.isGameEnded())
         {
            vo = new AlertVo();
            vo.alertType = "Confirm";
            vo.callBack = function(param1:int):void
            {
               if(param1 == 2)
               {
                  islandServiceComponent.leaveGame();
               }
            };
            vo.description = Sanalika.instance.localizationModel.translate("The game has already started, your ticket will be destroyed if you leave, do you still want to continue?");
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else
         {
            islandServiceComponent.leaveGame();
         }
      }
      
      public function add(param1:PartyPlayerVo) : void
      {
         boardBg.add(param1);
      }
      
      public function remove(param1:PartyPlayerVo) : void
      {
         boardBg.remove(param1);
      }
      
      private function onUpdate(param1:Event) : void
      {
         var _loc2_:IslandLeaderboardComponent = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
         _loc2_.update();
         boardBg.update();
      }
      
      private function onUpdateUI(param1:Object = null) : void
      {
         var _loc2_:Number = Sanalika.instance.scaleModel.uiScale;
         leaveGameButton.scaleX = leaveGameButton.scaleY = notifyItem.scaleX = notifyItem.scaleY = diceBg.scaleX = diceBg.scaleY = boardBg.scaleX = boardBg.scaleY = progressBar.scaleX = progressBar.scaleY = _loc2_;
         progressBar.x = 26;
         progressBar.y = 20;
         dice1.x = 34;
         dice1.y = 34;
         dice2.x = 58;
         dice2.y = 58;
         boardBg.x = Sanalika.instance.layerModel.canvasWidth - boardBg.width - 4;
         boardBg.y = 46;
         diceBg.x = Sanalika.instance.layerModel.canvasWidth - diceBg.width - 20;
         diceBg.y = Sanalika.instance.layerModel.canvasHeight - diceBg.height - 20;
         notifyItem.x = Sanalika.instance.layerModel.canvasWidth / 2;
         notifyItem.y = Sanalika.instance.layerModel.canvasHeight - notifyItem.height;
         leaveGameButton.x = 20;
         leaveGameButton.y = Sanalika.instance.layerModel.canvasHeight - (leaveGameButton.height + 20);
         leaveGameButton.buttonMode = true;
         updateNotifyText("Waiting for players...");
      }
      
      private function randomFunction(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:* = RandomUtils.integer(1,6);
         _loc2_.gotoAndStop(_loc3_);
      }
      
      public function setDiceResult(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc3_:MovieClip = null;
         setTimeout(0);
         var _loc5_:Array = [dice1,dice2];
         var _loc4_:Array = [param1,param2];
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc6_];
            _loc3_.play();
            _loc3_.addEventListener("enterFrame",randomFunction);
            flash.utils.setTimeout(finalizeDiceResult,RandomUtils.integer(1000,2000),_loc5_,_loc4_,_loc6_);
            _loc6_++;
         }
      }
      
      private function finalizeDiceResult(param1:Array, param2:Array, param3:int) : *
      {
         var _loc5_:MovieClip = param1[param3];
         var _loc4_:int = int(param2[param3]);
         _loc5_.removeEventListener("enterFrame",randomFunction);
         _loc5_.gotoAndStop(_loc4_);
      }
      
      public function setTurn(param1:Boolean) : void
      {
         diceBg.processTurn(param1);
      }
      
      public function setTimeout(param1:int) : void
      {
         diceBg.setTimer(param1);
      }
      
      private function onDiceButtonClick(param1:MouseEvent) : void
      {
         trace("onDiceButtonClick");
         Sanalika.instance.serviceModel.requestData("partyIsland.rollDice",{},null,Sanalika.instance.roomModel.interactiveRoom);
      }
      
      override public function dispose() : void
      {
         Dispatcher.removeEventListener("UI_SCALE_CHANGED",onUpdateUI);
         Dispatcher.removeEventListener("RESIZE",onUpdateUI);
         Dispatcher.removeEventListener("SCENE_LOADED",sceneLoaded);
         Sanalika.instance.layerModel.hudLayer.removeChild(container);
         Sanalika.instance.hudModel.visible = true;
         Sanalika.instance.stage.removeEventListener("enterFrame",onUpdate);
         isDisposed = true;
      }
   }
}

