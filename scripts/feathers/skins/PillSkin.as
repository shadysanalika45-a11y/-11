package feathers.skins
{
   import feathers.core.InvalidationFlag;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.layout.Direction;
   import flash.Boot;
   
   public class PillSkin extends BaseGraphicsPathSkin
   {
      
      public var _capDirection:Direction;
      
      public function PillSkin(param1:FillStyle = undefined, param2:LineStyle = undefined, param3:Direction = undefined)
      {
         if(param3 == null)
         {
            param3 = Direction.HORIZONTAL;
         }
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
         _capDirection = param3;
      }
      
      public function set_capDirection(param1:Direction) : Direction
      {
         if(_capDirection == param1)
         {
            return _capDirection;
         }
         _capDirection = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _capDirection;
      }
      
      public function set capDirection(param1:Direction) : void
      {
         set_capDirection(param1);
      }
      
      public function get_capDirection() : Direction
      {
         return _capDirection;
      }
      
      public function get capDirection() : Direction
      {
         return get_capDirection();
      }
      
      override public function drawPath() : void
      {
         var _loc1_:LineStyle = getCurrentBorder();
         var _loc2_:Number = getLineThickness(_loc1_);
         var _loc3_:Number = _loc2_ / 2;
         var _loc4_:Number = Math.max(0,actualWidth - _loc2_);
         var _loc5_:Number = Math.max(0,actualHeight - _loc2_);
         var _loc6_:Number = get_capDirection() == Direction.VERTICAL ? actualWidth : actualHeight;
         graphics.drawRoundRect(_loc3_,_loc3_,_loc4_,_loc5_,_loc6_);
      }
   }
}

