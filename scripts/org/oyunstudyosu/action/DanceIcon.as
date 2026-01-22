package org.oyunstudyosu.action
{
   [Embed(source="/_assets/assets.swf", symbol="symbol159")]
   public class DanceIcon extends ActionIcon
   {
      
      public function DanceIcon()
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

