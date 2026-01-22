package org.oyunstudyosu.components.scrollBar
{
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.greensock.easing.Quint;
   import com.oyunstudyosu.utils.DrawUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1223")]
   public class CoreScrollBar extends CoreMovieClip
   {
      
      public static var HORIZONTAL:String = "horizontal";
      
      public static var VERTICAL:String = "vertical";
      
      private static var DECAY:Number = 0.5;
      
      private static var MOUSE_DOWN_DECAY:Number = 0.5;
      
      private static var SPEED_SPRINGNESS:Number = 0.3;
      
      private static var BOUNCING_SPRINGESS:Number = 0.1;
      
      private static var WHEEL_DIFFERENCE:Number = 50;
      
      private var _container:Sprite;
      
      private var _canvas:Sprite;
      
      private var _containerStartX:Number;
      
      private var _containerStartY:Number;
      
      private var _mouseDownX:Number;
      
      private var _mouseDownY:Number;
      
      private var _velocity:Number = 0;
      
      private var _mouseDownPoint:Point = new Point();
      
      private var _lastMouseDownPoint:Point = new Point();
      
      private var _mouseDown:Boolean = false;
      
      private var _mouseMove:Boolean = false;
      
      public var scrollBackground:ScrollBackgroundUI;
      
      public var bar:BarUI;
      
      public var barMask:Sprite;
      
      private var isScrolled:Boolean = false;
      
      private var _barColor:uint;
      
      private var _bgColor:uint;
      
      private var _direction:String;
      
      private var _snap:int = WHEEL_DIFFERENCE;
      
      private var _snapCount:int;
      
      private var _mode:Boolean = true;
      
      private var _containerW:int;
      
      private var _containerH:int;
      
      public function CoreScrollBar()
      {
         super();
         this.scrollBackground = new ScrollBackgroundUI();
         addChild(this.scrollBackground);
         this.barMask = DrawUtils.getRectangleSprite(this.scrollBackground.width,this.scrollBackground.height,0,0.5);
         addChild(this.barMask);
         this.bar = new BarUI();
         addChild(this.bar);
      }
      
      override public function added() : void
      {
      }
      
      public function get direction() : String
      {
         return this._direction;
      }
      
      public function set direction(param1:String) : void
      {
         this._direction = param1;
      }
      
      public function get snap() : int
      {
         return this._snap;
      }
      
      public function set snap(param1:int) : void
      {
         this._snap = param1;
      }
      
      public function get snapCount() : int
      {
         return this._snapCount;
      }
      
      public function set snapCount(param1:int) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this._snapCount = param1;
         if(this.direction == VERTICAL)
         {
            _loc2_ = param1 * this.snap / (this._containerH - this._canvas.height) * (this.barMask.height - this.bar.height);
            if(this.bar.y >= -10 && this.bar.y <= this.barMask.height - this.bar.height + 10)
            {
               TweenLite.to(this.bar,0.4,{
                  "y":_loc2_,
                  "overwrite":true,
                  "ease":Quint.easeOut
               });
            }
            else
            {
               TweenLite.to(this.bar,0,{
                  "y":_loc2_,
                  "overwrite":true,
                  "ease":Quint.easeOut
               });
            }
         }
         else if(this.direction == HORIZONTAL)
         {
            _loc3_ = param1 * this.snap / (this._containerW - this._canvas.width) * (this.barMask.width - this.bar.width);
            if(this.bar.x >= -10 && this.bar.x <= this.barMask.width - this.bar.width + 10)
            {
               TweenLite.to(this.bar,0.4,{
                  "x":_loc3_,
                  "overwrite":true,
                  "ease":Quint.easeOut
               });
            }
            else
            {
               TweenLite.to(this.bar,0,{
                  "x":_loc3_,
                  "overwrite":true,
                  "ease":Quint.easeOut
               });
            }
         }
      }
      
      public function get mode() : Boolean
      {
         return this._mode;
      }
      
      public function set mode(param1:Boolean) : void
      {
         this._mode = param1;
         if(param1)
         {
            this.bar.addEventListener(MouseEvent.MOUSE_DOWN,this.targetDown);
            addEventListener(Event.ENTER_FRAME,this.targetEnterFrame);
            this._container.addEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheel);
         }
         else
         {
            this.bar.removeEventListener(MouseEvent.MOUSE_DOWN,this.targetDown);
            removeEventListener(Event.ENTER_FRAME,this.targetEnterFrame);
            this._container.removeEventListener(MouseEvent.MOUSE_WHEEL,this.targetMouseWheel);
         }
      }
      
      protected function changeBarPosition(param1:MouseEvent) : void
      {
         var _loc2_:Point = new Point(this.x,this.y);
         this.bar.x = _loc2_.x;
         this.snapCount = Math.round((this._containerStartY - this._container.y) / this.snap);
      }
      
      public function setTarget(param1:Sprite, param2:Sprite) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this._container = param1;
         this._canvas = param2;
         this._container.mask = this._canvas;
         this._containerStartX = this._container.x;
         this._containerStartY = this._container.y;
         this._containerW = this._container.width;
         this._containerH = this._container.height;
         if(this.direction == HORIZONTAL)
         {
            _loc3_ = this._canvas.width;
            _loc4_ = _loc3_ * (this._canvas.width / this._container.width);
            this.scrollBackground.width = this.barMask.width = _loc3_;
            this.bar.width = _loc4_;
            if(this._containerW > this._canvas.width)
            {
               this.isScrolled = true;
            }
         }
         else if(this.direction == VERTICAL)
         {
            _loc5_ = this._canvas.height;
            _loc6_ = _loc5_ * (this._canvas.height / this._container.height);
            this.scrollBackground.height = this.barMask.height = _loc5_;
            this.bar.height = _loc6_;
            if(this._containerH > this._canvas.height)
            {
               this.isScrolled = true;
            }
            else
            {
               this.bar.alpha = 0;
               this.scrollBackground.alpha = 0;
            }
         }
         this.bar.mask = this.barMask;
         this.bar.buttonMode = true;
         this.mode = true;
      }
      
      public function barResize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.direction == HORIZONTAL)
         {
            _loc1_ = this._canvas.width;
            _loc2_ = _loc1_ * (this._canvas.width / this._container.width);
            this.scrollBackground.width = this.barMask.width = _loc1_;
            this.bar.width = _loc2_;
            if(this._containerW > this._canvas.width)
            {
               this.isScrolled = true;
            }
         }
         else if(this.direction == VERTICAL)
         {
            _loc3_ = this._canvas.height;
            _loc4_ = _loc3_ * (this._canvas.height / this._container.height);
            this.scrollBackground.height = this.barMask.height = _loc3_;
            this.bar.height = _loc4_;
            if(this._containerH > this._canvas.height)
            {
               this.isScrolled = true;
            }
         }
      }
      
      protected function targetMouseWheel(param1:MouseEvent) : void
      {
         if(this.direction == VERTICAL)
         {
            if(param1.delta > 0)
            {
               this.snapCount = Math.round((this._containerStartY - this._container.y) / this.snap) - 1;
            }
            if(param1.delta < 0)
            {
               this.snapCount = Math.round((this._containerStartY - this._container.y) / this.snap) + 1;
            }
         }
         else if(this.direction == HORIZONTAL)
         {
            if(param1.delta > 0)
            {
               this.snapCount = Math.round((this._containerStartX - this._container.x) / this.snap) - 1;
            }
            if(param1.delta < 0)
            {
               this.snapCount = Math.round((this._containerStartX - this._container.x) / this.snap) + 1;
            }
         }
         param1.preventDefault();
      }
      
      protected function targetEnterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._mouseDown)
         {
            this._velocity *= MOUSE_DOWN_DECAY;
         }
         else
         {
            this._velocity *= DECAY;
         }
         if(!this._mouseDown)
         {
            _loc3_ = 0;
            if(this.direction == VERTICAL)
            {
               _loc4_ = this.bar.y;
               if(_loc4_ > this.barMask.height - this.bar.height)
               {
                  _loc3_ = (this.barMask.height - this.bar.height - _loc4_) * BOUNCING_SPRINGESS;
                  this.bar.y = int(_loc4_ + this._velocity + _loc3_);
               }
               else if(_loc4_ < 0)
               {
                  _loc3_ = -_loc4_ * BOUNCING_SPRINGESS;
                  this.bar.y = int(_loc4_ + this._velocity + _loc3_);
               }
            }
            else
            {
               _loc5_ = this.bar.x;
               if(_loc5_ > this.barMask.width - this.bar.width)
               {
                  _loc3_ = (this.barMask.width - this.bar.width - _loc5_) * BOUNCING_SPRINGESS;
                  this.bar.x = _loc5_ + this._velocity + _loc3_;
               }
               else if(_loc5_ < 0)
               {
                  _loc3_ = -_loc5_ * BOUNCING_SPRINGESS;
                  this.bar.x = _loc5_ + this._velocity + _loc3_;
               }
            }
         }
         if(this.direction == HORIZONTAL)
         {
            _loc2_ = this.bar.x / (this.barMask.width - this.bar.width);
            if(this.isScrolled)
            {
               TweenLite.to(this._container,0,{
                  "x":this._containerStartX + -_loc2_ * (this._containerW - this._canvas.width),
                  "overwrite":true,
                  "ease":Quad.easeOut
               });
            }
            else
            {
               TweenLite.to(this._container,0,{
                  "x":this._containerStartX,
                  "overwrite":true,
                  "ease":Quad.easeOut
               });
            }
         }
         else
         {
            _loc2_ = this.bar.y / (this.barMask.height - this.bar.height);
            if(this.isScrolled)
            {
               TweenLite.to(this._container,0.3,{
                  "y":int(this._containerStartY + -_loc2_ * (this._containerH - this._canvas.height + 3)),
                  "ease":Quad.easeOut
               });
            }
            else
            {
               TweenLite.to(this._container,0.3,{
                  "y":this._containerStartY,
                  "ease":Quad.easeOut
               });
            }
         }
      }
      
      protected function targetDown(param1:MouseEvent) : void
      {
         if(!this._mouseDown)
         {
            this._mouseDown = true;
            this._mouseDownPoint = new Point(param1.stageX,param1.stageY);
            this._lastMouseDownPoint = new Point(param1.stageX,param1.stageY);
            this._mouseDownX = this.bar.x;
            this._mouseDownY = this.bar.y;
            this.bar.stage.addEventListener(MouseEvent.MOUSE_UP,this.targetUp);
            this.bar.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.targetMove);
         }
      }
      
      protected function targetMove(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(this._mouseDown)
         {
            _loc2_ = new Point(param1.stageX,param1.stageY);
            if(this.direction == VERTICAL)
            {
               if(this.bar.y > -this.bar.height / 2 && this.bar.y < this.barMask.height - this.bar.height + this.bar.height / 2)
               {
                  this.bar.y = this._mouseDownY + (_loc2_.y - this._mouseDownPoint.y);
                  this._velocity += (_loc2_.y - this._lastMouseDownPoint.y) * SPEED_SPRINGNESS;
               }
            }
            else if(this.bar.x > -this.bar.width / 2 && this.bar.x < this.barMask.width - this.bar.width + this.bar.width / 2)
            {
               this.bar.x = this._mouseDownX + (_loc2_.x - this._mouseDownPoint.x);
               this._velocity += (_loc2_.x - this._lastMouseDownPoint.x) * SPEED_SPRINGNESS;
            }
            this._lastMouseDownPoint = _loc2_;
         }
      }
      
      protected function targetUp(param1:MouseEvent) : void
      {
         if(this._mouseDown)
         {
            this._mouseDown = false;
            if(this.snap != WHEEL_DIFFERENCE)
            {
               if(this.direction == VERTICAL)
               {
                  this.snapCount = Math.round((this._containerStartY - this._container.y) / this.snap);
               }
               else if(this.direction == HORIZONTAL)
               {
                  this.snapCount = Math.round((this._containerStartX - this._container.x) / this.snap);
               }
            }
            this.bar.stage.removeEventListener(MouseEvent.MOUSE_UP,this.targetUp);
            this.bar.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.targetMove);
         }
      }
      
      public function get containerW() : int
      {
         return this._containerW;
      }
      
      public function set containerW(param1:int) : void
      {
         this._containerW = param1;
         if(this.direction == HORIZONTAL)
         {
            if(this._containerW > this._canvas.width)
            {
               this.bar.mouseEnabled = true;
               this.bar.alpha = 1;
               this.isScrolled = true;
               this.bar.width = this.scrollBackground.width * (this._canvas.width / this._containerW);
            }
            else
            {
               this.bar.mouseEnabled = false;
               this.bar.alpha = 0;
               this.isScrolled = false;
               this.bar.width = this.scrollBackground.width;
               this.bar.height = this.scrollBackground.height;
               this.bar.x = this.scrollBackground.x;
               this.bar.y = this.scrollBackground.y;
            }
         }
      }
      
      public function get containerH() : int
      {
         return this._containerH;
      }
      
      public function set containerH(param1:int) : void
      {
         this._containerH = param1;
         if(this.direction == VERTICAL)
         {
            if(this._containerH > this._canvas.height)
            {
               this.bar.mouseEnabled = true;
               this.bar.alpha = 1;
               this.scrollBackground.alpha = 1;
               this.isScrolled = true;
               if(this.bar.height >= this.scrollBackground.height - 1 || this.bar.y >= this.scrollBackground.height - this.bar.height - 1)
               {
                  this.bar.height = this.scrollBackground.height * (this._canvas.height / this.containerH);
                  this.bar.y = this.scrollBackground.height - this.bar.height;
               }
               else
               {
                  this.bar.height = this.scrollBackground.height * (this._canvas.height / this.containerH);
               }
            }
            else
            {
               this.bar.mouseEnabled = false;
               this.bar.alpha = 0;
               this.scrollBackground.alpha = 0;
               this.isScrolled = false;
               this.bar.x = this.scrollBackground.x;
               this.bar.y = this.scrollBackground.y;
               this.bar.height = this.scrollBackground.height;
            }
         }
      }
      
      public function updateToEnd() : void
      {
         if(this.direction == VERTICAL)
         {
            this.bar.y = this.scrollBackground.height - this.bar.height;
         }
         else
         {
            TweenLite.to(this.bar,0,{
               "x":this.scrollBackground.width - this.bar.width,
               "ease":Quint.easeOut
            });
            this._container.x = this._containerStartX + -1 * (this._containerW - this._canvas.width);
            this.mode = true;
         }
      }
      
      public function get bgColor() : uint
      {
         return this._bgColor;
      }
      
      public function set bgColor(param1:uint) : void
      {
         this._bgColor = param1;
         TweenMax.to(this.scrollBackground,0,{"tint":param1});
      }
      
      public function get barColor() : uint
      {
         return this._barColor;
      }
      
      public function set barColor(param1:uint) : void
      {
         this._barColor = param1;
         TweenMax.to(this.bar,0,{"tint":param1});
      }
      
      override public function removed() : void
      {
         this.mode = false;
      }
   }
}

