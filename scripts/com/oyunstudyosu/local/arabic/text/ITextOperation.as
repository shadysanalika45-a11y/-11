package com.oyunstudyosu.local.arabic.text
{
   public interface ITextOperation
   {
      
      function perform(param1:ITextOperationContext) : void;
      
      function requiresDraw() : Boolean;
   }
}

