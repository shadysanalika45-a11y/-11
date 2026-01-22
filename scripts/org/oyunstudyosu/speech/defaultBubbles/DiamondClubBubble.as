package org.oyunstudyosu.speech.defaultBubbles
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.speech.BaseSpeechBubble;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1514")]
   public class DiamondClubBubble extends BaseSpeechBubble implements ISpeechBubble
   {
      
      public var speechTxt:TextField;
      
      public var bg:MovieClip;
      
      public var tip:MovieClip;
      
      public function DiamondClubBubble()
      {
         super();
         TweenMax.to(this,0,{"glowFilter":{
            "color":255,
            "alpha":1,
            "blurX":8,
            "blurY":8,
            "strength":2
         }});
         TweenMax.to(this,4,{"glowFilter":{
            "color":255,
            "alpha":0,
            "blurX":8,
            "blurY":8,
            "strength":2
         }});
      }
      
      override public function speech(param1:String = "", param2:String = "") : void
      {
         super.speech(param1,param2);
         sText.htmlText = "<font color=\"#660033\">" + param1 + ": " + "</font>" + "<font color=\"#1B1C26\">" + param2 + "</font>";
         sText.height = sText.textHeight + 4;
         if(sText.textHeight > maxHeight)
         {
            sText.height = maxHeight;
         }
         sText.width = sText.textWidth + 8;
         this.bg.height = sText.height + 22;
         this.bg.width = sText.width + 22;
         sText.x = int((this.bg.width - sText.width) / 2);
         sText.y = int(-3 + (this.bg.height - sText.height) / 2);
         this.tip.y = this.bg.height;
         this.tip.x = this.bg.width / 2;
      }
   }
}

