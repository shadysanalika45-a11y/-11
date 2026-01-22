package org.oyunstudyosu.speech
{
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1567")]
   public class FireBubble extends BaseSpeechBubble implements ISpeechBubble
   {
      
      public var speechTxt:TextField;
      
      public var bg:MovieClip;
      
      public var effect:MovieClip;
      
      public function FireBubble()
      {
         super();
      }
      
      override public function speech(param1:String = "", param2:String = "") : void
      {
         super.speech(param1,param2);
         sText.x = 10;
         sText.y = 7;
         sText.width = 120;
         sText.htmlText = param1 + " : " + param2;
         this.bg.width = sText.width + sText.x * 2;
         this.bg.height = sText.height + sText.y * 2;
      }
   }
}

