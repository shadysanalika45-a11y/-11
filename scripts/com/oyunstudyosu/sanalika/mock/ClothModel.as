package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.cloth.IClothModel;
   import flash.display.MovieClip;
   
   public class ClothModel implements IClothModel
   {
      
      public function ClothModel()
      {
         super();
      }
      
      public function getNewCharPreview(param1:MovieClip, param2:Object = null, param3:Boolean = false) : ICharPreview
      {
         return new CharPreviewMock();
      }
      
      public function getElementsWithCategory(param1:Array, param2:String) : Array
      {
         return null;
      }
      
      public function get allClothes() : Array
      {
         return null;
      }
      
      public function load(param1:Object) : void
      {
      }
      
      public function addPngListener(param1:Function) : void
      {
      }
      
      public function isMemberOfCostumeCategory(param1:int) : Boolean
      {
         return false;
      }
   }
}

