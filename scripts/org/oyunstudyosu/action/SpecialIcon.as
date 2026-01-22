package org.oyunstudyosu.action
{
   [Embed(source="/_assets/assets.swf", symbol="symbol122")]
   public class SpecialIcon extends ActionIcon
   {
      
      public function SpecialIcon()
      {
         addFrameScript(0,this.frame1);
         super();
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

