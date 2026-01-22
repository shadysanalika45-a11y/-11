package com.oyunstudyosu.game.partyisland.components
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.scene.components.BaseSceneComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import com.oyunstudyosu.game.partyisland.property.IPartyProperty;
   import com.oyunstudyosu.game.partyisland.property.PartyPropertyList;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import de.polygonal.core.fmt.Sprintf;
   
   public class IslandServiceComponent extends BaseSceneComponent
   {
      
      public var startPoint:IntPoint;
      
      public var finishPoint:IntPoint;
      
      public function IslandServiceComponent(param1:IScene)
      {
         super(param1);
         Dispatcher.addEventListener("SCENE_LOADED",sceneLoaded);
      }
      
      public function sceneLoaded(param1:GameEvent) : void
      {
         Sanalika.instance.serviceModel.listenExtension("partyIsland.turn",onTurn);
         Sanalika.instance.serviceModel.listenExtension("partyIsland.dice",onDice);
         Sanalika.instance.serviceModel.listenExtension("partyIsland.gameState",onGameState);
         Sanalika.instance.serviceModel.listenExtension("partyIsland.joinStatus",onJoinStatus);
         Sanalika.instance.serviceModel.listenExtension("partyIsland.property",onProperty);
         Sanalika.instance.serviceModel.listenExtension("partyIsland.gameCanceled",onGameCancelled);
         Sanalika.instance.serviceModel.listenRoomVariable("isGameEnded",onGameEnded);
         var _loc2_:ISFSArray = Sanalika.instance.roomModel.currentRoom.getVariable("startPoint").getSFSArrayValue();
         startPoint = new IntPoint(_loc2_.getShort(0),_loc2_.getShort(1));
         var _loc3_:ISFSArray = Sanalika.instance.roomModel.currentRoom.getVariable("finishPoint").getSFSArrayValue();
         finishPoint = new IntPoint(_loc3_.getShort(0),_loc3_.getShort(1));
         Sanalika.instance.serviceModel.sfs.addEventListener("userEnterRoom",onSpectatorCountUpdated);
         Sanalika.instance.serviceModel.sfs.addEventListener("userExitRoom",onSpectatorCountUpdated);
         onSpectatorCountUpdated();
      }
      
      private function onSpectatorCountUpdated(param1:SFSEvent = null) : void
      {
         var _loc2_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         _loc2_.updateSpectatorCount(Sanalika.instance.roomModel.currentRoom.spectatorCount);
      }
      
      public function isBuddyGame() : Boolean
      {
         var _loc1_:* = Sanalika.instance.roomModel.interactiveRoom;
         if(_loc1_ != null && _loc1_.containsVariable("ownerID"))
         {
            return _loc1_.getVariable("ownerID").getStringValue() != "0";
         }
         return false;
      }
      
      public function isGameStarted() : Boolean
      {
         var _loc1_:* = Sanalika.instance.roomModel.interactiveRoom;
         if(_loc1_ != null && _loc1_.containsVariable("isGameStarted"))
         {
            return _loc1_.getVariable("isGameStarted").getBoolValue();
         }
         return false;
      }
      
      public function isGameEnded() : Boolean
      {
         var _loc1_:* = Sanalika.instance.roomModel.interactiveRoom;
         if(_loc1_ != null && _loc1_.containsVariable("isGameEnded"))
         {
            return _loc1_.getVariable("isGameEnded").getBoolValue();
         }
         return false;
      }
      
      private function onTurn(param1:Object) : *
      {
         var _loc7_:ICharacter = null;
         var _loc3_:PartyPlayerVo = null;
         var _loc5_:String = param1.avatarId;
         var _loc4_:ISceneCharacterComponent = scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         if(_loc4_ != null)
         {
            _loc7_ = _loc4_.getAvatarById(_loc5_);
            if(_loc7_ != null)
            {
               _loc7_.screenShifting();
            }
         }
         var _loc6_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         if(_loc6_ != null)
         {
            _loc6_.highlightTurn(param1.avatarId);
            if(_loc5_ == Sanalika.instance.avatarModel.avatarId)
            {
               Sanalika.instance.soundModel.playSound("SoundKey.ALERT",1,1);
               _loc6_.updateNotifyText("It\'s your turn!");
            }
            else
            {
               _loc6_.updateNotifyText("Waiting for rolling dice...");
            }
            _loc6_.setTurn(_loc5_ == Sanalika.instance.avatarModel.avatarId);
            _loc6_.setTimeout(param1.timeout);
         }
         var _loc2_:IslandPartyPlayerComponent = scene.getComponent(IslandPartyPlayerComponent) as IslandPartyPlayerComponent;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.items[_loc5_];
            if(_loc3_ != null)
            {
               _loc3_.lastTurnAt = param1.lastTurnAt;
            }
         }
      }
      
      private function onDice(param1:Object) : void
      {
         var _loc2_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         _loc2_.setTurn(false);
         var _loc3_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         _loc3_.setDiceResult(param1.dice1,param1.dice2);
      }
      
      private function onGameState(param1:Object) : void
      {
         var _loc3_:PartyPlayerVo = null;
         var _loc2_:IslandPartyPlayerComponent = scene.getComponent(IslandPartyPlayerComponent) as IslandPartyPlayerComponent;
         var _loc6_:IslandLeaderboardComponent = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
         _loc6_.poolValues = param1.pool;
         var _loc5_:Array = param1.players;
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = _loc2_.items[_loc4_.avatarId];
            if(_loc3_ != null)
            {
               _loc3_.finishedAt = _loc4_.finishedAt;
               _loc3_.lastTurnAt = _loc4_.lastTurnAt;
               _loc3_.turnIndex = _loc4_.turnIndex;
               _loc3_.balance = _loc4_.balances[0].balance;
            }
         }
      }
      
      private function onJoinStatus(param1:Object) : void
      {
         var _loc2_:IslandLobbyComponent = scene.getComponent(IslandLobbyComponent) as IslandLobbyComponent;
         _loc2_.setJoinStatus(param1);
      }
      
      private function onProperty(param1:Object) : void
      {
         var _loc4_:String = param1.avatarId;
         var _loc3_:String = param1.property;
         var _loc5_:Object = param1.data;
         var _loc6_:Class = PartyPropertyList._SafeStr_2(_loc3_);
         if(_loc6_ == null)
         {
            trace(_loc3_ + " property not found");
            return;
         }
         var _loc2_:IPartyProperty = new _loc6_();
         _loc2_.execute(_loc4_,_loc5_);
      }
      
      private function onGameCancelled(param1:Object) : void
      {
         var _loc3_:AlertVo = null;
         var _loc2_:ISceneCharacterComponent = scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         if(!_loc2_.myChar.isSpectator)
         {
            _loc3_ = new AlertVo();
            _loc3_.alertType = "tooltip";
            _loc3_.description = Sanalika.instance.localizationModel.translate(param1.reason);
            _loc3_.sound = true;
            Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
         }
      }
      
      private function onGameEnded(param1:Room) : void
      {
         var _loc5_:IslandSceneHudComponent = null;
         var _loc6_:IslandLeaderboardComponent = null;
         var _loc3_:IslandPartyPlayerComponent = null;
         var _loc4_:PartyPlayerVo = null;
         var _loc2_:int = 0;
         var _loc7_:AlertVo = null;
         _loc7_ = null;
         if(isGameEnded())
         {
            Sanalika.instance.hudModel.visible = true;
            _loc5_ = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
            if(_loc5_ != null)
            {
               _loc5_.progressBar.visible = false;
            }
            _loc6_ = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
            _loc3_ = scene.getComponent(IslandPartyPlayerComponent) as IslandPartyPlayerComponent;
            _loc4_ = _loc3_.items[Sanalika.instance.avatarModel.avatarId];
            if(_loc4_ != null && _loc6_.orderedItems.indexOf(_loc4_) != -1)
            {
               _loc2_ = _loc6_.orderedItems.indexOf(_loc4_) + 1;
               _loc7_ = new AlertVo();
               _loc7_.alertType = "Info";
               _loc7_.title = "Congratulations!";
               _loc7_.description = Sprintf.format(Sanalika.instance.localizationModel.translate("You have finished the game in %s place and earned a total of %s sanil!"),[_loc2_,_loc4_.totalBalance]);
               Dispatcher.dispatchEvent(new AlertEvent(_loc7_));
            }
            else
            {
               _loc7_ = new AlertVo();
               _loc7_.alertType = "Info";
               _loc7_.title = "Game Ended";
               _loc7_.description = Sanalika.instance.localizationModel.translate("The game is over, click exit button to close.");
               Dispatcher.dispatchEvent(new AlertEvent(_loc7_));
            }
         }
      }
      
      public function leaveGame() : void
      {
         Sanalika.instance.serviceModel.requestData("partyIsland.leave",{},null,Sanalika.instance.roomModel.interactiveRoom);
      }
      
      override public function dispose() : void
      {
         Dispatcher.removeEventListener("SCENE_LOADED",sceneLoaded);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.turn",onTurn);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.dice",onDice);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.gameState",onGameState);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.joinStatus",onJoinStatus);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.property",onProperty);
         Sanalika.instance.serviceModel.removeExtension("partyIsland.gameCanceled",onGameCancelled);
         Sanalika.instance.serviceModel.removeRoomVariable("isGameEnded",onGameEnded);
         Sanalika.instance.serviceModel.sfs.removeEventListener("userEnterRoom",onSpectatorCountUpdated);
         Sanalika.instance.serviceModel.sfs.removeEventListener("userExitRoom",onSpectatorCountUpdated);
         isDisposed = true;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
