package com.oyunstudyosu.game.partyisland.components
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.scene.components.BaseSceneComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.game.partyisland.PartyPlayerVo;
   import flash.utils.Dictionary;
   
   public class IslandPartyPlayerComponent extends BaseSceneComponent implements IIslandPartyPlayerComponent
   {
      
      private var _items:Dictionary = new Dictionary();
      
      public function IslandPartyPlayerComponent(param1:IScene)
      {
         super(param1);
         Dispatcher.addEventListener("SCENE_LOADED",onSceneLoaded);
      }
      
      public function get items() : Dictionary
      {
         return _items;
      }
      
      public function set items(param1:Dictionary) : void
      {
         _items = param1;
      }
      
      public function onSceneLoaded(param1:GameEvent) : void
      {
         Dispatcher.addEventListener("USER_ENTER_ROOM",onUserEnterRoom);
         Dispatcher.addEventListener("USER_LEAVE_ROOM",onUserLeaveRoom);
         var _loc2_:ISceneCharacterComponent = scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         if(_loc2_ != null)
         {
            for each(var _loc3_ in _loc2_.characterList)
            {
               addPlayer(_loc3_);
            }
         }
      }
      
      public function onUserEnterRoom(param1:GameEvent) : void
      {
         var _loc2_:ISceneCharacterComponent = null;
         var _loc3_:ICharacter = null;
         if(scene.existsComponent(ISceneCharacterComponent))
         {
            _loc2_ = scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
            _loc3_ = _loc2_.getAvatarById(param1.id);
            if(_loc3_ != null)
            {
               addPlayer(_loc3_);
            }
         }
      }
      
      public function onUserLeaveRoom(param1:GameEvent) : void
      {
         removePlayer(param1.id);
      }
      
      public function addPlayer(param1:ICharacter) : void
      {
         if(param1.isSpectator)
         {
            return;
         }
         var _loc2_:PartyPlayerVo = new PartyPlayerVo(param1);
         items[param1.id] = _loc2_;
         var _loc5_:IslandLeaderboardComponent = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
         _loc5_.add(_loc2_);
         var _loc4_:IslandSceneHudComponent = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
         _loc4_.add(_loc2_);
         var _loc3_:IslandLobbyComponent = scene.getComponent(IslandLobbyComponent) as IslandLobbyComponent;
         _loc3_.add(_loc2_);
      }
      
      public function removePlayer(param1:String) : void
      {
         var _loc5_:IslandLeaderboardComponent = null;
         var _loc4_:IslandSceneHudComponent = null;
         var _loc3_:IslandLobbyComponent = null;
         if(!scene.existsComponent(ISceneCharacterComponent))
         {
            return;
         }
         var _loc2_:PartyPlayerVo = items[param1];
         if(_loc2_ != null)
         {
            _loc5_ = scene.getComponent(IslandLeaderboardComponent) as IslandLeaderboardComponent;
            if(_loc5_ != null)
            {
               _loc5_.remove(_loc2_);
            }
            _loc4_ = scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
            if(_loc4_ != null)
            {
               _loc4_.remove(_loc2_);
            }
            _loc3_ = scene.getComponent(IslandLobbyComponent) as IslandLobbyComponent;
            if(_loc3_ != null)
            {
               _loc3_.remove(_loc2_);
            }
         }
         delete items[param1];
      }
      
      override public function dispose() : void
      {
         Dispatcher.removeEventListener("SCENE_LOADED",onSceneLoaded);
         Dispatcher.removeEventListener("USER_ENTER_ROOM",onUserEnterRoom);
         Dispatcher.removeEventListener("USER_LEAVE_ROOM",onUserLeaveRoom);
         isDisposed = true;
      }
   }
}

