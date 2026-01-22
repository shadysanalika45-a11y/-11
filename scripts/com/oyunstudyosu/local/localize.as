package com.oyunstudyosu.local
{
   import flash.text.TextField;
   
   public function localize(param1:TextField) : void
   {
      param1.text = LocalizationModel.instance.translate(param1.name.replace("lbl_",""));
   }
}

