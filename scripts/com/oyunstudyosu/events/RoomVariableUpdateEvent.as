package com.oyunstudyosu.events
{
   import com.smartfoxserver.v2.entities.Room;
   import flash.events.Event;
   
   public class RoomVariableUpdateEvent extends Event
   {
      
      public static const VARIABLE_UPDATE:String = "variableUpdate";
      
      private var _key:String;
      
      private var _room:Room;
      
      public function RoomVariableUpdateEvent(param1:String, param2:String, param3:Room, param4:Boolean = false, param5:Boolean = false)
      {
         this._key = param2;
         this._room = param3;
         super(param1,param4,param5);
      }
      
      public function get room() : Room
      {
         return this._room;
      }
      
      public function get key() : String
      {
         return this._key;
      }
      
      override public function clone() : Event
      {
         return new RoomVariableUpdateEvent(type,this.key,this.room,bubbles,cancelable);
      }
   }
}

