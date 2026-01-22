package com.oyunstudyosu.local.arabic.text
{
   public interface ITextOperationContext
   {
      
      function addText(param1:String = "") : Selection;
      
      function addTextWithSelection(param1:Selection, param2:String = "") : Selection;
      
      function setSelection(param1:Selection) : void;
      
      function getSelection() : Selection;
      
      function getText() : String;
   }
}

