package com.oyunstudyosu.achievement
{
   import com.oyunstudyosu.events.AchievementEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.interfaces.IAchievementModel;
   
   public class AchievementModel implements IAchievementModel
   {
      
      private var _rewardCount:int;
      
      public function AchievementModel()
      {
         super();
         _rewardCount = 0;
      }
      
      public function get rewardCount() : int
      {
         return _rewardCount;
      }
      
      public function set rewardCount(param1:int) : void
      {
         _rewardCount = param1;
         Dispatcher.dispatchEvent(new AchievementEvent("AchievementEvent.REWARD_COUNT_UPDATED"));
      }
   }
}

