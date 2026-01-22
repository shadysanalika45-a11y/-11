package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.bot.IBotModel;
   import com.oyunstudyosu.door.IDoorModel;
   import com.oyunstudyosu.model.IGridModel;
   import com.smartfoxserver.v2.entities.Room;
   import flash.xml.XMLNode;
   
   public interface IRoomModel
   {
      
      function get title() : String;
      
      function get roomID() : String;
      
      function set roomID(param1:String) : void;
      
      function get houseID() : String;
      
      function set houseID(param1:String) : void;
      
      function get roomName() : String;
      
      function set roomName(param1:String) : void;
      
      function get buildingData() : Object;
      
      function set buildingData(param1:Object) : void;
      
      function get enterDoorKey() : String;
      
      function get gridModel() : IGridModel;
      
      function get doorModel() : IDoorModel;
      
      function get botModel() : IBotModel;
      
      function get ownerId() : String;
      
      function get ownerName() : String;
      
      function set ownerName(param1:String) : void;
      
      function get width() : int;
      
      function get height() : int;
      
      function get key() : String;
      
      function get currentRoom() : Room;
      
      function set currentRoom(param1:Room) : void;
      
      function get source() : String;
      
      function get type() : String;
      
      function get isUserRoom() : Boolean;
      
      function get interactiveRoom() : Room;
      
      function checkMap(param1:Object) : void;
      
      function reloadScene() : void;
      
      function getMap() : XMLNode;
   }
}

