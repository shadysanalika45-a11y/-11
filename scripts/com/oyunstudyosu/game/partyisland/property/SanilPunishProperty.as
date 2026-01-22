package com.oyunstudyosu.game.partyisland.property
{
   public class SanilPunishProperty extends EmptyPartyProperty
   {
      
      public function SanilPunishProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc3_:int = int(param2.amount);
         setText("You lost %s sanil",[_loc3_]);
      }
   }
}

