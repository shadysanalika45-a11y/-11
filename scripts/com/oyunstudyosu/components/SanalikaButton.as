package com.oyunstudyosu.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SanalikaButton extends MovieClip
   {
      
      private var isdown:Boolean;
      
      public function SanalikaButton()
      {
         super();
         this.buttonMode = true;
         this.mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeFromStage);
      }
      
      protected function addedToStage(param1:Event) : void
      {
         addEventListener(MouseEvent.CLICK,this.clickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.overHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.outHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         this.gotoAndStop(1);
         this.added();
      }
      
      protected function added() : void
      {
      }
      
      protected function removed() : void
      {
      }
      
      protected function clicked() : void
      {
      }
      
      protected function removeFromStage(param1:Event) : void
      {
         removeEventListener(MouseEvent.CLICK,this.clickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.overHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.outHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.downHandler);
         removeEventListener(MouseEvent.MOUSE_UP,this.upHandler);
         this.removed();
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         this.clicked();
      }
      
      protected function overHandler(param1:MouseEvent) : void
      {
         if(this.isdown)
         {
            return;
         }
         this.gotoAndStop(2);
      }
      
      protected function outHandler(param1:MouseEvent) : void
      {
         if(this.isdown)
         {
            return;
         }
         this.gotoAndStop(1);
      }
      
      protected function downHandler(param1:MouseEvent) : void
      {
         this.isdown = true;
         this.gotoAndStop(3);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.upHandler,false,0,true);
      }
      
      protected function upHandler(param1:MouseEvent) : void
      {
         this.isdown = false;
         try
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.upHandler);
            this.gotoAndStop(2);
         }
         catch(e:Error)
         {
         }
      }
   }
}

