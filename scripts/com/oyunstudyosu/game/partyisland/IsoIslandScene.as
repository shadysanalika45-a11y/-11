package com.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.scene.components.ISceneCameraComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneProcessDataComponent;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCameraComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.SceneMouseInteractionComponent;
   import com.oyunstudyosu.engine.scene.components.SceneZoomComponent;
   import com.oyunstudyosu.game.partyisland.components.IIslandLeaderboardComponent;
   import com.oyunstudyosu.game.partyisland.components.IIslandPartyPlayerComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandLeaderboardComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandLobbyComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandPartyPlayerComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandProcessDataComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandSceneHudComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandServiceComponent;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class IsoIslandScene extends IsoScene
   {
      
      public function IsoIslandScene()
      {
         super();
      }
      
      override public function init() : void
      {
         trace("init()");
         cursor.visible = true;
         arrow.visible = false;
         container.removeChild(arrow);
         if(!Sanalika.instance.avatarModel.settings.muteSound)
         {
            SoundMixer.soundTransform = new SoundTransform(1);
         }
         speechBalloons = [];
         grid = new Vector.<Cell>();
         sceneElements = new Vector.<IsoElement>();
         mapEntries = new Vector.<MapEntry>();
         disposed = false;
         addComponent(IslandSceneHudComponent);
         addComponent(IslandLobbyComponent);
         addComponent(IslandLeaderboardComponent,IIslandLeaderboardComponent);
         addComponent(IslandPartyPlayerComponent,IIslandPartyPlayerComponent);
         addComponent(IslandServiceComponent);
         addComponent(SceneCameraComponent,ISceneCameraComponent);
         addComponent(SceneMouseInteractionComponent);
         addComponent(SceneZoomComponent);
         addComponent(SceneBotComponent);
         addComponent(SceneCharacterComponent,ISceneCharacterComponent);
         addComponent(IslandProcessDataComponent,ISceneProcessDataComponent);
         Sanalika.instance.stage.addEventListener("enterFrame",enterFrameOperations);
         Sanalika.instance.serviceModel.listenExtension("roomjoincomplete",onRoomJoinComplete);
      }
      
      override protected function onRoomJoinComplete(param1:Object) : void
      {
         super.onRoomJoinComplete(param1);
         var _loc2_:ISceneCharacterComponent = getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         if(_loc2_ != null && _loc2_.myChar != null)
         {
            mouseEnabled = _loc2_.myChar.isSpectator;
         }
      }
   }
}

