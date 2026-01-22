package com.greensock.layout
{
   import com.greensock.TweenLite;
   import com.greensock.layout.core.LiquidData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class LiquidArea extends AutoFitArea
   {
      
      public static const version:Number = 2.53;
      
      protected var _liquidStage:LiquidStage;
      
      protected var _topLeftPin:PinPoint;
      
      protected var _bottomRightPin:PinPoint;
      
      protected var _tlData:LiquidData;
      
      protected var _brData:LiquidData;
      
      protected var _tlPrev:Point;
      
      protected var _brPrev:Point;
      
      protected var _tween:TweenLite;
      
      protected var _originalTween:TweenLite;
      
      protected var _wOffset:Number;
      
      protected var _hOffset:Number;
      
      protected var _data:LiquidData;
      
      protected var _strictMode:Boolean;
      
      protected var _strictDifTL:Point;
      
      protected var _strictDifBR:Point;
      
      public var minWidth:Number;
      
      public var minHeight:Number;
      
      public var maxWidth:Number;
      
      public var maxHeight:Number;
      
      public function LiquidArea(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint = 16711680, param7:Number = 0, param8:Number = 0, param9:Number = 99999999, param10:Number = 99999999, param11:Boolean = true, param12:LiquidStage = null, param13:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6);
         this._wOffset = this._hOffset = 0;
         this.minWidth = param7;
         this.minHeight = param8;
         this.maxWidth = param9;
         this.maxHeight = param10;
         this._liquidStage = param12;
         this._strictMode = param13;
         if(param11)
         {
            if(_parent.stage)
            {
               this.autoPinCorners(null);
            }
            else
            {
               _parent.addEventListener(Event.ADDED_TO_STAGE,this.autoPinCorners);
            }
         }
      }
      
      public static function createAround(param1:DisplayObject, param2:Object = null, ... rest) : LiquidArea
      {
         if(param2 == null || typeof param2 == "string")
         {
            param2 = {
               "scaleMode":param2 || "proportionalInside",
               "hAlign":rest[0] || "center",
               "vAlign":rest[1] || "center",
               "crop":Boolean(rest[2]),
               "minWidth":rest[4] || 0,
               "minHeight":rest[5] || 0,
               "maxWidth":(isNaN(rest[6]) ? 999999999 : rest[6]),
               "maxHeight":(isNaN(rest[7]) ? 999999999 : rest[7]),
               "autoPinCorners":Boolean(rest[8] != false),
               "calculateVisible":Boolean(rest[9]),
               "liquidStage":rest[10] || LiquidStage.getByStage(param1.stage),
               "reconcile":Boolean(rest[11] != false),
               "strict":Boolean(rest[12])
            };
         }
         var _loc4_:LiquidStage = param2.liquidStage || LiquidStage.getByStage(param1.stage);
         var _loc5_:Boolean = Boolean(param2.reconcile != false && !_loc4_.isBaseSize && !_loc4_.retroMode);
         if(_loc5_)
         {
            _loc4_.retroMode = true;
         }
         var _loc6_:DisplayObject = param2.customBoundsTarget is DisplayObject ? param2.customBoundsTarget : param1;
         var _loc7_:Rectangle = param2.calculateVisible == true ? getVisibleBounds(_loc6_,param1.parent) : _loc6_.getBounds(param1.parent);
         var _loc8_:uint = isNaN(rest[3]) ? ("previewColor" in param2 ? uint(param2.previewColor) : 16711680) : uint(rest[3]);
         var _loc9_:LiquidArea = new LiquidArea(param1.parent,_loc7_.x,_loc7_.y,_loc7_.width,_loc7_.height,_loc8_,Number(param2.minWidth) || 0,Number(param2.minHeight) || 0,"maxWidth" in param2 ? Number(param2.maxWidth) : 999999999,"maxHeight" in param2 ? Number(param2.maxHeight) : 999999999,Boolean(param2.autoPinCorners != false),_loc4_,Boolean(param2.strict));
         _loc9_.attach(param1,param2);
         if(_loc5_)
         {
            _loc4_.retroMode = false;
         }
         return _loc9_;
      }
      
      protected function autoPinCorners(param1:Event = null) : void
      {
         if(param1)
         {
            _parent.removeEventListener(Event.ADDED_TO_STAGE,this.autoPinCorners);
         }
         if(this._liquidStage == null)
         {
            this._liquidStage = LiquidStage.getByStage(_parent.stage);
         }
         if(Boolean(this._liquidStage) && this._topLeftPin == null)
         {
            this.pinCorners(this._liquidStage.TOP_LEFT,this._liquidStage.BOTTOM_RIGHT,true,0,null,this._strictMode);
         }
      }
      
      public function pinCorners(param1:PinPoint, param2:PinPoint, param3:Boolean = true, param4:Number = 0, param5:Object = null, param6:Boolean = false) : void
      {
         var _loc8_:Point = null;
         if(this._liquidStage == null)
         {
            this._liquidStage = LiquidStage.getByStage(_parent.stage);
         }
         var _loc7_:Boolean = Boolean(param3 && !this._liquidStage.isBaseSize && !this._liquidStage.retroMode);
         if(_loc7_)
         {
            this._liquidStage.retroMode = true;
         }
         if(this._topLeftPin != null)
         {
            this._data.destroy(false);
            if(_tweenMode)
            {
               this._tween.kill();
            }
         }
         if(param4 > 0)
         {
            this._tween = this._originalTween = this.dynamicTween(param4,param5 || {});
            this._tween.setEnabled(false,false);
         }
         this._strictMode = param6;
         this._topLeftPin = param1;
         this._bottomRightPin = param2;
         this._liquidStage = this._topLeftPin.data.liquidStage;
         this._tlData = this._topLeftPin.data;
         this._brData = this._bottomRightPin.data;
         this.capturePinData();
         this._data = new LiquidData(this._topLeftPin,this,3,this._liquidStage,false,0,null,false);
         LiquidData.addCacheData(this._liquidStage,this._data);
         if(this._strictMode)
         {
            _loc8_ = this._topLeftPin.toLocal(_parent);
            this._strictDifTL = new Point(this.x - _loc8_.x,this.y - _loc8_.y);
            _loc8_ = this._bottomRightPin.toLocal(_parent);
            this._strictDifBR = new Point(this.x + this.width - _loc8_.x,this.y + this.height - _loc8_.y);
         }
         if(_loc7_)
         {
            this._liquidStage.retroMode = false;
         }
      }
      
      override public function destroy() : void
      {
         if(this._topLeftPin)
         {
            this._data.destroy(false);
            this._topLeftPin = this._bottomRightPin = null;
         }
         this._liquidStage = null;
         super.destroy();
      }
      
      public function capturePinData() : void
      {
         this._tlPrev = _parent.globalToLocal(this._tlData.global);
         this._brPrev = _parent.globalToLocal(this._brData.global);
      }
      
      public function updatePins() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc5_:Point = _parent.globalToLocal(this._tlData.global);
         if(this._strictMode)
         {
            _loc1_ = int(_loc5_.x + this._strictDifTL.x) - int(this.x);
            _loc2_ = int(_loc5_.y + this._strictDifTL.y) - int(this.y);
            _loc5_ = _parent.globalToLocal(this._brData.global);
            _loc3_ = int(_loc5_.x + this._strictDifBR.x) - int(this.x + this.width) - _loc1_;
            _loc4_ = int(_loc5_.y + this._strictDifBR.y) - int(this.y + this.height) - _loc2_;
         }
         else
         {
            _loc1_ = int(_loc5_.x) - int(this._tlPrev.x);
            _loc2_ = int(_loc5_.y) - int(this._tlPrev.y);
            _loc5_ = _parent.globalToLocal(this._brData.global);
            _loc3_ = int(_loc5_.x) - int(this._brPrev.x) - _loc1_ - this._wOffset;
            _loc4_ = int(_loc5_.y) - int(this._brPrev.y) - _loc2_ - this._hOffset;
         }
         var _loc6_:Number = _tweenMode ? this._tween.vars.width + _loc3_ : this.width + _loc3_;
         if(_loc6_ < this.minWidth)
         {
            this._wOffset = this.minWidth - _loc6_;
         }
         else if(_loc6_ > this.maxWidth)
         {
            this._wOffset = this.maxWidth - _loc6_;
         }
         else
         {
            this._wOffset = 0;
         }
         _loc6_ += this._wOffset;
         var _loc7_:Number = _tweenMode ? this._tween.vars.height + _loc4_ : this.height + _loc4_;
         if(_loc7_ < this.minHeight)
         {
            this._hOffset = this.minHeight - _loc7_;
         }
         else if(_loc7_ > this.maxHeight)
         {
            this._hOffset = this.maxHeight - _loc7_;
         }
         else
         {
            this._hOffset = 0;
         }
         _loc7_ += this._hOffset;
         if(!(_loc1_ == 0 && _loc2_ == 0 && _loc3_ == 0 && _loc4_ == 0))
         {
            if(this._tween)
            {
               if(_tweenMode)
               {
                  this._tween.vars.x += _loc1_;
                  this._tween.vars.y += _loc2_;
               }
               else
               {
                  this._tween.vars.x = this.x + _loc1_;
                  this._tween.vars.y = this.y + _loc2_;
               }
               this._tween.vars.width = _loc6_;
               this._tween.vars.height = _loc7_;
               if(this._tween == this._originalTween)
               {
                  this._tween.invalidate();
                  this._tween.restart(true,true);
               }
               else
               {
                  _loc8_ = this._tween.currentTime;
                  this._tween.restart(false,true);
                  this._tween.invalidate();
                  this._tween.currentTime = _loc8_;
               }
               _tweenMode = true;
            }
            else
            {
               _loc9_ = _tweenMode;
               _tweenMode = true;
               this.x += _loc1_;
               this.y += _loc2_;
               this.width = _loc6_;
               this.height = _loc7_;
               _tweenMode = _loc9_;
               update();
            }
         }
      }
      
      protected function onTweenStart(param1:Object, param2:TweenLite) : void
      {
         _tweenMode = true;
         this._tween = param2;
         if(param1.onStart)
         {
            param1.onStart.apply(null,param1.onStartParams);
         }
      }
      
      protected function onTweenUpdate(param1:Object, param2:TweenLite) : void
      {
         update();
         if(param1.onUpdate)
         {
            param1.onUpdate.apply(null,param1.onUpdateParams);
         }
      }
      
      protected function onTweenComplete(param1:Object, param2:TweenLite) : void
      {
         _tweenMode = false;
         this._tween = this._originalTween;
         if(param1.onComplete)
         {
            param1.onComplete.apply(null,param1.onCompleteParams);
         }
      }
      
      public function dynamicTween(param1:Number, param2:Object) : TweenLite
      {
         var _loc4_:String = null;
         var _loc3_:Object = {};
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         if(!("x" in _loc3_))
         {
            _loc3_.x = this.x;
         }
         if(!("y" in _loc3_))
         {
            _loc3_.y = this.y;
         }
         if(!("width" in _loc3_))
         {
            _loc3_.width = this.width;
         }
         if(!("height" in _loc3_))
         {
            _loc3_.height = this.height;
         }
         _loc3_.overwrite = false;
         _loc3_.onStart = this.onTweenStart;
         _loc3_.onUpdate = this.onTweenUpdate;
         _loc3_.onComplete = this.onTweenComplete;
         _loc3_.onStartParams = _loc3_.onUpdateParams = _loc3_.onCompleteParams = [param2];
         var _loc5_:TweenLite = new TweenLite(this,param1,_loc3_);
         _loc3_.onStartParams[1] = _loc5_;
         return _loc5_;
      }
   }
}

