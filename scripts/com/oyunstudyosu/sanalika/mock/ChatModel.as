package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.chat.ChatVO;
   import com.oyunstudyosu.chat.IChatModel;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.events.GameEvent;
   
   public class ChatModel implements IChatModel
   {
      
      private var _list:Vector.<ChatVO>;
      
      private var _whisperMode:Boolean;
      
      private var _whisperId:String;
      
      public function ChatModel()
      {
         super();
         this._list = new Vector.<ChatVO>();
      }
      
      public function onTerminate(param1:GameEvent) : void
      {
      }
      
      public function get list() : Vector.<ChatVO>
      {
         return this._list;
      }
      
      public function add(param1:ICharacter, param2:String, param3:int = 0, param4:Boolean = true) : void
      {
      }
      
      public function addMsgBlockedUsers(param1:String) : void
      {
      }
      
      public function checkMsgBlockedUsers(param1:String) : Boolean
      {
         return false;
      }
      
      public function removeMsgBlockedUsers(param1:String) : void
      {
      }
      
      public function get whisperMode() : Boolean
      {
         return this._whisperMode;
      }
      
      public function set whisperMode(param1:Boolean) : void
      {
         this._whisperMode = param1;
      }
      
      public function get whisperId() : String
      {
         return this._whisperId;
      }
      
      public function set whisperId(param1:String) : void
      {
         this._whisperId = param1;
      }
   }
}

