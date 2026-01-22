package com.oyunstudyosu.local.arabic.text
{
   public class SetSelectionPositionOperation implements ITextOperation
   {
      
      private var position:uint;
      
      public function SetSelectionPositionOperation(param1:uint)
      {
         super();
         this.position = param1;
      }
      
      public function perform(param1:ITextOperationContext) : void
      {
         param1.setSelection(new Selection(this.position,this.position));
      }
      
      public function requiresDraw() : Boolean
      {
         return false;
      }
   }
}

