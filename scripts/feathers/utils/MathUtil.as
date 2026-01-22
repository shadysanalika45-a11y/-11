package feathers.utils
{
   public class MathUtil
   {
      
      public function MathUtil()
      {
      }
      
      public static function roundDownToNearest(param1:Number, param2:Number = 1) : Number
      {
         if(param2 == 0)
         {
            return param1;
         }
         return Math.floor(MathUtil.roundToPrecision(param1 / param2,10)) * param2;
      }
      
      public static function roundUpToNearest(param1:Number, param2:Number = 1) : Number
      {
         if(param2 == 0)
         {
            return param1;
         }
         return Math.ceil(MathUtil.roundToPrecision(param1 / param2,10)) * param2;
      }
      
      public static function roundToNearest(param1:Number, param2:Number = 1) : Number
      {
         if(param2 == 0)
         {
            return param1;
         }
         return Math.round(MathUtil.roundToPrecision(param1 / param2,10)) * param2;
      }
      
      public static function roundToPrecision(param1:Number, param2:int = 0) : Number
      {
         var _loc3_:Number = Math.pow(10,param2);
         return Math.round(_loc3_ * param1) / _loc3_;
      }
      
      public static function fuzzyEquals(param1:Number, param2:Number, param3:Number = 0.000001) : Boolean
      {
         return Math.abs(param1 - param2) <= param3;
      }
   }
}

