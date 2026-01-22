package org.oyunstudyosu.speech.defaultBubbles
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.speech.BaseSpeechBubble;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1522")]
   public class GreyBubble extends BaseSpeechBubble implements ISpeechBubble
   {
      
      public var speechTxt:TextField;
      
      public var bg:MovieClip;
      
      public var tip:MovieClip;
      
      public var nickBg:MovieClip;
      
      public function GreyBubble()
      {
         super();
         TweenMax.to(this,0,{"glowFilter":{
            "color":52428,
            "alpha":1,
            "blurX":8,
            "blurY":8,
            "strength":2
         }});
         TweenMax.to(this,4,{"glowFilter":{
            "color":52428,
            "alpha":0,
            "blurX":0,
            "blurY":0,
            "strength":2
         }});
      }
      
      override public function speech(param1:String = "", param2:String = "") : void
      {
         super.speech(param1,param2);
         sText.htmlText = "<font color=\"#00CCCC\">" + param1 + ": " + "</font>";
         this.nickBg.width = sText.textWidth;
         if(Connectr.instance.gameModel.language == "ar")
         {
            sText.htmlText = "<font color=\"#000066\">" + param1 + ": " + "</font>" + "<font color=\"#FFFFFF\">" + param2 + "</font>";
         }
         else
         {
            sText.htmlText = "<font color=\"#000000\">" + param1 + ": " + "</font>" + "<font color=\"#FFFFFF\">" + param2 + "</font>";
         }
         sText.height = sText.textHeight + 4;
         if(sText.textHeight > maxHeight)
         {
            sText.height = maxHeight;
         }
         sText.width = sText.textWidth + 8;
         this.bg.height = sText.height + 16;
         this.bg.width = sText.width + 16;
         sText.x = int((this.bg.width - sText.width) / 2);
         sText.y = int(-3 + (this.bg.height - sText.height) / 2);
         if(Connectr.instance.gameModel.language == "ar")
         {
            this.nickBg.visible = false;
         }
         else
         {
            this.nickBg.x = sText.x + 1;
         }
         this.nickBg.y = sText.y + 6;
         this.tip.y = this.bg.height;
         this.tip.x = this.bg.width / 2;
      }
   }
}

