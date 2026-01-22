package motion.easing
{
   public class Quart
   {
      
      public static var easeIn:IEasing = new QuartEaseIn();
      
      public static var easeInOut:IEasing = new QuartEaseInOut();
      
      public static var easeOut:IEasing = new QuartEaseOut();
      
      public function Quart()
      {
      }
   }
}

import motion.easing._Quart.QuartEaseIn;
import motion.easing._Quart.QuartEaseInOut;
import motion.easing._Quart.QuartEaseOut;

