package org.oyunstudyosu.emoticon
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1229")]
   public class Emoticons extends MovieClip
   {
      
      public function Emoticons()
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

