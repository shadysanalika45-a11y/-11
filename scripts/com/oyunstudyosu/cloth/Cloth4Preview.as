package com.oyunstudyosu.cloth
{
   import flash.display.MovieClip;
   
   public class Cloth4Preview
   {
      
      public var cloth:ICloth;
      
      public var tempKey:String;
      
      public var mc:MovieClip;
      
      public var placeBitIndex:int;
      
      public var isInited:Boolean;
      
      public function Cloth4Preview(param1:ICloth)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         this.cloth = param1;
         this.resetPlaceBitIndex();
         initMovieClip();
      }
      
      public function resetPlaceBitIndex() : void
      {
         this.placeBitIndex = cloth.maxPlaceBitIndex;
      }
      
      public function getKey() : String
      {
         if(tempKey != null)
         {
            return tempKey;
         }
         return cloth.key;
      }
      
      public function setTempKey(param1:String) : void
      {
         this.tempKey = param1;
         initMovieClip();
      }
      
      public function initMovieClip() : void
      {
         var _loc1_:String = getKey();
         if(cloth.isAccessory)
         {
            mc = Sanalika.instance.itemModel.getClothMovieClip(_loc1_);
         }
         else
         {
            mc = Sanalika.instance.itemModel.getItemMovieClip(_loc1_);
         }
         if(mc == null)
         {
            mc = new MovieClip();
            this.isInited = false;
         }
         else
         {
            this.isInited = true;
         }
      }
      
      public function dispose() : void
      {
         cloth = null;
         mc = null;
      }
   }
}

