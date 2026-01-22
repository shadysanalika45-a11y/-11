package com.oyunstudyosu.game.partyisland
{
   import com.oyunstudyosu.engine.ICharacter;
   
   public class PartyPlayerVo
   {
      
      public var finishedAt:int = 0;
      
      public var lastTurnAt:int = 0;
      
      public var progress:Number = 0;
      
      public var turnIndex:int = -1;
      
      public var lastBalance:int = 0;
      
      public var balance:int = 0;
      
      public var lastPoolBalance:int = 0;
      
      public var poolBalance:int = 0;
      
      public var totalBalance:int = 0;
      
      public var character:ICharacter;
      
      public function PartyPlayerVo(param1:ICharacter)
      {
         super();
         this.character = param1;
      }
   }
}

