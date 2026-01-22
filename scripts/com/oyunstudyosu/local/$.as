package com.oyunstudyosu.local
{
   public function $(param1:String) : String
   {
      return LocalizationModel.instance.translate2(param1);
   }
}

