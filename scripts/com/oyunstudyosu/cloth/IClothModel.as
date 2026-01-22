package com.oyunstudyosu.cloth
{
   import flash.display.MovieClip;
   
   public interface IClothModel
   {
      
      function getNewCharPreview(param1:MovieClip, param2:Object = null, param3:Boolean = false) : ICharPreview;
      
      function getElementsWithCategory(param1:Array, param2:String) : Array;
      
      function isMemberOfCostumeCategory(param1:int) : Boolean;
      
      function addPngListener(param1:Function) : void;
      
      function load(param1:Object) : void;
      
      function get allClothes() : Array;
   }
}

