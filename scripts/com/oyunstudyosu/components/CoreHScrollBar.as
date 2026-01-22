package com.oyunstudyosu.components
{
   import feathers.controls.HScrollBar;
   import feathers.graphics.FillStyle;
   import feathers.skins.RectangleSkin;
   
   public class CoreHScrollBar extends HScrollBar
   {
      
      private var _barHeight:uint = 8;
      
      private var _bgColor:uint;
      
      private var _barColor:uint;
      
      public function CoreHScrollBar()
      {
         super();
         paddingLeft = paddingRight = -1;
         buttonMode = true;
      }
      
      public function get barHeight() : uint
      {
         return this._barHeight;
      }
      
      public function set barHeight(param1:uint) : *
      {
         if(this._barHeight == param1)
         {
            return;
         }
         this._barHeight = param1;
         this.__updateSkin();
      }
      
      public function get bgColor() : uint
      {
         return this._bgColor;
      }
      
      public function set bgColor(param1:uint) : *
      {
         if(this._bgColor == param1)
         {
            return;
         }
         this._bgColor = param1;
         this.__updateSkin();
      }
      
      public function get barColor() : uint
      {
         return this._barColor;
      }
      
      public function set barColor(param1:uint) : *
      {
         if(this._barColor == param1)
         {
            return;
         }
         this._barColor = param1;
         this.__updateSkin();
      }
      
      private function __updateSkin() : void
      {
         var _loc1_:* = new RectangleSkin();
         _loc1_.set_fill(FillStyle.SolidColor(this._bgColor));
         _loc1_.height = this._barHeight;
         _loc1_.set_cornerRadius(10);
         this.set_trackSkin(_loc1_);
         var _loc2_:* = new RectangleSkin();
         _loc2_.set_fill(FillStyle.SolidColor(this._barColor));
         _loc2_.height = this._barHeight;
         _loc2_.set_cornerRadius(10);
         this.set_thumbSkin(_loc2_);
      }
   }
}

