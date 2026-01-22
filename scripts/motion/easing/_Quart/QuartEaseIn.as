package motion.easing._Quart
{
   import motion.easing.IEasing;
   
   public class QuartEaseIn implements IEasing
   {
      
      public function QuartEaseIn()
      {
      }
      
      public function ease(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * (param1 /= param4) * param1 * param1 * param1 + param2;
      }
      
      public function calculate(param1:Number) : Number
      {
         return param1 * param1 * param1 * param1;
      }
   }
}

