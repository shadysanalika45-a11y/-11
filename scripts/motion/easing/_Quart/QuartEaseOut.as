package motion.easing._Quart
{
   import motion.easing.IEasing;
   
   public class QuartEaseOut implements IEasing
   {
      
      public function QuartEaseOut()
      {
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = param1 / param4 - 1;
         return -param3 * (param1 * param1 * param1 * param1 - 1) + param2;
      }
      
      public function calculate(param1:Number) : Number
      {
         return -(--param1 * param1 * param1 * param1 - 1);
      }
   }
}

