package com.oyunstudyosu.utils
{
   import com.oyunstudyosu.local.LocalInstanceConfig;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class STextField extends TextField
   {
      
      public var flaraby:FlarabyAS3;
      
      private var flarabyData:String = "";
      
      private var format:TextFormat;
      
      private var resizable:Boolean;
      
      public function STextField(param1:Boolean = false, param2:Boolean = true)
      {
         super();
         this.mouseEnabled = false;
         this.multiline = param1;
         if(param1)
         {
            this.wordWrap = true;
         }
         else
         {
            this.wordWrap = false;
         }
         this.autoSize = TextFieldAutoSize.NONE;
         this.resizable = param2;
         this.embedFonts = true;
         this.selectable = false;
         var _loc3_:String = Boolean(Connectr.instance.gameModel) && Connectr.instance.gameModel.language != null ? Connectr.instance.gameModel.language : LocalInstanceConfig._SafeStr_2("LANGUAGE");
         if(_loc3_ == "ar")
         {
            this.flaraby = new FlarabyAS3();
            this.flaraby.dir = "RTL";
            this.flaraby.embedFonts = true;
            this.flaraby.html = true;
            this.flaraby.multiline = param1;
            this.flaraby.extraCharWidth = 1;
         }
      }
      
      override public function set text(param1:String) : void
      {
         if(this.flaraby != null)
         {
            this.flaraby.multiline = multiline;
            this.flarabyData = param1;
            this.format = this.getTextFormat();
            this.format.align = TextFormatAlign.RIGHT;
            this.defaultTextFormat = this.format;
            super.htmlText = this.flaraby.convertArabicString(this.flarabyData,this.width + 20,defaultTextFormat);
         }
         else
         {
            super.text = param1;
         }
      }
      
      override public function set htmlText(param1:String) : void
      {
         if(this.flaraby != null)
         {
            this.flaraby.multiline = multiline;
            this.flarabyData = param1;
            this.format = this.getTextFormat();
            this.format.align = TextFormatAlign.RIGHT;
            this.defaultTextFormat = this.format;
            trace("this.width",this.width);
            super.htmlText = this.flaraby.convertArabicString(this.flarabyData,this.width + 5,defaultTextFormat);
            if(!multiline && this.resizable)
            {
               this.width = this.textWidth + 6;
            }
            if(this.resizable)
            {
               this.height = this.textHeight + 4;
            }
         }
         else
         {
            super.htmlText = param1;
            if(!multiline && this.resizable)
            {
               this.width = this.textWidth + 6;
            }
            if(this.resizable)
            {
               this.height = this.textHeight + 4;
            }
         }
      }
      
      public function set centerText(param1:String) : void
      {
         if(this.flaraby != null)
         {
            this.flaraby.multiline = multiline;
            this.flarabyData = param1;
            this.format = this.getTextFormat();
            this.format.align = TextFormatAlign.CENTER;
            this.defaultTextFormat = this.format;
            super.htmlText = this.flaraby.convertArabicString(this.flarabyData,this.width + 5,defaultTextFormat);
            if(!multiline && this.resizable)
            {
               this.width = this.textWidth + 8;
            }
            if(this.resizable)
            {
               this.height = this.textHeight + 4;
            }
         }
         else
         {
            super.htmlText = param1;
            if(!multiline && this.resizable)
            {
               this.width = this.textWidth + 6;
            }
            if(this.resizable)
            {
               this.height = this.textHeight + 4;
            }
         }
      }
      
      override public function set multiline(param1:Boolean) : void
      {
         super.multiline = param1;
         if(this.flaraby != null)
         {
            this.flaraby.multiline = multiline;
         }
      }
      
      public function set extraCharWidth(param1:Number) : void
      {
         if(this.flaraby != null && !isNaN(param1))
         {
            this.flaraby.extraCharWidth = param1;
         }
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
