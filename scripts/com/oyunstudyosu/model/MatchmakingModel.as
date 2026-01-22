package com.oyunstudyosu.model
{
   public class MatchmakingModel implements IMatchmakingModel
   {
      
      public var _isMatchmaking:Boolean = false;
      
      public function MatchmakingModel()
      {
         super();
      }
      
      public function get isMatchmaking() : Boolean
      {
         return _isMatchmaking;
      }
      
      public function set isMatchmaking(param1:Boolean) : void
      {
         _isMatchmaking = param1;
      }
      
      public function cancel() : void
      {
         Sanalika.instance.serviceModel.requestData("matchmakingCancel",{},null);
      }
   }
}

