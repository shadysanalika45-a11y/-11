package com.oyunstudyosu.components
{
   import feathers.controls.VScrollBar;
   import feathers.graphics.FillStyle;
   import feathers.skins.RectangleSkin;
   
   public class CoreVScrollBar extends VScrollBar
   {
      
      private var _barWidth:uint = 10;
      
      private var _bgColor:uint = 0;
      
      private var _barColor:uint = 0;
      
      public function CoreVScrollBar()
      {
         super();
         paddingBottom = paddingTop = -1;
         buttonMode = true;
      }
      
      public function get barWidth() : uint
      {
         return this._barWidth;
      }
      
      public function set barWidth(param1:uint) : *
      {
         if(this._barWidth == param1)
         {
            return;
         }
         this._barWidth = param1;
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
         _loc1_.width = this._barWidth;
         _loc1_.set_cornerRadius(10);
         this.set_trackSkin(_loc1_);
         var _loc2_:* = new RectangleSkin();
         _loc2_.set_fill(FillStyle.SolidColor(this._barColor));
         _loc2_.width = this._barWidth;
         _loc2_.set_cornerRadius(10);
         this.set_thumbSkin(_loc2_);
      }
   }
}

