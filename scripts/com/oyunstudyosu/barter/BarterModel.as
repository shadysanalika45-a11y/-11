package com.oyunstudyosu.barter
{
   public class BarterModel
   {
      
      private var _isBusy:Boolean;
      
      public function BarterModel()
      {
         super();
      }
      
      public function get isBusy() : Boolean
      {
         return _isBusy;
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         if(_isBusy == param1)
         {
            return;
         }
         _isBusy = param1;
      }
   }
}

