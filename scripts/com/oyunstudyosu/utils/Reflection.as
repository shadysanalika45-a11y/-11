package com.oyunstudyosu.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.MovieClip;
   import flash.display.SpreadMethod;
   import flash.geom.Matrix;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class Reflection extends MovieClip
   {
      
      private static var VERSION:String = "4.0";
      
      private var mc:MovieClip;
      
      private var mcBMP:BitmapData;
      
      private var reflectionBMP:Bitmap;
      
      private var gradientMask_mc:MovieClip;
      
      private var updateInt:Number;
      
      private var bounds:Object;
      
      private var distance:Number = 0;
      
      public function Reflection()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc17_:Number = NaN;
         this.mc = param1.mc;
         var _loc2_:Number = param1.alpha / 100;
         var _loc3_:Number = Number(param1.ratio);
         var _loc4_:Number = Number(param1.updateTime);
         var _loc5_:Number = Number(param1.reflectionDropoff);
         var _loc6_:Number = Number(param1.distance);
         var _loc7_:Number = this.mc.height;
         var _loc8_:Number = this.mc.width;
         this.bounds = new Object();
         this.bounds.width = _loc8_;
         this.bounds.height = _loc7_;
         this.mcBMP = new BitmapData(this.bounds.width,this.bounds.height,true,0);
         this.mcBMP.draw(this.mc);
         this.reflectionBMP = new Bitmap(this.mcBMP);
         this.reflectionBMP.scaleY = -1;
         this.reflectionBMP.y = this.bounds.height * 2 + _loc6_;
         this.reflectionBMP.smoothing = true;
         var _loc9_:DisplayObject = this.mc.addChild(this.reflectionBMP);
         _loc9_.name = "reflectionBMP";
         var _loc10_:DisplayObject = this.mc.addChild(new MovieClip());
         _loc10_.name = "gradientMask_mc";
         this.gradientMask_mc = this.mc.getChildByName("gradientMask_mc") as MovieClip;
         var _loc11_:String = GradientType.LINEAR;
         var _loc12_:Array = [16777215,16777215];
         var _loc13_:Array = [_loc2_,0];
         var _loc14_:Array = [0,_loc3_];
         var _loc15_:String = SpreadMethod.PAD;
         var _loc16_:Matrix = new Matrix();
         if(_loc5_ <= 0)
         {
            _loc17_ = Number(this.bounds.height);
         }
         else
         {
            _loc17_ = this.bounds.height / _loc5_;
         }
         _loc16_.createGradientBox(this.bounds.width,_loc17_,90 / 180 * Math.PI,0,0);
         this.gradientMask_mc.graphics.beginGradientFill(_loc11_,_loc12_,_loc13_,_loc14_,_loc16_,_loc15_);
         this.gradientMask_mc.graphics.drawRect(0,0,this.bounds.width,this.bounds.height);
         this.gradientMask_mc.y = this.mc.getChildByName("reflectionBMP").y - this.mc.getChildByName("reflectionBMP").height;
         this.gradientMask_mc.cacheAsBitmap = true;
         this.mc.getChildByName("reflectionBMP").cacheAsBitmap = true;
         this.mc.getChildByName("reflectionBMP").mask = this.gradientMask_mc;
         if(_loc4_ > -1)
         {
            this.updateInt = setInterval(this.update,_loc4_,this.mc);
         }
      }
      
      public function setBounds(param1:Number, param2:Number) : void
      {
         this.bounds.width = param1;
         this.bounds.height = param2;
         this.gradientMask_mc.width = this.bounds.width;
         this.redrawBMP(this.mc);
      }
      
      public function redrawBMP(param1:MovieClip) : void
      {
         this.mcBMP.dispose();
         this.mcBMP = new BitmapData(this.bounds.width,this.bounds.height,true,0);
         this.mcBMP.draw(param1);
      }
      
      private function update(param1:MovieClip) : void
      {
         this.mcBMP = new BitmapData(this.bounds.width,this.bounds.height,true,0);
         this.mcBMP.draw(param1);
         this.reflectionBMP.bitmapData = this.mcBMP;
      }
      
      public function destroy() : void
      {
         this.mc.removeChild(this.mc.getChildByName("reflectionBMP"));
         this.reflectionBMP = null;
         this.mcBMP.dispose();
         clearInterval(this.updateInt);
         this.mc.removeChild(this.mc.getChildByName("gradientMask_mc"));
      }
   }
}

