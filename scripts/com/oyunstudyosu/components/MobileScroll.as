package com.oyunstudyosu.components
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Strong;
   import com.greensock.plugins.ThrowPropsPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.oyunstudyosu.utils.BlitMask;
   import com.oyunstudyosu.utils.DrawUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class MobileScroll extends Sprite
   {
      
      public var listContainer:Sprite;
      
      private var scrollContainerBg:Sprite;
      
      public var boundHeight:int;
      
      public var boundWidth:int;
      
      private var bounds:Rectangle;
      
      private var t1:uint;
      
      private var t2:uint;
      
      private var y1:Number;
      
      private var y2:Number;
      
      private var yOverlap:Number;
      
      private var yOffset:Number;
      
      private var blitMask:BlitMask;
      
      private var padding:int;
      
      public function MobileScroll()
      {
         super();
         this.listContainer = new Sprite();
         this.listContainer.y = 0;
         TweenPlugin.activate([ThrowPropsPlugin]);
      }
      
      public function init(param1:int, param2:int, param3:int = 0) : void
      {
         this.listContainer.y = 0;
         this.padding = param3;
         this.scrollContainerBg = DrawUtils.getRectangleSprite(param1,param2,0,0);
         this.bounds = new Rectangle(this.listContainer.x,this.listContainer.y,param1,param2);
         this.blitMask = new BlitMask(this,this.x,this.y,this.bounds.width,this.bounds.height,false);
         this.blitMask.bitmapMode = false;
         this.blitMask.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         this.setPositions();
         this.addChild(this.scrollContainerBg);
         this.addChild(this.listContainer);
      }
      
      public function setPositions() : void
      {
         var _loc3_:MovieClip = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.listContainer.numChildren)
         {
            _loc3_ = this.listContainer.getChildAt(_loc2_) as MovieClip;
            _loc3_.y = _loc1_;
            _loc1_ += int(_loc3_.height) + this.padding;
            _loc2_++;
         }
         this.scrollContainerBg.height = _loc1_ + this.listContainer.y;
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         TweenLite.killTweensOf(this.listContainer);
         this.y1 = this.y2 = this.listContainer.y;
         this.yOffset = this.mouseY - this.listContainer.y;
         this.yOverlap = Math.max(0,this.listContainer.height - this.bounds.height);
         this.t1 = this.t2 = getTimer();
         this.listContainer.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         this.listContainer.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
      }
      
      private function mouseMoveHandler(param1:MouseEvent) : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         var _loc2_:Number = this.mouseY - this.yOffset;
         if(_loc2_ > this.bounds.top)
         {
            this.listContainer.y = (_loc2_ + this.bounds.top) * 0.5;
         }
         else if(_loc2_ < this.bounds.top - this.yOverlap)
         {
            this.listContainer.y = (_loc2_ + this.bounds.top - this.yOverlap) * 0.5;
         }
         else
         {
            this.listContainer.y = _loc2_;
         }
         this.blitMask.update();
         var _loc3_:uint = uint(getTimer());
         if(_loc3_ - this.t2 > 50)
         {
            this.y2 = this.y1;
            this.t2 = this.t1;
            this.y1 = this.listContainer.y;
            this.t1 = _loc3_;
         }
         param1.updateAfterEvent();
      }
      
      private function mouseUpHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         this.mouseEnabled = true;
         this.mouseChildren = true;
         this.listContainer.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
         this.listContainer.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         var _loc2_:Number = (getTimer() - this.t2) / 1000;
         var _loc3_:Number = (this.listContainer.y - this.y2) / _loc2_;
         ThrowPropsPlugin.to(this.listContainer,{
            "throwProps":{"y":{
               "velocity":_loc3_,
               "max":this.bounds.top,
               "min":this.bounds.top - this.yOverlap,
               "resistance":300
            }},
            "onUpdate":this.blitMask.update,
            "ease":Strong.easeOut
         },1,0.3,1);
      }
      
      public function disposeItems(param1:Function = null) : void
      {
         var _loc2_:MovieClip = null;
         while(this.listContainer.numChildren > 0)
         {
            _loc2_ = this.listContainer.getChildAt(0) as MovieClip;
            if(param1 != null)
            {
               _loc2_.removeEventListener(MouseEvent.CLICK,param1);
            }
            this.listContainer.removeChild(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function dispose(param1:Function = null) : void
      {
         this.disposeItems(param1);
         if(this.blitMask)
         {
            this.blitMask.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
            this.blitMask = null;
         }
         if(Boolean(this.scrollContainerBg) && this.contains(this.scrollContainerBg) > 0)
         {
            this.removeChild(this.scrollContainerBg);
         }
      }
   }
}

