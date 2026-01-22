package com.oyunstudyosu.local.arabic.text
{
   public class MoveSelectionOperation implements ITextOperation
   {
      
      public var amount:int;
      
      public function MoveSelectionOperation(param1:int)
      {
         super();
         this.amount = param1;
      }
      
      public function perform(param1:ITextOperationContext) : void
      {
         var _loc2_:Selection = param1.getSelection();
         if(_loc2_.length > 0)
         {
            _loc2_.contract(this.amount > 0 ? SelectionDirection.RIGHT : SelectionDirection.LEFT);
         }
         else
         {
            _loc2_.move(this.amount,param1.getText().length);
         }
      }
      
      public function requiresDraw() : Boolean
      {
         return false;
      }
   }
}

