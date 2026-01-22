package com.oyunstudyosu.game.partyisland.property
{
   import com.oyunstudyosu.engine.ICharacter;
   
   public class FinishPartyProperty extends EmptyPartyProperty
   {
      
      public function FinishPartyProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc3_:ICharacter = getAvatarById(param1);
         if(_loc3_ != null)
         {
            setText("%s finished the game",[_loc3_.avatarName]);
         }
      }
   }
}

