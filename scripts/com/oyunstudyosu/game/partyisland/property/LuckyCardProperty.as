package com.oyunstudyosu.game.partyisland.property
{
   public class LuckyCardProperty extends CardProperty
   {
      
      public function LuckyCardProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Lucky card drawn");
         super.execute(param1,param2);
      }
   }
}

