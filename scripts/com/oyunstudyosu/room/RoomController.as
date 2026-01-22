package com.oyunstudyosu.room
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.debug.DebugConsole;
   import com.oyunstudyosu.engine.IEngine;
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.FarmEvent;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.sanalika.interfaces.IRoomModel;
   import com.oyunstudyosu.utils.Tracker;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.SFSRoom;
   import com.smartfoxserver.v2.entities.SFSUser;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.entities.variables.UserVariable;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.Coin;
   import org.oyunstudyosu.assets.clips.DiamondR;
   
   public class RoomController
   {
      
      private var sfs:SmartFox;
      
      private var engine:IEngine;
      
      private var currentRoom:SFSRoom;
      
      private var roomModel:IRoomModel;
      
      private var userQueue:Dictionary;
      
      public function RoomController(param1:SmartFox)
      {
         super();
         this.sfs = param1;
         this.engine = Sanalika.instance.engine;
         this.roomModel = Sanalika.instance.roomModel;
         this.sfs.addEventListener("roomJoin",onJoinRoom);
         this.sfs.addEventListener("roomJoinError",onJoinRoomError);
         this.sfs.addEventListener("userEnterRoom",onUserEnterRoom);
         this.sfs.addEventListener("userExitRoom",onUserExitRoom);
         Dispatcher.addEventListener("SCENE_READY",onSceneReady);
         Dispatcher.addEventListener("SCENE_LOADED",onSceneLoaded);
         Dispatcher.addEventListener("PREVIOUS_ROOM",onPreviousRoom);
         Sanalika.instance.serviceModel.listenExtension("roomDesignUpdated",onRoomDesignUpdate);
         Sanalika.instance.serviceModel.listenExtension("joinError",onJoinError);
         Sanalika.instance.serviceModel.listenRoomVariable("doors",doorVariableUpdate);
         Sanalika.instance.serviceModel.listenRoomVariable("bots",botVariableUpdate);
         Sanalika.instance.serviceModel.listenExtension("masterRoomUpdated",onMasterRoomUpdated);
         Sanalika.instance.serviceModel.listenExtension("objectframechanged",onFrameChanged);
         Sanalika.instance.serviceModel.listenExtension("objectstatechanged",onObjectStateChanged);
         Sanalika.instance.serviceModel.listenExtension("objectlockchanged",onObjectLockChanged);
         Sanalika.instance.serviceModel.listenExtension("objectstockchanged",onObjectStockChanged);
         Sanalika.instance.serviceModel.listenExtension("objectremoved",onObjectRemoved);
         Sanalika.instance.serviceModel.listenExtension("farmstatuschanged",onFarmStatusChanged);
         Sanalika.instance.serviceModel.listenExtension("usedoor",onUseDoor);
         Sanalika.instance.serviceModel.listenExtension("recommendeduniverse",onRecommendedUniverse);
         Sanalika.instance.serviceModel.listenExtension("removeRoomClient",onRemoveRoomClient);
      }
      
      private function update(param1:Event) : void
      {
         if(Sanalika.instance.engine.sceneInitialized && Sanalika.instance.engine.scene.sceneLoaded)
         {
            for(var _loc2_ in userQueue)
            {
               addChar(_loc2_,userQueue[_loc2_]);
            }
            userQueue = new Dictionary();
         }
      }
      
      private function onUseDoor(param1:Object) : void
      {
         try
         {
            DebugConsole.info("ROOM","onUseDoor","errorCode=",param1.errorCode);
         }
         catch(e:Error)
         {
         }
         if(param1.errorCode != undefined)
         {
            Sanalika.instance.roomModel.doorModel.busy = false;
            if(param1.errorCode != "FLOOD" && param1.errorCode != "EXTENSION_IDLE")
            {
            }
            return;
         }
         Sanalika.instance.roomModel.buildingData = null;
         Sanalika.instance.roomModel.checkMap(param1);
      }
      
      private function onRecommendedUniverse(param1:Object) : void
      {
         var data:Object = param1;
         var vo:AlertVo = new AlertVo();
         vo.alertType = "tooltip";
         vo.description = Sanalika.instance.localizationModel.translate("A fuller universe is available.");
         vo.callBack = function():*
         {
            Dispatcher.dispatchEvent(new HudEvent("openIslandsPanel"));
         };
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      public function onFrameChanged(param1:Object) : void
      {
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:IEntryVo = Sanalika.instance.entryModel.getObjectById(param1.id);
         _loc5_.gotoFrame(param1.frame);
         if(_loc5_.property.data.cn == "GridSealingProperty")
         {
            if(int(param1.frame) == 1)
            {
               _loc4_ = false;
            }
            else
            {
               _loc4_ = true;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc5_.depth)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc5_.width)
               {
                  Sanalika.instance.engine.scene.setCellStatus(_loc5_.x + _loc2_,_loc5_.z + _loc3_,_loc4_);
                  trace("disableCellCount--");
                  trace("Cell: w" + _loc2_ + "x+w:" + (_loc5_.x + _loc2_) + " " + (_loc5_.z + _loc3_) + " " + _loc4_);
                  _loc2_++;
               }
               _loc3_++;
            }
         }
      }
      
      private function botVariableUpdate(param1:Room) : void
      {
         if(currentRoom == param1 && param1.containsVariable("bots"))
         {
            engine.reset();
            Sanalika.instance.roomModel.reloadScene();
         }
      }
      
      private function doorVariableUpdate(param1:Room) : void
      {
         if(currentRoom == param1 && param1.containsVariable("doors"))
         {
            Sanalika.instance.roomModel.doorModel.dispose();
            Sanalika.instance.roomModel.doorModel.loadJSON(param1.getVariable("doors").getStringValue());
         }
      }
      
      protected function onPreviousRoom(param1:GameEvent) : void
      {
         roomModel.doorModel.useDoorByKey(roomModel.enterDoorKey);
      }
      
      public function onMasterRoomUpdated(param1:Object) : void
      {
         if(param1.errorCode != undefined)
         {
            try
            {
               DebugConsole.warn("ROOM","onMasterRoomUpdated","errorCode=",param1.errorCode);
            }
            catch(e1:Error)
            {
            }
            return;
         }
         try
         {
            DebugConsole.info("ROOM","onMasterRoomUpdated","ok");
         }
         catch(e2:Error)
         {
         }
         roomModel.checkMap(param1);
      }
      
      public function onObjectStockChanged(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         trace("onObjectStockChanged",param1.id);
         Sanalika.instance.entryModel.getObjectById(param1.id).sv = param1.stock;
         try
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $("GatheringStockChanged");
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
            Sanalika.instance.entryModel.getObjectById(param1.id).setIndicator();
         }
         catch(error:Error)
         {
            trace("indicator Error");
         }
      }
      
      public function onFarmStatusChanged(param1:Object) : void
      {
         trace("onFarmStatusChanged",param1.id);
         var _loc2_:IEntryVo = Sanalika.instance.entryModel.getObjectById(param1.id);
         _loc2_.property.dispose();
         _loc2_.setProperty(param1.property);
         if(param1.status == "CLEANED" || param1.status == "HARVESTED")
         {
            _loc2_.gotoFrame(1);
            if(param1.status == "HARVESTED")
            {
               Dispatcher.dispatchEvent(new FarmEvent("FarmEvent.HARVEST"));
            }
         }
         else
         {
            _loc2_.gotoFrameLabel(param1.property.item.clip + "" + param1.property.status.state);
         }
         var _loc3_:AlertVo = new AlertVo();
         _loc3_.alertType = "tooltip";
         _loc3_.description = $("farm" + param1.status);
         Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
      }
      
      public function onObjectRemoved(param1:Object) : void
      {
         var _loc4_:IEntryVo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         trace("onObjectRemoved",param1.id);
         try
         {
            _loc4_ = Sanalika.instance.entryModel.getObjectById(param1.id);
            _loc3_ = 0;
            while(_loc3_ < _loc4_.depth)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc4_.width)
               {
                  Sanalika.instance.engine.scene.setCellStatus(_loc4_.x + _loc2_,_loc4_.z + _loc3_,true);
                  _loc2_++;
               }
               _loc3_++;
            }
            Sanalika.instance.entryModel.removeObjectById(param1.id);
            _loc4_.clip.visible = false;
            _loc4_.dispose();
         }
         catch(error:Error)
         {
            trace("error Object Remove");
         }
      }
      
      public function onObjectLockChanged(param1:Object) : void
      {
         Sanalika.instance.entryModel.getObjectById(param1.id).lc = param1.locked;
         trace("onObjectLockChanged");
         try
         {
            Sanalika.instance.entryModel.getObjectById(param1.id).lockState();
         }
         catch(error:Error)
         {
            trace("sorun1");
         }
      }
      
      public function onObjectStateChanged(param1:Object) : void
      {
         var _loc3_:DiamondR = null;
         var _loc2_:Coin = null;
         Sanalika.instance.entryModel.getObjectById(param1.id).s = param1.state;
         trace("onObjectStateChanged");
         if(param1.state == 0)
         {
            try
            {
               Sanalika.instance.entryModel.getObjectById(param1.id).clip.removeChild(Sanalika.instance.entryModel.getObjectById(param1.id).clip.getChildByName("coin"));
            }
            catch(error:Error)
            {
               trace("sorun1");
            }
         }
         else if(param1.state == 2)
         {
            try
            {
               _loc3_ = new DiamondR();
               _loc3_.y = -60;
               _loc3_.x = 0;
               _loc3_.name = "coin";
               _loc3_.buttonMode = true;
               Sanalika.instance.entryModel.getObjectById(param1.id).clip.addChild(_loc3_);
            }
            catch(error:Error)
            {
               trace("sorun3");
            }
         }
         else
         {
            try
            {
               _loc2_ = new Coin();
               _loc2_.y = -80;
               _loc2_.x = 0;
               _loc2_.name = "coin";
               _loc2_.buttonMode = true;
               Sanalika.instance.entryModel.getObjectById(param1.id).clip.addChild(_loc2_);
            }
            catch(error:Error)
            {
               trace("sorun2");
            }
         }
      }
      
      public function onRoomDesignUpdate(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         if(param1.errorCode)
         {
            try
            {
               DebugConsole.warn("ROOM","onRoomDesignUpdate","errorCode=",param1.errorCode);
            }
            catch(e3:Error)
            {
            }
            _loc2_ = new AlertVo();
            _loc2_.alertType = "Error";
            _loc2_.description = param1.errorMessage;
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         else if(Sanalika.instance.roomModel.isUserRoom)
         {
            try
            {
               DebugConsole.info("ROOM","onRoomDesignUpdate","reload");
            }
            catch(e4:Error)
            {
            }
            roomModel.checkMap(param1);
            startload();
         }
      }
      
      public function startload(param1:GameEvent = null) : void
      {
         var _loc7_:Object;
         var _loc6_:String;
         var _loc5_:String;
         var _loc4_:*;
         var _loc3_:UserVariable;
         var _loc2_:Array;
         try
         {
            DebugConsole.info("ROOM","startload","room=",currentRoom ? currentRoom.name : "null");
         }
         catch(e5:Error)
         {
         }
         _loc7_ = null;
         _loc6_ = null;
         _loc5_ = null;
         engine.reset();
         trace("startload");
         engine.reset();
         _loc4_ = ProgressVo.ROOM_FILES;
         _loc4_.percent = 0;
         Dispatcher.dispatchEvent(new OSProgressEvent("LOADING_PROGRESS",_loc4_));
         Sanalika.instance.roomModel.mapInitalized = false;
         Dispatcher.removeEventListener("ROOM_MAP_INITIALIZED",startload);
         Sanalika.instance.roomModel.key = currentRoom.getVariable("roomKey").getStringValue();
         Tracker.roomKey = Sanalika.instance.roomModel.key;
         Sanalika.instance.roomModel.title = currentRoom.name;
         Sanalika.instance.roomModel.groupId = currentRoom.groupId;
         Sanalika.instance.roomModel.width = currentRoom.getVariable("width").getIntValue();
         Sanalika.instance.roomModel.height = currentRoom.getVariable("height").getIntValue();
         if(currentRoom.containsVariable("source"))
         {
            Sanalika.instance.roomModel.source = currentRoom.getVariable("source").getStringValue();
         }
         if(currentRoom.containsVariable("bots"))
         {
            Sanalika.instance.roomModel.botModel.loadJSON(currentRoom.getVariable("bots").getStringValue());
            trace("bots: " + currentRoom.getVariable("bots").getStringValue());
         }
         if(currentRoom.containsVariable("doors"))
         {
            Sanalika.instance.roomModel.doorModel.loadJSON(currentRoom.getVariable("doors").getStringValue());
         }
         if(currentRoom.containsVariable("ownerID") && !currentRoom.containsVariable("isInteractiveRoom"))
         {
            Sanalika.instance.roomModel.ownerId = currentRoom.getVariable("ownerID").getStringValue();
         }
         else
         {
            Sanalika.instance.roomModel.ownerId = null;
         }
         if(currentRoom.containsVariable("ownerName"))
         {
            Sanalika.instance.roomModel.ownerName = currentRoom.getVariable("ownerName").getStringValue();
         }
         else
         {
            Sanalika.instance.roomModel.ownerName = null;
         }
         if(currentRoom.containsVariable("roomTitle"))
         {
            Sanalika.instance.roomModel.title = currentRoom.getVariable("roomTitle").getStringValue();
         }
         if(currentRoom.containsVariable("flatID"))
         {
            Sanalika.instance.roomModel.houseID = currentRoom.getVariable("flatID").getStringValue();
         }
         else
         {
            Sanalika.instance.roomModel.houseID = null;
         }
         if(currentRoom.containsVariable("roomID"))
         {
            Sanalika.instance.roomModel.roomID = currentRoom.getVariable("roomID").getIntValue().toString();
            _loc7_ = {};
            _loc7_.roomID = Sanalika.instance.roomModel.roomID;
            _loc7_.type = Sanalika.instance.roomModel.type;
            Sanalika.instance.discordModel.setSecrets(JSON.stringify(_loc7_));
            Sanalika.instance.discordModel.setDetails("");
            Sanalika.instance.discordModel.setState(Sanalika.instance.roomModel.title);
         }
         else
         {
            Sanalika.instance.roomModel.roomID = "";
            try
            {
               _loc6_ = Sanalika.instance.roomModel.title.split("#")[0];
               _loc5_ = Sanalika.instance.roomModel.title.split("#")[1];
               Sanalika.instance.discordModel.setDetails(Sanalika.instance.localizationModel.translate("universe_" + _loc6_));
               Sanalika.instance.discordModel.setState(Sanalika.instance.localizationModel.translate("room_" + _loc5_));
               Sanalika.instance.discordModel.setSecrets("");
            }
            catch(e:Error)
            {
            }
         }
         if(currentRoom.containsVariable("grid"))
         {
            Sanalika.instance.roomModel.gridModel.load(currentRoom.getVariable("grid").getStringValue());
         }
         Sanalika.instance.discordModel.setParty(currentRoom.id.toString(),currentRoom.userCount,currentRoom.capacity);
         _loc3_ = sfs.mySelf.getVariable("clothes");
         Sanalika.instance.avatarModel.gender = sfs.mySelf.getVariable("gender").getStringValue();
         _loc2_ = JSON.parse(_loc3_.getStringValue()) as Array;
         Sanalika.instance.avatarModel.clothesOn = _loc2_;
         Sanalika.instance.avatarModel.position = sfs.mySelf.getVariable("position").getStringValue();
         Sanalika.instance.avatarModel.direction = sfs.mySelf.getVariable("direction").getIntValue();
         engine.changeScene();
      }
      
      private function onExtensionsLoaded(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("EXTENSIONS_LOADED",onExtensionsLoaded);
      }
      
      private function onJoinRoom(param1:SFSEvent) : void
      {
         var _loc2_:SFSRoom = param1.params.room;
         try
         {
            DebugConsole.info("ROOM","onJoinRoom","room=",_loc2_ ? _loc2_.name : "null");
         }
         catch(e6:Error)
         {
         }
         if(_loc2_.containsVariable("isInteractiveRoom") && !_loc2_.getVariable("isInteractiveRoom").getBoolValue())
         {
            return;
         }
         userQueue = new Dictionary();
         currentRoom = param1.params.room;
         Tracker.track("room","join",Sanalika.instance.roomModel.key);
         Sanalika.instance.roomModel.currentRoom = currentRoom;
         if(Sanalika.instance.roomModel.mapInitialized)
         {
            try
            {
               DebugConsole.info("ROOM","mapInitialized=true -> startload");
            }
            catch(e7:Error)
            {
            }
            startload();
         }
         else
         {
            try
            {
               DebugConsole.info("ROOM","mapInitialized=false -> wait ROOM_MAP_INITIALIZED");
            }
            catch(e8:Error)
            {
            }
            Dispatcher.addEventListener("ROOM_MAP_INITIALIZED",startload);
         }
      }
      
      private function onSceneReady(param1:GameEvent) : void
      {
      }
      
      protected function onSceneLoaded(param1:GameEvent) : void
      {
         var _loc3_:String = Sanalika.instance.avatarModel.avatarId;
         for each(var _loc2_ in currentRoom.userList)
         {
            if(_loc3_ != _loc2_.name)
            {
               addCharIntoQueue(_loc2_,true);
            }
         }
         engine.showScene();
      }
      
      private function onJoinRoomError(param1:SFSEvent) : void
      {
         trace("onJoinRoomError");
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "Error";
         _loc2_.description = param1.params.errorMessage;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function onJoinError(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "Error";
         _loc2_.description = param1.errorMessage;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function onUserEnterRoom(param1:SFSEvent) : void
      {
         if(engine.scene == null || !engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc2_:SFSUser = param1.params.user;
         var _loc3_:Room = param1.params.room;
         if(_loc3_.containsVariable("isInteractiveRoom") && !_loc3_.getVariable("isInteractiveRoom").getBoolValue())
         {
            return;
         }
         if(_loc2_.isItMe)
         {
            return;
         }
         addCharIntoQueue(_loc2_,false);
         Sanalika.instance.discordModel.setParty(currentRoom.id.toString(),currentRoom.userCount,currentRoom.capacity);
      }
      
      private function onUserExitRoom(param1:SFSEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:GamePool = null;
         var _loc3_:SceneCharacterComponent = null;
         var _loc7_:Room = param1.params.room;
         var _loc6_:User = param1.params.user;
         if(_loc7_.containsVariable("isInteractiveRoom") && !_loc7_.getVariable("isInteractiveRoom").getBoolValue())
         {
            return;
         }
         delete userQueue[_loc6_];
         if(!Sanalika.instance.engine.sceneInitialized || !Sanalika.instance.engine.sceneLoaded)
         {
            return;
         }
         if(_loc6_.getVariable("poolVars"))
         {
            _loc2_ = _loc6_.getVariable("poolVars").getStringValue();
            _loc5_ = Sanalika.instance.engine.scene.elementsContainer.getChildByName(_loc2_.split(",")[0]) as GamePool;
            if(_loc5_)
            {
               _loc5_.removeItem(_loc6_.name);
            }
         }
         if(engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc3_ = engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc3_.removeWithAvatarId(_loc6_.name);
         }
         var _loc4_:GameEvent = new GameEvent("USER_LEAVE_ROOM");
         _loc4_.id = _loc6_.name;
         Dispatcher.dispatchEvent(_loc4_);
         Sanalika.instance.discordModel.setParty(currentRoom.id.toString(),currentRoom.userCount,currentRoom.capacity);
      }
      
      private function addCharIntoQueue(param1:User, param2:Boolean = false) : void
      {
         userQueue[param1] = param2;
         update(null);
      }
      
      private function addChar(param1:SFSUser, param2:Boolean = false) : Boolean
      {
         var _loc21_:Boolean;
         var _loc3_:SceneCharacterComponent = null;
         var _loc8_:UserVariable = null;
         var _loc5_:Array = null;
         var _loc12_:String = null;
         var _loc6_:Character = null;
         var _loc9_:int = 0;
         var _loc11_:Array = null;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc13_:Array = null;
         var _loc10_:GameEvent = null;
         if(Sanalika.instance.avatarModel.isTutorialMode || param1.privilegeId == 0)
         {
            return false;
         }
         if(!engine.scene.existsComponent(SceneCharacterComponent))
         {
            return false;
         }
         try
         {
            if(param1 == null && param1.getVariable("avatarName") != null)
            {
               return false;
            }
            _loc3_ = engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            if(_loc3_.existsWithAvatarId(param1.name))
            {
               return false;
            }
            if(!param1.containsVariable("position"))
            {
               trace("addChar() : name[" + param1.name + "] : COORDINATE VARIABLE[p] NOT FOUND !");
               return false;
            }
            if(!param1.containsVariable("gender"))
            {
               trace("addChar() : name[" + param1.name + "] : GENDER VARIABLE[gender] NOT FOUND !");
               return false;
            }
            _loc8_ = param1.getVariable("clothes");
            _loc5_ = JSON.parse(_loc8_.getStringValue()) as Array;
            _loc12_ = param1.getVariable("gender").getStringValue();
            _loc6_ = new Character();
            _loc6_.isSpectator = currentRoom.spectatorList.indexOf(param1) != -1;
            _loc6_.platform = param1.getVariable("platform").getStringValue();
            _loc6_.setRoles(param1.getVariable("roles").getStringValue());
            _loc6_.init(param1.name,engine.scene as IsoScene,0,_loc12_,_loc5_);
            _loc6_.speed = param1.getVariable("speed").getDoubleValue();
            _loc6_.avatarName = param1.getVariable("avatarName").getStringValue();
            _loc9_ = int(param1.containsVariable("direction") ? param1.getVariable("direction").getIntValue() : 1);
            _loc11_ = param1.getVariable("position").getStringValue().split(",");
            if(_loc11_.length != 2)
            {
               return false;
            }
            _loc7_ = int(parseInt(_loc11_[0]));
            _loc4_ = int(parseInt(_loc11_[1]));
            if(_loc6_.platform == "mobile")
            {
               Sanalika.instance.mobileModel.addById(param1.name.toString());
               _loc6_.hide = true;
            }
            if(Sanalika.instance.avatarModel.isTutorialMode || Sanalika.instance.avatarModel.isHideMode)
            {
               _loc6_.hide = true;
            }
            if(param1.containsVariable("status"))
            {
               _loc6_.setAction(param1.getVariable("status").getStringValue());
            }
            if(param1.containsVariable("smiley"))
            {
               _loc6_.setSmiley(param1.getVariable("smiley").getStringValue());
            }
            if(param1.containsVariable("avatarSize"))
            {
               _loc6_.avatarSize = param1.getVariable("avatarSize").getDoubleValue();
            }
            if(param1.containsVariable("hand"))
            {
               _loc6_.useHandItem(param1.getVariable("hand").getStringValue());
            }
            if(!_loc6_.isSpectator)
            {
               _loc6_.reLocate(_loc7_,_loc4_,_loc9_);
            }
            _loc3_.addChar(_loc6_);
            if(param1.containsVariable("target") && param2)
            {
               _loc13_ = param1.getVariable("target").getStringValue().split(",");
               if(_loc13_ && _loc13_.length == 2)
               {
                  _loc6_.walk(int(_loc13_[0]),int(_loc13_[1]));
               }
            }
            engine.scene.dispatchEvent(new Event("roomListUpdate"));
            if(!param1.containsVariable("npc"))
            {
               _loc10_ = new GameEvent("USER_ENTER_ROOM");
               _loc10_.id = param1.name;
               Dispatcher.dispatchEvent(_loc10_);
            }
            _loc5_ = null;
            _loc11_ = null;
            return true;
         }
         catch(error:Error)
         {
            _loc21_ = false;
         }
         return _loc21_;
      }
      
      private function onRemoveRoomClient(param1:Object) : void
      {
         var _loc2_:Room = sfs.roomManager.getRoomById(param1.id);
         if(_loc2_ == null)
         {
            return;
         }
         sfs.dispatchEvent(new SFSEvent("userExitRoom",{
            "user":sfs.mySelf,
            "room":_loc2_
         }));
         sfs.roomManager.removeRoomById(param1.id);
         sfs.lastJoinedRoom = sfs.joinedRooms[sfs.joinedRooms.length - 1];
      }
   }
}

