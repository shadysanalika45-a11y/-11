package com.oyunstudyosu.sanalika.mock
{
   import flash.events.EventDispatcher;
   
   public class CharPreview extends EventDispatcher
   {
      
      public function CharPreview()
      {
         super(null);
      }
      
      public function getDiff() : Array
      {
         return [];
      }
      
      public function rotate(param1:int) : void
      {
      }
      
      public function addHandItem(param1:String) : void
      {
         trace("addHandItem : " + param1);
      }
      
      public function addClothByName(param1:String) : void
      {
         trace("addClothByName : " + param1);
      }
      
      public function removeClothByName(param1:String) : void
      {
         trace("removeClothByName : " + param1);
      }
      
      public function reset() : void
      {
      }
   }
}

