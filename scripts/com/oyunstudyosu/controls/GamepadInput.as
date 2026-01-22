package com.oyunstudyosu.controls
{
   public class GamepadInput
   {
      
      protected var _isDown:Boolean;
      
      protected var _isPressed:Boolean;
      
      protected var _isReleased:Boolean;
      
      protected var _downTicks:int = -1;
      
      protected var _upTicks:int = -1;
      
      protected var mappedKeys:Array;
      
      public function GamepadInput(param1:int = -1)
      {
         super();
         this.mappedKeys = param1 > -1 ? [param1] : [];
      }
      
      public function mapKey(param1:int, param2:Boolean = false) : void
      {
         if(param2)
         {
            this.mappedKeys = [param1];
         }
         else if(this.mappedKeys.indexOf(param1) == -1)
         {
            this.mappedKeys.push(param1);
         }
      }
      
      public function unmapKey(param1:int) : void
      {
         this.mappedKeys.splice(this.mappedKeys.indexOf(param1),1);
      }
      
      public function update() : void
      {
         if(this._isDown)
         {
            this._isPressed = this._downTicks == -1;
            this._isReleased = false;
            ++this._downTicks;
            this._upTicks = -1;
         }
         else
         {
            this._isReleased = this._upTicks == -1;
            this._isPressed = false;
            ++this._upTicks;
            this._downTicks = -1;
         }
      }
      
      public function keyDown(param1:int) : void
      {
         if(this.mappedKeys.indexOf(param1) > -1)
         {
            this._isDown = true;
         }
      }
      
      public function containsKey(param1:int) : Boolean
      {
         if(this.mappedKeys.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
      
      public function keyUp(param1:int) : void
      {
         if(this.mappedKeys.indexOf(param1) > -1)
         {
            this._isDown = false;
         }
      }
      
      public function get isDown() : Boolean
      {
         return this._isDown;
      }
      
      public function get isPressed() : Boolean
      {
         return this._isPressed;
      }
      
      public function get isReleased() : Boolean
      {
         return this._isReleased;
      }
      
      public function get downTicks() : int
      {
         return this._downTicks;
      }
      
      public function get upTicks() : int
      {
         return this._upTicks;
      }
   }
}

