package org.oyunstudyosu.components.hud.menu
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.SoundEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.sound.SoundKey;
   import com.oyunstudyosu.utils.Reflection;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import org.oyunstudyosu.components.hud.HudShadow;
   
   public class MainHudButton extends MovieClip
   {
      
      private var isover:Boolean = false;
      
      private var img:Bitmap;
      
      private var soundEvent:SoundEvent;
      
      public var hudEvent:HudEvent;
      
      private var reflect:Reflection;
      
      private var buttonY:int;
      
      private var reflectY:int;
      
      private var reflectionClip:DisplayObject;
      
      private var hudShadow:HudShadow;
      
      private var buttonH:int = 46;
      
      private var hitClip:MovieClip;
      
      private var xOrg:int;
      
      private var yOrg:int;
      
      public function MainHudButton()
      {
         super();
         this.cacheAsBitmap = true;
         if(Connectr.instance.airModel.isMobile())
         {
            this["cacheAsBitmapMatrix"] = new Matrix();
         }
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeFromStage);
      }
      
      protected function addedToStage(param1:Event) : void
      {
         this.gotoAndStop(1);
         this.added();
      }
      
      public function move(param1:*, param2:*) : void
      {
         this.x = param1;
         this.y = param2;
         this.buttonY = param2;
      }
      
      public function restore() : void
      {
         this.x = this.xOrg;
         this.y = this.yOrg;
         this.buttonY = this.yOrg;
      }
      
      protected function added() : void
      {
      }
      
      public function init() : void
      {
         this.hitClip = this.getChildByName("hitMc") as MovieClip;
         this.buttonY = this.y;
         this.xOrg = this.x;
         this.yOrg = this.y;
         this.hitClip.buttonMode = true;
         this.hitClip.mouseChildren = false;
         this.hitClip.addEventListener(MouseEvent.CLICK,this.clickHandler);
         this.hitClip.addEventListener(MouseEvent.ROLL_OVER,this.overHandler);
         this.hitClip.addEventListener(MouseEvent.ROLL_OUT,this.outHandler);
         this.hitClip.addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this.hitClip.addEventListener(MouseEvent.MOUSE_UP,this.upHandler);
      }
      
      protected function removed() : void
      {
      }
      
      protected function clicked() : void
      {
         this.soundEvent = new SoundEvent(SoundEvent.PLAY_SOUND);
         this.soundEvent.soundKey = SoundKey.HUD_CLICK;
         Dispatcher.dispatchEvent(this.soundEvent);
      }
      
      protected function removeFromStage(param1:Event) : void
      {
         this.hitClip.removeEventListener(MouseEvent.CLICK,this.clickHandler);
         this.hitClip.removeEventListener(MouseEvent.ROLL_OVER,this.overHandler);
         this.hitClip.removeEventListener(MouseEvent.ROLL_OUT,this.outHandler);
         this.hitClip.removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         this.hitClip.removeEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         this.removed();
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         trace("clicked");
         this.clicked();
      }
      
      protected function overHandler(param1:MouseEvent) : void
      {
         this.gotoAndStop(2);
         TweenMax.to(this,0.2,{
            "y":this.buttonY - 2,
            "ease":Quad.easeOut
         });
         this.isover = true;
      }
      
      protected function outHandler(param1:MouseEvent) : void
      {
         this.gotoAndStop(1);
         this.isover = false;
         TweenMax.to(this,0.2,{
            "y":this.buttonY,
            "ease":Quad.easeOut
         });
      }
      
      protected function downHandler(param1:MouseEvent) : void
      {
         this.gotoAndStop(3);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.upHandler,false,0,true);
      }
      
      protected function upHandler(param1:MouseEvent) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         if(this.isover)
         {
            this.overHandler(null);
         }
         else
         {
            this.outHandler(null);
         }
      }
   }
}

