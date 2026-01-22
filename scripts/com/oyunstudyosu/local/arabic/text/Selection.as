package com.oyunstudyosu.local.arabic.text
{
   import flash.text.TextField;
   
   public class Selection
   {
      
      private var _beginIndex:int;
      
      private var _endIndex:int;
      
      private var _direction:int;
      
      public function Selection(param1:int, param2:int, param3:int = 0)
      {
         super();
         this._endIndex = param2;
         this._beginIndex = param1;
         if(this.length > 0)
         {
            if(param3 > 0)
            {
               this._direction = param3;
            }
            else
            {
               this._direction = SelectionDirection.RIGHT;
            }
         }
      }
      
      public static function fromRTLTextField(param1:TextField) : Selection
      {
         var _loc2_:int = param1.text.length;
         return new Selection(_loc2_ - param1.selectionEndIndex,_loc2_ - param1.selectionBeginIndex);
      }
      
      public static function fromLTRTextField(param1:TextField) : Selection
      {
         return new Selection(param1.selectionEndIndex,param1.selectionBeginIndex);
      }
      
      public function move(param1:int, param2:int = -1) : void
      {
         this._beginIndex += param1;
         this._endIndex += param1;
         if(param2 >= 0)
         {
            this.clamp(param2);
         }
      }
      
      public function contract(param1:int) : void
      {
         if(this.length > 0)
         {
            if(param1 == SelectionDirection.RIGHT)
            {
               this._beginIndex = this._endIndex;
            }
            else
            {
               this._endIndex = this._beginIndex;
            }
            this._direction = SelectionDirection.NONE;
         }
      }
      
      public function extend(param1:int, param2:int = 0, param3:int = -1) : void
      {
         if(param1 == 0)
         {
            return;
         }
         if(param2 == 0)
         {
            param2 = this._direction;
         }
         if(param2 == SelectionDirection.NONE)
         {
            return;
         }
         if(this._direction == SelectionDirection.NONE)
         {
            this._direction = param2;
         }
         if(this._direction == param2)
         {
            if(this._direction == SelectionDirection.RIGHT)
            {
               this._endIndex += param1;
            }
            else
            {
               this._beginIndex -= param1;
            }
         }
         else if(this._direction == SelectionDirection.RIGHT)
         {
            this._endIndex -= param1;
         }
         else
         {
            this._beginIndex += param1;
         }
         if(param3 >= 0)
         {
            this.clamp(param3);
         }
      }
      
      public function get beginIndex() : int
      {
         return this._beginIndex;
      }
      
      public function get endIndex() : int
      {
         return this._endIndex;
      }
      
      public function get length() : int
      {
         return this.endIndex - this.beginIndex;
      }
      
      public function equals(param1:Selection) : Boolean
      {
         return this.beginIndex == param1.beginIndex && this.endIndex == param1.endIndex;
      }
      
      private function clamp(param1:int) : void
      {
         this._beginIndex = Math.max(0,Math.min(param1,this._beginIndex));
         this._endIndex = Math.max(0,Math.min(param1,this._endIndex));
         if(param1 == 0)
         {
            this._direction = SelectionDirection.NONE;
         }
      }
      
      public function get direction() : int
      {
         return this._direction;
      }
   }
}

