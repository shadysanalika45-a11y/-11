package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.layout.LiquidStage;
   import com.greensock.layout.PinPoint;
   import com.greensock.layout.core.LiquidData;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class LiquidPositionPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected var _tween:TweenLite;
      
      protected var _target:DisplayObject;
      
      protected var _prevFactor:Number;
      
      protected var _prevTime:Number;
      
      protected var _xStart:Number;
      
      protected var _yStart:Number;
      
      protected var _xOffset:Number;
      
      protected var _yOffset:Number;
      
      protected var _data:LiquidData;
      
      protected var _ignoreX:Boolean;
      
      protected var _ignoreY:Boolean;
      
      public function LiquidPositionPlugin()
      {
         super();
         this.propName = "liquidPosition";
         this.overwriteProps = [];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is DisplayObject))
         {
            throw Error("Tween Error: liquidPosition requires that the target be a DisplayObject.");
         }
         if(!("pin" in param2) || !(param2.pin is PinPoint))
         {
            throw Error("Tween Error: liquidPosition requires a valid \'pin\' property which must be a PinPoint.");
         }
         this._target = DisplayObject(param1);
         this._tween = param3;
         this._prevFactor = this._tween.ratio;
         this._prevTime = this._tween.cachedTime;
         this._ignoreX = Boolean(param2.ignoreX == true);
         this._ignoreY = Boolean(param2.ignoreY == true);
         this._data = PinPoint(param2.pin).data;
         this._xStart = this._target.x;
         this._yStart = this._target.y;
         var _loc4_:LiquidStage = this._data.liquidStage;
         var _loc5_:Boolean = Boolean(param2.reconcile != false);
         if(_loc5_)
         {
            _loc4_.retroMode = true;
         }
         var _loc6_:Point = this._target.parent.globalToLocal(this._data.global);
         this._xOffset = "x" in param2 ? param2.x - _loc6_.x : 0;
         if(!this._ignoreX)
         {
            this.overwriteProps[this.overwriteProps.length] = "x";
         }
         this._yOffset = "y" in param2 ? param2.y - _loc6_.y : 0;
         if(!this._ignoreY)
         {
            this.overwriteProps[this.overwriteProps.length] = "y";
         }
         if(_loc5_)
         {
            _loc4_.retroMode = false;
         }
         return true;
      }
      
      override public function killProps(param1:Object) : void
      {
         if("x" in param1)
         {
            this._ignoreX = true;
         }
         if("y" in param1)
         {
            this._ignoreY = true;
         }
         super.killProps(param1);
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         if(param1 != this._prevFactor)
         {
            _loc3_ = this._target.parent.globalToLocal(this._data.global);
            _loc3_.x += this._xOffset;
            _loc3_.y += this._yOffset;
            if(this._tween.cachedTime > this._prevTime)
            {
               _loc2_ = param1 == 1 || this._prevFactor == 1 ? 0 : 1 - (param1 - this._prevFactor) / (1 - this._prevFactor);
               if(!this._ignoreX)
               {
                  this._target.x = _loc3_.x - (_loc3_.x - this._target.x) * _loc2_;
               }
               if(!this._ignoreY)
               {
                  this._target.y = _loc3_.y - (_loc3_.y - this._target.y) * _loc2_;
               }
            }
            else
            {
               _loc2_ = param1 == 0 || this._prevFactor == 0 ? 0 : 1 - (param1 - this._prevFactor) / -this._prevFactor;
               if(!this._ignoreX)
               {
                  this._target.x = this._xStart + (this._target.x - this._xStart) * _loc2_;
               }
               if(!this._ignoreY)
               {
                  this._target.y = this._yStart + (this._target.y - this._yStart) * _loc2_;
               }
            }
            this._prevFactor = param1;
         }
         this._prevTime = this._tween.cachedTime;
      }
   }
}

