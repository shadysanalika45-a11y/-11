package com.oyunstudyosu.model
{
   public interface IMatchmakingModel
   {
      
      function get isMatchmaking() : Boolean;
      
      function set isMatchmaking(param1:Boolean) : void;
      
      function cancel() : void;
   }
}

