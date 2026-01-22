package com.oyunstudyosu.local.arabic.text
{
   public class JumpToWordOperation implements ITextOperation
   {
      
      private var direction:int;
      
      private var select:Boolean;
      
      public function JumpToWordOperation(param1:int, param2:Boolean = false)
      {
         this.select = param2;
         super();
         if(!(param1 == SelectionDirection.LEFT || param1 == SelectionDirection.RIGHT))
         {
            throw new ArgumentError("Direction should be left or right");
         }
         this.direction = param1;
      }
      
      public function perform(param1:ITextOperationContext) : void
      {
         var _loc9_:int = 0;
         var _loc2_:RegExp = /\s/g;
         var _loc3_:String = param1.getText();
         var _loc4_:* = _loc2_.exec(_loc3_);
         var _loc5_:Selection = param1.getSelection();
         var _loc6_:int = _loc5_.endIndex;
         if(_loc5_.length > 0 && this.direction == SelectionDirection.LEFT)
         {
            _loc6_ = _loc5_.beginIndex;
         }
         var _loc7_:Vector.<int> = new <int>[0];
         while(_loc4_)
         {
            _loc7_.push(int(_loc4_["index"]));
            _loc4_ = _loc2_.exec(_loc3_);
         }
         _loc7_.push(_loc3_.length);
         var _loc8_:int = int(_loc7_.length);
         var _loc10_:int = -1;
         if(this.direction == SelectionDirection.RIGHT)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               if(_loc7_[_loc9_] > _loc6_)
               {
                  _loc10_ = _loc7_[_loc9_] + 1;
                  break;
               }
               _loc9_++;
            }
         }
         else
         {
            _loc9_ = _loc8_ - 1;
            while(_loc9_ >= 0)
            {
               if(_loc7_[_loc9_] < _loc6_)
               {
                  _loc10_ = _loc7_[_loc9_];
                  break;
               }
               _loc9_--;
            }
         }
         if(_loc10_ >= 0)
         {
            if(!this.select)
            {
               param1.setSelection(new Selection(_loc10_,_loc10_));
            }
            else
            {
               if(_loc5_.direction != this.direction)
               {
                  _loc5_.contract(this.direction);
               }
               if(this.direction == SelectionDirection.LEFT)
               {
                  param1.setSelection(new Selection(_loc10_,_loc5_.endIndex,this.direction));
               }
               else
               {
                  param1.setSelection(new Selection(_loc5_.beginIndex,_loc10_,this.direction));
               }
            }
         }
      }
      
      public function requiresDraw() : Boolean
      {
         return false;
      }
   }
}

