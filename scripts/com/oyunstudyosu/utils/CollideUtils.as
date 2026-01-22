package com.oyunstudyosu.utils
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class CollideUtils
   {
      
      public function CollideUtils()
      {
         super();
      }
      
      public static function isColliding(param1:Sprite, param2:int, param3:int) : Boolean
      {
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc4_.draw(param1,new Matrix(1,0,0,1,param1.width / 2,param1.height));
         var _loc5_:Point = param1.globalToLocal(new Point(param2,param3));
         var _loc6_:Point = new Point(param1.width / 2 + _loc5_.x,param1.height + _loc5_.y);
         var _loc7_:Boolean = _loc4_.hitTest(new Point(0,0),0,_loc6_);
         _loc4_.dispose();
         _loc4_ = null;
         _loc6_ = null;
         _loc5_ = null;
         return _loc7_;
      }
   }
}

