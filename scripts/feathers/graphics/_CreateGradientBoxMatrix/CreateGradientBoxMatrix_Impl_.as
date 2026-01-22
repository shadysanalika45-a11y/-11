package feathers.graphics._CreateGradientBoxMatrix
{
   import flash.geom.Matrix;
   
   public final class CreateGradientBoxMatrix_Impl_
   {
      
      public function CreateGradientBoxMatrix_Impl_()
      {
      }
      
      public static function fromRadians(param1:Number) : Function
      {
         var radians:Number = param1;
         return function(param1:Number, param2:Number, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined):Matrix
         {
            var _loc6_:Matrix = new Matrix();
            _loc6_.createGradientBox(param1,param2,radians,param4,param5);
            return _loc6_;
         };
      }
      
      public static function fromMatrix(param1:Matrix) : Function
      {
         var matrix:Matrix = param1;
         return function(param1:Number, param2:Number, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined):Matrix
         {
            return matrix;
         };
      }
   }
}

