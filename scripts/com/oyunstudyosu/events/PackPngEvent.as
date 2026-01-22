package com.oyunstudyosu.events
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PackPngEvent extends Event
   {
      
      public var key:String;
      
      public var sex:String;
      
      public var bitmapData:BitmapData;
      
      public function PackPngEvent(param1:String, param2:String, param3:String, param4:BitmapData, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.key = param2;
         this.sex = param3;
         this.bitmapData = param4;
      }
      
      public function getMovieClip() : MovieClip
      {
         var _loc1_:MovieClip = new MovieClip();
         var _loc2_:Bitmap = new Bitmap(this.bitmapData);
         _loc2_.x = -_loc2_.width / 2;
         _loc2_.y = -_loc2_.height / 2;
         _loc1_.addChild(_loc2_);
         return _loc1_;
      }
      
      public function getClothClip() : MovieClip
      {
         var _loc1_:MovieClip = new MovieClip();
         var _loc2_:Bitmap = new Bitmap(this.bitmapData);
         _loc1_.addChild(_loc2_);
         if(_loc2_.width > 48)
         {
            _loc2_.height = _loc2_.height / _loc2_.width * 48;
            _loc2_.width = 48;
         }
         _loc1_.x = -_loc1_.width / 2;
         _loc1_.y = -_loc1_.height / 2;
         return _loc1_;
      }
   }
}

