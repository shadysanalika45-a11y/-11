package com.oyunstudyosu.controls
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class Gamepad
   {
      
      protected var _up:GamepadInput;
      
      protected var _down:GamepadInput;
      
      protected var _left:GamepadInput;
      
      protected var _right:GamepadInput;
      
      protected var _fire1:GamepadInput;
      
      protected var _fire2:GamepadInput;
      
      protected var _inputs:Array;
      
      protected var _upLeft:GamepadMultiInput;
      
      protected var _downLeft:GamepadMultiInput;
      
      protected var _upRight:GamepadMultiInput;
      
      protected var _downRight:GamepadMultiInput;
      
      protected var _anyDirection:GamepadMultiInput;
      
      protected var _multiInputs:Array;
      
      protected var _x:Number = 0;
      
      protected var _y:Number = 0;
      
      protected var _targetX:Number = 0;
      
      protected var _targetY:Number = 0;
      
      protected var _angle:Number = 0;
      
      protected var _rotation:Number = 0;
      
      protected var _magnitude:Number = 0;
      
      public var isCircle:Boolean;
      
      public var ease:Number;
      
      protected var stage:Stage;
      
      public function Gamepad(param1:Stage, param2:Boolean, param3:Number = 0.2, param4:Boolean = true)
      {
         super();
         this.isCircle = param2;
         this.ease = param3;
         this.stage = param1;
         this._up = new GamepadInput();
         this._down = new GamepadInput();
         this._left = new GamepadInput();
         this._right = new GamepadInput();
         this._fire1 = new GamepadInput();
         this._fire2 = new GamepadInput();
         this._inputs = [this._up,this._down,this._left,this._right,this._fire1,this._fire2];
         this._upLeft = new GamepadMultiInput([this._up,this._left],false);
         this._upRight = new GamepadMultiInput([this._up,this._right],false);
         this._downLeft = new GamepadMultiInput([this._down,this._left],false);
         this._downRight = new GamepadMultiInput([this._down,this._right],false);
         this._anyDirection = new GamepadMultiInput([this._up,this._down,this._left,this._right],true);
         this._multiInputs = [this._upLeft,this._upRight,this._downLeft,this._downRight,this._anyDirection];
         this.useArrows();
         this.useControlSpace();
         param1.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown,false,0,true);
         param1.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,0,true);
         if(param4)
         {
            param1.addEventListener(Event.ENTER_FRAME,this.onEnterFrame,false,0,true);
         }
      }
      
      public function destroy() : void
      {
         this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         this.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function mapDirection(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : void
      {
         this._up.mapKey(param1,param5);
         this._down.mapKey(param2,param5);
         this._left.mapKey(param3,param5);
         this._right.mapKey(param4,param5);
      }
      
      public function useArrows(param1:Boolean = false) : void
      {
         this.mapDirection(Keyboard.UP,Keyboard.DOWN,Keyboard.LEFT,Keyboard.RIGHT,param1);
      }
      
      public function useWASD(param1:Boolean = false) : void
      {
         this.mapDirection(KeyCode.W,KeyCode.S,KeyCode.A,KeyCode.D,param1);
      }
      
      public function useIJKL(param1:Boolean = false) : void
      {
         this.mapDirection(KeyCode.I,KeyCode.K,KeyCode.J,KeyCode.L,param1);
      }
      
      public function useZQSD(param1:Boolean = false) : void
      {
         this.mapDirection(KeyCode.Z,KeyCode.S,KeyCode.Q,KeyCode.D,param1);
      }
      
      public function mapFireButtons(param1:int, param2:int, param3:Boolean = false) : void
      {
         this._fire1.mapKey(param1,param3);
         this._fire2.mapKey(param2,param3);
      }
      
      public function useChevrons(param1:Boolean = false) : void
      {
         this.mapFireButtons(KeyCode.LESS_THAN,KeyCode.GREATER_THAN,param1);
      }
      
      public function useGH(param1:Boolean = false) : void
      {
         this.mapFireButtons(KeyCode.G,KeyCode.H,param1);
      }
      
      public function useZX(param1:Boolean = false) : void
      {
         this.mapFireButtons(KeyCode.Z,KeyCode.X,param1);
      }
      
      public function useYX(param1:Boolean = false) : void
      {
         this.mapFireButtons(KeyCode.Y,KeyCode.X,param1);
      }
      
      public function useControlSpace(param1:Boolean = false) : void
      {
         this.mapFireButtons(KeyCode.CONTROL,KeyCode.SPACEBAR,param1);
      }
      
      public function step() : void
      {
         var _loc1_:GamepadInput = null;
         this._x += (this._targetX - this._x) * this.ease;
         this._y += (this._targetY - this._y) * this.ease;
         this._magnitude = Math.sqrt(this._x * this._x + this._y * this._y);
         this._angle = Math.atan2(this._x,this._y);
         this._rotation = this._angle * 57.29577951308232;
         for each(_loc1_ in this._inputs)
         {
            _loc1_.update();
         }
      }
      
      public function get angle() : Number
      {
         return this._angle;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function get up() : GamepadInput
      {
         return this._up;
      }
      
      public function get down() : GamepadInput
      {
         return this._down;
      }
      
      public function get left() : GamepadInput
      {
         return this._left;
      }
      
      public function get right() : GamepadInput
      {
         return this._right;
      }
      
      public function get upLeft() : GamepadMultiInput
      {
         return this._upLeft;
      }
      
      public function get downLeft() : GamepadMultiInput
      {
         return this._downLeft;
      }
      
      public function get upRight() : GamepadMultiInput
      {
         return this._upRight;
      }
      
      public function get downRight() : GamepadMultiInput
      {
         return this._downRight;
      }
      
      public function get fire1() : GamepadInput
      {
         return this._fire1;
      }
      
      public function get fire2() : GamepadInput
      {
         return this._fire2;
      }
      
      public function get anyDirection() : GamepadMultiInput
      {
         return this._anyDirection;
      }
      
      public function get magnitude() : Number
      {
         return this._magnitude;
      }
      
      public function get rotation() : Number
      {
         return this._rotation;
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         this.step();
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:GamepadInput = null;
         for each(_loc2_ in this._inputs)
         {
            _loc2_.keyDown(param1.keyCode);
         }
         this.updateState();
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:GamepadInput = null;
         for each(_loc2_ in this._inputs)
         {
            _loc2_.keyUp(param1.keyCode);
         }
         this.updateState();
      }
      
      protected function updateState() : void
      {
         var _loc1_:GamepadMultiInput = null;
         for each(_loc1_ in this._multiInputs)
         {
            _loc1_.update();
         }
         if(this._up.isDown)
         {
            this._targetY = -1;
         }
         else if(this._down.isDown)
         {
            this._targetY = 1;
         }
         else
         {
            this._targetY = 0;
         }
         if(this._left.isDown)
         {
            this._targetX = -1;
         }
         else if(this._right.isDown)
         {
            this._targetX = 1;
         }
         else
         {
            this._targetX = 0;
         }
         var _loc2_:Number = Math.atan2(this._targetX,this._targetY);
         if(this.isCircle && this._anyDirection.isDown)
         {
            this._targetX = Math.sin(_loc2_);
            this._targetY = Math.cos(_loc2_);
         }
      }
   }
}

