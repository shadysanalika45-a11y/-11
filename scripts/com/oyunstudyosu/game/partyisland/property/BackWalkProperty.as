package com.oyunstudyosu.game.partyisland.property
{
   public class BackWalkProperty extends EmptyPartyProperty
   {
      
      public function BackWalkProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc3_:int = int(param2.dice1);
         var _loc4_:int = int(param2.dice2);
         var _loc5_:int = _loc3_ + _loc4_;
         setText("Back %s steps",[_loc5_]);
      }
   }
}

