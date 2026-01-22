package com.oyunstudyosu.game.partyisland.property
{
   public class RollDiceAgainProperty extends EmptyPartyProperty
   {
      
      public function RollDiceAgainProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Roll dice again");
      }
   }
}

