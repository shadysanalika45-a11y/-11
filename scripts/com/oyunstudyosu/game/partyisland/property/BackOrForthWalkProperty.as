package com.oyunstudyosu.game.partyisland.property
{
   public class BackOrForthWalkProperty extends EmptyPartyProperty
   {
      
      public function BackOrForthWalkProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         if(param2.isForward)
         {
            setText("Move forward as far as the rolled dice");
         }
         else
         {
            setText("Move backward as far as the rolled dice");
         }
      }
   }
}

