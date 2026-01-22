package feathers.core
{
   import feathers.events.FeathersEvent;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class MeasureSprite extends ValidatingSprite implements IMeasureObject
   {
      
      public var scaledActualWidth:Number;
      
      public var scaledActualMinWidth:Number;
      
      public var scaledActualMinHeight:Number;
      
      public var scaledActualMaxWidth:Number;
      
      public var scaledActualMaxHeight:Number;
      
      public var scaledActualHeight:Number;
      
      public var actualWidth:Number;
      
      public var actualMinWidth:Number;
      
      public var actualMinHeight:Number;
      
      public var actualMaxWidth:Number;
      
      public var actualMaxHeight:Number;
      
      public var actualHeight:Number;
      
      public var _explicitWidth:Object;
      
      public var _explicitMinWidth:Object;
      
      public var _explicitMinHeight:Object;
      
      public var _explicitMaxWidth:Object;
      
      public var _explicitMaxHeight:Object;
      
      public var _explicitHeight:Object;
      
      public var __getBoundsHelperMatrix2:Matrix;
      
      public var __getBoundsHelperMatrix1:Matrix;
      
      public function MeasureSprite()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _explicitMaxHeight = null;
         _explicitMaxWidth = null;
         _explicitMinHeight = null;
         _explicitMinWidth = null;
         _explicitHeight = null;
         _explicitWidth = null;
         scaledActualMaxHeight = 1 / 0;
         scaledActualMaxWidth = 1 / 0;
         scaledActualMinHeight = 0;
         scaledActualMinWidth = 0;
         scaledActualHeight = 0;
         scaledActualWidth = 0;
         actualMaxHeight = 1 / 0;
         actualMaxWidth = 1 / 0;
         actualMinHeight = 0;
         actualMinWidth = 0;
         actualHeight = 0;
         actualWidth = 0;
         super();
      }
      
      override public function set width(param1:Number) : void
      {
         if(scaleX != 1)
         {
            param1 /= scaleX;
         }
         set_explicitWidth(param1);
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         saveMeasurements(actualWidth,actualHeight,actualMinWidth,actualMinHeight,actualMaxWidth,actualMaxHeight);
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         saveMeasurements(actualWidth,actualHeight,actualMinWidth,actualMinHeight,actualMaxWidth,actualMaxHeight);
      }
      
      public function set_minWidth(param1:Number) : Number
      {
         if(scaleX != 1)
         {
            param1 /= scaleX;
         }
         set_explicitMinWidth(param1);
         return scaledActualMinWidth;
      }
      
      public function set minWidth(param1:Number) : void
      {
         set_minWidth(param1);
      }
      
      public function set_minHeight(param1:Number) : Number
      {
         if(scaleY != 1)
         {
            param1 /= scaleY;
         }
         set_explicitMinHeight(param1);
         return scaledActualMinHeight;
      }
      
      public function set minHeight(param1:Number) : void
      {
         set_minHeight(param1);
      }
      
      public function set_maxWidth(param1:Number) : Number
      {
         if(scaleX != 1)
         {
            param1 /= scaleX;
         }
         set_explicitMaxWidth(param1);
         return scaledActualMaxWidth;
      }
      
      public function set maxWidth(param1:Number) : void
      {
         set_maxWidth(param1);
      }
      
      public function set_maxHeight(param1:Number) : Number
      {
         if(scaleY != 1)
         {
            param1 /= scaleY;
         }
         set_explicitMaxHeight(param1);
         return scaledActualMaxHeight;
      }
      
      public function set maxHeight(param1:Number) : void
      {
         set_maxHeight(param1);
      }
      
      override public function set height(param1:Number) : void
      {
         if(scaleY != 1)
         {
            param1 /= scaleY;
         }
         set_explicitHeight(param1);
      }
      
      public function set_explicitWidth(param1:Object) : Object
      {
         var _loc2_:Boolean = false;
         if(_explicitWidth == param1)
         {
            return _explicitWidth;
         }
         _explicitWidth = param1;
         if(param1 == null)
         {
            actualWidth = 0;
            scaledActualWidth = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc2_ = saveMeasurements(param1,actualHeight,actualMinWidth,actualMinHeight,actualMaxWidth,actualMaxHeight);
            if(_loc2_)
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitWidth;
      }
      
      public function set explicitWidth(param1:Object) : void
      {
         set_explicitWidth(param1);
      }
      
      public function set_explicitMinWidth(param1:Object) : Object
      {
         var _loc3_:Number = NaN;
         if(_explicitMinWidth == param1)
         {
            return _explicitMinWidth;
         }
         var _loc2_:Object = _explicitMinWidth;
         _explicitMinWidth = param1;
         if(param1 == null)
         {
            actualMinWidth = 0;
            scaledActualMinWidth = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc3_ = actualWidth;
            saveMeasurements(actualWidth,actualHeight,param1,actualMinHeight,actualMaxWidth,actualMaxHeight);
            if(_explicitWidth == null && (_loc3_ < param1 || _loc3_ == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMinWidth;
      }
      
      public function set explicitMinWidth(param1:Object) : void
      {
         set_explicitMinWidth(param1);
      }
      
      public function set_explicitMinHeight(param1:Object) : Object
      {
         var _loc3_:Number = NaN;
         if(_explicitMinHeight == param1)
         {
            return _explicitMinHeight;
         }
         var _loc2_:Object = _explicitMinHeight;
         _explicitMinHeight = param1;
         if(param1 == null)
         {
            actualMinHeight = 0;
            scaledActualMinHeight = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc3_ = actualHeight;
            saveMeasurements(actualWidth,actualHeight,actualMinWidth,param1,actualMaxWidth,actualMaxHeight);
            if(_explicitHeight == null && (_loc3_ < param1 || _loc3_ == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMinHeight;
      }
      
      public function set explicitMinHeight(param1:Object) : void
      {
         set_explicitMinHeight(param1);
      }
      
      public function set_explicitMaxWidth(param1:Object) : Object
      {
         var _loc3_:Number = NaN;
         if(_explicitMaxWidth == param1)
         {
            return _explicitMaxWidth;
         }
         var _loc2_:Object = _explicitMaxWidth;
         _explicitMaxWidth = param1;
         if(param1 == null)
         {
            actualMaxWidth = 1 / 0;
            scaledActualMaxWidth = 1 / 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc3_ = actualWidth;
            saveMeasurements(actualWidth,actualHeight,actualMinWidth,actualMinHeight,param1,actualMaxHeight);
            if(_explicitWidth == null && (_loc3_ > param1 || _loc3_ == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMaxWidth;
      }
      
      public function set explicitMaxWidth(param1:Object) : void
      {
         set_explicitMaxWidth(param1);
      }
      
      public function set_explicitMaxHeight(param1:Object) : Object
      {
         var _loc3_:Number = NaN;
         if(_explicitMaxHeight == param1)
         {
            return _explicitMaxHeight;
         }
         var _loc2_:Object = _explicitMaxHeight;
         _explicitMaxHeight = param1;
         if(param1 == null)
         {
            actualMaxHeight = 1 / 0;
            scaledActualMaxHeight = 1 / 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc3_ = actualHeight;
            saveMeasurements(actualWidth,actualHeight,actualMinWidth,actualMinHeight,actualMaxWidth,param1);
            if(_explicitHeight == null && (_loc3_ > param1 || _loc3_ == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMaxHeight;
      }
      
      public function set explicitMaxHeight(param1:Object) : void
      {
         set_explicitMaxHeight(param1);
      }
      
      public function set_explicitHeight(param1:Object) : Object
      {
         var _loc2_:Boolean = false;
         if(_explicitHeight == param1)
         {
            return _explicitHeight;
         }
         _explicitHeight = param1;
         if(param1 == null)
         {
            actualHeight = 0;
            scaledActualHeight = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _loc2_ = saveMeasurements(actualWidth,param1,actualMinWidth,actualMinHeight,actualMaxWidth,actualMaxHeight);
            if(_loc2_)
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitHeight;
      }
      
      public function set explicitHeight(param1:Object) : void
      {
         set_explicitHeight(param1);
      }
      
      public function saveMeasurements(param1:Number, param2:Number, param3:Number = 0, param4:Number = 0, param5:Object = undefined, param6:Object = undefined) : Boolean
      {
         if(param5 == null)
         {
            param5 = 1 / 0;
         }
         if(param6 == null)
         {
            param6 = 1 / 0;
         }
         if(_explicitMinWidth != null)
         {
            param3 = Number(_explicitMinWidth);
         }
         if(_explicitMinHeight != null)
         {
            param4 = Number(_explicitMinHeight);
         }
         if(_explicitMaxWidth != null)
         {
            param5 = _explicitMaxWidth;
         }
         else if(param5 == null)
         {
            param5 = 1 / 0;
         }
         if(_explicitMaxHeight != null)
         {
            param6 = _explicitMaxHeight;
         }
         else if(param6 == null)
         {
            param6 = 1 / 0;
         }
         if(_explicitMaxWidth == null && param5 < param3)
         {
            param5 = param3;
         }
         if(_explicitMinWidth == null && param3 > param5)
         {
            param3 = Number(param5);
         }
         if(_explicitMaxHeight == null && param6 < param4)
         {
            param6 = param4;
         }
         if(_explicitMinHeight == null && param4 > param6)
         {
            param4 = Number(param6);
         }
         if(_explicitWidth != null)
         {
            param1 = Number(_explicitWidth);
         }
         else if(param1 < param3)
         {
            param1 = param3;
         }
         else if(param1 > param5)
         {
            param1 = Number(param5);
         }
         if(_explicitHeight != null)
         {
            param2 = Number(_explicitHeight);
         }
         else if(param2 < param4)
         {
            param2 = param4;
         }
         else if(param2 > param6)
         {
            param2 = Number(param6);
         }
         var _loc7_:Number = scaleX;
         if(_loc7_ < 0)
         {
            _loc7_ = -_loc7_;
         }
         var _loc8_:Number = scaleY;
         if(_loc8_ < 0)
         {
            _loc8_ = -_loc8_;
         }
         var _loc9_:Boolean = false;
         if(actualWidth != param1)
         {
            actualWidth = param1;
            _loc9_ = true;
         }
         if(actualHeight != param2)
         {
            actualHeight = param2;
            _loc9_ = true;
         }
         if(actualMinWidth != param3)
         {
            actualMinWidth = param3;
            _loc9_ = true;
         }
         if(actualMinHeight != param4)
         {
            actualMinHeight = param4;
            _loc9_ = true;
         }
         if(actualMaxWidth != param5)
         {
            actualMaxWidth = param5;
            _loc9_ = true;
         }
         if(actualMaxHeight != param6)
         {
            actualMaxHeight = param6;
            _loc9_ = true;
         }
         param1 = scaledActualWidth;
         param2 = scaledActualHeight;
         scaledActualWidth = actualWidth * _loc7_;
         scaledActualHeight = actualHeight * _loc8_;
         scaledActualMinWidth = actualMinWidth * _loc7_;
         scaledActualMinHeight = actualMinHeight * _loc8_;
         scaledActualMaxWidth = actualMaxWidth * _loc7_;
         scaledActualMaxHeight = actualMaxHeight * _loc8_;
         if(param1 != scaledActualWidth || param2 != scaledActualHeight)
         {
            _loc9_ = true;
            FeathersEvent.dispatch(this,Event.RESIZE);
         }
         return _loc9_;
      }
      
      public function resetWidth() : void
      {
         set_explicitWidth(null);
      }
      
      public function resetMinWidth() : void
      {
         set_explicitMinWidth(null);
      }
      
      public function resetMinHeight() : void
      {
         set_explicitMinHeight(null);
      }
      
      public function resetMaxWidth() : void
      {
         set_explicitMaxWidth(null);
      }
      
      public function resetMaxHeight() : void
      {
         set_explicitMaxHeight(null);
      }
      
      public function resetHeight() : void
      {
         set_explicitHeight(null);
      }
      
      override public function get width() : Number
      {
         return scaledActualWidth;
      }
      
      public function get_minWidth() : Number
      {
         return scaledActualMinWidth;
      }
      
      public function get minWidth() : Number
      {
         return get_minWidth();
      }
      
      public function get_minHeight() : Number
      {
         return scaledActualMinHeight;
      }
      
      public function get minHeight() : Number
      {
         return get_minHeight();
      }
      
      public function get_maxWidth() : Number
      {
         return scaledActualMaxWidth;
      }
      
      public function get maxWidth() : Number
      {
         return get_maxWidth();
      }
      
      public function get_maxHeight() : Number
      {
         return scaledActualMaxHeight;
      }
      
      public function get maxHeight() : Number
      {
         return get_maxHeight();
      }
      
      override public function get height() : Number
      {
         return scaledActualHeight;
      }
      
      public function get_explicitWidth() : Object
      {
         return _explicitWidth;
      }
      
      public function get explicitWidth() : Object
      {
         return get_explicitWidth();
      }
      
      public function get_explicitMinWidth() : Object
      {
         return _explicitMinWidth;
      }
      
      public function get explicitMinWidth() : Object
      {
         return get_explicitMinWidth();
      }
      
      public function get_explicitMinHeight() : Object
      {
         return _explicitMinHeight;
      }
      
      public function get explicitMinHeight() : Object
      {
         return get_explicitMinHeight();
      }
      
      public function get_explicitMaxWidth() : Object
      {
         return _explicitMaxWidth;
      }
      
      public function get explicitMaxWidth() : Object
      {
         return get_explicitMaxWidth();
      }
      
      public function get_explicitMaxHeight() : Object
      {
         return _explicitMaxHeight;
      }
      
      public function get explicitMaxHeight() : Object
      {
         return get_explicitMaxHeight();
      }
      
      public function get_explicitHeight() : Object
      {
         return _explicitHeight;
      }
      
      public function get explicitHeight() : Object
      {
         return get_explicitHeight();
      }
      
      override public function getBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:* = null as Matrix;
         var _loc3_:* = null as Matrix;
         if(__getBoundsHelperMatrix1 == null)
         {
            __getBoundsHelperMatrix1 = new Matrix();
         }
         else
         {
            __getBoundsHelperMatrix1.identity();
         }
         if(param1 != null && param1 != this)
         {
            if(__getBoundsHelperMatrix2 == null)
            {
               __getBoundsHelperMatrix2 = new Matrix();
            }
            _loc2_ = transform.concatenatedMatrix;
            __getBoundsHelperMatrix1.copyFrom(_loc2_);
            _loc3_ = null;
            if(param1 == stage)
            {
               __getBoundsHelperMatrix2.identity();
               _loc3_ = __getBoundsHelperMatrix2;
            }
            else
            {
               _loc3_ = param1.transform.concatenatedMatrix;
            }
            __getBoundsHelperMatrix2.copyFrom(_loc3_);
            __getBoundsHelperMatrix2.invert();
            __getBoundsHelperMatrix1.concat(__getBoundsHelperMatrix2);
            __getBoundsHelperMatrix2.identity();
         }
         var _loc4_:Number = __getBoundsHelperMatrix1.tx;
         var _loc5_:Number = __getBoundsHelperMatrix1.ty;
         var _loc6_:Number = actualWidth * __getBoundsHelperMatrix1.a + actualHeight * __getBoundsHelperMatrix1.c + __getBoundsHelperMatrix1.tx - _loc4_;
         var _loc7_:Number = actualWidth * __getBoundsHelperMatrix1.b + actualHeight * __getBoundsHelperMatrix1.d + __getBoundsHelperMatrix1.ty - _loc5_;
         __getBoundsHelperMatrix1.identity();
         return new Rectangle(_loc4_,_loc5_,_loc6_,_loc7_);
      }
   }
}

