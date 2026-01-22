package org.oyunstudyosu.action
{
   [Embed(source="/_assets/assets.swf", symbol="symbol164")]
   public class IdleIcon extends ActionIcon
   {
      
      public function IdleIcon()
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

