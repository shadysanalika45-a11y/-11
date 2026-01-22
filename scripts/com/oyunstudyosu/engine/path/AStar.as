package com.oyunstudyosu.engine.path
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.core.Cell;
   
   public class AStar
   {
      
      public var MAX:int = 1000000000;
      
      private var width:int;
      
      private var height:int;
      
      private var start:Cell;
      
      private var goal:Cell;
      
      private var map:Vector.<Cell>;
      
      private var bit:int;
      
      public function AStar(param1:Vector.<Cell>, param2:int, param3:int, param4:IntPoint, param5:IntPoint, param6:int)
      {
         super();
         this.bit = param6;
         this.width = param2;
         this.height = param3;
         this.start = new Cell(param4.x,param4.y);
         this.goal = new Cell(param5.x,param5.y);
         this.map = param1;
      }
      
      public function solve(param1:ICharacter = null) : Vector.<IntPoint>
      {
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = width * height;
         var _loc12_:Boolean = false;
         var _loc3_:int = start.y * width + start.x;
         var _loc13_:int = goal.y * width + goal.x;
         if(_loc3_ == _loc13_)
         {
            return new Vector.<IntPoint>();
         }
         var _loc4_:Vector.<int> = new Vector.<int>();
         _loc4_.push(_loc3_);
         var _loc6_:Vector.<int> = new Vector.<int>();
         _loc11_ = 0;
         while(_loc11_ < _loc2_)
         {
            if(param1 != null && map[_loc11_].isWalkable(param1) || param1 == null && map[_loc11_].isWalkableBit(bit))
            {
               _loc6_[_loc11_] = MAX;
            }
            else
            {
               _loc6_[_loc11_] = -1;
            }
            _loc11_++;
         }
         _loc6_[_loc3_] = 0;
         while(!_loc12_)
         {
            _loc8_ = int(_loc4_.length);
            if(_loc8_ == 0)
            {
               return null;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc8_)
            {
               processNeighbours(_loc4_.shift(),_loc6_,_loc4_);
               _loc11_++;
            }
            _loc11_ = 0;
            while(_loc11_ < _loc4_.length)
            {
               if(_loc4_[_loc11_] == _loc13_)
               {
                  _loc12_ = true;
                  break;
               }
               _loc11_++;
            }
         }
         var _loc7_:Vector.<int> = new Vector.<int>();
         var _loc5_:* = _loc13_;
         _loc7_.unshift(_loc5_);
         while(_loc5_ != _loc3_)
         {
            _loc5_ = minimumKomsuBul(_loc5_,_loc6_);
            _loc7_.unshift(_loc5_);
         }
         var _loc9_:Vector.<IntPoint> = new Vector.<IntPoint>();
         _loc11_ = 0;
         while(_loc11_ < _loc7_.length)
         {
            _loc9_.unshift(new IntPoint(_loc7_[_loc11_] % width,_loc7_[_loc11_] / width));
            _loc11_++;
         }
         if(_loc9_.length == 0)
         {
            _loc9_ = null;
         }
         return _loc9_;
      }
      
      public function minimumKomsuBul(param1:int, param2:Vector.<int>) : int
      {
         var _loc4_:int = 0;
         var _loc5_:int = param1 % width;
         var _loc6_:int = param1 / width;
         var _loc3_:int = MAX;
         if(_loc5_ > 0)
         {
            if(param2[param1 - 1] < _loc3_ && param2[param1 - 1] != -1)
            {
               _loc3_ = param2[param1 - 1];
               _loc4_ = param1 - 1;
            }
            if(_loc6_ > 0)
            {
               if(param2[param1 - width - 1] < _loc3_ && param2[param1 - width] != -1 && param2[param1 - 1] != -1 && param2[param1 - width - 1] != -1)
               {
                  _loc3_ = param2[param1 - width - 1];
                  _loc4_ = param1 - width - 1;
               }
            }
            if(_loc6_ < height - 1)
            {
               if(param2[param1 + width - 1] < _loc3_ && param2[param1 + width] != -1 && param2[param1 - 1] != -1 && param2[param1 + width - 1] != -1)
               {
                  _loc3_ = param2[param1 + width - 1];
                  _loc4_ = param1 + width - 1;
               }
            }
         }
         if(_loc5_ < width - 1)
         {
            if(param2[param1 + 1] < _loc3_ && param2[param1 + 1] != -1)
            {
               _loc3_ = param2[param1 + 1];
               _loc4_ = param1 + 1;
            }
            if(_loc6_ > 0)
            {
               if(param2[param1 - width + 1] < _loc3_ && param2[param1 - width] != -1 && param2[param1 + 1] != -1 && param2[param1 - width + 1] != -1)
               {
                  _loc3_ = param2[param1 - width + 1];
                  _loc4_ = param1 - width + 1;
               }
            }
            if(_loc6_ < height - 1)
            {
               if(param2[param1 + width + 1] < _loc3_ && param2[param1 + width] != -1 && param2[param1 + 1] != -1 && param2[param1 + width + 1] != -1)
               {
                  _loc3_ = param2[param1 + width + 1];
                  _loc4_ = param1 + width + 1;
               }
            }
         }
         if(_loc6_ > 0)
         {
            if(param2[param1 - width] < _loc3_ && param2[param1 - width] != -1)
            {
               _loc3_ = param2[param1 - width];
               _loc4_ = param1 - width;
            }
         }
         if(_loc6_ < height - 1)
         {
            if(param2[param1 + width] < _loc3_ && param2[param1 + width] != -1)
            {
               _loc3_ = param2[param1 + width];
               _loc4_ = param1 + width;
            }
         }
         return _loc4_;
      }
      
      public function processNeighbours(param1:int, param2:Vector.<int>, param3:Vector.<int>) : void
      {
         var _loc4_:int = param1 % width;
         var _loc5_:int = param1 / width;
         if(_loc4_ > 0)
         {
            if(param2[param1 - 1] > param2[param1] + 2)
            {
               param2[param1 - 1] = param2[param1] + 2;
               param3.push(param1 - 1);
            }
            if(_loc5_ > 0)
            {
               if(param2[param1 - width - 1] > param2[param1] + 3 && param2[param1 - width] != -1 && param2[param1 - 1] != -1)
               {
                  param2[param1 - width - 1] = param2[param1] + 3;
                  param3.push(param1 - width - 1);
               }
            }
            if(_loc5_ < height - 1)
            {
               if(param2[param1 + width - 1] > param2[param1] + 3 && param2[param1 + width] != -1 && param2[param1 - 1] != -1)
               {
                  param2[param1 + width - 1] = param2[param1] + 3;
                  param3.push(param1 + width - 1);
               }
            }
         }
         if(_loc4_ < width - 1)
         {
            if(param2[param1 + 1] > param2[param1] + 2)
            {
               param2[param1 + 1] = param2[param1] + 2;
               param3.push(param1 + 1);
            }
            if(_loc5_ > 0)
            {
               if(param2[param1 - width + 1] > param2[param1] + 3 && param2[param1 - width] != -1 && param2[param1 + 1] != -1)
               {
                  param2[param1 - width + 1] = param2[param1] + 3;
                  param3.push(param1 - width + 1);
               }
            }
            if(_loc5_ < height - 1)
            {
               if(param2[param1 + width + 1] > param2[param1] + 3 && param2[param1 + width] != -1 && param2[param1 + 1] != -1)
               {
                  param2[param1 + width + 1] = param2[param1] + 3;
                  param3.push(param1 + width + 1);
               }
            }
         }
         if(_loc5_ > 0)
         {
            if(param2[param1 - width] > param2[param1] + 2)
            {
               param2[param1 - width] = param2[param1] + 2;
               param3.push(param1 - width);
            }
         }
         if(_loc5_ < height - 1)
         {
            if(param2[param1 + width] > param2[param1] + 2)
            {
               param2[param1 + width] = param2[param1] + 2;
               param3.push(param1 + width);
            }
         }
      }
   }
}

