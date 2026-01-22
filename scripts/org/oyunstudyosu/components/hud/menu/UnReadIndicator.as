package org.oyunstudyosu.components.hud.menu
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1184")]
   public class UnReadIndicator extends MovieClip
   {
      
      public var txtIndicator:TextField;
      
      public var background:MovieClip;
      
      public function UnReadIndicator()
      {
         super();
         this.txtIndicator.mouseEnabled = false;
         this.txtIndicator.visible = this.background.visible = false;
      }
      
      public function setIndicator(param1:Number) : void
      {
         if(param1 > 0)
         {
            this.txtIndicator.text = param1.toString();
            this.background.width = this.txtIndicator.textWidth + 2;
            this.background.visible = true;
            this.txtIndicator.visible = true;
         }
         else
         {
            this.txtIndicator.text = "";
            this.background.width = this.txtIndicator.textWidth + 6;
            this.background.visible = false;
            this.txtIndicator.visible = false;
         }
      }
   }
}

