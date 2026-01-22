package org.oyunstudyosu.alert.buttons
{
   import com.oyunstudyosu.components.CloseButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol40")]
   public class CloseViewButton extends CloseButton
   {
      
      public function CloseViewButton()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

