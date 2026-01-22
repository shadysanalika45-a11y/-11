package com.oyunstudyosu.controls
{
   public class GamepadMultiInput
   {
      
      protected var _isDown:Boolean;
      
      protected var _isPressed:Boolean;
      
      protected var _isReleased:Boolean;
      
      protected var _downTicks:int = -1;
      
      protected var _upTicks:int = -1;
      
      protected var isOr:Boolean;
      
      protected var inputs:Array;
      
      public function GamepadMultiInput(param1:Array, param2:Boolean)
      {
         super();
         this.inputs = param1;
         this.isOr = param2;
      }
      
      public function update() : void
      {
         var _loc1_:GamepadInput = null;
         var _loc2_:GamepadInput = null;
         if(this.isOr)
         {
            this._isDown = false;
            for each(_loc1_ in this.inputs)
            {
               if(_loc1_.isDown)
               {
                  this._isDown = true;
                  break;
               }
            }
         }
         else
         {
            this._isDown = true;
            for each(_loc2_ in this.inputs)
            {
               if(!_loc2_.isDown)
               {
                  this._isDown = false;
                  break;
               }
            }
         }
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

