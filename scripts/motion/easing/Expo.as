package motion.easing
{
   public class Expo
   {
      
      public static var easeIn:IEasing = new ExpoEaseIn();
      
      public static var easeInOut:IEasing = new ExpoEaseInOut();
      
      public static var easeOut:IEasing = new ExpoEaseOut();
      
      public function Expo()
      {
      }
   }
}

import motion.easing._Expo.ExpoEaseIn;
import motion.easing._Expo.ExpoEaseInOut;
import motion.easing._Expo.ExpoEaseOut;

