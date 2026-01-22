package com.oyunstudyosu.engine
{
   public class IntPoint
   {
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public function IntPoint(param1:int = 0, param2:int = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
      }
      
      public static function getDir(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:Number = Math.round(Math.atan2(param4 - param2,param3 - param1) * 180 / Math.PI / 45);
         if(_loc5_ == 0)
         {
            return 2;
         }
         if(_loc5_ == 1)
         {
            return 1;
         }
         if(_loc5_ > 0)
         {
            return 10 - _loc5_;
         }
         if(_loc5_ < 0)
         {
            return 2 - _loc5_;
         }
         return 0;
      }
      
      public function add(param1:IntPoint) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      public function toString() : String
      {
         return "[ " + this.x + ", " + this.y + " ]";
      }
      
      public function clone() : IntPoint
      {
         return new IntPoint(this.x,this.y);
      }
      
      public function equals(param1:IntPoint) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.x == param1.x && this.y == param1.y;
      }
      
      public function swap() : IntPoint
      {
         return new IntPoint(this.y,this.x);
      }
   }
}

