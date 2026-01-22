package com.oyunstudyosu.room
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.bot.BotModel;
   import com.oyunstudyosu.bot.IBotModel;
   import com.oyunstudyosu.debug.DebugConsole;
   import com.oyunstudyosu.door.DoorModel;
   import com.oyunstudyosu.door.IDoorModel;
   import com.oyunstudyosu.door.IDoorVO;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.model.GridModel;
   import com.oyunstudyosu.model.IGridModel;
   import com.oyunstudyosu.sanalika.interfaces.IRoomModel;
   import com.oyunstudyosu.utils.StringUtils;
   import com.smartfoxserver.v2.entities.Room;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   
   public class RoomModel implements IRoomModel
   {
      
      public var disableAddChar:Boolean = false;
      
      private var roomData:Object;
      
      private var _enterDoorKey:String = "d1";
      
      private var _roomID:String;
      
      private var _houseID:String;
      
      private var _groupId:String;
      
      private var _ownerId:String;
      
      private var _ownerName:String;
      
      private var _roomName:String;
      
      private var _buildingData:Object;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _key:String;
      
      private var _source:String;
      
      private var _mapInitialized:Boolean = false;
      
      private var _map:XMLList;
      
      private var _title:String;
      
      private var _type:String;
      
      private var _gridModel:IGridModel;
      
      private var _doorModel:IDoorModel;
      
      private var _botModel:IBotModel;
      
      private var _currentRoom:Room;
      
      public function RoomModel()
      {
         super();
         _botModel = new BotModel();
         _doorModel = new DoorModel();
         _gridModel = new GridModel();
      }
      
      public function get enterDoorKey() : String
      {
         return _enterDoorKey;
      }
      
      public function set enterDoorKey(param1:String) : void
      {
         if(_enterDoorKey == param1 || _enterDoorKey == null || _enterDoorKey == "")
         {
            return;
         }
         _enterDoorKey = param1;
      }
      
      public function get roomID() : String
      {
         return _roomID;
      }
      
      public function set roomID(param1:String) : void
      {
         if(_roomID == param1)
         {
            return;
         }
         _roomID = param1;
      }
      
      public function get houseID() : String
      {
         return _houseID;
      }
      
      public function set houseID(param1:String) : void
      {
         if(_houseID == param1)
         {
            return;
         }
         _houseID = param1;
      }
      
      public function get isUserRoom() : Boolean
      {
         return Boolean(_ownerId) && ownerId != Sanalika.instance.avatarModel.avatarId;
      }
      
      public function get groupId() : String
      {
         return _groupId;
      }
      
      public function set groupId(param1:String) : void
      {
         if(_groupId == param1)
         {
            return;
         }
         _groupId = param1;
      }
      
      public function get ownerId() : String
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:String) : void
      {
         if(_ownerId == param1)
         {
            return;
         }
         _ownerId = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         if(_ownerName == param1)
         {
            return;
         }
         _ownerName = param1;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         if(_roomName == param1)
         {
            return;
         }
         _roomName = param1;
      }
      
      public function get buildingData() : Object
      {
         return _buildingData;
      }
      
      public function set buildingData(param1:Object) : void
      {
         if(_buildingData == param1)
         {
            return;
         }
         _buildingData = param1;
         if(param1 == null)
         {
            type = null;
         }
         else
         {
            type = param1.roomType;
         }
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function set width(param1:int) : void
      {
         if(_width == param1)
         {
            return;
         }
         _width = param1;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function set height(param1:int) : void
      {
         if(_height == param1)
         {
            return;
         }
         _height = param1;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(param1:String) : void
      {
         if(_key == param1)
         {
            return;
         }
         _key = param1;
      }
      
      public function get source() : String
      {
         return _source;
      }
      
      public function set source(param1:String) : void
      {
         if(_source == param1)
         {
            return;
         }
         _source = param1;
      }
      
      public function get mapInitialized() : Boolean
      {
         return _mapInitialized;
      }
      
      public function set mapInitalized(param1:Boolean) : void
      {
         _mapInitialized = param1;
      }
      
      public function get interactiveRoom() : Room
      {
         var _loc2_:Array = Sanalika.instance.serviceModel.sfs.roomList;
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_.containsVariable("isInteractiveRoom") && Boolean(_loc1_.getVariable("isInteractiveRoom").getBoolValue()))
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function reloadScene() : void
      {
         Dispatcher.addEventListener("ROOM_MAP_INITIALIZED",onReloadScene);
         checkMap(roomData);
      }
      
      private function onReloadScene(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("ROOM_MAP_INITIALIZED",onReloadScene);
         setTimeout(startload,500);
      }
      
      public function getController() : RoomController
      {
         return Sanalika.instance.getController(RoomController) as RoomController;
      }
      
      private function startload() : void
      {
         var _loc1_:RoomController = Sanalika.instance.getController(RoomController) as RoomController;
         if(_loc1_)
         {
            _loc1_.startload();
         }
      }
      
      public function checkMap(param1:Object) : void
      {
         roomData = param1;
         if(roomData)
         {
            try
            {
               DebugConsole.info("ROOM","checkMap","doorKey=",roomData.room.doorKey,"mapLen=",roomData.room.map ? String(roomData.room.map).length : 0);
            }
            catch(e0:Error)
            {
            }
            map = roomData.room.map;
            enterDoorKey = roomData.room.doorKey;
         }
      }
      
      public function getMap() : XMLNode
      {
         var _loc1_:XMLDocument = new XMLDocument();
         _loc1_.ignoreWhite = true;
         _loc1_.parseXML(_map.toXMLString());
         return _loc1_.firstChild;
      }
      
      private function set map(param1:String) : void
      {
         var _loc2_:String = StringUtils.replaceAll(param1,"\\u003d","=");
         try
         {
            DebugConsole.info("MAP","decode","base64Len=",param1 ? param1.length : 0);
         }
         catch(e1:Error)
         {
         }
         _map = XMLList(Base64.decode(param1));
         try
         {
            DebugConsole.info("MAP","decoded","xmlLen=",_map ? _map.toXMLString().length : 0);
         }
         catch(e2:Error)
         {
         }
         mapInitalized = true;
         Dispatcher.dispatchEvent(new GameEvent("ROOM_MAP_INITIALIZED"));
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         if(_title == param1)
         {
            return;
         }
         _title = param1;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
      }
      
      public function get gridModel() : IGridModel
      {
         return _gridModel;
      }
      
      public function get doorModel() : IDoorModel
      {
         return _doorModel;
      }
      
      public function get botModel() : IBotModel
      {
         return _botModel;
      }
      
      public function getDefaultPosition() : Point
      {
         var _loc3_:String = null;
         var _loc2_:IDoorVO = null;
         var _loc1_:Array = doorModel.keyList;
         if(_loc1_.length > 0)
         {
            _loc3_ = doorModel.keyList[0];
            _loc2_ = doorModel.getDoorById(_loc3_);
            return new Point(_loc2_.x,_loc2_.y);
         }
         return new Point();
      }
      
      public function get currentRoom() : Room
      {
         return _currentRoom;
      }
      
      public function set currentRoom(param1:Room) : void
      {
         if(_currentRoom == param1)
         {
            return;
         }
         _currentRoom = param1;
      }
   }
}

