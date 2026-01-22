package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.cloth.ICloth;
   
   public class CharPreviewMock implements ICharPreview
   {
      
      public function CharPreviewMock()
      {
         super();
      }
      
      public function rotate(param1:int) : void
      {
      }
      
      public function rotateLeft() : void
      {
      }
      
      public function rotateRight() : void
      {
      }
      
      public function addHandItem(param1:String) : void
      {
      }
      
      public function removeHandItemByName(param1:String) : void
      {
      }
      
      public function removeHandItem() : void
      {
      }
      
      public function addClothByName(param1:String) : void
      {
      }
      
      public function removeClothByName(param1:String) : void
      {
      }
      
      public function getActiveHair() : ICloth
      {
         return null;
      }
      
      public function setStatus(param1:String, param2:String, param3:int) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function isActiveOnThePreview(param1:int) : Boolean
      {
         return false;
      }
      
      public function addCloth(param1:ICloth) : void
      {
      }
      
      public function removeCloth(param1:int) : void
      {
      }
      
      public function getClothes() : Array
      {
         return null;
      }
      
      public function get scale() : Number
      {
         return 0;
      }
      
      public function set scale(param1:Number) : void
      {
      }
      
      public function terminate() : void
      {
      }
   }
}

