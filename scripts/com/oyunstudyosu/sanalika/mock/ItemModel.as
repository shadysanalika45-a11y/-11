package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.cloth.ClothData;
   import com.oyunstudyosu.sanalika.interfaces.IItemModel;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   
   public class ItemModel extends EventDispatcher implements IItemModel
   {
      
      public function ItemModel()
      {
         super(null);
      }
      
      public function getClothClass(param1:String) : Class
      {
         return null;
      }
      
      public function getItemImage(param1:String) : MovieClip
      {
         return null;
      }
      
      public function addPngListener(param1:Function) : void
      {
      }
      
      public function addItemListener(param1:Function) : void
      {
      }
      
      public function getClothAdjustObject(param1:String) : Object
      {
         return null;
      }
      
      public function getClothMovieClip(param1:String) : MovieClip
      {
         return null;
      }
      
      public function getItemMovieClip(param1:String) : MovieClip
      {
         return null;
      }
      
      public function getItemType(param1:String) : uint
      {
         return 0;
      }
      
      public function getBitmapdata(param1:String) : BitmapData
      {
         return null;
      }
      
      public function getCloth(param1:String) : ClothData
      {
         return null;
      }
      
      public function removePngListener(param1:Function) : void
      {
      }
      
      public function isInfoFileDownloaded() : Boolean
      {
         return false;
      }
      
      public function removeItemListener(param1:Function) : void
      {
      }
   }
}

