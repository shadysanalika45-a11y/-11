package motion.easing._Quart
{
   import motion.easing.IEasing;
   
   public class QuartEaseInOut implements IEasing
   {
      
      public function QuartEaseInOut()
      {
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 /= param4 / 2;
         if(param1 < 1)
         {
            return param3 / 2 * param1 * param1 * param1 * param1 + param2;
         }
         return -param3 / 2 * ((param1 -= 2) * param1 * param1 * param1 - 2) + param2;
      }
      
      public function calculate(param1:Number) : Number
      {
         param1 *= 2;
         if(param1 < 1)
         {
            return 0.5 * param1 * param1 * param1 * param1;
         }
         return -0.5 * ((param1 -= 2) * param1 * param1 * param1 - 2);
      }
   }
}

