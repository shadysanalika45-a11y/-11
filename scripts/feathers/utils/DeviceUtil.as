package feathers.utils
{
   import flash.ui.Mouse;
   
   public class DeviceUtil
   {
      
      public static var MEDIA_QUERY_DESKTOP:String = "screen and (hover: hover) and (pointer: fine)";
      
      public static var MEDIA_QUERY_MOBILE:String = "screen and (hover: none) and (pointer: coarse)";
      
      public function DeviceUtil()
      {
      }
      
      public static function isDesktop() : Boolean
      {
         return Mouse.supportsCursor;
      }
      
      public static function isMobile() : Boolean
      {
         return !Mouse.supportsCursor;
      }
   }
}

