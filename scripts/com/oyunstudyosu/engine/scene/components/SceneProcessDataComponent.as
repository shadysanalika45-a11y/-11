package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.AssetRequestQueue;
   import com.oyunstudyosu.debug.DebugConsole;
   import com.oyunstudyosu.debug.ContractLogger;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.map.property.MapProperty;
   import com.oyunstudyosu.map.property.SoundProperty;
   import com.oyunstudyosu.map.property.YoutubeScreenProperty;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.User;
   import flash.display.MovieClip;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.BotPlaceHolder;
   
   public class SceneProcessDataComponent extends BaseSceneComponent implements ISceneProcessDataComponent
   {
      
      private static var MapPropertyClassList:Dictionary;
      
      private var mapPropertyList:Array;
      
      private var roomContext:LoaderContext;
      
      private var furnitureContextList:Vector.<LoaderContext>;
      
      private var assetRequestQueue:AssetRequestQueue;
      
      protected var requests:Array = [];
      
      public function SceneProcessDataComponent(param1:IScene)
      {
         super(param1);
         mapPropertyList = [];
         furnitureContextList = new Vector.<LoaderContext>();
         roomContext = Sanalika.instance.domainModel.generateContext("ModuleType.ROOM");
         if(MapPropertyClassList == null)
         {
            MapPropertyClassList = new Dictionary();
            MapPropertyClassList[17] = YoutubeScreenProperty;
            MapPropertyClassList[21] = SoundProperty;
         }
      }
      
      public function load() : void
      {
         var _loc7_:Array;
         var _loc5_:*;
         var _loc8_:int = 0;
         var _loc4_:MapEntry = null;
         var _loc3_:AssetRequest = null;
         var _loc2_:String = null;
         var _loc6_:String = null;
         var _loc1_:LoaderContext = null;
         trace("load()");
         try
         {
            DebugConsole.info("RENDER","SceneProcessDataComponent.load","roomKey=",Sanalika.instance.roomModel.key);
         }
         catch(e:Error)
         {
         }
         scene.map = Sanalika.instance.roomModel.getMap();
         try
         {
            DebugConsole.info("MAP","getMap","xOrigin=",scene.map.attributes["xOrigin"],"yOrigin=",scene.map.attributes["yOrigin"],"children=",scene.map.childNodes ? scene.map.childNodes.length : 0);
         }
         catch(e2:Error)
         {
         }
         try
         {
            ContractLogger.log("map_root",{
               "xOrigin":scene.map.attributes["xOrigin"],
               "yOrigin":scene.map.attributes["yOrigin"],
               "children":scene.map.childNodes ? scene.map.childNodes.length : 0
            });
         }
         catch(e2c:Error)
         {
         }
         scene.processMap(scene.map);
         scene.processGrid();
         try
         {
            DebugConsole.info("MAP","processed","entries=",scene.mapEntries.length,"grid=",scene.grid.length);
         }
         catch(e3:Error)
         {
         }
         try
         {
            ContractLogger.log("map_processed",{
               "entries":scene.mapEntries.length,
               "gridCells":scene.grid.length
            });
         }
         catch(e3c:Error)
         {
         }
         scene.gridManager.doFixedObjectOperations();
         _loc7_ = [];
         _loc8_ = 0;
         while(_loc8_ < scene.mapEntries.length)
         {
            _loc4_ = scene.mapEntries[_loc8_];
            if(_loc4_.id != "0" || _loc4_.ext)
            {
               trace("entry.identry.id",_loc4_.id);
               trace("entry.definitionentry.definition",_loc4_.definition);
               _loc7_.push(_loc4_);
            }
            _loc8_++;
         }
         for each(_loc5_ in _loc7_)
         {
            _loc2_ = _loc5_.definition;
            _loc6_ = "";
            if(_loc5_.version > 0)
            {
               _loc6_ = "." + _loc5_.version;
            }
            trace("packageList[i]",_loc2_);
            _loc3_ = new AssetRequest();
            _loc1_ = Sanalika.instance.domainModel.generateContext("ModuleType.FURNITURE");
            furnitureContextList.push(_loc1_);
            _loc3_.context = _loc1_;
            _loc3_.assetId = Sanalika.instance.moduleModel.getPath(_loc2_ + _loc6_,"ModuleType.FURNITURE");
            _loc3_.type = "ModuleType.FURNITURE";
            _loc3_.priority = 99;
            requests.push(_loc3_);
         }
         _loc3_ = new AssetRequest();
         _loc3_.context = roomContext;
         _loc3_.assetId = Sanalika.instance.moduleModel.getPath(Sanalika.instance.roomModel.key,"ModuleType.ROOM");
         _loc3_.type = "ModuleType.ROOM";
         _loc3_.priority = 100;
         requests.push(_loc3_);
         assetRequestQueue = new AssetRequestQueue(requests);
         try
         {
            DebugConsole.info("ASSETS","queue","requests=",requests.length);
         }
         catch(e4:Error)
         {
         }
         assetRequestQueue.progress = onProgress;
         assetRequestQueue.callback = onLoaded;
         Sanalika.instance.assetModel.requestQueue(assetRequestQueue);
      }
      
      protected function onProgress(param1:AssetRequestQueue) : void
      {
         var _loc2_:ProgressVo = ProgressVo.ROOM_FILES;
         _loc2_.percent = param1.percent;
         Dispatcher.dispatchEvent(new OSProgressEvent("LOADING_PROGRESS",_loc2_));
      }
      
      protected function onLoaded(param1:AssetRequestQueue) : void
      {
         var sceneBackgroundRequest:Array;
         var alertvo:AlertVo;
         var extensions:Array;
         var extMap:Dictionary;
         var extension:Object;
         var assetRequestQueue:AssetRequestQueue = param1;
         trace("onLoaded");
         try
         {
            DebugConsole.info("ASSETS","loaded","count=",assetRequestQueue.queue.length);
         }
         catch(e:Error)
         {
         }
         sceneBackgroundRequest = assetRequestQueue.queue.filter(function(param1:AssetRequest, param2:int, param3:Array):Boolean
         {
            return param1.type == "ModuleType.ROOM";
         });
         if(sceneBackgroundRequest[0].error)
         {
            sceneBackgroundRequest[0].dispose();
            Dispatcher.dispatchEvent(new GameEvent("PREVIOUS_ROOM"));
            alertvo = new AlertVo();
            alertvo.alertType = "Error";
            alertvo.description = "Something wrong with the room.";
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            return;
         }
         if(Sanalika.instance.roomModel.currentRoom.containsVariable("extensions"))
         {
            extensions = JSON.parse(Sanalika.instance.roomModel.currentRoom.getVariable("extensions").getStringValue()) as Array;
            if(extensions.length == 0)
            {
               processSceneData();
            }
            else
            {
               extMap = new Dictionary();
               for each(extension in extensions)
               {
                  trace("currentRoomloadExtension:" + extension.source);
                  extMap[extension.source] = Sanalika.instance.domainModel.subContext;
               }
               Dispatcher.addEventListener("EXTENSIONS_LOADED",onExtensionsLoaded);
               Sanalika.instance.extensionModel.loadExtensionList(extMap,1);
            }
         }
         else
         {
            processSceneData();
         }
      }
      
      private function onExtensionsLoaded(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("EXTENSIONS_LOADED",onExtensionsLoaded);
         processSceneData();
      }
      
      public function processSceneData() : void
      {
         var _loc8_:*;
         var _loc11_:SceneDoorComponent;
         var _loc13_:*;
         var _loc9_:*;
         var _loc5_:Vector.<MapEntry>;
         var _loc14_:SceneBotComponent;
         var _loc4_:*;
         var _loc6_:Room;
         var _loc12_:User;
         var _loc1_:SceneCharacterComponent;
         var _loc10_:Vector3d = null;
         var _loc15_:Character = null;
         var _loc7_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         try
         {
            DebugConsole.info("RENDER","processSceneData","entries=",scene.mapEntries.length);
         }
         catch(e0:Error)
         {
         }
         if(!Sanalika.instance.serviceModel.sfs.isConnected)
         {
            return;
         }
         _loc8_ = ProgressVo.ROOM_FILES;
         _loc8_.percent = 100;
         Dispatcher.dispatchEvent(new OSProgressEvent("LOADING_PROGRESS",_loc8_));
         _loc11_ = scene.getComponent(SceneDoorComponent) as SceneDoorComponent;
         if(_loc11_ != null)
         {
            _loc11_.processCeiling();
            _loc11_.processDoors();
         }
         scene.processBackground();
         try
         {
            DebugConsole.info("RENDER","background","bg=",scene.bg ? scene.bg.name : "null");
         }
         catch(e1:Error)
         {
         }
         _loc13_ = [];
         for each(_loc9_ in scene.mapEntries)
         {
            if(processEntry(_loc9_))
            {
               _loc13_.push(_loc9_);
            }
         }
         try
         {
            DebugConsole.info("RENDER","entriesProcessed","kept=",_loc13_.length);
         }
         catch(e2:Error)
         {
         }
         _loc5_ = Vector.<MapEntry>(_loc13_);
         scene.mapEntries = _loc5_;
         _loc14_ = scene.getComponent(SceneBotComponent) as SceneBotComponent;
         if(_loc14_ != null)
         {
            _loc14_.processBotsForEntry();
         }
         for each(_loc4_ in scene.sceneElements)
         {
            _loc10_ = scene.getScenePositionFromTile(_loc4_.currentTile.x,_loc4_.currentTile.y);
            _loc4_.moveTo(_loc10_.x,_loc10_.y,_loc10_.z);
         }
         scene.gridManager.doFixedObjectOperations();
         _loc6_ = Sanalika.instance.roomModel.currentRoom;
         _loc12_ = Sanalika.instance.serviceModel.sfs.mySelf;
         _loc1_ = scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc1_ != null && !Sanalika.instance.roomModel.disableAddChar)
         {
            _loc15_ = new Character();
            _loc15_.isSpectator = _loc6_.spectatorList.indexOf(_loc12_) != -1;
            _loc15_.isMe = true;
            _loc15_.setRoles(_loc12_.getVariable("roles").getStringValue());
            _loc15_.init(Sanalika.instance.avatarModel.avatarId,scene,0,Sanalika.instance.avatarModel.gender,Sanalika.instance.avatarModel.clothesOn);
            _loc15_.id = Sanalika.instance.avatarModel.avatarId;
            _loc15_.speed = _loc12_.getVariable("speed").getDoubleValue();
            _loc15_.avatarName = Sanalika.instance.avatarModel.avatarName;
            _loc15_.avatarSize = Sanalika.instance.avatarModel.avatarSize;
            if(_loc12_.containsVariable("smiley"))
            {
               _loc15_.setSmiley(_loc12_.getVariable("smiley").getStringValue());
            }
            if(_loc12_.containsVariable("hand"))
            {
               _loc15_.useHandItem(_loc12_.getVariable("hand").getStringValue());
            }
            if(_loc12_.containsVariable("avatarSize"))
            {
               _loc15_.avatarSize = _loc12_.getVariable("avatarSize").getDoubleValue();
            }
            _loc7_ = Sanalika.instance.avatarModel.position.split(",");
            _loc3_ = int(parseInt(_loc7_[0]));
            _loc2_ = int(parseInt(_loc7_[1]));
            if(!_loc15_.isSpectator)
            {
               _loc15_.reLocate(_loc3_,_loc2_,Sanalika.instance.avatarModel.direction);
            }
            _loc1_.addChar(_loc15_);
            _loc1_.myChar = _loc15_;
         }
         Dispatcher.dispatchEvent(new GameEvent("SCENE_READY"));
         try
         {
            DebugConsole.info("RENDER","SCENE_READY");
         }
         catch(e3:Error)
         {
         }
         Sanalika.instance.serviceModel.requestData("roomjoincomplete",{},null);
         assetRequestQueue.dispose();
         assetRequestQueue = null;
      }
      
      public function processEntry(param1:MapEntry) : Boolean
      {
         var _loc7_:MapProperty = null;
         var _loc6_:* = undefined;
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         var _loc5_:* = 0;
         if(MapPropertyClassList[param1.entryType] != null)
         {
            try
            {
               DebugConsole.info("RENDER","propertyEntry","type=",param1.entryType,"id=",param1.id);
            }
            catch(eP:Error)
            {
            }
            _loc7_ = new (MapPropertyClassList[param1.entryType] as Class)();
            _loc7_.entry = param1;
            _loc7_.data = param1.getEntryData();
            _loc7_.execute();
            mapPropertyList.push(_loc7_);
            return false;
         }
         if(param1.check4Errors())
         {
            try
            {
               DebugConsole.warn("RENDER","badEntry","type=",param1.entryType,"id=",param1.id,"def=",param1.definition);
            }
            catch(eB:Error)
            {
            }
            trace("MapEntry is BAD:node[" + param1 + "]");
            return false;
         }
         if(param1.definition != null)
         {
            if(param1.entryType == 4)
            {
               _loc6_ = new GamePool();
               GamePool(_loc6_).setValues(param1.x,param1.z,param1.y,param1.width,param1.height,param1.gameType);
               _loc6_.name = param1.gameZoneId;
               if(param1.maskDefinition != null)
               {
                  _loc4_ = scene.getMovieClip(param1.maskDefinition);
                  _loc3_ = scene.getPosFromGrid(param1.x,param1.z);
                  _loc4_.x = _loc3_.x;
                  _loc4_.y = _loc3_.y;
                  scene.elementsContainer.addChild(_loc4_);
                  _loc6_.mask = _loc4_;
               }
            }
            else
            {
               _loc6_ = scene.getMovieClip(param1.definition);
            }
            if(_loc6_ == null)
            {
               try
               {
                  DebugConsole.warn("RENDER","missingClip","def=",param1.definition,"type=",param1.entryType);
               }
               catch(eM:Error)
               {
               }
               try
               {
                  ContractLogger.log("map_entry_clip_missing",{
                     "def":param1.definition,
                     "entryType":param1.entryType,
                     "id":param1.id
                  });
               }
               catch(eM2:Error)
               {
               }
               return false;
            }
            param1.clip = _loc6_;
            if(param1.entryType == 8)
            {
               scene.floorContainer.addChild(_loc6_);
            }
            else
            {
               scene.elementsContainer.addChild(_loc6_);
            }
            try
            {
               DebugConsole.info("RENDER","addClip","def=",param1.definition,"type=",param1.entryType,"to=",param1.entryType == 8 ? "floor" : "elements");
            }
            catch(eA:Error)
            {
            }
            try
            {
               ContractLogger.log("map_entry_clip",{
                  "def":param1.definition,
                  "entryType":param1.entryType,
                  "id":param1.id,
                  "container":param1.entryType == 8 ? "floor" : "elements"
               });
            }
            catch(eA2:Error)
            {
            }
            _loc2_ = new IsoElement();
            _loc2_.create(null,_loc6_,scene);
            _loc2_.id = param1.definition;
            _loc2_.currentTile = new IntPoint(param1.x,param1.z);
            scene.sceneElements.push(_loc2_);
            param1.element = _loc2_;
         }
         param1.init(scene);
         if(param1.interactive)
         {
            Sanalika.instance.entryModel.loadJSON(param1.property,param1.getEntryData());
         }
         _loc5_ = 0;
         while(_loc5_ < param1.clip.currentLabels.length)
         {
            if(param1.clip.currentLabels[_loc5_].name == Sanalika.instance.gameModel.language)
            {
               param1.clip.gotoAndStop(Sanalika.instance.gameModel.language);
            }
            _loc5_++;
         }
         try
         {
            if(param1.clip.snow)
            {
               param1.clip.snow.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("snow") > -1)
               {
                  param1.clip.snow.visible = true;
               }
            }
            if(param1.clip.christmas)
            {
               param1.clip.christmas.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("christmas") > -1)
               {
                  param1.clip.christmas.visible = true;
               }
            }
            if(param1.clip.fest)
            {
               param1.clip.fest.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("fest") > -1)
               {
                  param1.clip.fest.visible = true;
               }
            }
            if(param1.clip.ramadan)
            {
               param1.clip.fest.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("ramadan") > -1)
               {
                  param1.clip.fest.visible = true;
               }
            }
            if(param1.clip.halloween)
            {
               param1.clip.halloween.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("halloween") > -1)
               {
                  param1.clip.halloween.visible = true;
               }
            }
            if(param1.clip.snowMain)
            {
               param1.clip.snowMain.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("snow") > -1)
               {
                  param1.clip.snowMain.visible = true;
                  if(param1.clip.snow)
                  {
                     param1.clip.snow.visible = false;
                  }
                  if(param1.clip.christmas)
                  {
                     param1.clip.christmas.visible = false;
                  }
                  if(param1.clip.halloween)
                  {
                     param1.clip.halloween.visible = false;
                  }
                  if(param1.clip.hide)
                  {
                     param1.clip.hide.visible = false;
                  }
               }
            }
            if(param1.clip.christmasMain)
            {
               param1.clip.christmasMain.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("christmas") > -1)
               {
                  param1.clip.christmasMain.visible = true;
                  if(param1.clip.snow)
                  {
                     param1.clip.snow.visible = false;
                  }
                  if(param1.clip.christmas)
                  {
                     param1.clip.christmas.visible = false;
                  }
                  if(param1.clip.halloween)
                  {
                     param1.clip.halloween.visible = false;
                  }
                  if(param1.clip.hide)
                  {
                     param1.clip.hide.visible = false;
                  }
               }
            }
            if(param1.clip.halloweenMain)
            {
               param1.clip.halloweenMain.visible = false;
               if(Sanalika.instance.gameModel.roomTheme.indexOf("halloween") > -1)
               {
                  param1.clip.halloweenMain.visible = true;
                  if(param1.clip.snow)
                  {
                     param1.clip.snow.visible = false;
                  }
                  if(param1.clip.christmas)
                  {
                     param1.clip.christmas.visible = false;
                  }
                  if(param1.clip.halloween)
                  {
                     param1.clip.halloween.visible = false;
                  }
                  if(param1.clip.hide)
                  {
                     param1.clip.hide.visible = false;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
         return true;
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var _loc6_:Class = null;
         var _loc7_:* = null;
         var _loc3_:* = null;
         for each(var _loc4_ in furnitureContextList)
         {
            if(_loc4_ && _loc4_.applicationDomain)
            {
               _loc6_ = DefinitionUtils.getClass(_loc4_.applicationDomain,param1,Sanalika.instance.gameModel.weather);
               if(_loc6_)
               {
                  return new _loc6_();
               }
            }
         }
         var _loc2_:Class = DefinitionUtils.getClass(roomContext.applicationDomain,param1,Sanalika.instance.gameModel.weather);
         if(_loc2_)
         {
            return new _loc2_();
         }
         var _loc5_:MovieClip = new MovieClip();
         _loc5_.addChild(new BotPlaceHolder());
         return _loc5_;
      }
      
      override public function dispose() : void
      {
         var _loc3_:* = undefined;
         var _loc2_:MapProperty = null;
         Dispatcher.removeEventListener("EXTENSIONS_LOADED",onExtensionsLoaded);
         _loc3_ = 0;
         while(_loc3_ < mapPropertyList.length)
         {
            _loc2_ = mapPropertyList[_loc3_];
            _loc2_.dispose();
            _loc3_++;
         }
         if(assetRequestQueue != null)
         {
            assetRequestQueue.dispose();
         }
         for each(var _loc1_ in furnitureContextList)
         {
            _loc1_.applicationDomain = null;
         }
         furnitureContextList = new Vector.<LoaderContext>();
         if(roomContext != null)
         {
            roomContext.applicationDomain = null;
         }
         roomContext = null;
         isDisposed = true;
      }
   }
}

