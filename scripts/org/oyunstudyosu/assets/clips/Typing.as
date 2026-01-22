package org.oyunstudyosu.assets.clips
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol937")]
   public class Typing extends MovieClip
   {
      
      public var typeBubble:MovieClip;
      
      public function Typing()
      {
         super();
         addFrameScript(25,this.frame26,33,this.frame34);
      }
      
      internal function frame26() : *
      {
         gotoAndPlay("loop");
      }
      
      internal function frame34() : *
      {
         stop();
      }
   }
}

