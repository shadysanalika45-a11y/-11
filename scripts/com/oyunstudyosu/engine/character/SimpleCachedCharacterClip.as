package com.oyunstudyosu.engine.character
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class SimpleCachedCharacterClip extends Bitmap
   {
      
      public function SimpleCachedCharacterClip(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function gotoAndStop(param1:Object, param2:String = null) : void
      {
      }
      
      public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
      }
   }
}

