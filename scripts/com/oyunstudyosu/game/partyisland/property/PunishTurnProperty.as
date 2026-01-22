package com.oyunstudyosu.game.partyisland.property
{
   public class PunishTurnProperty extends EmptyPartyProperty
   {
      
      public function PunishTurnProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Turn penalty!");
      }
   }
}

