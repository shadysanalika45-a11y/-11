package org.oyunstudyosu.complete
{
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1089")]
   public class AvatarNickCompleteItem extends CoreMovieClip
   {
      
      public var bg:MovieClip;
      
      public var nickTxt:TextField;
      
      private var sNickName:STextField;
      
      private var _selected:Boolean;
      
      private var _title:String;
      
      public function AvatarNickCompleteItem()
      {
         super();
      }
      
      override public function added() : void
      {
         if(this.sNickName == null)
         {
            this.sNickName = TextFieldManager.convertAsArabicTextField(this.getChildByName("nickTxt") as TextField);
         }
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         if(param1)
         {
            this.gotoAndStop(2);
         }
         else
         {
            this.gotoAndStop(1);
         }
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
         this.sNickName.text = param1;
         this.selected = false;
      }
   }
}

