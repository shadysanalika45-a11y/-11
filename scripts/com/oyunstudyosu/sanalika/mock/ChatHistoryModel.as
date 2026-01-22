package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.chat.ChatVO;
   import com.oyunstudyosu.chat.IChatModel;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.events.ChatHistoryEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   
   public class ChatHistoryModel implements IChatModel
   {
      
      public function ChatHistoryModel()
      {
         super();
      }
      
      public function onTerminate(param1:GameEvent) : void
      {
      }
      
      public function get list() : Vector.<ChatVO>
      {
         return new Vector.<ChatVO>();
      }
      
      public function add(param1:ICharacter, param2:String, param3:int = 0, param4:Boolean = true) : void
      {
         var _loc5_:ChatVO = new ChatVO();
         _loc5_.sender = param1;
         _loc5_.message = param2;
         _loc5_.frameNo = param3;
         this.list.push(_loc5_);
         var _loc6_:ChatHistoryEvent = new ChatHistoryEvent(ChatHistoryEvent.ADD);
         _loc6_.vo = _loc5_;
         Dispatcher.dispatchEvent(_loc6_);
      }
      
      public function checkMsgBlockedUsers(param1:String) : Boolean
      {
         return false;
      }
      
      public function removeMsgBlockedUsers(param1:String) : void
      {
      }
      
      public function get whisperId() : String
      {
         return null;
      }
      
      public function set whisperId(param1:String) : void
      {
      }
      
      public function get whisperMode() : Boolean
      {
         return false;
      }
      
      public function set whisperMode(param1:Boolean) : void
      {
      }
      
      public function addMsgBlockedUsers(param1:String) : void
      {
      }
   }
}

