package feathers.utils
{
   import feathers.events.ScrollEvent;
   import flash.Boot;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import motion.Actuate;
   import motion.actuators.GenericActuator;
   import motion.actuators.SimpleActuator;
   import motion.easing.IEasing;
   import motion.easing.Quart;
   import openfl.Lib;
   
   public class Scroller extends EventDispatcher
   {
      
      public static var MINIMUM_VELOCITY:Number = 0.02;
      
      public static var POINTER_ID_MOUSE:int = -1000;
      
      public var throwElasticity:Number;
      
      public var targetScrollY:Number;
      
      public var targetScrollX:Number;
      
      public var startTouchY:Number;
      
      public var startTouchX:Number;
      
      public var startScrollY:Number;
      
      public var startScrollX:Number;
      
      public var snappingToEdge:Boolean;
      
      public var snapPositionsY:Array;
      
      public var snapPositionsX:Array;
      
      public var simulateTouch:Boolean;
      
      public var savedScrollMoves:Array;
      
      public var restoreMouseChildren:Boolean;
      
      public var mouseWheelYScrollsX:Boolean;
      
      public var mouseWheelDuration:Number;
      
      public var mouseWheelDeltaY:Number;
      
      public var mouseWheelDeltaX:Number;
      
      public var minDragDistance:Number;
      
      public var forceElasticTop:Boolean;
      
      public var forceElasticRight:Boolean;
      
      public var forceElasticLeft:Boolean;
      
      public var forceElasticBottom:Boolean;
      
      public var enabledY:Boolean;
      
      public var enabledX:Boolean;
      
      public var elasticity:Number;
      
      public var elasticSnapDuration:Number;
      
      public var elasticEdges:Boolean;
      
      public var ease:IEasing;
      
      public var bounceEase:IEasing;
      
      public var animateScrollYEndRatio:Number;
      
      public var animateScrollY:SimpleActuator;
      
      public var animateScrollXEndRatio:Number;
      
      public var animateScrollX:SimpleActuator;
      
      public var _visibleWidth:Number;
      
      public var _visibleHeight:Number;
      
      public var _touchPointIsSimulated:Boolean;
      
      public var _touchPointID:Object;
      
      public var _target:InteractiveObject;
      
      public var _scrolling:Boolean;
      
      public var _scrollY:Number;
      
      public var _scrollX:Number;
      
      public var _previousTouchPointID:Object;
      
      public var _mouseWheelDeltaMode:int;
      
      public var _minScrollY:Number;
      
      public var _minScrollX:Number;
      
      public var _maxScrollY:Number;
      
      public var _maxScrollX:Number;
      
      public var _logDecelerationRate:Number;
      
      public var _fixedThrowDuration:Number;
      
      public var _draggingY:Boolean;
      
      public var _draggingX:Boolean;
      
      public var _decelerationRate:Number;
      
      public var _contentWidth:Number;
      
      public var _contentHeight:Number;
      
      public var _animateScrollYEase:IEasing;
      
      public var _animateScrollXEase:IEasing;
      
      public function Scroller(param1:InteractiveObject = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _touchPointIsSimulated = false;
         _touchPointID = null;
         _previousTouchPointID = null;
         snappingToEdge = false;
         targetScrollY = 0;
         targetScrollX = 0;
         animateScrollYEndRatio = 1;
         animateScrollXEndRatio = 1;
         _animateScrollYEase = null;
         _animateScrollXEase = null;
         animateScrollY = null;
         animateScrollX = null;
         savedScrollMoves = [];
         startScrollY = 0;
         startScrollX = 0;
         startTouchY = 0;
         startTouchX = 0;
         restoreMouseChildren = false;
         _fixedThrowDuration = 2.996998998998728;
         _logDecelerationRate = -0.0020020026706730793;
         snapPositionsY = null;
         snapPositionsX = null;
         _decelerationRate = 0.998;
         simulateTouch = false;
         mouseWheelDuration = 0;
         _mouseWheelDeltaMode = 1;
         mouseWheelYScrollsX = false;
         mouseWheelDeltaY = 10;
         mouseWheelDeltaX = 10;
         bounceEase = null;
         ease = Quart.easeOut;
         elasticSnapDuration = 0.5;
         throwElasticity = 0.05;
         elasticity = 0.33;
         forceElasticLeft = false;
         forceElasticBottom = false;
         forceElasticRight = false;
         forceElasticTop = false;
         elasticEdges = true;
         minDragDistance = 6;
         _draggingY = false;
         _draggingX = false;
         _scrolling = false;
         _contentHeight = 0;
         _contentWidth = 0;
         _visibleHeight = 0;
         _visibleWidth = 0;
         _maxScrollY = 0;
         _maxScrollX = 0;
         _minScrollY = 0;
         _minScrollX = 0;
         _scrollY = 0;
         _scrollX = 0;
         enabledY = true;
         enabledX = true;
         super();
         set_target(param1);
      }
      
      public function touchMove(param1:int, param2:Boolean, param3:Number, param4:Number) : void
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         if(_touchPointID == null)
         {
            return;
         }
         if(_touchPointID != param1)
         {
            return;
         }
         if(_touchPointIsSimulated != param2)
         {
            return;
         }
         var _loc5_:Number = param3 - startTouchX;
         var _loc6_:Number = param4 - startTouchY;
         var _loc7_:Number = 1;
         var _loc8_:Number = 1;
         var _loc9_:InteractiveObject = _target;
         while(_loc9_ != _loc9_.stage)
         {
            _loc7_ /= _loc9_.scaleX;
            _loc8_ /= _loc9_.scaleY;
            _loc9_ = _loc9_.parent;
         }
         _loc5_ *= _loc7_;
         _loc6_ *= _loc8_;
         var _loc10_:Boolean = canDragX();
         var _loc11_:Boolean = canDragY();
         if(!_draggingX && _loc10_ && Math.abs(_loc5_) > minDragDistance)
         {
            startTouchX = param3;
            _loc5_ = 0;
            _draggingX = true;
            if(!_draggingY)
            {
               startScroll();
               if(_touchPointID == null)
               {
                  return;
               }
            }
         }
         if(!_draggingY && _loc11_ && Math.abs(_loc6_) > minDragDistance)
         {
            startTouchY = param4;
            _loc6_ = 0;
            _draggingY = true;
            if(!_draggingX)
            {
               startScroll();
               if(_touchPointID == null)
               {
                  return;
               }
            }
         }
         if(!_draggingX && !_draggingY)
         {
            return;
         }
         var _loc12_:Number = startScrollX;
         if(_loc10_)
         {
            _loc12_ -= _loc5_;
            if(elasticEdges)
            {
               _loc13_ = _minScrollX;
               if(_loc13_ > startScrollX)
               {
                  _loc13_ = startScrollX;
               }
               _loc14_ = _maxScrollX;
               if(_loc14_ < startScrollX)
               {
                  _loc14_ = startScrollX;
               }
               if(_loc12_ < _minScrollX)
               {
                  if(_maxScrollX > _minScrollX || forceElasticLeft)
                  {
                     _loc12_ -= (_loc12_ - _loc13_) * (1 - elasticity);
                  }
                  else
                  {
                     _loc12_ = _minScrollX;
                  }
               }
               else if(_loc12_ > _maxScrollX)
               {
                  if(_maxScrollX > _minScrollX || forceElasticRight)
                  {
                     _loc12_ -= (_loc12_ - _loc14_) * (1 - elasticity);
                  }
                  else
                  {
                     _loc12_ = _maxScrollX;
                  }
               }
            }
            else if(_loc12_ < _minScrollX)
            {
               _loc12_ = _minScrollX;
            }
            else if(_loc12_ > _maxScrollX)
            {
               _loc12_ = _maxScrollX;
            }
         }
         _loc13_ = startScrollY;
         if(_loc11_)
         {
            _loc13_ -= _loc6_;
            if(elasticEdges)
            {
               _loc14_ = _minScrollY;
               if(_loc14_ > startScrollY)
               {
                  _loc14_ = startScrollY;
               }
               _loc15_ = _maxScrollY;
               if(_loc15_ < startScrollY)
               {
                  _loc15_ = startScrollY;
               }
               if(_loc13_ < _minScrollY)
               {
                  if(_maxScrollY > _minScrollY || forceElasticTop)
                  {
                     _loc13_ -= (_loc13_ - _loc14_) * (1 - elasticity);
                  }
                  else
                  {
                     _loc13_ = _minScrollY;
                  }
               }
               else if(_loc13_ > _maxScrollY)
               {
                  if(_maxScrollY > _minScrollY || forceElasticBottom)
                  {
                     _loc13_ -= (_loc13_ - _loc15_) * (1 - elasticity);
                  }
                  else
                  {
                     _loc13_ = _maxScrollY;
                  }
               }
            }
            else if(_loc13_ < _minScrollY)
            {
               _loc13_ = _minScrollY;
            }
            else if(_loc13_ > _maxScrollY)
            {
               _loc13_ = _maxScrollY;
            }
         }
         set_scrollX(_loc12_);
         set_scrollY(_loc13_);
         if(int(savedScrollMoves.length) > 60)
         {
            savedScrollMoves.resize(30);
         }
         savedScrollMoves.push(_loc12_);
         savedScrollMoves.push(_loc13_);
         savedScrollMoves.push(Lib.getTimer());
      }
      
      public function touchEnd(param1:int, param2:Boolean) : void
      {
         var _loc12_:Number = NaN;
         if(_touchPointID == null)
         {
            return;
         }
         if(_touchPointID != param1)
         {
            return;
         }
         if(_touchPointIsSimulated != param2)
         {
            return;
         }
         cleanupAfterDrag();
         var _loc3_:* = !canDragX();
         var _loc4_:* = !canDragY();
         if(_scrollX < _minScrollX || _scrollX > _maxScrollX)
         {
            _loc3_ = true;
            finishScrollX();
         }
         if(_scrollY < _minScrollY || _scrollY > _maxScrollY)
         {
            _loc4_ = true;
            finishScrollY();
         }
         if(_loc3_ && _loc4_)
         {
            return;
         }
         if(!_draggingX && !_draggingY)
         {
            return;
         }
         var _loc5_:* = Lib.getTimer() - 100;
         var _loc6_:*;
         var _loc7_:int = _loc6_ = int(savedScrollMoves.length) - 1;
         var _loc8_:* = _loc6_;
         while(_loc6_ > 0 && Number(savedScrollMoves[_loc8_]) > _loc5_)
         {
            _loc7_ = _loc8_;
            _loc8_ -= 3;
         }
         if(_loc7_ == _loc6_)
         {
            if(!_loc3_ && _draggingX)
            {
               finishScrollX();
            }
            if(!_loc4_ && _draggingY)
            {
               finishScrollY();
            }
            return;
         }
         var _loc9_:Number = Number(savedScrollMoves[_loc6_]) - Number(savedScrollMoves[_loc7_]);
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         if(_loc9_ > 0)
         {
            if(!_loc3_ && _draggingX)
            {
               _loc12_ = _scrollX - Number(savedScrollMoves[_loc7_ - 2]);
               _loc10_ = -_loc12_ / _loc9_;
            }
            if(!_loc4_ && _draggingY)
            {
               _loc12_ = _scrollY - Number(savedScrollMoves[_loc7_ - 1]);
               _loc11_ = -_loc12_ / _loc9_;
            }
         }
         if(_loc10_ != null || _loc11_ != null)
         {
            throwWithVelocity(_loc10_,_loc11_);
         }
         if(_loc10_ == null && _draggingX)
         {
            finishScrollX();
         }
         if(_loc11_ == null && _draggingY)
         {
            finishScrollY();
         }
      }
      
      public function touchBegin(param1:int, param2:Boolean, param3:Number, param4:Number) : void
      {
         var _loc5_:* = null as DisplayObjectContainer;
         if(param2 && !simulateTouch)
         {
            return;
         }
         if(_touchPointID != null)
         {
            return;
         }
         if(animateScrollX != null)
         {
            Actuate.stop(animateScrollX,null,false,false);
            animateScrollX = null;
            _animateScrollXEase = null;
         }
         if(animateScrollY != null)
         {
            Actuate.stop(animateScrollY,null,false,false);
            animateScrollY = null;
            _animateScrollYEase = null;
         }
         _target.addEventListener(Event.REMOVED_FROM_STAGE,scroller_target_removedFromStageHandler,false,0,true);
         _target.stage.addEventListener(MouseEvent.MOUSE_MOVE,scroller_target_stage_mouseMoveHandler,false,0,true);
         _target.stage.addEventListener(MouseEvent.MOUSE_UP,scroller_target_stage_mouseUpHandler,false,0,true);
         _target.stage.addEventListener(TouchEvent.TOUCH_MOVE,scroller_target_stage_touchMoveHandler,false,0,true);
         _target.stage.addEventListener(TouchEvent.TOUCH_END,scroller_target_stage_touchEndHandler,false,0,true);
         if(_target is DisplayObjectContainer)
         {
            _loc5_ = _target;
            if(_scrolling)
            {
               _loc5_.mouseChildren = false;
            }
         }
         _previousTouchPointID = null;
         _touchPointID = param1;
         _touchPointIsSimulated = param2;
         startTouchX = param3;
         startTouchY = param4;
         startScrollX = _scrollX;
         startScrollY = _scrollY;
         savedScrollMoves.resize(0);
      }
      
      public function throwWithVelocity(param1:Object, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(param1 != null)
         {
            if(Math.abs(param1) <= Scroller.MINIMUM_VELOCITY)
            {
               finishScrollX();
            }
            else if(snapPositionsX != null)
            {
               _loc5_ = 0;
               _loc6_ = int(snapPositionsX.length);
               while(_loc5_ < _loc6_)
               {
                  _loc7_ = _loc5_++;
                  _loc8_ = Number(snapPositionsX[_loc7_]);
                  if(param1 < 0)
                  {
                     _loc3_ = _loc8_;
                     if(_loc8_ > _scrollX)
                     {
                        break;
                     }
                  }
                  if(param1 > 0)
                  {
                     _loc3_ = _loc7_ == 0 ? _loc8_ : Number(snapPositionsX[_loc7_ - 1]);
                     if(_loc8_ >= _scrollX)
                     {
                        break;
                     }
                  }
               }
            }
            else
            {
               _loc3_ = _scrollX + calculateDistanceFromVelocity(param1);
            }
         }
         if(param2 != null)
         {
            if(Math.abs(param2) <= Scroller.MINIMUM_VELOCITY)
            {
               finishScrollY();
            }
            else if(snapPositionsY != null)
            {
               _loc5_ = 0;
               _loc6_ = int(snapPositionsY.length);
               while(_loc5_ < _loc6_)
               {
                  _loc7_ = _loc5_++;
                  _loc8_ = Number(snapPositionsY[_loc7_]);
                  if(param2 < 0)
                  {
                     _loc4_ = _loc8_;
                     if(_loc8_ > _scrollY)
                     {
                        break;
                     }
                  }
                  if(param2 > 0)
                  {
                     _loc4_ = _loc7_ == 0 ? _loc8_ : Number(snapPositionsY[_loc7_ - 1]);
                     if(_loc8_ >= _scrollY)
                     {
                        break;
                     }
                  }
               }
            }
            else
            {
               _loc4_ = _scrollY + calculateDistanceFromVelocity(param2);
            }
         }
         throwTo(_loc3_,_loc4_,_fixedThrowDuration);
      }
      
      public function throwTo(param1:Object, param2:Object, param3:Object = undefined, param4:IEasing = undefined) : void
      {
         var _gthis:Scroller;
         var _loc6_:* = null as GenericActuator;
         _gthis = this;
         if(param3 == null)
         {
            param3 = _fixedThrowDuration;
         }
         if(param4 == null)
         {
            param4 = ease;
         }
         var _loc5_:Boolean = false;
         if(param1 != null)
         {
            if(animateScrollX != null)
            {
               Actuate.stop(animateScrollX,null,false,false);
               animateScrollX = null;
               _animateScrollXEase = null;
            }
            if(_scrollX != param1)
            {
               _loc5_ = true;
               startScroll();
               if(param3 == 0)
               {
                  set_scrollX(param1);
               }
               else
               {
                  startScrollX = _scrollX;
                  targetScrollX = param1;
                  _animateScrollXEase = param4;
                  _loc6_ = Actuate.update(function(param1:Object):Number
                  {
                     if(param1 == null)
                     {
                        param1 = _gthis.targetScrollX;
                     }
                     return _gthis.set_scrollX(param1);
                  },param3,[_scrollX],[targetScrollX],true);
                  animateScrollX = _loc6_;
                  animateScrollX.ease(_animateScrollXEase);
                  animateScrollX.onComplete(animateScrollX_onComplete);
                  refreshAnimateScrollXEndRatio();
               }
            }
            else
            {
               finishScrollX();
            }
         }
         if(param2 != null)
         {
            if(animateScrollY != null)
            {
               Actuate.stop(animateScrollY,null,false,false);
               animateScrollY = null;
               _animateScrollYEase = null;
            }
            if(_scrollY != param2)
            {
               _loc5_ = true;
               startScroll();
               if(param3 == 0)
               {
                  set_scrollY(param2);
               }
               else
               {
                  startScrollY = _scrollY;
                  targetScrollY = param2;
                  _animateScrollYEase = param4;
                  _loc6_ = Actuate.update(function(param1:Object):Number
                  {
                     if(param1 == null)
                     {
                        param1 = _gthis.targetScrollY;
                     }
                     return _gthis.set_scrollY(param1);
                  },param3,[_scrollY],[targetScrollY],true);
                  animateScrollY = _loc6_;
                  animateScrollY.ease(_animateScrollYEase);
                  animateScrollY.onComplete(animateScrollY_onComplete);
                  refreshAnimateScrollYEndRatio();
               }
            }
            else
            {
               finishScrollY();
            }
         }
         if(_loc5_ && param3 == 0)
         {
            completeScroll();
         }
      }
      
      public function stop() : void
      {
         if(animateScrollX != null)
         {
            Actuate.stop(animateScrollX,null,false,false);
            animateScrollX = null;
            _animateScrollXEase = null;
         }
         if(animateScrollY != null)
         {
            Actuate.stop(animateScrollY,null,false,false);
            animateScrollY = null;
            _animateScrollYEase = null;
         }
         cleanupAfterDrag();
         _draggingX = false;
         _draggingY = false;
         completeScroll();
      }
      
      public function startScroll() : void
      {
         var _loc1_:* = null as DisplayObjectContainer;
         if(_scrolling)
         {
            return;
         }
         _scrolling = true;
         if(_target is DisplayObjectContainer)
         {
            _loc1_ = _target;
            restoreMouseChildren = _loc1_.mouseChildren;
            _loc1_.mouseChildren = false;
         }
         ScrollEvent.dispatch(this,"scrollStart");
      }
      
      public function set_target(param1:InteractiveObject) : InteractiveObject
      {
         if(_target == param1)
         {
            return _target;
         }
         if(_target != null)
         {
            cleanupAfterDrag();
            _target.removeEventListener(Event.REMOVED_FROM_STAGE,scroller_target_removedFromStageHandler);
            _target.removeEventListener(MouseEvent.MOUSE_DOWN,scroller_target_mouseDownHandler);
            _target.removeEventListener(MouseEvent.MOUSE_DOWN,scroller_target_mouseDownCaptureHandler,true);
            _target.removeEventListener(MouseEvent.MOUSE_WHEEL,scroller_target_mouseWheelHandler);
            _target.removeEventListener(TouchEvent.TOUCH_BEGIN,scroller_target_touchBeginHandler);
            _target.removeEventListener(TouchEvent.TOUCH_BEGIN,scroller_target_touchBeginCaptureHandler,true);
            _target.removeEventListener(MouseEvent.CLICK,scroller_target_clickCaptureHandler,true);
            _target.removeEventListener(TouchEvent.TOUCH_TAP,scroller_target_touchTapCaptureHandler,true);
         }
         _target = param1;
         if(_target != null)
         {
            _target.addEventListener(MouseEvent.MOUSE_DOWN,scroller_target_mouseDownHandler,false,0,true);
            _target.addEventListener(MouseEvent.MOUSE_DOWN,scroller_target_mouseDownCaptureHandler,true,0,true);
            _target.addEventListener(MouseEvent.MOUSE_WHEEL,scroller_target_mouseWheelHandler,false,0,true);
            _target.addEventListener(TouchEvent.TOUCH_BEGIN,scroller_target_touchBeginHandler,false,0,true);
            _target.addEventListener(TouchEvent.TOUCH_BEGIN,scroller_target_touchBeginCaptureHandler,true,0,true);
            _target.addEventListener(MouseEvent.CLICK,scroller_target_clickCaptureHandler,true,0,true);
            _target.addEventListener(TouchEvent.TOUCH_TAP,scroller_target_touchTapCaptureHandler,true,0,true);
         }
         return _target;
      }
      
      public function set target(param1:InteractiveObject) : void
      {
         set_target(param1);
      }
      
      public function set_scrollY(param1:Number) : Number
      {
         if(_scrollY == param1)
         {
            return _scrollY;
         }
         _scrollY = param1;
         ScrollEvent.dispatch(this,"scroll");
         return _scrollY;
      }
      
      public function set scrollY(param1:Number) : void
      {
         set_scrollY(param1);
      }
      
      public function set_scrollX(param1:Number) : Number
      {
         if(_scrollX == param1)
         {
            return _scrollX;
         }
         _scrollX = param1;
         ScrollEvent.dispatch(this,"scroll");
         return _scrollX;
      }
      
      public function set scrollX(param1:Number) : void
      {
         set_scrollX(param1);
      }
      
      public function set_restrictedScrollY(param1:Number) : Number
      {
         if(param1 < _minScrollY)
         {
            param1 = _minScrollY;
         }
         else if(param1 > _maxScrollY)
         {
            param1 = _maxScrollY;
         }
         if(_scrollY == param1)
         {
            return _scrollY;
         }
         _scrollY = param1;
         ScrollEvent.dispatch(this,"scroll");
         return _scrollY;
      }
      
      public function set restrictedScrollY(param1:Number) : void
      {
         set_restrictedScrollY(param1);
      }
      
      public function set_restrictedScrollX(param1:Number) : Number
      {
         if(param1 < _minScrollX)
         {
            param1 = _minScrollX;
         }
         else if(param1 > _maxScrollX)
         {
            param1 = _maxScrollX;
         }
         if(_scrollX == param1)
         {
            return _scrollX;
         }
         _scrollX = param1;
         ScrollEvent.dispatch(this,"scroll");
         return _scrollX;
      }
      
      public function set restrictedScrollX(param1:Number) : void
      {
         set_restrictedScrollX(param1);
      }
      
      public function set_decelerationRate(param1:Number) : Number
      {
         if(_decelerationRate == param1)
         {
            return _decelerationRate;
         }
         _decelerationRate = param1;
         _logDecelerationRate = Math.log(_decelerationRate);
         _fixedThrowDuration = -0.1 / Math.log(Math.pow(_decelerationRate,16.666666666666668));
         return _decelerationRate;
      }
      
      public function set decelerationRate(param1:Number) : void
      {
         set_decelerationRate(param1);
      }
      
      public function setDimensions(param1:Object = undefined, param2:Object = undefined, param3:Object = undefined, param4:Object = undefined) : void
      {
         _visibleWidth = param1 != null ? Number(param1) : 0;
         _visibleHeight = param2 != null ? Number(param2) : 0;
         _contentWidth = param3 != null ? Number(param3) : 0;
         _contentHeight = param4 != null ? Number(param4) : 0;
         calculateMinAndMax();
      }
      
      public function scroller_target_touchTapCaptureHandler(param1:TouchEvent) : void
      {
         if(_previousTouchPointID == null || _previousTouchPointID != param1.touchPointID)
         {
            return;
         }
         if(param1.isPrimaryTouchPoint)
         {
            _previousTouchPointID = Scroller.POINTER_ID_MOUSE;
            return;
         }
         _previousTouchPointID = null;
         param1.stopImmediatePropagation();
      }
      
      public function scroller_target_touchBeginHandler(param1:TouchEvent) : void
      {
         if(simulateTouch && param1.isPrimaryTouchPoint)
         {
            return;
         }
         touchBegin(param1.touchPointID,false,param1.stageX,param1.stageY);
      }
      
      public function scroller_target_touchBeginCaptureHandler(param1:TouchEvent) : void
      {
         if(!_scrolling)
         {
            return;
         }
         param1.stopImmediatePropagation();
         scroller_target_touchBeginHandler(param1);
      }
      
      public function scroller_target_stage_touchMoveHandler(param1:TouchEvent) : void
      {
         touchMove(param1.touchPointID,false,param1.stageX,param1.stageY);
      }
      
      public function scroller_target_stage_touchEndHandler(param1:TouchEvent) : void
      {
         touchEnd(param1.touchPointID,false);
      }
      
      public function scroller_target_stage_mouseUpHandler(param1:MouseEvent) : void
      {
         touchEnd(Scroller.POINTER_ID_MOUSE,true);
      }
      
      public function scroller_target_stage_mouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Stage = param1.currentTarget;
         touchMove(Scroller.POINTER_ID_MOUSE,true,_loc2_.mouseX,_loc2_.mouseY);
      }
      
      public function scroller_target_removedFromStageHandler(param1:Event) : void
      {
         cleanupAfterDrag();
      }
      
      public function scroller_target_mouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc5_:Number = NaN;
         if(_scrolling)
         {
            param1.stopImmediatePropagation();
            stop();
         }
         var _loc2_:* = param1.delta;
         switch(_mouseWheelDeltaMode)
         {
            case 0:
               _loc2_ /= 40;
               break;
            case 2:
               _loc2_ *= 16;
         }
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(mouseWheelYScrollsX)
         {
            _loc5_ = _scrollX;
            if(animateScrollX != null)
            {
               _loc5_ = targetScrollX;
            }
            _loc3_ = _loc5_ - _loc2_ * mouseWheelDeltaX;
            if(_loc3_ < _minScrollX)
            {
               _loc3_ = _minScrollX;
            }
            else if(_loc3_ > _maxScrollX)
            {
               _loc3_ = _maxScrollX;
            }
         }
         else
         {
            _loc5_ = _scrollY;
            if(animateScrollY != null)
            {
               _loc5_ = targetScrollY;
            }
            _loc4_ = _loc5_ - _loc2_ * mouseWheelDeltaY;
            if(_loc4_ < _minScrollY)
            {
               _loc4_ = _minScrollY;
            }
            else if(_loc4_ > _maxScrollY)
            {
               _loc4_ = _maxScrollY;
            }
         }
         if((_loc3_ == null || _loc3_ == _scrollX) && (_loc4_ == null || _loc4_ == _scrollY))
         {
            return;
         }
         if(!_scrolling)
         {
            param1.stopImmediatePropagation();
            stop();
         }
         if(_loc3_ != null)
         {
            _draggingX = true;
         }
         if(_loc4_ != null)
         {
            _draggingY = true;
         }
         if(mouseWheelDuration > 0)
         {
            throwTo(_loc3_,_loc4_,mouseWheelDuration,ease);
         }
         else
         {
            startScroll();
            if(_loc3_ != null)
            {
               set_scrollX(_loc3_);
            }
            if(_loc4_ != null)
            {
               set_scrollY(_loc4_);
            }
            _draggingX = false;
            _draggingY = false;
            completeScroll();
         }
      }
      
      public function scroller_target_mouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:Stage = _target.stage;
         if(_loc2_ == null)
         {
            return;
         }
         touchBegin(Scroller.POINTER_ID_MOUSE,true,_loc2_.mouseX,_loc2_.mouseY);
      }
      
      public function scroller_target_mouseDownCaptureHandler(param1:MouseEvent) : void
      {
         if(!_scrolling)
         {
            return;
         }
         param1.stopImmediatePropagation();
         scroller_target_mouseDownHandler(param1);
      }
      
      public function scroller_target_clickCaptureHandler(param1:MouseEvent) : void
      {
         if(_previousTouchPointID == null)
         {
            return;
         }
         _previousTouchPointID = null;
         param1.stopImmediatePropagation();
      }
      
      public function refreshAnimateScrollYEndRatio() : void
      {
         var _loc1_:Number = Math.abs(targetScrollY - startScrollY);
         var _loc2_:Number = 0;
         if(targetScrollY > _maxScrollY)
         {
            _loc2_ = (targetScrollY - _maxScrollY) / _loc1_;
         }
         else if(targetScrollY < _minScrollY)
         {
            _loc2_ = (_minScrollY - targetScrollY) / _loc1_;
         }
         if(_loc2_ > 0)
         {
            if(elasticEdges)
            {
               animateScrollYEndRatio = 1 - _loc2_ + _loc2_ * throwElasticity;
            }
            else
            {
               animateScrollYEndRatio = 1 - _loc2_;
            }
         }
         else
         {
            animateScrollYEndRatio = 1;
         }
         if(animateScrollY != null)
         {
            if(animateScrollYEndRatio < 1)
            {
               animateScrollY.onUpdate(animateScrollY_endRatio_onUpdate);
            }
            else
            {
               animateScrollY.onUpdate(null);
            }
         }
      }
      
      public function refreshAnimateScrollXEndRatio() : void
      {
         var _loc1_:Number = Math.abs(targetScrollX - startScrollX);
         var _loc2_:Number = 0;
         if(targetScrollX > _maxScrollX)
         {
            _loc2_ = (targetScrollX - _maxScrollX) / _loc1_;
         }
         else if(targetScrollX < _minScrollX)
         {
            _loc2_ = (_minScrollX - targetScrollX) / _loc1_;
         }
         if(_loc2_ > 0)
         {
            if(elasticEdges)
            {
               animateScrollXEndRatio = 1 - _loc2_ + _loc2_ * throwElasticity;
            }
            else
            {
               animateScrollXEndRatio = 1 - _loc2_;
            }
         }
         else
         {
            animateScrollXEndRatio = 1;
         }
         if(animateScrollX != null)
         {
            if(animateScrollXEndRatio < 1)
            {
               animateScrollX.onUpdate(animateScrollX_endRatio_onUpdate);
            }
            else
            {
               animateScrollX.onUpdate(null);
            }
         }
      }
      
      public function get_visibleWidth() : Number
      {
         return _visibleWidth;
      }
      
      public function get visibleWidth() : Number
      {
         return get_visibleWidth();
      }
      
      public function get_visibleHeight() : Number
      {
         return _visibleHeight;
      }
      
      public function get visibleHeight() : Number
      {
         return get_visibleHeight();
      }
      
      public function get_touchPointIsSimulated() : Boolean
      {
         return _touchPointIsSimulated;
      }
      
      public function get touchPointIsSimulated() : Boolean
      {
         return get_touchPointIsSimulated();
      }
      
      public function get_touchPointID() : Object
      {
         return _touchPointID;
      }
      
      public function get touchPointID() : Object
      {
         return get_touchPointID();
      }
      
      public function get_target() : InteractiveObject
      {
         return _target;
      }
      
      public function get target() : InteractiveObject
      {
         return get_target();
      }
      
      public function get_scrolling() : Boolean
      {
         return _scrolling;
      }
      
      public function get scrolling() : Boolean
      {
         return get_scrolling();
      }
      
      public function get_scrollY() : Number
      {
         return _scrollY;
      }
      
      public function get scrollY() : Number
      {
         return get_scrollY();
      }
      
      public function get_scrollX() : Number
      {
         return _scrollX;
      }
      
      public function get scrollX() : Number
      {
         return get_scrollX();
      }
      
      public function get_restrictedScrollY() : Number
      {
         return _scrollY;
      }
      
      public function get restrictedScrollY() : Number
      {
         return get_restrictedScrollY();
      }
      
      public function get_restrictedScrollX() : Number
      {
         return _scrollX;
      }
      
      public function get restrictedScrollX() : Number
      {
         return get_restrictedScrollX();
      }
      
      public function get_minScrollY() : Number
      {
         return _minScrollY;
      }
      
      public function get minScrollY() : Number
      {
         return get_minScrollY();
      }
      
      public function get_minScrollX() : Number
      {
         return _minScrollX;
      }
      
      public function get minScrollX() : Number
      {
         return get_minScrollX();
      }
      
      public function get_maxScrollY() : Number
      {
         return _maxScrollY;
      }
      
      public function get maxScrollY() : Number
      {
         return get_maxScrollY();
      }
      
      public function get_maxScrollX() : Number
      {
         return _maxScrollX;
      }
      
      public function get maxScrollX() : Number
      {
         return get_maxScrollX();
      }
      
      public function get_draggingY() : Boolean
      {
         return _draggingY;
      }
      
      public function get draggingY() : Boolean
      {
         return get_draggingY();
      }
      
      public function get_draggingX() : Boolean
      {
         return _draggingX;
      }
      
      public function get draggingX() : Boolean
      {
         return get_draggingX();
      }
      
      public function get_decelerationRate() : Number
      {
         return _decelerationRate;
      }
      
      public function get decelerationRate() : Number
      {
         return get_decelerationRate();
      }
      
      public function get_contentWidth() : Number
      {
         return _contentWidth;
      }
      
      public function get contentWidth() : Number
      {
         return get_contentWidth();
      }
      
      public function get_contentHeight() : Number
      {
         return _contentHeight;
      }
      
      public function get contentHeight() : Number
      {
         return get_contentHeight();
      }
      
      public function finishScrollY() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null as Array;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _draggingY = false;
         var _loc1_:Object = null;
         if(snapPositionsY != null)
         {
            _loc2_ = Number(Math.POSITIVE_INFINITY);
            _loc3_ = 0;
            _loc4_ = snapPositionsY;
            while(_loc3_ < int(_loc4_.length))
            {
               _loc5_ = Number(_loc4_[_loc3_]);
               _loc3_++;
               _loc6_ = Math.abs(_loc5_ - _scrollY);
               if(_loc2_ > _loc6_)
               {
                  _loc2_ = _loc6_;
                  _loc1_ = _loc5_;
               }
            }
            if(_loc1_ == _scrollY)
            {
               _loc1_ = null;
            }
         }
         if(_scrollY < _minScrollY)
         {
            _loc1_ = _minScrollY;
         }
         else if(_scrollY > _maxScrollY)
         {
            _loc1_ = _maxScrollY;
         }
         if(_loc1_ == null)
         {
            completeScroll();
         }
         else
         {
            _loc2_ = Math.abs(_scrollY - _loc1_) >= 1 ? elasticSnapDuration : 0;
            throwTo(null,_loc1_,_loc2_,bounceEase);
         }
      }
      
      public function finishScrollX() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null as Array;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _draggingX = false;
         var _loc1_:Object = null;
         if(snapPositionsX != null)
         {
            _loc2_ = Number(Math.POSITIVE_INFINITY);
            _loc3_ = 0;
            _loc4_ = snapPositionsX;
            while(_loc3_ < int(_loc4_.length))
            {
               _loc5_ = Number(_loc4_[_loc3_]);
               _loc3_++;
               _loc6_ = Math.abs(_loc5_ - _scrollX);
               if(_loc2_ > _loc6_)
               {
                  _loc2_ = _loc6_;
                  _loc1_ = _loc5_;
               }
            }
            if(_loc1_ == _scrollX)
            {
               _loc1_ = null;
            }
         }
         if(_scrollX < _minScrollX)
         {
            _loc1_ = _minScrollX;
         }
         else if(_scrollX > _maxScrollX)
         {
            _loc1_ = _maxScrollX;
         }
         if(_loc1_ == null)
         {
            completeScroll();
         }
         else
         {
            _loc2_ = Math.abs(_scrollX - _loc1_) >= 1 ? elasticSnapDuration : 0;
            throwTo(_loc1_,null,_loc2_,bounceEase);
         }
      }
      
      public function completeScroll() : void
      {
         var _loc1_:* = null as DisplayObjectContainer;
         if(!_scrolling || _draggingX || _draggingY || animateScrollX != null || animateScrollY != null)
         {
            return;
         }
         _scrolling = false;
         if(_target is DisplayObjectContainer)
         {
            _loc1_ = _target;
            _loc1_.mouseChildren = restoreMouseChildren;
         }
         ScrollEvent.dispatch(this,"scrollComplete");
      }
      
      public function cleanupAfterDrag() : void
      {
         if(_touchPointID == null)
         {
            return;
         }
         _previousTouchPointID = _scrolling ? _touchPointID : null;
         _touchPointID = null;
         _touchPointIsSimulated = false;
         _target.removeEventListener(Event.REMOVED_FROM_STAGE,scroller_target_removedFromStageHandler);
         if(_target.stage != null)
         {
            _target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,scroller_target_stage_mouseMoveHandler);
            _target.stage.removeEventListener(MouseEvent.MOUSE_UP,scroller_target_stage_mouseUpHandler);
            _target.stage.removeEventListener(TouchEvent.TOUCH_MOVE,scroller_target_stage_touchMoveHandler);
            _target.stage.removeEventListener(TouchEvent.TOUCH_END,scroller_target_stage_touchEndHandler);
         }
      }
      
      public function canDragY() : Boolean
      {
         if(enabledY)
         {
            if(!(_maxScrollY > _minScrollY || forceElasticTop))
            {
               return forceElasticBottom;
            }
            return true;
         }
         return false;
      }
      
      public function canDragX() : Boolean
      {
         if(enabledX)
         {
            if(!(_maxScrollX > _minScrollX || forceElasticLeft))
            {
               return forceElasticRight;
            }
            return true;
         }
         return false;
      }
      
      public function calculateMinAndMax() : void
      {
         var _loc1_:Number = _minScrollX;
         var _loc2_:Number = _maxScrollX;
         var _loc3_:Number = _minScrollY;
         var _loc4_:Number = _maxScrollY;
         _minScrollX = 0;
         _minScrollY = 0;
         _maxScrollX = Math.max(_contentWidth,_visibleWidth) - _visibleWidth;
         _maxScrollY = Math.max(_contentHeight,_visibleHeight) - _visibleHeight;
         if(_loc1_ != _minScrollX || _loc2_ != _maxScrollX)
         {
            refreshAnimateScrollXEndRatio();
         }
         if(_loc3_ != _minScrollY || _loc4_ != _maxScrollY)
         {
            refreshAnimateScrollYEndRatio();
         }
      }
      
      public function calculateDistanceFromVelocity(param1:Number) : Number
      {
         return (param1 - Scroller.MINIMUM_VELOCITY) / _logDecelerationRate;
      }
      
      public function applyScrollRestrictions() : void
      {
         var _loc1_:Boolean = false;
         if(_scrollX < _minScrollX)
         {
            _scrollX = _minScrollX;
            _loc1_ = true;
         }
         else if(_scrollX > _maxScrollX)
         {
            _scrollX = _maxScrollX;
            _loc1_ = true;
         }
         if(_scrollY < _minScrollY)
         {
            _scrollY = _minScrollY;
            _loc1_ = true;
         }
         else if(_scrollY > _maxScrollY)
         {
            _scrollY = _maxScrollY;
            _loc1_ = true;
         }
         if(_loc1_)
         {
            ScrollEvent.dispatch(this,"scroll");
         }
      }
      
      public function animateScrollY_onComplete() : void
      {
         animateScrollY = null;
         _animateScrollYEase = null;
         finishScrollY();
      }
      
      public function animateScrollY_endRatio_onUpdate() : void
      {
         var _loc1_:Number = Lib.getTimer() / 1000;
         var _loc2_:Number = _loc1_ - animateScrollY.startTime;
         var _loc3_:Number = _loc2_ / animateScrollY.duration;
         _loc3_ = _animateScrollYEase.calculate(_loc3_);
         if(_loc3_ >= animateScrollYEndRatio && _loc2_ < animateScrollY.duration)
         {
            if(!elasticEdges)
            {
               if(_scrollY < _minScrollY)
               {
                  set_scrollY(_minScrollY);
               }
               else if(_scrollY > _maxScrollY)
               {
                  set_scrollY(_maxScrollY);
               }
            }
            Actuate.stop(animateScrollY,null,false,false);
            animateScrollY = null;
            _animateScrollYEase = null;
            finishScrollY();
            return;
         }
      }
      
      public function animateScrollX_onComplete() : void
      {
         animateScrollX = null;
         _animateScrollXEase = null;
         finishScrollX();
      }
      
      public function animateScrollX_endRatio_onUpdate() : void
      {
         var _loc1_:Number = Lib.getTimer() / 1000;
         var _loc2_:Number = _loc1_ - animateScrollX.startTime;
         var _loc3_:Number = _loc2_ / animateScrollX.duration;
         _loc3_ = _animateScrollXEase.calculate(_loc3_);
         if(_loc3_ >= animateScrollXEndRatio && _loc2_ < animateScrollX.duration)
         {
            if(!elasticEdges)
            {
               if(_scrollX < _minScrollX)
               {
                  set_scrollX(_minScrollX);
               }
               else if(_scrollX > _maxScrollX)
               {
                  set_scrollX(_maxScrollX);
               }
            }
            Actuate.stop(animateScrollX,null,false,false);
            animateScrollX = null;
            _animateScrollXEase = null;
            finishScrollX();
            return;
         }
      }
   }
}

