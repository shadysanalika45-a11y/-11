package org.oyunstudyosu.action
{
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol165")]
   public class ActionView extends CoreMovieClip
   {
      
      public var actionIcon:ActionIcon;
      
      public var danceIcon:ActionIcon;
      
      public var idleIcon:ActionIcon;
      
      private var hudEvent:HudEvent;
      
      public function ActionView()
      {
         super();
      }
      
      override public function added() : void
      {
         this.actionIcon.addEventListener(MouseEvent.CLICK,this.actionIconClicked);
         this.danceIcon.addEventListener(MouseEvent.CLICK,this.danceIconClicked);
         this.idleIcon.addEventListener(MouseEvent.CLICK,this.idleIconClicked);
         Connectr.instance.toolTipModel.addTip(this.actionIcon,$("Action"));
         Connectr.instance.toolTipModel.addTip(this.danceIcon,$("Dance"));
         Connectr.instance.toolTipModel.addTip(this.idleIcon,$("Idle"));
      }
      
      protected function actionIconClicked(param1:MouseEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.ACTION_FRAME);
         Dispatcher.dispatchEvent(this.hudEvent);
      }
      
      protected function danceIconClicked(param1:MouseEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.DANCE_FRAME);
         Dispatcher.dispatchEvent(this.hudEvent);
      }
      
      protected function idleIconClicked(param1:MouseEvent) : void
      {
         this.hudEvent = new HudEvent(HudEvent.IDLE_FRAME);
         Dispatcher.dispatchEvent(this.hudEvent);
      }
      
      public function update() : void
      {
         var _loc1_:ISceneCharacterComponent = Connectr.instance.engine.scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
         if(_loc1_ != null && _loc1_.myChar != null && _loc1_.myChar.hasActionFrame())
         {
            this.actionIcon.enableIcon();
         }
         else
         {
            this.actionIcon.disableIcon();
         }
         if(_loc1_ != null && _loc1_.myChar != null && _loc1_.myChar.hasDanceFrame())
         {
            this.danceIcon.enableIcon();
         }
         else
         {
            this.danceIcon.disableIcon();
         }
      }
      
      override public function removed() : void
      {
         this.actionIcon.removeEventListener(MouseEvent.CLICK,this.actionIconClicked);
         this.danceIcon.removeEventListener(MouseEvent.CLICK,this.danceIconClicked);
         this.idleIcon.removeEventListener(MouseEvent.CLICK,this.idleIconClicked);
         Connectr.instance.toolTipModel.removeTip(this.actionIcon,$("Action"));
         Connectr.instance.toolTipModel.removeTip(this.danceIcon,$("Dance"));
         Connectr.instance.toolTipModel.removeTip(this.idleIcon,$("Idle"));
         super.removed();
      }
   }
}

