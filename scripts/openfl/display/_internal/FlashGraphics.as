package openfl.display._internal
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsEndFill;
   import flash.display.GraphicsGradientFill;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsShaderFill;
   import flash.display.GraphicsSolidFill;
   import flash.display.GraphicsStroke;
   import flash.display.GraphicsTrianglePath;
   import flash.display.IGraphicsData;
   import flash.display.IGraphicsFill;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import openfl._Vector.VectorDataIterator;
   import openfl.display.GraphicsQuadPath;
   
   public class FlashGraphics
   {
      
      public static var __meta__:* = {"obj":{"SuppressWarnings":["checkstyle:FieldDocComment"]}};
      
      public static var bitmapFill:Dictionary = Dictionary_Impl_._new(true);
      
      public static var tileRect:Rectangle = new Rectangle();
      
      public static var tileTransform:Matrix = new Matrix();
      
      public function FlashGraphics()
      {
      }
      
      public static function drawGraphicsData(param1:Graphics, param2:Vector.<IGraphicsData>) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null as IGraphicsData;
         var _loc6_:* = null as GraphicsSolidFill;
         var _loc7_:* = null as GraphicsBitmapFill;
         var _loc8_:* = null as GraphicsGradientFill;
         var _loc9_:* = null as GraphicsShaderFill;
         var _loc10_:* = null as GraphicsStroke;
         var _loc11_:* = null as GraphicsPath;
         var _loc12_:* = null as GraphicsTrianglePath;
         var _loc13_:* = null as GraphicsQuadPath;
         var _loc14_:* = null as BitmapData;
         var _loc15_:* = null as Object;
         var _loc3_:Boolean = false;
         if(param2 != null)
         {
            _loc4_ = new VectorDataIterator(param2);
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               if(_loc5_ is GraphicsQuadPath)
               {
                  _loc3_ = true;
                  break;
               }
            }
         }
         if(_loc3_)
         {
            _loc4_ = new VectorDataIterator(param2);
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               if(_loc5_ is GraphicsSolidFill)
               {
                  _loc6_ = _loc5_;
                  _loc14_ = null;
                  FlashGraphics.bitmapFill[param1] = _loc14_;
                  param1.beginFill(_loc6_.color,_loc6_.alpha);
               }
               else if(_loc5_ is GraphicsBitmapFill)
               {
                  _loc7_ = _loc5_;
                  _loc14_ = _loc7_.bitmapData;
                  FlashGraphics.bitmapFill[param1] = _loc14_;
                  param1.beginBitmapFill(_loc14_,_loc7_.matrix,_loc7_.repeat,_loc7_.smooth);
               }
               else if(_loc5_ is GraphicsGradientFill)
               {
                  _loc8_ = _loc5_;
                  _loc14_ = null;
                  FlashGraphics.bitmapFill[param1] = _loc14_;
                  param1.beginGradientFill(_loc8_.type,_loc8_.colors,_loc8_.alphas,_loc8_.ratios,_loc8_.matrix,_loc8_.spreadMethod,_loc8_.interpolationMethod,_loc8_.focalPointRatio);
               }
               else if(_loc5_ is GraphicsShaderFill)
               {
                  _loc9_ = _loc5_;
                  _loc14_ = null;
                  FlashGraphics.bitmapFill[param1] = _loc14_;
                  param1.beginShaderFill(_loc9_.shader,_loc9_.matrix);
               }
               else if(_loc5_ is GraphicsStroke)
               {
                  _loc10_ = _loc5_;
                  if(_loc10_.fill != null)
                  {
                     _loc15_ = _loc10_.thickness;
                     if(Math.isNaN(_loc15_))
                     {
                        _loc15_ = null;
                     }
                     if(_loc10_.fill is GraphicsSolidFill)
                     {
                        _loc6_ = _loc10_.fill;
                        param1.lineStyle(_loc15_,_loc6_.color,_loc6_.alpha,_loc10_.pixelHinting,_loc10_.scaleMode,_loc10_.caps,_loc10_.joints,_loc10_.miterLimit);
                     }
                     else if(_loc10_.fill is GraphicsBitmapFill)
                     {
                        _loc7_ = _loc10_.fill;
                        param1.lineStyle(_loc15_,0,1,_loc10_.pixelHinting,_loc10_.scaleMode,_loc10_.caps,_loc10_.joints,_loc10_.miterLimit);
                        param1.lineBitmapStyle(_loc7_.bitmapData,_loc7_.matrix,_loc7_.repeat,_loc7_.smooth);
                     }
                     else if(_loc10_.fill is GraphicsGradientFill)
                     {
                        _loc8_ = _loc10_.fill;
                        param1.lineStyle(_loc15_,0,1,_loc10_.pixelHinting,_loc10_.scaleMode,_loc10_.caps,_loc10_.joints,_loc10_.miterLimit);
                        param1.lineGradientStyle(_loc8_.type,_loc8_.colors,_loc8_.alphas,_loc8_.ratios,_loc8_.matrix,_loc8_.spreadMethod,_loc8_.interpolationMethod,_loc8_.focalPointRatio);
                     }
                     else if(_loc10_.fill is GraphicsShaderFill)
                     {
                        _loc9_ = _loc10_.fill;
                        param1.lineStyle(_loc15_,0,1,_loc10_.pixelHinting,_loc10_.scaleMode,_loc10_.caps,_loc10_.joints,_loc10_.miterLimit);
                        param1.lineShaderStyle(_loc9_.shader,_loc9_.matrix);
                     }
                  }
                  else
                  {
                     param1.lineStyle();
                  }
               }
               else if(_loc5_ is GraphicsPath)
               {
                  _loc11_ = _loc5_;
                  param1.drawPath(_loc11_.commands,_loc11_.data,_loc11_.winding);
               }
               else if(_loc5_ is GraphicsTrianglePath)
               {
                  _loc12_ = _loc5_;
                  param1.drawTriangles(_loc12_.vertices,_loc12_.indices,_loc12_.uvtData,_loc12_.culling);
               }
               else if(_loc5_ is GraphicsEndFill)
               {
                  _loc14_ = null;
                  FlashGraphics.bitmapFill[param1] = _loc14_;
                  param1.endFill();
               }
               else if(_loc5_ is GraphicsQuadPath)
               {
                  _loc13_ = _loc5_;
                  FlashGraphics.drawQuads(param1,_loc13_.rects,_loc13_.indices,_loc13_.transforms);
               }
            }
         }
         else
         {
            param1.drawGraphicsData(param2);
         }
      }
      
      public static function drawQuads(param1:Graphics, param2:Vector.<Number>, param3:Vector.<int>, param4:Vector.<Number>) : void
      {
         var _loc11_:int = 0;
         var _loc12_:* = 0;
         var _loc15_:* = null as Vector.<Number>;
         var _loc19_:* = null as Vector.<int>;
         var _loc23_:* = null as Vector.<Number>;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc42_:int = 0;
         var _loc43_:int = 0;
         var _loc44_:Number = NaN;
         var _loc5_:BitmapData = FlashGraphics.bitmapFill[param1];
         if(param2 == null || int(param2.length) == 0)
         {
            return;
         }
         var _loc6_:Rectangle = _loc5_ != null ? _loc5_.rect : null;
         var _loc7_:* = param3 != null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:int = _loc7_ ? int(param3.length) : int(Math.floor(int(param2.length) / 4));
         if(_loc10_ == 0)
         {
            return;
         }
         if(param4 != null)
         {
            if(int(param4.length) >= _loc10_ * 6)
            {
               _loc8_ = true;
               _loc9_ = true;
            }
            else if(int(param4.length) >= _loc10_ * 4)
            {
               _loc8_ = true;
            }
            else if(int(param4.length) >= _loc10_ * 2)
            {
               _loc9_ = true;
            }
         }
         var _loc13_:Object = null;
         var _loc14_:Array = null;
         if(_loc14_ != null)
         {
            _loc15_ = Vector.<Number>(_loc14_);
         }
         else
         {
            _loc15_ = new Vector.<Number>(_loc10_ * 8,_loc13_);
         }
         var _loc16_:Vector.<Number> = _loc15_;
         var _loc17_:Object = null;
         var _loc18_:Array = null;
         if(_loc18_ != null)
         {
            _loc19_ = Vector.<int>(_loc18_);
         }
         else
         {
            _loc19_ = new Vector.<int>(_loc10_ * 6,_loc17_);
         }
         var _loc20_:Vector.<int> = _loc19_;
         var _loc21_:Object = null;
         var _loc22_:Array = null;
         if(_loc22_ != null)
         {
            _loc23_ = Vector.<Number>(_loc22_);
         }
         else
         {
            _loc23_ = new Vector.<Number>(_loc10_ * 8,_loc21_);
         }
         var _loc24_:Vector.<Number> = _loc23_;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc36_:Number = 0;
         var _loc37_:Number = 0;
         var _loc38_:Number = 1;
         var _loc39_:Number = 1;
         var _loc40_:int = 0;
         var _loc41_:int = _loc10_;
         while(_loc40_ < _loc41_)
         {
            _loc42_ = _loc40_++;
            _loc11_ = _loc7_ ? param3[_loc42_] * 4 : _loc42_ * 4;
            if(_loc11_ >= 0)
            {
               FlashGraphics.tileRect.setTo(param2[_loc11_],param2[_loc11_ + 1],param2[_loc11_ + 2],param2[_loc11_ + 3]);
               if(!(FlashGraphics.tileRect.width <= 0 || FlashGraphics.tileRect.height <= 0))
               {
                  if(_loc8_ && _loc9_)
                  {
                     _loc12_ = _loc42_ * 6;
                     FlashGraphics.tileTransform.setTo(param4[_loc12_],param4[_loc12_ + 1],param4[_loc12_ + 2],param4[_loc12_ + 3],param4[_loc12_ + 4],param4[_loc12_ + 5]);
                  }
                  else if(_loc8_)
                  {
                     _loc12_ = _loc42_ * 4;
                     FlashGraphics.tileTransform.setTo(param4[_loc12_],param4[_loc12_ + 1],param4[_loc12_ + 2],param4[_loc12_ + 3],FlashGraphics.tileRect.x,FlashGraphics.tileRect.y);
                  }
                  else if(_loc9_)
                  {
                     _loc12_ = _loc42_ * 2;
                     FlashGraphics.tileTransform.tx = param4[_loc12_];
                     FlashGraphics.tileTransform.ty = param4[_loc12_ + 1];
                  }
                  else
                  {
                     FlashGraphics.tileTransform.tx = FlashGraphics.tileRect.x;
                     FlashGraphics.tileTransform.ty = FlashGraphics.tileRect.y;
                  }
                  _loc30_ = FlashGraphics.tileRect.width;
                  _loc31_ = FlashGraphics.tileRect.height;
                  _loc32_ = FlashGraphics.tileTransform.a;
                  _loc33_ = FlashGraphics.tileTransform.b;
                  _loc34_ = FlashGraphics.tileTransform.c;
                  _loc35_ = FlashGraphics.tileTransform.d;
                  _loc28_ = FlashGraphics.tileTransform.tx;
                  _loc29_ = FlashGraphics.tileTransform.ty;
                  _loc16_[_loc27_] = _loc28_;
                  _loc16_[_loc27_ + 1] = _loc29_;
                  _loc16_[_loc27_ + 2] = _loc28_ + _loc30_ * _loc32_;
                  _loc16_[_loc27_ + 3] = _loc29_ + _loc30_ * _loc33_;
                  _loc16_[_loc27_ + 4] = _loc28_ + _loc31_ * _loc34_;
                  _loc16_[_loc27_ + 5] = _loc29_ + _loc31_ * _loc35_;
                  _loc16_[_loc27_ + 6] = _loc28_ + _loc30_ * _loc32_ + _loc31_ * _loc34_;
                  _loc16_[_loc27_ + 7] = _loc29_ + _loc30_ * _loc33_ + _loc31_ * _loc35_;
                  _loc20_[_loc26_] = _loc25_;
                  _loc20_[_loc26_ + 1] = _loc20_[_loc26_ + 3] = 1 + _loc25_;
                  _loc20_[_loc26_ + 2] = _loc20_[_loc26_ + 5] = 2 + _loc25_;
                  _loc20_[_loc26_ + 4] = 3 + _loc25_;
                  if(_loc6_ != null)
                  {
                     _loc36_ = FlashGraphics.tileRect.x / _loc6_.width;
                     _loc37_ = FlashGraphics.tileRect.y / _loc6_.height;
                     _loc38_ = FlashGraphics.tileRect.right / _loc6_.width;
                     _loc39_ = FlashGraphics.tileRect.bottom / _loc6_.height;
                     _loc24_[_loc27_] = _loc24_[_loc27_ + 4] = _loc36_;
                     _loc24_[_loc27_ + 1] = _loc24_[_loc27_ + 3] = _loc37_;
                     _loc24_[_loc27_ + 2] = _loc24_[_loc27_ + 6] = _loc38_;
                     _loc24_[_loc27_ + 5] = _loc24_[_loc27_ + 7] = _loc39_;
                  }
                  _loc25_ += 4;
                  _loc26_ += 6;
                  _loc27_ += 8;
               }
            }
         }
         if(_loc6_ != null)
         {
            param1.drawTriangles(_loc16_,_loc20_,_loc24_);
         }
         else
         {
            param1.drawTriangles(_loc16_,_loc20_);
         }
      }
   }
}

import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import openfl.utils._Dictionary.Dictionary_Impl_;

