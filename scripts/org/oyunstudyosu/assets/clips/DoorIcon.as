package org.oyunstudyosu.assets.clips
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol434")]
   public dynamic class DoorIcon extends MovieClip
   {
      
      public function DoorIcon()
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

