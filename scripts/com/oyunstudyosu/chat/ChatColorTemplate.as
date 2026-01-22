package com.oyunstudyosu.chat
{
   public class ChatColorTemplate
   {
      
      public static const DEFAULT:ChatColorTemplate = new ChatColorTemplate(6118749,16711666,"Default Bubble",1);
      
      public static const BLUE:ChatColorTemplate = new ChatColorTemplate(16777215,3394713,"Blue Bubble",6);
      
      public static const SILVER:ChatColorTemplate = new ChatColorTemplate(16777215,3394713,"Silver Bubble",2);
      
      public static const YELLOW:ChatColorTemplate = new ChatColorTemplate(6118749,16631612,"Yellow Bubble",3);
      
      public static const GREY:ChatColorTemplate = new ChatColorTemplate(16777215,8289918,"Grey Bubble",4);
      
      public static const BAN:ChatColorTemplate = new ChatColorTemplate(16777215,8289918,"Ban Bubble",4);
      
      public static const BOT:ChatColorTemplate = new ChatColorTemplate(6118749,16711666,"Bot Bubble",5);
      
      public static const QUEST:ChatColorTemplate = new ChatColorTemplate(6118749,16711666,"Quest Bubble",12);
      
      public static const BLACK:ChatColorTemplate = new ChatColorTemplate(16711422,197379,"Black Bubble",23);
      
      public static const RED:ChatColorTemplate = new ChatColorTemplate(16777215,14836065,"Red Bubble",24);
      
      public static const PINK:ChatColorTemplate = new ChatColorTemplate(16777215,16492024,"Pink Bubble",25);
      
      public static const LOVE:ChatColorTemplate = new ChatColorTemplate(6118749,15713752,"Love Bubble",22);
      
      public static const WING:ChatColorTemplate = new ChatColorTemplate(16777215,9687516,"Wing Bubble",8);
      
      public static const MUSIC:ChatColorTemplate = new ChatColorTemplate(6118749,12177472,"Music Bubble",9);
      
      public static const WHISPER:ChatColorTemplate = new ChatColorTemplate(16777215,12177472,"Whisper Bubble",11);
      
      public static const DIAMOND_CLUB:ChatColorTemplate = new ChatColorTemplate(16777215,3355443,"Diamond Club Bubble",26);
      
      public static const SANALIKAX:ChatColorTemplate = new ChatColorTemplate(16777215,16750592,"SanalikaX Bubble",30);
      
      public var textColor:uint;
      
      public var boxColor:uint;
      
      public var tipKey:String;
      
      public var bgFrame:int;
      
      public function ChatColorTemplate(param1:uint = 0, param2:uint = 0, param3:String = "", param4:int = 0)
      {
         super();
         this.textColor = param1;
         this.boxColor = param2;
         this.tipKey = param3;
         this.bgFrame = param4;
      }
   }
}

