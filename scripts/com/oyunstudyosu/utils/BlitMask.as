package com.oyunstudyosu.utils
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   
   public class BlitMask extends Sprite
   {
      
      public static var version:Number = 0.62;
      
      protected static var _tempContainer:Sprite = new Sprite();
      
      protected static var _sliceRect:Rectangle = new Rectangle();
      
      protected static var _drawRect:Rectangle = new Rectangle();
      
      protected static var _destPoint:Point = new Point();
      
      protected static var _tempMatrix:Matrix = new Matrix();
      
      protected static var _emptyArray:Array = [];
      
      protected static var _colorTransform:ColorTransform = new ColorTransform();
      
      protected static var _mouseEvents:Array = [MouseEvent.CLICK,MouseEvent.DOUBLE_CLICK,MouseEvent.MOUSE_DOWN,MouseEvent.MOUSE_MOVE,MouseEvent.MOUSE_OUT,MouseEvent.MOUSE_OVER,MouseEvent.MOUSE_UP,MouseEvent.MOUSE_WHEEL,MouseEvent.ROLL_OUT,MouseEvent.ROLL_OVER,"gesturePressAndTap","gesturePan","gestureRotate","gestureSwipe","gestureZoom","gestureTwoFingerTap","touchBegin","touchEnd","touchMove","touchOut","touchOver","touchRollOut","touchRollOver","touchTap"];
      
      protected var _target:DisplayObject;
      
      protected var _fillColor:uint;
      
      protected var _smoothing:Boolean;
      
      protected var _width:Number;
      
      protected var _height:Number;
      
      protected var _bd:BitmapData;
      
      protected var _gridSize:int = 2879;
      
      protected var _grid:Array;
      
      protected var _bounds:Rectangle;
      
      protected var _clipRect:Rectangle;
      
      protected var _bitmapMode:Boolean;
      
      protected var _rows:int;
      
      protected var _columns:int;
      
      protected var _scaleX:Number;
      
      protected var _scaleY:Number;
      
      protected var _prevMatrix:Matrix;
      
      protected var _transform:Transform;
      
      protected var _prevRotation:Number;
      
      protected var _autoUpdate:Boolean;
      
      protected var _wrap:Boolean;
      
      protected var _wrapOffsetX:Number = 0;
      
      protected var _wrapOffsetY:Number = 0;
      
      public function BlitMask(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 100, param5:Number = 100, param6:Boolean = false, param7:Boolean = false, param8:uint = 0, param9:Boolean = false)
      {
         super();
         if(param4 < 0 || param5 < 0)
         {
            throw new Error("A FlexBlitMask cannot have a negative width or height.");
         }
         this._width = param4;
         this._height = param5;
         this._scaleX = this._scaleY = 1;
         this._smoothing = param6;
         this._fillColor = param8;
         this._autoUpdate = param7;
         this._wrap = param9;
         this._grid = [];
         this._bounds = new Rectangle();
         if(this._smoothing)
         {
            super.x = param2;
            super.y = param3;
         }
         else
         {
            super.x = param2 < 0 ? param2 - 0.5 >> 0 : param2 + 0.5 >> 0;
            super.y = param3 < 0 ? param3 - 0.5 >> 0 : param3 + 0.5 >> 0;
         }
         this._clipRect = new Rectangle(0,0,this._gridSize + 1,this._gridSize + 1);
         this._bd = new BitmapData(param4 + 1,param5 + 1,true,this._fillColor);
         this._bitmapMode = true;
         this.target = param1;
      }
      
      protected function _captureTargetBitmap() : void
      {
         var _loc10_:BitmapData = null;
         var _loc11_:Number = NaN;
         var _loc13_:int = 0;
         if(this._bd == null || this._target == null)
         {
            return;
         }
         this._disposeGrid();
         var _loc1_:DisplayObject = this._target.mask;
         if(_loc1_ != null)
         {
            this._target.mask = null;
         }
         var _loc2_:Rectangle = this._target.scrollRect;
         if(_loc2_ != null)
         {
            this._target.scrollRect = null;
         }
         var _loc3_:Array = this._target.filters;
         if(_loc3_.length != 0)
         {
            this._target.filters = _emptyArray;
         }
         this._grid = [];
         if(this._target.parent == null)
         {
            _tempContainer.addChild(this._target);
         }
         this._bounds = this._target.getBounds(this._target.parent);
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         this._columns = Math.ceil(this._bounds.width / this._gridSize);
         this._rows = Math.ceil(this._bounds.height / this._gridSize);
         var _loc6_:Number = 0;
         var _loc7_:Matrix = this._transform.matrix;
         var _loc8_:Number = _loc7_.tx - this._bounds.x;
         var _loc9_:Number = _loc7_.ty - this._bounds.y;
         if(!this._smoothing)
         {
            _loc8_ = _loc8_ + 0.5 >> 0;
            _loc9_ = _loc9_ + 0.5 >> 0;
         }
         var _loc12_:int = 0;
         while(_loc12_ < this._rows)
         {
            _loc5_ = this._bounds.height - _loc6_ > this._gridSize ? this._gridSize : this._bounds.height - _loc6_;
            _loc7_.ty = -_loc6_ + _loc9_;
            _loc11_ = 0;
            this._grid[_loc12_] = [];
            _loc13_ = 0;
            while(_loc13_ < this._columns)
            {
               _loc4_ = this._bounds.width - _loc11_ > this._gridSize ? this._gridSize : this._bounds.width - _loc11_;
               this._grid[_loc12_][_loc13_] = _loc10_ = new BitmapData(_loc4_ + 1,_loc5_ + 1,true,this._fillColor);
               _loc7_.tx = -_loc11_ + _loc8_;
               _loc10_.draw(this._target,_loc7_,null,null,this._clipRect,this._smoothing);
               _loc11_ += _loc4_;
               _loc13_++;
            }
            _loc6_ += _loc5_;
            _loc12_++;
         }
         if(this._target.parent == _tempContainer)
         {
            _tempContainer.removeChild(this._target);
         }
         if(_loc1_ != null)
         {
            this._target.mask = _loc1_;
         }
         if(_loc2_ != null)
         {
            this._target.scrollRect = _loc2_;
         }
         if(_loc3_.length != 0)
         {
            this._target.filters = _loc3_;
         }
      }
      
      protected function _disposeGrid() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc1_:int = int(this._grid.length);
         while(--_loc1_ > -1)
         {
            _loc3_ = this._grid[_loc1_];
            _loc2_ = int(_loc3_.length);
            while(--_loc2_ > -1)
            {
               BitmapData(_loc3_[_loc2_]).dispose();
            }
         }
      }
      
      public function update(param1:Event = null, param2:Boolean = false) : void
      {
         var _loc3_:Matrix = null;
         if(this._bd == null)
         {
            return;
         }
         if(this._target == null)
         {
            this._render();
         }
         else if(this._target.parent)
         {
            this._bounds = this._target.getBounds(this._target.parent);
            if(this.parent != this._target.parent)
            {
               this._target.parent.addChildAt(this,this._target.parent.getChildIndex(this._target));
            }
         }
         if(this._bitmapMode || param2)
         {
            _loc3_ = this._transform.matrix;
            if(param2 || this._prevMatrix == null || _loc3_.a != this._prevMatrix.a || _loc3_.b != this._prevMatrix.b || _loc3_.c != this._prevMatrix.c || _loc3_.d != this._prevMatrix.d)
            {
               this._captureTargetBitmap();
               this._render();
            }
            else if(_loc3_.tx != this._prevMatrix.tx || _loc3_.ty != this._prevMatrix.ty)
            {
               this._render();
            }
            else if(this._bitmapMode && this._target != null)
            {
               this.filters = this._target.filters;
               this.transform.colorTransform = this._transform.colorTransform;
            }
            this._prevMatrix = _loc3_;
         }
      }
      
      protected function _render(param1:Number = 0, param2:Number = 0, param3:Boolean = true, param4:Boolean = false) : void
      {
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:int = 0;
         var _loc19_:BitmapData = null;
         if(param3)
         {
            _sliceRect.x = _sliceRect.y = 0;
            _sliceRect.width = this._width + 1;
            _sliceRect.height = this._height + 1;
            this._bd.fillRect(_sliceRect,this._fillColor);
            if(this._bitmapMode && this._target != null)
            {
               this.filters = this._target.filters;
               this.transform.colorTransform = this._transform.colorTransform;
            }
            else
            {
               this.filters = _emptyArray;
               this.transform.colorTransform = _colorTransform;
            }
         }
         if(this._bd == null)
         {
            return;
         }
         if(this._rows == 0)
         {
            this._captureTargetBitmap();
         }
         var _loc5_:Number = super.x + param1;
         var _loc6_:Number = super.y + param2;
         var _loc7_:* = this._bounds.width + this._wrapOffsetX + 0.5 >> 0;
         var _loc8_:* = this._bounds.height + this._wrapOffsetY + 0.5 >> 0;
         var _loc9_:Graphics = this.graphics;
         if(this._bounds.width == 0 || this._bounds.height == 0 || this._wrap && (_loc7_ == 0 || _loc8_ == 0) || !this._wrap && (_loc5_ + this._width < this._bounds.x || _loc6_ + this._height < this._bounds.y || _loc5_ > this._bounds.right || _loc6_ > this._bounds.bottom))
         {
            _loc9_.clear();
            _loc9_.beginBitmapFill(this._bd);
            _loc9_.drawRect(0,0,this._width,this._height);
            _loc9_.endFill();
            return;
         }
         var _loc10_:int = int((_loc5_ - this._bounds.x) / this._gridSize);
         if(_loc10_ < 0)
         {
            _loc10_ = 0;
         }
         var _loc11_:int = int((_loc6_ - this._bounds.y) / this._gridSize);
         if(_loc11_ < 0)
         {
            _loc11_ = 0;
         }
         var _loc12_:int = int((_loc5_ + this._width - this._bounds.x) / this._gridSize);
         if(_loc12_ >= this._columns)
         {
            _loc12_ = this._columns - 1;
         }
         var _loc13_:uint = uint(int((_loc6_ + this._height - this._bounds.y) / this._gridSize));
         if(_loc13_ >= this._rows)
         {
            _loc13_ = uint(this._rows - 1);
         }
         var _loc14_:Number = (this._bounds.x - _loc5_) % 1;
         var _loc15_:Number = (this._bounds.y - _loc6_) % 1;
         if(_loc6_ <= this._bounds.y)
         {
            _destPoint.y = this._bounds.y - _loc6_ >> 0;
            _sliceRect.y = -1;
         }
         else
         {
            _destPoint.y = 0;
            _sliceRect.y = Math.ceil(_loc6_ - this._bounds.y) - _loc11_ * this._gridSize - 1;
            if(param3 && _loc15_ != 0)
            {
               _loc15_ += 1;
            }
         }
         if(_loc5_ <= this._bounds.x)
         {
            _destPoint.x = this._bounds.x - _loc5_ >> 0;
            _sliceRect.x = -1;
         }
         else
         {
            _destPoint.x = 0;
            _sliceRect.x = Math.ceil(_loc5_ - this._bounds.x) - _loc10_ * this._gridSize - 1;
            if(param3 && _loc14_ != 0)
            {
               _loc14_ += 1;
            }
         }
         if(this._wrap && param3)
         {
            this._render(Math.ceil((this._bounds.x - _loc5_) / _loc7_) * _loc7_,Math.ceil((this._bounds.y - _loc6_) / _loc8_) * _loc8_,false,false);
         }
         else if(this._rows != 0)
         {
            _loc16_ = _destPoint.x;
            _loc17_ = _sliceRect.x;
            _loc18_ = _loc10_;
            while(_loc11_ <= _loc13_)
            {
               _loc19_ = this._grid[_loc11_][0];
               _sliceRect.height = _loc19_.height - _sliceRect.y;
               _destPoint.x = _loc16_;
               _sliceRect.x = _loc17_;
               _loc10_ = _loc18_;
               while(_loc10_ <= _loc12_)
               {
                  _loc19_ = this._grid[_loc11_][_loc10_];
                  _sliceRect.width = _loc19_.width - _sliceRect.x;
                  this._bd.copyPixels(_loc19_,_sliceRect,_destPoint);
                  _destPoint.x += _sliceRect.width - 1;
                  _sliceRect.x = 0;
                  _loc10_++;
               }
               _destPoint.y += _sliceRect.height - 1;
               _sliceRect.y = 0;
               _loc11_++;
            }
         }
         if(param3)
         {
            _tempMatrix.tx = _loc14_ - 1;
            _tempMatrix.ty = _loc15_ - 1;
            _loc9_.clear();
            _loc9_.beginBitmapFill(this._bd,_tempMatrix,false,this._smoothing);
            _loc9_.drawRect(0,0,this._width,this._height);
            _loc9_.endFill();
         }
         else if(this._wrap)
         {
            if(_loc5_ + this._width > this._bounds.right)
            {
               this._render(param1 - _loc7_,param2,false,true);
            }
            if(!param4 && _loc6_ + this._height > this._bounds.bottom)
            {
               this._render(param1,param2 - _loc8_,false,false);
            }
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(this._width == param1 && this._height == param2)
         {
            return;
         }
         if(param1 < 0 || param2 < 0)
         {
            throw new Error("A BlitMask cannot have a negative width or height.");
         }
         if(this._bd != null)
         {
            this._bd.dispose();
         }
         this._width = param1;
         this._height = param2;
         this._bd = new BitmapData(param1 + 1,param2 + 1,true,this._fillColor);
         this._render();
      }
      
      protected function _mouseEventPassthrough(param1:Event) : void
      {
         if(this.mouseEnabled && (!this._bitmapMode || param1 is MouseEvent && this.hitTestPoint(MouseEvent(param1).stageX,MouseEvent(param1).stageY,false)))
         {
            dispatchEvent(param1);
         }
      }
      
      public function enableBitmapMode(param1:Event = null) : void
      {
         this.bitmapMode = true;
      }
      
      public function disableBitmapMode(param1:Event = null) : void
      {
         this.bitmapMode = false;
      }
      
      public function normalizePosition() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(Boolean(this._target) && Boolean(this._bounds))
         {
            _loc1_ = this._bounds.width + this._wrapOffsetX + 0.5 >> 0;
            _loc2_ = this._bounds.height + this._wrapOffsetY + 0.5 >> 0;
            _loc3_ = (this._bounds.x - this.x) % _loc1_;
            _loc4_ = (this._bounds.y - this.y) % _loc2_;
            if(_loc3_ > (this._width + this._wrapOffsetX) / 2)
            {
               _loc3_ -= _loc1_;
            }
            else if(_loc3_ < (this._width + this._wrapOffsetX) / -2)
            {
               _loc3_ += _loc1_;
            }
            if(_loc4_ > (this._height + this._wrapOffsetY) / 2)
            {
               _loc4_ -= _loc2_;
            }
            else if(_loc4_ < (this._height + this._wrapOffsetY) / -2)
            {
               _loc4_ += _loc2_;
            }
            this._target.x += this.x + _loc3_ - this._bounds.x;
            this._target.y += this.y + _loc4_ - this._bounds.y;
         }
      }
      
      public function dispose() : void
      {
         if(this._bd == null)
         {
            return;
         }
         this._disposeGrid();
         this._bd.dispose();
         this._bd = null;
         this.bitmapMode = false;
         this.autoUpdate = false;
         if(this._target != null)
         {
            this._target.mask = null;
         }
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         this.target = null;
      }
      
      public function get bitmapMode() : Boolean
      {
         return this._bitmapMode;
      }
      
      public function set bitmapMode(param1:Boolean) : void
      {
         if(this._bitmapMode != param1)
         {
            this._bitmapMode = param1;
            if(this._target != null)
            {
               this._target.visible = !this._bitmapMode;
               this.update(null);
               if(this._bitmapMode)
               {
                  this.filters = this._target.filters;
                  this.transform.colorTransform = this._transform.colorTransform;
                  this.blendMode = this._target.blendMode;
                  this._target.mask = null;
               }
               else
               {
                  this.filters = _emptyArray;
                  this.transform.colorTransform = _colorTransform;
                  this.blendMode = "normal";
                  this.cacheAsBitmap = false;
                  this._target.mask = this;
                  if(this._wrap)
                  {
                     this.normalizePosition();
                  }
               }
               if(this._bitmapMode && this._autoUpdate)
               {
                  this.addEventListener(Event.ENTER_FRAME,this.update,false,-10,true);
               }
               else
               {
                  this.removeEventListener(Event.ENTER_FRAME,this.update);
               }
            }
         }
      }
      
      public function get autoUpdate() : Boolean
      {
         return this._autoUpdate;
      }
      
      public function set autoUpdate(param1:Boolean) : void
      {
         if(this._autoUpdate != param1)
         {
            this._autoUpdate = param1;
            if(this._bitmapMode && this._autoUpdate)
            {
               this.addEventListener(Event.ENTER_FRAME,this.update,false,-10,true);
            }
            else
            {
               this.removeEventListener(Event.ENTER_FRAME,this.update);
            }
         }
      }
      
      public function get target() : DisplayObject
      {
         return this._target;
      }
      
      public function set target(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         if(this._target != param1)
         {
            _loc2_ = int(_mouseEvents.length);
            if(this._target != null)
            {
               while(--_loc2_ > -1)
               {
                  this._target.removeEventListener(_mouseEvents[_loc2_],this._mouseEventPassthrough);
               }
            }
            this._target = param1;
            if(this._target != null)
            {
               _loc2_ = int(_mouseEvents.length);
               while(--_loc2_ > -1)
               {
                  this._target.addEventListener(_mouseEvents[_loc2_],this._mouseEventPassthrough,false,0,true);
               }
               this._prevMatrix = null;
               this._transform = this._target.transform;
               this._bitmapMode = !this._bitmapMode;
               this.bitmapMode = !this._bitmapMode;
            }
            else
            {
               this._bounds = new Rectangle();
            }
         }
      }
      
      override public function get x() : Number
      {
         return super.x;
      }
      
      override public function set x(param1:Number) : void
      {
         if(this._smoothing)
         {
            super.x = param1;
         }
         else if(param1 >= 0)
         {
            super.x = param1 + 0.5 >> 0;
         }
         else
         {
            super.x = param1 - 0.5 >> 0;
         }
         if(this._bitmapMode)
         {
            this._render();
         }
      }
      
      override public function get y() : Number
      {
         return super.y;
      }
      
      override public function set y(param1:Number) : void
      {
         if(this._smoothing)
         {
            super.y = param1;
         }
         else if(param1 >= 0)
         {
            super.y = param1 + 0.5 >> 0;
         }
         else
         {
            super.y = param1 - 0.5 >> 0;
         }
         if(this._bitmapMode)
         {
            this._render();
         }
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1,this._height);
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this._width,param1);
      }
      
      override public function get scaleX() : Number
      {
         return 1;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         var _loc2_:Number = this._scaleX;
         this._scaleX = param1;
         this.setSize(this._width * (this._scaleX / _loc2_),this._height);
      }
      
      override public function get scaleY() : Number
      {
         return 1;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         var _loc2_:Number = this._scaleY;
         this._scaleY = param1;
         this.setSize(this._width,this._height * (this._scaleY / _loc2_));
      }
      
      override public function set rotation(param1:Number) : void
      {
         if(param1 != 0)
         {
            throw new Error("Cannot set the rotation of a BlitMask to a non-zero number. BlitMasks should remain unrotated.");
         }
      }
      
      public function get scrollX() : Number
      {
         return (super.x - this._bounds.x) / (this._bounds.width - this._width);
      }
      
      public function set scrollX(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._target != null && Boolean(this._target.parent))
         {
            this._bounds = this._target.getBounds(this._target.parent);
            _loc2_ = super.x - (this._bounds.width - this._width) * param1 - this._bounds.x;
            this._target.x += _loc2_;
            this._bounds.x += _loc2_;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get scrollY() : Number
      {
         return (super.y - this._bounds.y) / (this._bounds.height - this._height);
      }
      
      public function set scrollY(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._target != null && Boolean(this._target.parent))
         {
            this._bounds = this._target.getBounds(this._target.parent);
            _loc2_ = super.y - (this._bounds.height - this._height) * param1 - this._bounds.y;
            this._target.y += _loc2_;
            this._bounds.y += _loc2_;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get smoothing() : Boolean
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:Boolean) : void
      {
         if(this._smoothing != param1)
         {
            this._smoothing = param1;
            this._captureTargetBitmap();
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get fillColor() : uint
      {
         return this._fillColor;
      }
      
      public function set fillColor(param1:uint) : void
      {
         if(this._fillColor != param1)
         {
            this._fillColor = param1;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get wrap() : Boolean
      {
         return this._wrap;
      }
      
      public function set wrap(param1:Boolean) : void
      {
         if(this._wrap != param1)
         {
            this._wrap = param1;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get wrapOffsetX() : Number
      {
         return this._wrapOffsetX;
      }
      
      public function set wrapOffsetX(param1:Number) : void
      {
         if(this._wrapOffsetX != param1)
         {
            this._wrapOffsetX = param1;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
      
      public function get wrapOffsetY() : Number
      {
         return this._wrapOffsetY;
      }
      
      public function set wrapOffsetY(param1:Number) : void
      {
         if(this._wrapOffsetY != param1)
         {
            this._wrapOffsetY = param1;
            if(this._bitmapMode)
            {
               this._render();
            }
         }
      }
   }
}

