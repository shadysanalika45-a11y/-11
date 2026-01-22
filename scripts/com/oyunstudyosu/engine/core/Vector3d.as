package com.oyunstudyosu.engine.core
{
   public class Vector3d
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var z:Number = 0;
      
      public function Vector3d(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.z = param3;
      }
      
      public function clone() : Vector3d
      {
         return new Vector3d(this.x,this.y,this.z);
      }
      
      public function equals(param1:Vector3d) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return Math.abs(param1.x - this.x) < 0.00001 && Math.abs(param1.z - this.z) < 0.00001;
      }
      
      public function toString() : String
      {
         return "[" + this.x + " : " + this.y + " : " + this.z + "]";
      }
      
      public function minus(param1:Vector3d) : void
      {
         this.x -= param1.x;
         this.y -= param1.y;
         this.z -= param1.z;
      }
   }
}

