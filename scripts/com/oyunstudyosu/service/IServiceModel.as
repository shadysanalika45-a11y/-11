package com.oyunstudyosu.service
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Room;
   
   public interface IServiceModel
   {
      
      function get sfs() : SmartFox;
      
      function set sfs(param1:SmartFox) : void;
      
      function activate() : void;
      
      function deactivate() : void;
      
      function listenRoomVariable(param1:String, param2:Function) : void;
      
      function removeRoomVariable(param1:String, param2:Function) : void;
      
      function listenExtension(param1:String, param2:Function) : void;
      
      function removeExtension(param1:String, param2:Function) : void;
      
      function requestExtension(param1:String, param2:Object, param3:Function, param4:Room = null) : void;
      
      function removeRequestExtension(param1:String, param2:Function) : void;
      
      function requestData(param1:String, param2:Object, param3:Function, param4:Room = null) : void;
      
      function removeRequestData(param1:String, param2:Function) : void;
      
      function listenUserVariable(param1:String, param2:Function) : void;
      
      function removeUserVariable(param1:String, param2:Function) : void;
      
      function setRoomVariable(param1:Array, param2:Array) : void;
      
      function setUserVariable(param1:Array, param2:Array) : void;
   }
}

