package org.oyunstudyosu.components.hud.menu
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1156")]
   public class IslandsButton extends MainHudButton
   {
      
      public var hitMc:MovieClip;
      
      public function IslandsButton()
      {
         super();
      }
      
      override protected function added() : void
      {
      }
      
      override protected function overHandler(param1:MouseEvent) : void
      {
         super.overHandler(param1);
         if(Connectr.instance.roomModel.ownerId)
         {
            Connectr.instance.toolTipModel.addTip(this,Connectr.instance.roomModel.title);
         }
         else
         {
            Connectr.instance.toolTipModel.addTip(this,$("universe_" + Connectr.instance.avatarModel.universe) + " - " + $("room_" + Connectr.instance.roomModel.key));
         }
      }
      
      override protected function outHandler(param1:MouseEvent) : void
      {
         super.outHandler(param1);
         Connectr.instance.toolTipModel.removeTip(this);
      }
      
      override protected function clicked() : void
      {
         hudEvent = new HudEvent(HudEvent.OPEN_ISLANDS_PANEL);
         Dispatcher.dispatchEvent(hudEvent);
         super.clicked();
      }
      
      override protected function removed() : void
      {
         Connectr.instance.toolTipModel.removeTip(this);
      }
   }
}

