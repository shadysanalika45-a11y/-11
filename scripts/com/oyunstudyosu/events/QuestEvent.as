package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class QuestEvent extends Event
   {
      
      public static const QUEST_COMPLETED:String = "QuestEvent.QUEST_COMPLETED";
      
      public static const QUEST_ACTION:String = "QuestEvent.QUEST_ACTION";
      
      public static const QUEST_LIST_ROOM_READY:String = "QuestEvent.QUEST_LIST_ROOM_READY";
      
      public var questID:String;
      
      public function QuestEvent(param1:String)
      {
         super(param1,bubbles,cancelable);
      }
   }
}

