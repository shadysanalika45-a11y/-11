package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.bot.IBotModel;
   import com.oyunstudyosu.door.IDoorModel;
   import com.oyunstudyosu.model.IGridModel;
   import com.oyunstudyosu.sanalika.interfaces.IRoomModel;
   import com.smartfoxserver.v2.entities.Room;
   import flash.xml.XMLNode;
   
   public class RoomModel implements IRoomModel
   {
      
      private var _doorModel:IDoorModel;
      
      private var _roomID:String;
      
      private var _houseID:String;
      
      private var _roomName:String;
      
      public function RoomModel()
      {
         super();
         this._doorModel = new DoorModel();
      }
      
      public function checkMap(param1:Object) : void
      {
      }
      
      public function reloadScene() : void
      {
      }
      
      public function get title() : String
      {
         return null;
      }
      
      public function get ownerName() : String
      {
         return "Tayfun";
      }
      
      public function set ownerName(param1:String) : void
      {
      }
      
      public function get gridModel() : IGridModel
      {
         return null;
      }
      
      public function get doorModel() : IDoorModel
      {
         return this._doorModel;
      }
      
      public function get botModel() : IBotModel
      {
         return null;
      }
      
      public function get height() : int
      {
         return 0;
      }
      
      public function get key() : String
      {
         return null;
      }
      
      public function get ownerId() : String
      {
         return null;
      }
      
      public function get source() : String
      {
         return null;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function get width() : int
      {
         return 0;
      }
      
      public function getMap() : XMLNode
      {
         return null;
      }
      
      public function get isUserRoom() : Boolean
      {
         return false;
      }
      
      public function set map(param1:String) : void
      {
      }
      
      public function get roomID() : String
      {
         return this._roomID;
      }
      
      public function set roomID(param1:String) : void
      {
         if(this._roomID == param1)
         {
            return;
         }
         this._roomID = param1;
      }
      
      public function get houseID() : String
      {
         return this._houseID;
      }
      
      public function set houseID(param1:String) : void
      {
         if(this._houseID == param1)
         {
            return;
         }
         this._houseID = param1;
      }
      
      public function get roomName() : String
      {
         return this._roomName;
      }
      
      public function set roomName(param1:String) : void
      {
         if(this._roomName == param1)
         {
            return;
         }
         this._roomName = param1;
      }
      
      public function get buildingID() : String
      {
         return null;
      }
      
      public function set buildingID(param1:String) : void
      {
      }
      
      public function get currentRoom() : Room
      {
         return null;
      }
      
      public function set currentRoom(param1:Room) : void
      {
      }
      
      public function get enterDoorKey() : String
      {
         return null;
      }
      
      public function set enterDoorKey(param1:String) : void
      {
      }
      
      public function get buildingData() : Object
      {
         return null;
      }
      
      public function set buildingData(param1:Object) : void
      {
      }
      
      public function get interactiveRoom() : Room
      {
         return null;
      }
   }
}

