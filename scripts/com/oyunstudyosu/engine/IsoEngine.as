package com.oyunstudyosu.engine
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.door.DoorIconModel;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.pool.manager.GamePoolManager;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.game.partyisland.IsoIslandScene;
   import com.oyunstudyosu.progress.ProgressVo;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   import flash.utils.getDefinitionByName;
   
   public class IsoEngine extends EventDispatcher implements IEngine
   {
      
      private var gamePoolManager:GamePoolManager;
      
      private var doorIconModel:DoorIconModel;
      
      private var _scene:IScene;
      
      public function IsoEngine()
      {
         super();
         Dispatcher.addEventListener("TERMINATE_GAME",onGameTerminated);
         Sanalika.instance.discordModel.init();
         Sanalika.instance.discordModel.setLargeImage("sanalika","Sanalika");
         IsoScene;
         IsoIslandScene;
      }
      
      public function get scene() : IScene
      {
         return _scene;
      }
      
      public function set scene(param1:IScene) : void
      {
         if(_scene == param1)
         {
            return;
         }
         if(scene != null)
         {
            Sanalika.instance.layerModel.gameLayer.removeChild(scene.container);
         }
         if(param1 != null)
         {
            Sanalika.instance.layerModel.gameLayer.addChildAt(param1.container,0);
         }
         _scene = param1;
      }
      
      public function get sceneInitialized() : Boolean
      {
         return scene != null && scene.initialized;
      }
      
      public function get sceneLoaded() : Boolean
      {
         return scene != null && scene.sceneLoaded;
      }
      
      private function onGameTerminated(param1:GameEvent) : void
      {
         terminate();
      }
      
      public function start() : void
      {
         gamePoolManager = new GamePoolManager();
      }
      
      public function changeScene() : void
      {
         var _loc1_:Class = null;
         if(scene != null)
         {
            scene.dispose();
         }
         if(Sanalika.instance.roomModel.currentRoom.containsVariable("scene"))
         {
            _loc1_ = getDefinitionByName(Sanalika.instance.roomModel.currentRoom.getVariable("scene").getStringValue()) as Class;
            if(_loc1_ == null)
            {
               scene = new IsoScene();
            }
            else
            {
               scene = new _loc1_();
            }
         }
         else
         {
            scene = new IsoScene();
         }
         scene.init();
         Dispatcher.addEventListener("SCENE_DATA_LOADED",sceneDataLoaded);
         scene.load();
      }
      
      public function sceneDataLoaded(param1:GameEvent) : void
      {
         doorIconModel = new DoorIconModel(scene);
         doorIconModel.init();
         trace("GameEvent.SCENE_LOADED");
         Dispatcher.dispatchEvent(new GameEvent("SCENE_LOADED"));
      }
      
      public function showScene() : void
      {
         scene.enable();
         Dispatcher.dispatchEvent(new GameEvent("TRANSITION_IN"));
      }
      
      public function loadIsoDesigner() : void
      {
         resetPartly();
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.LOAD_DESIGNER));
         var _loc1_:IAssetRequest = new AssetRequest();
         _loc1_.assetId = Sanalika.instance.moduleModel.getPath("RoomDesigner","ModuleType.EXTENSION");
         _loc1_.context = Sanalika.instance.domainModel.subContext;
         _loc1_.type = "ModuleType.EXTENSION";
         _loc1_.loadedFunction = onDesignerLoaded;
         Sanalika.instance.assetModel.request(_loc1_);
         trace("room_designer");
      }
      
      private function onDesignerLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:MovieClip = param1.display as MovieClip;
         _loc2_.scaleX = Sanalika.instance.scaleModel.currentScale;
         _loc2_.scaleY = Sanalika.instance.scaleModel.currentScale;
         Sanalika.instance.layerModel.gameLayer.addChild(_loc2_);
         Sanalika.instance.layerModel.stage.focus = _loc2_;
         _loc2_.design();
         param1.dispose();
      }
      
      public function resetPartly() : void
      {
         var _loc2_:GamePool = null;
         Dispatcher.dispatchEvent(new GameEvent("TRANSITION_OUT"));
         if(scene == null)
         {
            return;
         }
         var _loc1_:SceneCharacterComponent = scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc1_ != null && _loc1_.myChar != null)
         {
            _loc2_ = scene.elementsContainer.getChildByName(_loc1_.myChar.gameZoneId) as GamePool;
            if(_loc2_ != null)
            {
               gamePoolManager.killAll(_loc2_);
               _loc1_.myChar.gameZoneId = "";
            }
         }
         if(doorIconModel != null)
         {
            doorIconModel.dispose();
            doorIconModel = null;
         }
         scene.dispose();
         scene = null;
      }
      
      public function reset() : void
      {
         resetPartly();
         Sanalika.instance.roomModel.doorModel.dispose();
         Sanalika.instance.roomModel.botModel.dispose();
         Sanalika.instance.mobileModel.reset();
      }
      
      public function reload() : void
      {
         trace("Sanalika.reload");
         if(ExternalInterface.available)
         {
            ExternalInterface.call("Sanalika.reload");
         }
      }
      
      public function terminate() : void
      {
         reset();
      }
   }
}

