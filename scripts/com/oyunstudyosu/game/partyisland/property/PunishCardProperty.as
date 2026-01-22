package com.oyunstudyosu.game.partyisland.property
{
   public class PunishCardProperty extends CardProperty
   {
      
      public function PunishCardProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         setText("Punish card drawn");
         super.execute(param1,param2);
      }
   }
}

