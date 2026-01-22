package com.oyunstudyosu.components
{
   import com.oyunstudyosu.utils.STextField;
   import com.oyunstudyosu.utils.TextFieldManager;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class DynamicSanalikaButton extends SanalikaButton
   {
      
      public var textfield:STextField;
      
      public function DynamicSanalikaButton()
      {
         super();
         this.textfield = TextFieldManager.convertAsArabicTextField(this.getChildByName("lbl_Button") as TextField,false,false);
         this.textfield.wordWrap = false;
      }
      
      public function setText(param1:String) : void
      {
         if(this.textfield.text == param1)
         {
            return;
         }
         this.textfield.centerText = param1;
         this.textfield.y = (height - this.textfield.height) / 2 - 2;
      }
      
      override protected function overHandler(param1:MouseEvent) : void
      {
         if(this.textfield == null)
         {
            return;
         }
         super.overHandler(param1);
      }
      
      override protected function outHandler(param1:MouseEvent) : void
      {
         if(this.textfield == null)
         {
            return;
         }
         super.outHandler(param1);
      }
      
      override protected function downHandler(param1:MouseEvent) : void
      {
         if(this.textfield == null)
         {
            return;
         }
         super.downHandler(param1);
      }
      
      override protected function upHandler(param1:MouseEvent) : void
      {
         if(this.textfield == null)
         {
            return;
         }
         super.upHandler(param1);
      }
      
      override protected function removed() : void
      {
         super.removed();
      }
   }
}

