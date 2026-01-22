package com.oyunstudyosu.events
{
   import com.oyunstudyosu.chat.ChatVO;
   import flash.events.Event;
   
   public class ChatHistoryEvent extends Event
   {
      
      public static const ADD:String = "add_history";
      
      public static const CLEAR:String = "clear_history";
      
      public var vo:ChatVO;
      
      public function ChatHistoryEvent(param1:String)
      {
         super(param1);
      }
   }
}

