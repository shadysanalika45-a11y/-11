package org.oyunstudyosu.components.hud.menu
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1132")]
   public class DanceButton extends MainHudButton
   {
      
      public var hitMc:MovieClip;
      
      public function DanceButton()
      {
         super();
      }
      
      override protected function added() : void
      {
      }
   }
}

