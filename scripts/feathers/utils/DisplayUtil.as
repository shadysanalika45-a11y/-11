package feathers.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.geom.Point;
   
   public class DisplayUtil
   {
      
      public function DisplayUtil()
      {
      }
      
      public static function getDisplayObjectDepthFromStage(param1:DisplayObject) : int
      {
         if(param1.stage == null)
         {
            return -1;
         }
         var _loc2_:int = 0;
         while(param1.parent != null)
         {
            param1 = param1.parent;
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function getConcatenatedScaleX(param1:DisplayObject) : Number
      {
         if(param1 == null)
         {
            throw new ArgumentError("getConcatenatedScaleX target must not be null");
         }
         var _loc2_:Number = 1;
         var _loc3_:DisplayObject = param1;
         do
         {
            _loc2_ /= _loc3_.scaleX;
            _loc3_ = _loc3_.parent;
         }
         while(_loc3_ != null && _loc3_ != _loc3_.stage);
         
         return _loc2_;
      }
      
      public static function getConcatenatedScaleY(param1:DisplayObject) : Number
      {
         if(param1 == null)
         {
            throw new ArgumentError("getConcatenatedScaleY target must not be null");
         }
         var _loc2_:Number = 1;
         var _loc3_:DisplayObject = param1;
         do
         {
            _loc2_ /= _loc3_.scaleY;
            _loc3_ = _loc3_.parent;
         }
         while(_loc3_ != null && _loc3_ != _loc3_.stage);
         
         return _loc2_;
      }
      
      public static function getConcatenatedScale(param1:DisplayObject, param2:Point = undefined) : Point
      {
         if(param1 == null)
         {
            throw new ArgumentError("getConcatenatedScale target must not be null");
         }
         var _loc3_:Number = 1;
         var _loc4_:Number = 1;
         var _loc5_:DisplayObject = param1;
         do
         {
            _loc3_ /= _loc5_.scaleX;
            _loc4_ /= _loc5_.scaleY;
            _loc5_ = _loc5_.parent;
         }
         while(_loc5_ != null && _loc5_ != _loc5_.stage);
         
         if(param2 == null)
         {
            return new Point(_loc3_,_loc4_);
         }
         param2.setTo(_loc3_,_loc4_);
         return param2;
      }
   }
}

