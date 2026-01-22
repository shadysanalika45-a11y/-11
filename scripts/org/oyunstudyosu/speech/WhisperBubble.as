package org.oyunstudyosu.speech
{
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1589")]
   public class WhisperBubble extends BaseSpeechBubble implements ISpeechBubble
   {
      
      public var speechTxt:TextField;
      
      public var bg:MovieClip;
      
      public var tip:MovieClip;
      
      public function WhisperBubble()
      {
         super();
         this.alpha = 0.8;
      }
      
      override public function speech(param1:String = "", param2:String = "") : void
      {
         super.speech(param1,param2);
         sText.htmlText = "<font color=\"#A5F0E6\">" + param1 + ": " + "</font>" + "<font color=\"#FFFFFF\">" + param2 + "</font>";
         sText.height = sText.textHeight + 4;
         if(sText.textHeight > maxHeight)
         {
            sText.height = maxHeight;
         }
         sText.width = sText.textWidth + 8;
         this.bg.height = sText.height + 10;
         this.bg.width = sText.width + 10;
         sText.x = 2 + (this.bg.width - sText.width) / 2;
         sText.y = -3 + (this.bg.height - sText.height) / 2;
         this.tip.y = this.bg.height;
         this.tip.x = this.bg.width / 2;
      }
   }
}

