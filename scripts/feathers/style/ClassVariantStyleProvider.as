package feathers.style
{
   import feathers.events.StyleProviderEvent;
   import feathers.style._ClassVariantStyleProvider.StyleTarget;
   import flash.Boot;
   import flash.events.EventDispatcher;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   
   public class ClassVariantStyleProvider extends EventDispatcher implements IStyleProvider
   {
      
      public var styleTargets:IMap;
      
      public function ClassVariantStyleProvider()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      public function setStyleFunction(param1:Class, param2:String, param3:Function) : void
      {
         var _gthis:ClassVariantStyleProvider;
         var callback:Function;
         var _loc6_:* = null as Object;
         callback = param3;
         _gthis = this;
         if(styleTargets == null)
         {
            styleTargets = new EnumValueMap();
         }
         var _loc4_:String = Type.getClassName(param1);
         var _loc5_:StyleTarget = param2 == null ? StyleTarget.Class(_loc4_) : StyleTarget.ClassAndVariant(_loc4_,param2);
         if(callback == null)
         {
            if(!styleTargets.exists(_loc5_))
            {
               return;
            }
            styleTargets.remove(_loc5_);
         }
         else
         {
            _loc6_ = styleTargets._SafeStr_2(_loc5_);
            if(Reflect.compareMethods(callback,_loc6_) || Reflect.compare(callback,_loc6_) == 0)
            {
               return;
            }
            styleTargets._SafeStr_1(_loc5_,callback);
         }
         StyleProviderEvent.dispatch(this,"stylesChange",function(param1:IStyleObject):Boolean
         {
            var _loc2_:Class = _gthis.getStyleContext(param1);
            var _loc3_:String = _gthis.getVariant(param1);
            var _loc4_:* = _gthis.getStyleFunctionInternal(_loc2_,_loc3_,false);
            if(!Reflect.compareMethods(callback,_loc4_))
            {
               return Reflect.compare(callback,_loc4_) == 0;
            }
            return true;
         });
      }
      
      public function getVariant(param1:IStyleObject) : String
      {
         var _loc3_:* = null as IVariantStyleObject;
         var _loc2_:String = null;
         if(param1 is IVariantStyleObject)
         {
            _loc3_ = param1;
            _loc2_ = _loc3_.get_variant();
         }
         return _loc2_;
      }
      
      public function getStyleFunctionInternal(param1:Class, param2:String, param3:Boolean) : Function
      {
         if(styleTargets == null)
         {
            return null;
         }
         var _loc4_:String = Type.getClassName(param1);
         var _loc5_:StyleTarget = param2 == null ? StyleTarget.Class(_loc4_) : StyleTarget.ClassAndVariant(_loc4_,param2);
         var _loc6_:Object = styleTargets._SafeStr_2(_loc5_);
         if(_loc6_ != null || param3)
         {
            return _loc6_;
         }
         return styleTargets._SafeStr_2(StyleTarget.Class(_loc4_));
      }
      
      public function getStyleFunction(param1:Class, param2:String) : Function
      {
         return getStyleFunctionInternal(param1,param2,true);
      }
      
      public function getStyleContext(param1:IStyleObject) : Class
      {
         var _loc3_:* = null as IVariantStyleObject;
         var _loc2_:Class = null;
         if(param1 is IVariantStyleObject)
         {
            _loc3_ = param1;
            _loc2_ = _loc3_.get_styleContext();
         }
         if(_loc2_ == null)
         {
            _loc2_ = Type.getClass(param1);
         }
         return _loc2_;
      }
      
      public function applyStyles(param1:IStyleObject) : void
      {
         if(styleTargets == null)
         {
            return;
         }
         var _loc2_:Class = getStyleContext(param1);
         var _loc3_:String = getVariant(param1);
         var _loc4_:Function = getStyleFunctionInternal(_loc2_,_loc3_,false);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_(param1);
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
