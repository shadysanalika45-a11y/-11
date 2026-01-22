package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.cloth.ClothData;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public interface IItemModel
   {
      
      function getCloth(param1:String) : ClothData;
      
      function getClothClass(param1:String) : Class;
      
      function getItemImage(param1:String) : MovieClip;
      
      function addPngListener(param1:Function) : void;
      
      function removePngListener(param1:Function) : void;
      
      function addItemListener(param1:Function) : void;
      
      function removeItemListener(param1:Function) : void;
      
      function getItemMovieClip(param1:String) : MovieClip;
      
      function getClothMovieClip(param1:String) : MovieClip;
      
      function getClothAdjustObject(param1:String) : Object;
      
      function getItemType(param1:String) : uint;
      
      function getBitmapdata(param1:String) : BitmapData;
      
      function isInfoFileDownloaded() : Boolean;
   }
}

