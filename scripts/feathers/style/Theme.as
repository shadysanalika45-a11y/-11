package feathers.style
{
   import feathers.themes.steel.DefaultSteelTheme;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import haxe.IMap;
   import haxe.ds.ObjectMap;
   
   public final class Theme
   {
      
      public static var _fallbackTheme:ITheme;
      
      public static var primaryTheme:ITheme;
      
      public static var rootToTheme:IMap;
      
      public static var roots:Array = null;
      
      public function Theme()
      {
      }
      
      public static function get_fallbackTheme() : ITheme
      {
         if(Theme._fallbackTheme == null)
         {
            Theme._fallbackTheme = new DefaultSteelTheme();
         }
         return Theme._fallbackTheme;
      }
      
      public static function setTheme(param1:ITheme, param2:DisplayObjectContainer = undefined, param3:Boolean = true) : void
      {
         var _loc5_:* = null as IMap;
         var _loc4_:ITheme = null;
         if(param2 == null)
         {
            _loc4_ = Theme.primaryTheme;
            Theme.primaryTheme = param1;
         }
         else if(Theme.roots == null)
         {
            Theme.roots = [param2];
            _loc5_ = new ObjectMap();
            _loc5_[param2] = param1;
            Theme.rootToTheme = _loc5_;
         }
         else
         {
            _loc4_ = Theme.rootToTheme[param2];
            if(_loc4_ == null)
            {
               Theme.roots.push(param2);
            }
            Theme.rootToTheme[param2] = param1;
         }
         if(_loc4_ != null && param3)
         {
            _loc4_.dispose();
         }
      }
      
      public static function getTheme(param1:IStyleObject = undefined) : ITheme
      {
         var _loc2_:* = null as DisplayObject;
         var _loc3_:* = null as IStyleObject;
         var _loc4_:* = null as DisplayObject;
         var _loc5_:int = 0;
         var _loc6_:* = null as Array;
         var _loc7_:* = null as DisplayObjectContainer;
         if(param1 is DisplayObject)
         {
            _loc2_ = param1;
            while(_loc2_ != null)
            {
               if(_loc2_ is IStyleObject)
               {
                  _loc3_ = _loc2_;
                  if(!_loc3_.get_themeEnabled())
                  {
                     return null;
                  }
               }
               _loc2_ = _loc2_.parent;
            }
            if(Theme.roots != null)
            {
               _loc4_ = param1;
               _loc5_ = 0;
               _loc6_ = Theme.roots;
               while(_loc5_ < int(_loc6_.length))
               {
                  _loc7_ = _loc6_[_loc5_];
                  if((++_loc7_).contains(_loc4_))
                  {
                     return Theme.rootToTheme[_loc7_];
                  }
               }
            }
         }
         else if(param1 != null && !param1.get_themeEnabled())
         {
            return null;
         }
         if(Theme.primaryTheme != null)
         {
            return Theme.primaryTheme;
         }
         return Theme.get_fallbackTheme();
      }
   }
}

