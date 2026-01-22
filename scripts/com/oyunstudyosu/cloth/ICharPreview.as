package com.oyunstudyosu.cloth
{
   public interface ICharPreview
   {
      
      function rotate(param1:int) : void;
      
      function rotateLeft() : void;
      
      function rotateRight() : void;
      
      function addHandItem(param1:String) : void;
      
      function removeHandItemByName(param1:String) : void;
      
      function addClothByName(param1:String) : void;
      
      function removeClothByName(param1:String) : void;
      
      function getActiveHair() : ICloth;
      
      function setStatus(param1:String, param2:String, param3:int) : void;
      
      function reset() : void;
      
      function isActiveOnThePreview(param1:int) : Boolean;
      
      function addCloth(param1:ICloth) : void;
      
      function removeCloth(param1:int) : void;
      
      function getClothes() : Array;
      
      function get scale() : Number;
      
      function set scale(param1:Number) : void;
      
      function terminate() : void;
   }
}

