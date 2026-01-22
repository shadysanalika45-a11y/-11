package org.oyunstudyosu.speech
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechBubble;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   public class BaseSpeechBubble extends CoreMovieClip implements ISpeechBubble
   {
      
      protected var sText:STextField;
      
      protected var maxHeight:int = 100;
      
      protected var maxWidth:int = 110;
      
      private var nick:String;
      
      private var message:String;
      
      private var _sender:ICharacter;
      
      public function BaseSpeechBubble()
      {
         super();
      }
      
      public function get sender() : ICharacter
      {
         return this._sender;
      }
      
      public function set sender(param1:ICharacter) : void
      {
         if(this._sender == param1)
         {
            return;
         }
         this._sender = param1;
      }
      
      public function speech(param1:String = "", param2:String = "") : void
      {
         this.nick = param1;
         this.message = param2;
         if(this.sText == null)
         {
            this.sText = TextFieldManager.convertAsArabicTextField(getChildByName("speechTxt") as TextField,true,false);
         }
         this.sText.width = this.maxWidth;
      }
   }
}

