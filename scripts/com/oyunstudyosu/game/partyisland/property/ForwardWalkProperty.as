package com.oyunstudyosu.game.partyisland.property
{
   public class ForwardWalkProperty extends EmptyPartyProperty
   {
      
      public function ForwardWalkProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc3_:int = int(param2.dice1);
         var _loc4_:int = int(param2.dice2);
         var _loc5_:int = _loc3_ + _loc4_;
         setText("Forward %s steps",[_loc5_]);
      }
   }
}

