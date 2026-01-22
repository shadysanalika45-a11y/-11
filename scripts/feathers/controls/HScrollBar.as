package feathers.controls
{
   import feathers.controls.supportClasses.BaseScrollBar;
   import feathers.core.IMeasureObject;
   import feathers.core.IValidating;
   import feathers.themes.steel.components.SteelHScrollBarStyles;
   import flash.Boot;
   import flash.display.InteractiveObject;
   
   public class HScrollBar extends BaseScrollBar
   {
      
      public function HScrollBar(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         initializeHScrollBarTheme();
         super(param1,param2,param3,param4);
      }
      
      override public function valueToLocation(param1:Number) : Number
      {
         if(_currentThumbSkin is IValidating)
         {
            _currentThumbSkin.validateNow();
         }
         var _loc2_:Number = normalizeValue(param1);
         var _loc3_:Number = actualWidth - get_paddingLeft() - get_paddingRight() - _currentThumbSkin.width;
         return get_paddingLeft() + _loc3_ * _loc2_;
      }
      
      override public function saveThumbStart(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = actualWidth;
         var _loc4_:Number = param1;
         if(_currentThumbSkin != null)
         {
            _loc3_ -= _currentThumbSkin.width;
            _loc4_ -= _currentThumbSkin.width / 2;
         }
         _thumbStartX = Math.min(_loc3_,_loc4_);
         _thumbStartY = param2;
      }
      
      override public function measure() : Boolean
      {
         var _loc8_:Number = NaN;
         var _loc1_:* = get_explicitWidth() == null;
         var _loc2_:* = get_explicitHeight() == null;
         var _loc3_:* = get_explicitMinWidth() == null;
         var _loc4_:* = get_explicitMinHeight() == null;
         var _loc5_:* = get_explicitMaxWidth() == null;
         var _loc6_:* = get_explicitMaxHeight() == null;
         if(!_loc1_ && !_loc2_ && !_loc3_ && !_loc4_ && !_loc5_ && !_loc6_)
         {
            return false;
         }
         _thumbSkinMeasurements.restore(_currentThumbSkin);
         if(_currentThumbSkin is IValidating)
         {
            _currentThumbSkin.validateNow();
         }
         if(_currentTrackSkin != null)
         {
            _trackSkinMeasurements.restore(_currentTrackSkin);
            if(_currentTrackSkin is IValidating)
            {
               _currentTrackSkin.validateNow();
            }
         }
         if(_currentSecondaryTrackSkin != null)
         {
            _secondaryTrackSkinMeasurements.restore(_currentSecondaryTrackSkin);
            if(_currentSecondaryTrackSkin is IValidating)
            {
               _currentSecondaryTrackSkin.validateNow();
            }
         }
         var _loc7_:Object = get_explicitWidth();
         if(_loc1_)
         {
            _loc7_ = 0;
            if(_currentTrackSkin != null)
            {
               _loc7_ += _currentTrackSkin.width;
               if(_currentSecondaryTrackSkin != null)
               {
                  _loc7_ += _currentSecondaryTrackSkin.width;
               }
            }
            _loc8_ = _currentThumbSkin.width + get_paddingLeft() + get_paddingRight();
            if(_loc7_ < _loc8_)
            {
               _loc7_ = _loc8_;
            }
         }
         var _loc9_:Object = get_explicitHeight();
         if(_loc2_)
         {
            _loc9_ = _currentThumbSkin.height + get_paddingTop() + get_paddingBottom();
            if(_currentTrackSkin != null)
            {
               if(_loc9_ < _currentTrackSkin.height)
               {
                  _loc9_ = _currentTrackSkin.height;
               }
               if(_currentSecondaryTrackSkin != null && _loc9_ < _currentSecondaryTrackSkin.height)
               {
                  _loc9_ = _currentSecondaryTrackSkin.height;
               }
            }
         }
         var _loc10_:Object = _loc7_;
         var _loc11_:Object = _loc9_;
         var _loc12_:Object = _loc9_;
         return saveMeasurements(_loc7_,_loc9_,_loc10_,_loc11_,null,_loc12_);
      }
      
      override public function locationToValue(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = actualWidth - get_paddingLeft() - get_paddingRight() - _currentThumbSkin.width;
         var _loc5_:Number = param1 - _pointerStartX;
         var _loc6_:Number = Math.min(Math.max(0,_thumbStartX + _loc5_),_loc4_);
         _loc3_ = _loc6_ / _loc4_;
         return _minimum + _loc3_ * (_maximum - _minimum);
      }
      
      override public function layoutThumb() : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as IMeasureObject;
         if(_currentThumbSkin == null)
         {
            return;
         }
         var _loc1_:Number = _maximum - _minimum;
         var _loc2_:Boolean = !get_hideThumbWhenDisabled() || _enabled;
         _currentThumbSkin.visible = _loc2_ && _loc1_ > 0;
         if(!_currentThumbSkin.visible)
         {
            return;
         }
         if(_currentThumbSkin is IValidating)
         {
            _currentThumbSkin.validateNow();
         }
         var _loc3_:Number = 0;
         if(_value < _minimum)
         {
            _loc3_ = _minimum - _value;
         }
         else if(_value > _maximum)
         {
            _loc3_ = _value - _maximum;
         }
         var _loc4_:Number = actualWidth - get_paddingLeft() - get_paddingRight();
         var _loc5_:Number = actualHeight - get_paddingTop() - get_paddingBottom();
         if(get_fixedThumbSize())
         {
            if(_thumbSkinMeasurements.width != null)
            {
               _currentThumbSkin.width = _thumbSkinMeasurements.width;
            }
         }
         else
         {
            _loc6_ = getAdjustedPage();
            _loc7_ = _loc4_ * _loc6_ / (_loc1_ + _loc6_);
            if(_loc7_ > 0)
            {
               _loc8_ = _loc4_ - _loc7_;
               if(_loc8_ > _loc7_)
               {
                  _loc8_ = _loc7_;
               }
               _loc8_ *= _loc3_ / (_loc1_ * _loc7_ / _loc4_);
               _loc7_ -= _loc8_;
            }
            if(_thumbSkinMeasurements.minWidth != null)
            {
               if(_loc7_ < _thumbSkinMeasurements.minWidth)
               {
                  _loc7_ = Number(_thumbSkinMeasurements.minWidth);
               }
            }
            else if(_currentThumbSkin is IMeasureObject)
            {
               _loc9_ = _currentThumbSkin;
               if(_loc7_ < _loc9_.get_minWidth())
               {
                  _loc7_ = _loc9_.get_minWidth();
               }
            }
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
            _currentThumbSkin.width = _loc7_;
         }
         _currentThumbSkin.x = valueToLocation(_value);
         _loc6_ = get_paddingTop();
         _currentThumbSkin.y = _loc6_ + (_loc5_ - _currentThumbSkin.height) / 2;
      }
      
      override public function layoutSplitTrack() : void
      {
         var _loc1_:Number = valueToLocation(get_value());
         if(_currentThumbSkin != null)
         {
            if(_currentThumbSkin is IValidating)
            {
               _currentThumbSkin.validateNow();
            }
            _loc1_ += int(Math.round(_currentThumbSkin.width / 2));
         }
         _currentTrackSkin.x = 0;
         _currentTrackSkin.width = _loc1_;
         _currentSecondaryTrackSkin.x = _loc1_;
         _currentSecondaryTrackSkin.width = actualWidth - _loc1_;
         if(_currentTrackSkin is IValidating)
         {
            _currentTrackSkin.validateNow();
         }
         if(_currentSecondaryTrackSkin is IValidating)
         {
            _currentSecondaryTrackSkin.validateNow();
         }
         _currentTrackSkin.y = (actualHeight - _currentTrackSkin.height) / 2;
         _currentSecondaryTrackSkin.y = (actualHeight - _currentSecondaryTrackSkin.height) / 2;
      }
      
      override public function layoutSingleTrack() : void
      {
         if(_currentTrackSkin == null)
         {
            return;
         }
         _currentTrackSkin.x = 0;
         _currentTrackSkin.width = actualWidth;
         if(_currentTrackSkin is IValidating)
         {
            _currentTrackSkin.validateNow();
         }
         _currentTrackSkin.y = (actualHeight - _currentTrackSkin.height) / 2;
      }
      
      public function initializeHScrollBarTheme() : void
      {
         SteelHScrollBarStyles.initialize();
      }
      
      override public function get_styleContext() : Class
      {
         return HScrollBar;
      }
   }
}

