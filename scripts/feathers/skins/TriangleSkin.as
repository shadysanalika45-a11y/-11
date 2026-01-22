package feathers.skins
{
   import feathers.core.InvalidationFlag;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.layout.RelativePosition;
   import flash.Boot;
   
   public class TriangleSkin extends BaseGraphicsPathSkin
   {
      
      public var _pointPosition:RelativePosition;
      
      public var _drawBaseBorder:Boolean;
      
      public function TriangleSkin(param1:FillStyle = undefined, param2:LineStyle = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _drawBaseBorder = true;
         _pointPosition = RelativePosition.TOP;
         super(param1,param2);
      }
      
      public function set_pointPosition(param1:RelativePosition) : RelativePosition
      {
         if(_pointPosition == param1)
         {
            return _pointPosition;
         }
         _pointPosition = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _pointPosition;
      }
      
      public function set pointPosition(param1:RelativePosition) : void
      {
         set_pointPosition(param1);
      }
      
      public function set_drawBaseBorder(param1:Boolean) : Boolean
      {
         if(_drawBaseBorder == param1)
         {
            return _drawBaseBorder;
         }
         _drawBaseBorder = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _drawBaseBorder;
      }
      
      public function set drawBaseBorder(param1:Boolean) : void
      {
         set_drawBaseBorder(param1);
      }
      
      public function get_pointPosition() : RelativePosition
      {
         return _pointPosition;
      }
      
      public function get pointPosition() : RelativePosition
      {
         return get_pointPosition();
      }
      
      public function get_drawBaseBorder() : Boolean
      {
         return _drawBaseBorder;
      }
      
      public function get drawBaseBorder() : Boolean
      {
         return get_drawBaseBorder();
      }
      
      override public function drawPath() : void
      {
         var _loc1_:LineStyle = getCurrentBorder();
         var _loc2_:Number = getLineThickness(_loc1_) / 2;
         var _loc3_:Number = Math.max(0,actualWidth - _loc2_);
         var _loc4_:Number = Math.max(0,actualHeight - _loc2_);
         switch(_pointPosition.index)
         {
            case 0:
               graphics.moveTo(actualWidth / 2,_loc2_);
               if(_drawBaseBorder)
               {
                  graphics.lineTo(_loc3_,_loc4_);
                  graphics.lineTo(_loc2_,_loc4_);
               }
               else
               {
                  graphics.lineTo(_loc3_,actualHeight);
                  graphics.lineStyle(0,null,0,null,null,null,null,0);
                  graphics.lineTo(_loc2_,actualHeight);
                  applyLineStyle(_loc1_);
               }
               graphics.lineTo(actualWidth / 2,_loc2_);
               break;
            case 1:
               if(_drawBaseBorder)
               {
                  graphics.moveTo(_loc2_,_loc2_);
               }
               else
               {
                  graphics.moveTo(0,_loc2_);
               }
               graphics.lineTo(_loc3_,actualHeight / 2);
               if(_drawBaseBorder)
               {
                  graphics.lineTo(_loc2_,_loc4_);
                  graphics.lineTo(_loc2_,_loc2_);
                  break;
               }
               graphics.lineTo(0,_loc4_);
               graphics.lineStyle(0,null,0,null,null,null,null,0);
               graphics.lineTo(0,_loc2_);
               applyLineStyle(_loc1_);
               break;
            case 2:
               if(_drawBaseBorder)
               {
                  graphics.moveTo(_loc2_,_loc2_);
                  graphics.lineTo(_loc3_,_loc2_);
               }
               else
               {
                  graphics.lineStyle(0,null,0,null,null,null,null,0);
                  graphics.moveTo(_loc2_,0);
                  graphics.lineTo(_loc3_,0);
                  applyLineStyle(_loc1_);
               }
               graphics.lineTo(actualWidth / 2,_loc4_);
               if(_drawBaseBorder)
               {
                  graphics.lineTo(_loc2_,_loc2_);
                  break;
               }
               graphics.lineTo(_loc2_,0);
               break;
            case 3:
               if(_drawBaseBorder)
               {
                  graphics.moveTo(_loc3_,_loc2_);
                  graphics.lineTo(_loc3_,_loc4_);
               }
               else
               {
                  graphics.moveTo(actualWidth,_loc2_);
                  graphics.lineStyle(0,null,0,null,null,null,null,0);
                  graphics.lineTo(actualWidth,_loc4_);
                  applyLineStyle(_loc1_);
               }
               graphics.lineTo(_loc2_,actualHeight / 2);
               if(_drawBaseBorder)
               {
                  graphics.lineTo(_loc3_,_loc2_);
                  break;
               }
               graphics.lineTo(actualWidth,_loc2_);
               break;
            default:
               throw new ArgumentError("Triangle pointPosition not supported: " + Std.string(_pointPosition));
         }
      }
   }
}

