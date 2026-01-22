package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class AchievementEvent extends Event
   {
      
      public static const GET_REWARD:String = "AchievementEvent.GET_REWARD";
      
      public static const REWARD_COUNT_UPDATED:String = "AchievementEvent.REWARD_COUNT_UPDATED";
      
      public var id:String;
      
      public function AchievementEvent(param1:String, param2:String = "")
      {
         this.id = param2;
         super(param1,bubbles,cancelable);
      }
   }
}

