package com.oyunstudyosu.local.arabic.text
{
   public class AddTextOperation implements ITextOperation
   {
      
      private var _text:String;
      
      public function AddTextOperation(param1:String = "")
      {
         super();
         this._text = param1;
      }
      
      public function perform(param1:ITextOperationContext) : void
      {
         param1.addText(this._text);
      }
      
      public function requiresDraw() : Boolean
      {
         return true;
      }
   }
}

