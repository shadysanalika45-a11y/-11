package com.oyunstudyosu.utils
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   public class DrawUtils
   {
      
      public function DrawUtils()
      {
         super();
      }
      
      public static function getRectangleSprite(param1:int, param2:int, param3:uint, param4:Number) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Graphics = _loc5_.graphics;
         _loc6_.beginFill(param3,param4);
         _loc6_.drawRect(0,0,param1,param2);
         return _loc5_;
      }
      
      public static function getCircleSprite(param1:uint, param2:int) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(param1);
         _loc3_.graphics.drawCircle(0,0,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      public static function getLineSprite(param1:int, param2:int, param3:uint, param4:Number) : Sprite
      {
         var _loc5_:Sprite = new Sprite();
         var _loc6_:Graphics = _loc5_.graphics;
         _loc6_.lineStyle(1,param3,param4);
         _loc6_.lineTo(param1,param2);
         return _loc5_;
      }
   }
}

