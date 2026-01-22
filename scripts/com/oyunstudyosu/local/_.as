package com.oyunstudyosu.local
{
   public function _(param1:String) : String
   {
      return LocalizationModel.instance.translate(param1);
   }
}

