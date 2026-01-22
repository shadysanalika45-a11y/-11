package org.oyunstudyosu.action
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ActionIcon extends MovieClip
   {
      
      public function ActionIcon()
      {
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.ROLL_OVER,this.overIcon);
         this.addEventListener(MouseEvent.ROLL_OUT,this.outIcon);
      }
      
      protected function overIcon(param1:MouseEvent) : void
      {
         this.gotoAndStop("animationFrame");
      }
      
      protected function outIcon(param1:MouseEvent) : void
      {
         this.gotoAndStop("normalFrame");
      }
      
      public function enableIcon() : void
      {
         this.mouseEnabled = true;
         this.gotoAndStop("normalFrame");
      }
      
      public function disableIcon() : void
      {
         this.mouseEnabled = false;
         this.gotoAndStop("disableFrame");
      }
      
      public function dispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.overIcon);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.outIcon);
      }
   }
}

