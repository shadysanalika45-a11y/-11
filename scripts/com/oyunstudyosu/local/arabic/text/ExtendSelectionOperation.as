package com.oyunstudyosu.local.arabic.text
{
   public class ExtendSelectionOperation implements ITextOperation
   {
      
      private var direction:int;
      
      private var amount:int;
      
      public function ExtendSelectionOperation(param1:int, param2:int)
      {
         super();
         this.amount = param1;
         this.direction = param2;
      }
      
      public function perform(param1:ITextOperationContext) : void
      {
         param1.getSelection().extend(this.amount,this.direction,param1.getText().length);
      }
      
      public function requiresDraw() : Boolean
      {
         return false;
      }
   }
}

