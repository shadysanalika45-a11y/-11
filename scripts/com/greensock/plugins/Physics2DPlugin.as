package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.SimpleTimeline;
   import flash.display.DisplayObject;
   
   public class Physics2DPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      private static const _DEG2RAD:Number = Math.PI / 180;
      
      protected var _tween:TweenLite;
      
      protected var _target:DisplayObject;
      
      protected var _x:Physics2DProp;
      
      protected var _y:Physics2DProp;
      
      protected var _skipX:Boolean;
      
      protected var _skipY:Boolean;
      
      protected var _friction:Number = 1;
      
      protected var _step:uint;
      
      protected var _stepsPerTimeUnit:uint = 30;
      
      public function Physics2DPlugin()
      {
         super();
         this.propName = "physics2D";
         this.overwriteProps = ["x","y"];
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!(param1 is DisplayObject))
         {
            trace("Tween Error: physics2D requires that the target be a DisplayObject.");
            return false;
         }
         this._target = DisplayObject(param1);
         this._tween = param3;
         this._step = 0;
         var _loc4_:SimpleTimeline = this._tween.timeline;
         while(_loc4_.timeline)
         {
            _loc4_ = _loc4_.timeline;
         }
         if(_loc4_ == TweenLite.rootFramesTimeline)
         {
            this._stepsPerTimeUnit = 1;
         }
         var _loc5_:Number = Number(Number(param2.angle) || 0);
         var _loc6_:Number = Number(Number(param2.velocity) || 0);
         var _loc7_:Number = Number(Number(param2.acceleration) || 0);
         var _loc8_:Number = Boolean(param2.accelerationAngle) || param2.accelerationAngle == 0 ? Number(param2.accelerationAngle) : _loc5_;
         if(param2.gravity)
         {
            _loc7_ = Number(param2.gravity);
            _loc8_ = 90;
         }
         _loc5_ *= _DEG2RAD;
         _loc8_ *= _DEG2RAD;
         if(param2.friction)
         {
            this._friction = 1 - Number(param2.friction);
         }
         this._x = new Physics2DProp(this._target.x,Math.cos(_loc5_) * _loc6_,Math.cos(_loc8_) * _loc7_,this._stepsPerTimeUnit);
         this._y = new Physics2DProp(this._target.y,Math.sin(_loc5_) * _loc6_,Math.sin(_loc8_) * _loc7_,this._stepsPerTimeUnit);
         return true;
      }
      
      override public function killProps(param1:Object) : void
      {
         if("x" in param1)
         {
            this._skipX = true;
         }
         if("y" in param1)
         {
            this._skipY = true;
         }
         super.killProps(param1);
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc2_:Number = this._tween.cachedTime;
         if(this._friction == 1)
         {
            _loc5_ = _loc2_ * _loc2_ * 0.5;
            _loc3_ = this._x.start + (this._x.velocity * _loc2_ + this._x.acceleration * _loc5_);
            _loc4_ = this._y.start + (this._y.velocity * _loc2_ + this._y.acceleration * _loc5_);
         }
         else
         {
            _loc6_ = int(_loc2_ * this._stepsPerTimeUnit) - this._step;
            _loc7_ = _loc2_ * this._stepsPerTimeUnit % 1;
            if(_loc6_ >= 0)
            {
               _loc8_ = _loc6_;
               while(_loc8_--)
               {
                  this._x.v += this._x.a;
                  this._y.v += this._y.a;
                  this._x.v *= this._friction;
                  this._y.v *= this._friction;
                  this._x.value += this._x.v;
                  this._y.value += this._y.v;
               }
            }
            else
            {
               _loc8_ = -_loc6_;
               while(_loc8_--)
               {
                  this._x.value -= this._x.v;
                  this._y.value -= this._y.v;
                  this._x.v /= this._friction;
                  this._y.v /= this._friction;
                  this._x.v -= this._x.a;
                  this._y.v -= this._y.a;
               }
            }
            _loc3_ = this._x.value + this._x.v * _loc7_;
            _loc4_ = this._y.value + this._y.v * _loc7_;
            this._step += _loc6_;
         }
         if(this.round)
         {
            if(_loc3_ > 0)
            {
               _loc3_ = _loc3_ + 0.5 >> 0;
            }
            else
            {
               _loc3_ = _loc3_ - 0.5 >> 0;
            }
            if(_loc4_ > 0)
            {
               _loc4_ = _loc4_ + 0.5 >> 0;
            }
            else
            {
               _loc4_ = _loc4_ - 0.5 >> 0;
            }
         }
         if(!this._skipX)
         {
            this._target.x = _loc3_;
         }
         if(!this._skipY)
         {
            this._target.y = _loc4_;
         }
      }
   }
}

class Physics2DProp
{
   
   public var start:Number;
   
   public var velocity:Number;
   
   public var v:Number;
   
   public var a:Number;
   
   public var value:Number;
   
   public var acceleration:Number;
   
   public function Physics2DProp(param1:Number, param2:Number, param3:Number, param4:uint)
   {
      super();
      this.start = this.value = param1;
      this.velocity = param2;
      this.v = this.velocity / param4;
      if(Boolean(param3) || param3 == 0)
      {
         this.acceleration = param3;
         this.a = this.acceleration / (param4 * param4);
      }
      else
      {
         this.acceleration = this.a = 0;
      }
   }
}
