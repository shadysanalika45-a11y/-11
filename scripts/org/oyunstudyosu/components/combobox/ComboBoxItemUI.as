package org.oyunstudyosu.components.combobox
{
   import com.oyunstudyosu.combobox.ComboBoxVo;
   import com.oyunstudyosu.components.SanalikaButton;
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.text.TextField;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1098")]
   public class ComboBoxItemUI extends CoreMovieClip
   {
      
      public var headerTxt:TextField;
      
      private var _vo:ComboBoxVo;
      
      public var bg:SanalikaButton;
      
      public var sText:STextField;
      
      private var _setW:int;
      
      public function ComboBoxItemUI()
      {
         super();
      }
      
      public function get vo() : ComboBoxVo
      {
         return this._vo;
      }
      
      public function set vo(param1:ComboBoxVo) : void
      {
         this._vo = param1;
         if(this.sText == null)
         {
            this.sText = TextFieldManager.convertAsArabicTextField(this.getChildByName("headerTxt") as TextField,false);
         }
         this.sText.text = param1.label;
         this.sText.mouseEnabled = false;
         if(this.sText.width + 20 > this.bg.width)
         {
            this.bg.width = this.sText.width + 20;
         }
      }
      
      public function get setW() : int
      {
         return this._setW;
      }
      
      public function set setW(param1:int) : void
      {
         if(this._setW == param1)
         {
            return;
         }
         this.bg.width = param1;
         this.sText.width = this.bg.width - 20;
         this.sText.x = 10;
      }
   }
}

