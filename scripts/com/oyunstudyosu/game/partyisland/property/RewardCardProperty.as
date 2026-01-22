package com.oyunstudyosu.game.partyisland.property
{
   public class RewardCardProperty extends CardProperty
   {
      
      public function RewardCardProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Reward card drawn");
         super.execute(param1,param2);
      }
   }
}

