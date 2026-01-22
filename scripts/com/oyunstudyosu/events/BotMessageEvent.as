package com.oyunstudyosu.events
{
   import com.oyunstudyosu.bot.IBotMessage;
   import flash.events.Event;
   
   public class BotMessageEvent extends Event
   {
      
      public static const ADD_MESSAGE:String = "BotMessageEvent.ADD_MESSAGE";
      
      public static const REMOVE_MESSAGE:String = "BotMessageEvent.REMOVE_MESSAGE";
      
      public var clip:IBotMessage;
      
      public function BotMessageEvent(param1:String)
      {
         super(param1);
      }
   }
}

