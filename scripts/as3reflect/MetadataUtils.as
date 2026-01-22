package as3reflect
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class MetadataUtils
   {
      
      private static var _timer:Timer;
      
      private static var _cache:Object = new Object();
      
      public static var CLEAR_CACHE_INTERVAL:uint = 60000;
      
      public function MetadataUtils()
      {
         super();
      }
      
      public static function getFromString(param1:String) : XML
      {
         var _loc2_:Class = getDefinitionByName(param1) as Class;
         return getFromObject(_loc2_);
      }
      
      public static function clearCache() : void
      {
         _cache = new Object();
         if(Boolean(_timer) && _timer.running)
         {
            _timer.stop();
         }
      }
      
      private static function _timerHandler(param1:TimerEvent) : void
      {
         clearCache();
      }
      
      public static function getFromObject(param1:Object) : XML
      {
         var _loc2_:XML = null;
         var _loc3_:String = getQualifiedClassName(param1);
         if(_cache.hasOwnProperty(_loc3_))
         {
            _loc2_ = _cache[_loc3_];
         }
         else
         {
            if(!_timer)
            {
               _timer = new Timer(CLEAR_CACHE_INTERVAL,1);
               _timer.addEventListener(TimerEvent.TIMER,_timerHandler);
            }
            if(!(param1 is Class))
            {
               param1 = param1.constructor;
            }
            _loc2_ = describeType(param1);
            _cache[_loc3_] = _loc2_;
            if(!_timer.running)
            {
               _timer.start();
            }
         }
         return _loc2_;
      }
   }
}

