package com.oyunstudyosu.chat
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.events.ChatHistoryEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   
   public class ChatModel implements IChatModel
   {
      
      private var _list:Vector.<ChatVO> = new Vector.<ChatVO>();
      
      private var vo:ChatVO;
      
      public var msgBlockedUsers:Array = [];
      
      private var _whisperMode:Boolean;
      
      private var _whisperId:String;
      
      public function ChatModel()
      {
         super();
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminate);
      }
      
      public function onTerminate(param1:GameEvent) : void
      {
         whisperMode = false;
      }
      
      public function get list() : Vector.<ChatVO>
      {
         return _list;
      }
      
      public function set list(param1:Vector.<ChatVO>) : void
      {
         _list = param1;
      }
      
      public function add(param1:ICharacter, param2:String, param3:int = 0, param4:Boolean = true) : void
      {
         if(list.length >= 50)
         {
            vo = list.shift();
            vo.sender = param1;
            vo.message = param2;
            vo.frameNo = param3;
            vo.isPublic = param4;
         }
         else
         {
            vo = new ChatVO();
            vo.sender = param1;
            vo.message = param2;
            vo.frameNo = param3;
            vo.isPublic = param4;
         }
         list.push(vo);
         var _loc5_:ChatHistoryEvent = new ChatHistoryEvent("add_history");
         _loc5_.vo = vo;
         Dispatcher.dispatchEvent(_loc5_);
      }
      
      public function get whisperMode() : Boolean
      {
         return _whisperMode;
      }
      
      public function set whisperMode(param1:Boolean) : void
      {
         _whisperMode = param1;
      }
      
      public function get whisperId() : String
      {
         return _whisperId;
      }
      
      public function set whisperId(param1:String) : void
      {
         _whisperId = param1;
      }
   }
}

