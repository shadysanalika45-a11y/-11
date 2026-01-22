package feathers.skins
{
   import feathers.core.InvalidationFlag;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import flash.Boot;
   
   public class RectangleSkin extends BaseGraphicsPathSkin
   {
      
      public var _cornerRadius:Number;
      
      public function RectangleSkin(param1:FillStyle = undefined, param2:LineStyle = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _cornerRadius = 0;
         super(param1,param2);
      }
      
      public function set_cornerRadius(param1:Number) : Number
      {
         if(_cornerRadius == param1)
         {
            return _cornerRadius;
         }
         _cornerRadius = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _cornerRadius;
      }
      
      public function set cornerRadius(param1:Number) : void
      {
         set_cornerRadius(param1);
      }
      
      public function get_cornerRadius() : Number
      {
         return _cornerRadius;
      }
      
      public function get cornerRadius() : Number
      {
         return get_cornerRadius();
      }
      
      override public function drawPath() : void
      {
         var _loc6_:Number = NaN;
         var _loc1_:LineStyle = getCurrentBorder();
         var _loc2_:Number = getLineThickness(_loc1_);
         var _loc3_:Number = _loc2_ / 2;
         var _loc4_:Number = Math.max(0,actualWidth - _loc2_);
         var _loc5_:Number = Math.max(0,actualHeight - _loc2_);
         if(_cornerRadius == 0)
         {
            graphics.drawRect(_loc3_,_loc3_,_loc4_,_loc5_);
         }
         else
         {
            _loc6_ = _cornerRadius * 2;
            _loc6_ = Math.min(_loc6_,Math.min(actualWidth,actualHeight));
            graphics.drawRoundRect(_loc3_,_loc3_,_loc4_,_loc5_,_loc6_);
         }
      }
   }
}

