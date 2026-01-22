package feathers.utils
{
   import feathers.core.IMeasureObject;
   import feathers.layout.Measurements;
   import flash.display.DisplayObject;
   
   public final class MeasurementsUtil
   {
      
      public function MeasurementsUtil()
      {
      }
      
      public static function resetFluidlyWithParentValues(param1:Measurements, param2:DisplayObject, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined, param6:Object = undefined, param7:Object = undefined, param8:Object = undefined) : void
      {
         var _loc9_:* = null as IMeasureObject;
         var _loc10_:* = null as Object;
         var _loc11_:* = null as Object;
         var _loc12_:* = null as Object;
         var _loc13_:* = null as Object;
         var _loc14_:* = null as Object;
         var _loc15_:* = null as Object;
         if(param2 == null)
         {
            return;
         }
         if(param2 is IMeasureObject)
         {
            _loc9_ = param2;
            _loc10_ = param3;
            if(_loc10_ == null)
            {
               _loc10_ = param1.width;
            }
            if(_loc10_ == null)
            {
               _loc9_.resetWidth();
            }
            else
            {
               _loc9_.width = _loc10_;
            }
            _loc11_ = param4;
            if(_loc11_ == null)
            {
               _loc11_ = param1.height;
            }
            if(_loc11_ == null)
            {
               _loc9_.resetHeight();
            }
            else
            {
               _loc9_.height = _loc11_;
            }
            _loc12_ = param5;
            if(_loc12_ == null || _loc9_.get_explicitMinWidth() != null && _loc9_.get_explicitMinWidth() > _loc12_)
            {
               _loc12_ = _loc9_.get_explicitMinWidth();
            }
            if(_loc12_ == null)
            {
               _loc12_ = 0;
            }
            _loc9_.set_minWidth(_loc12_);
            _loc13_ = param6;
            if(_loc13_ == null || _loc9_.get_explicitMinHeight() != null && _loc9_.get_explicitMinHeight() > _loc13_)
            {
               _loc13_ = _loc9_.get_explicitMinHeight();
            }
            if(_loc13_ == null)
            {
               _loc13_ = 0;
            }
            _loc9_.set_minHeight(_loc13_);
            _loc14_ = param7;
            if(_loc14_ == null || _loc9_.get_explicitMaxWidth() != null && _loc9_.get_explicitMaxWidth() < _loc14_)
            {
               _loc14_ = _loc9_.get_explicitMaxWidth();
            }
            if(_loc14_ == null)
            {
               _loc14_ = 1 / 0;
            }
            _loc9_.set_maxWidth(_loc14_);
            _loc15_ = param8;
            if(_loc15_ == null || _loc9_.get_explicitMaxHeight() != null && _loc9_.get_explicitMaxHeight() < _loc15_)
            {
               _loc15_ = _loc9_.get_explicitMaxHeight();
            }
            if(_loc15_ == null)
            {
               _loc15_ = 1 / 0;
            }
            _loc9_.set_maxHeight(_loc15_);
            return;
         }
         if(param3 != null)
         {
            param2.width = param3;
         }
         else if(param1.width != null)
         {
            param2.width = param1.width;
         }
         if(param4 != null)
         {
            param2.height = param4;
         }
         else if(param1.height != null)
         {
            param2.height = param1.height;
         }
      }
      
      public static function resetFluidlyWithParent(param1:Measurements, param2:DisplayObject, param3:IMeasureObject) : void
      {
         MeasurementsUtil.resetFluidlyWithParentValues(param1,param2,param3.get_explicitWidth(),param3.get_explicitHeight(),param3.get_explicitMinWidth(),param3.get_explicitMinHeight(),param3.get_explicitMaxWidth(),param3.get_explicitMaxHeight());
      }
   }
}

