package org.oyunstudyosu.alert.buttons
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol188")]
   public dynamic class ReportViewButton extends MovieClip
   {
      
      public function ReportViewButton()
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

