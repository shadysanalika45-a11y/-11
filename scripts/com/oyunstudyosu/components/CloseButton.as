package com.oyunstudyosu.components
{
   import com.oyunstudyosu.sanalika.extension.Connectr;
   
   public class CloseButton extends SanalikaButton
   {
      
      public function CloseButton()
      {
         super();
         if(Connectr.instance.airModel.isMobile())
         {
            this.scaleX = this.scaleY = 1.7;
         }
      }
   }
}

