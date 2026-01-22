package org.oyunstudyosu.components.hud.menu
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1182")]
   public class SmileyButton extends MainHudButton
   {
      
      public var hitMc:MovieClip;
      
      public function SmileyButton()
      {
         super();
      }
      
      override protected function added() : void
      {
         Connectr.instance.toolTipModel.addTip(this,$("Emotions"));
      }
      
      override protected function clicked() : void
      {
         hudEvent = new HudEvent(HudEvent.OPEN_SMILEY_PANEL);
         Dispatcher.dispatchEvent(hudEvent);
         super.clicked();
      }
      
      override protected function removed() : void
      {
         Connectr.instance.toolTipModel.removeTip(this);
      }
   }
}

