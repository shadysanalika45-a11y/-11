package org.oyunstudyosu.components.combobox
{
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.oyunstudyosu.assets.buttons.ComboBoxButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1094")]
   public class ComboBoxHeader extends MovieClip
   {
      
      public var headerTxt:TextField;
      
      public var bg:MovieClip;
      
      public var comboboxButton:ComboBoxButton;
      
      public var sText:STextField;
      
      public function ComboBoxHeader()
      {
         super();
         if(this.sText == null)
         {
            this.sText = TextFieldManager.convertAsArabicTextField(this.getChildByName("headerTxt") as TextField,false);
         }
         this.sText.mouseEnabled = false;
      }
   }
}

