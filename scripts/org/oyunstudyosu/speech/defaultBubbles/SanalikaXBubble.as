package org.oyunstudyosu.speech.defaultBubbles
{
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.speech.BaseSpeechBubble;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1541")]
   public class SanalikaXBubble extends BaseSpeechBubble implements ISpeechBubble
   {
      
      public var speechTxt:TextField;
      
      public var bg:MovieClip;
      
      public var tip:MovieClip;
      
      public function SanalikaXBubble()
      {
         super();
      }
      
      override public function speech(param1:String = "", param2:String = "") : void
      {
         super.speech(param1,param2);
         sText.htmlText = "<font color=\"#FFFFFF\">" + param1 + ": " + "</font>" + "<font color=\"#000000\">" + param2 + "</font>";
         sText.height = sText.textHeight + 4;
         if(sText.textHeight > maxHeight)
         {
            sText.height = maxHeight;
         }
         sText.width = sText.textWidth + 8;
         this.bg.height = sText.height + 10;
         this.bg.width = sText.width + 10;
         sText.x = int((this.bg.width - sText.width) / 2);
         sText.y = int(-3 + (this.bg.height - sText.height) / 2);
         this.tip.y = this.bg.height;
         this.tip.x = this.bg.width / 2;
      }
   }
}

