package com.oyunstudyosu.engine.pool.model
{
   import com.oyunstudyosu.engine.pool.chars.PoolItem;
   
   public class PoolItemDirection
   {
      
      public static var action5Directions:Array = ["5","5","5","5","5","5","4","3","2","1","8","8","7","7","6","5","5","5","5","5","5","5","5","5","5"];
      
      public static var action3Directions:Array = ["3","3","3","3","3","3","4","5","6","7","8","8","1","1","2","3","3","3","3","3","3","3","3","3","3"];
      
      public function PoolItemDirection()
      {
         super();
      }
      
      public static function setDirection(param1:PoolItem) : void
      {
         var _loc2_:int = 0;
         trace("item.control.x: " + param1.control.x);
         trace("item.control.y: " + param1.control.y);
         param1._nonIsoX += param1.control.x / 5;
         param1._nonIsoY -= param1.control.y / 5;
         if(param1._nonIsoX > param1.pool.bounds.x)
         {
            param1._nonIsoX = param1.pool.bounds.x;
         }
         if(param1._nonIsoX < 0)
         {
            param1._nonIsoX = 0;
         }
         if(param1._nonIsoY > param1.pool.bounds.y)
         {
            param1._nonIsoY = param1.pool.bounds.y;
         }
         if(param1._nonIsoY < 0)
         {
            param1._nonIsoY = 0;
         }
         var _loc3_:int = Math.abs(param1.control.rotation) / 22.5;
         if(param1.control.rotation > 0)
         {
            if(_loc3_ == 0)
            {
               _loc2_ = 3;
            }
            else if(_loc3_ == 1 || _loc3_ == 2)
            {
               _loc2_ = 2;
            }
            else if(_loc3_ == 3 || _loc3_ == 4)
            {
               _loc2_ = 1;
            }
            else if(_loc3_ == 5 || _loc3_ == 6)
            {
               _loc2_ = 8;
            }
            else if(_loc3_ == 7 || _loc3_ == 8)
            {
               _loc2_ = 7;
            }
         }
         else if(_loc3_ == 0)
         {
            _loc2_ = 3;
         }
         else if(_loc3_ == 1 || _loc3_ == 2)
         {
            _loc2_ = 4;
         }
         else if(_loc3_ == 3 || _loc3_ == 4)
         {
            _loc2_ = 5;
         }
         else if(_loc3_ == 5 || _loc3_ == 6)
         {
            _loc2_ = 6;
         }
         else if(_loc3_ == 7 || _loc3_ == 8)
         {
            _loc2_ = 7;
         }
         if(_loc2_ != param1._direction)
         {
            param1._direction = _loc2_;
         }
         if(param1.control.magnitude > 0.15)
         {
            param1._status = "gm";
         }
         else
         {
            param1._status = "gi";
         }
      }
      
      public static function setActionDirection(param1:PoolItem) : void
      {
         if(param1._direction >= 1 && param1._direction <= 4)
         {
            param1._direction = 3;
         }
         else
         {
            param1._direction = 5;
         }
      }
   }
}

