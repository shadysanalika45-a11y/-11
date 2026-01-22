package feathers.controls
{
   import feathers.controls.supportClasses.BaseScrollBar;
   import feathers.core.IMeasureObject;
   import feathers.core.IValidating;
   import feathers.themes.steel.components.SteelVScrollBarStyles;
   import flash.Boot;
   import flash.display.InteractiveObject;
   
   public class VScrollBar extends BaseScrollBar
   {
      
      public function VScrollBar(param1:Number = 0, param2:Number = 0, param3:Number = 1, param4:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         initializeVScrollBarTheme();
         super(param1,param2,param3,param4);
      }
      
      override public function valueToLocation(param1:Number) : Number
      {
         if(_currentThumbSkin is IValidating)
         {
            _currentThumbSkin.validateNow();
         }
         var _loc2_:Number = normalizeValue(param1);
         var _loc3_:Number = actualHeight - get_paddingTop() - get_paddingBottom() - _currentThumbSkin.height;
         return get_paddingTop() + _loc3_ * _loc2_;
      }
      
      override public function saveThumbStart(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = actualHeight;
         var _loc4_:Number = param2;
         if(_currentThumbSkin != null)
         {
            _loc3_ -= _currentThumbSkin.height;
            _loc4_ -= _currentThumbSkin.height / 2;
         }
         _thumbStartX = param1;
         _thumbStartY = Math.min(_loc3_,_loc4_);
      }
      
      override public function measure() : Boolean
      {
         var _loc9_:Number = NaN;
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
            _loc7_ = _currentThumbSkin.width + get_paddingLeft() + get_paddingRight();
            if(_currentTrackSkin != null)
            {
               if(_loc7_ < _currentTrackSkin.width)
               {
                  _loc7_ = _currentTrackSkin.width;
               }
               if(_currentSecondaryTrackSkin != null && _loc7_ < _currentSecondaryTrackSkin.width)
               {
                  _loc7_ = _currentSecondaryTrackSkin.width;
               }
            }
         }
         var _loc8_:Object = get_explicitHeight();
         if(_loc2_)
         {
            _loc8_ = 0;
            if(_currentTrackSkin != null)
            {
               _loc8_ += _currentTrackSkin.height;
               if(_currentSecondaryTrackSkin != null)
               {
                  _loc8_ += _currentSecondaryTrackSkin.height;
               }
            }
            _loc9_ = _currentThumbSkin.height + get_paddingTop() + get_paddingBottom();
            if(_loc8_ < _loc9_)
            {
               _loc8_ = _loc9_;
            }
         }
         var _loc10_:Object = _loc7_;
         var _loc11_:Object = _loc8_;
         var _loc12_:Object = _loc7_;
         return saveMeasurements(_loc7_,_loc8_,_loc10_,_loc11_,_loc12_,null);
      }
      
      override public function locationToValue(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:Number = actualHeight - get_paddingTop() - get_paddingBottom() - _currentThumbSkin.height;
         var _loc5_:Number = param2 - _pointerStartY;
         var _loc6_:Number = Math.min(Math.max(0,_thumbStartY + _loc5_),_loc4_);
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
            if(_thumbSkinMeasurements.height != null)
            {
               _currentThumbSkin.height = _thumbSkinMeasurements.height;
            }
         }
         else
         {
            _loc6_ = getAdjustedPage();
            _loc7_ = _loc5_ * _loc6_ / (_loc1_ + _loc6_);
            if(_loc7_ > 0)
            {
               _loc8_ = _loc5_ - _loc7_;
               if(_loc8_ > _loc7_)
               {
                  _loc8_ = _loc7_;
               }
               _loc8_ *= _loc3_ / (_loc1_ * _loc7_ / _loc5_);
               _loc7_ -= _loc8_;
            }
            if(_thumbSkinMeasurements.minHeight != null)
            {
               if(_loc7_ < _thumbSkinMeasurements.minHeight)
               {
                  _loc7_ = Number(_thumbSkinMeasurements.minHeight);
               }
            }
            else if(_currentThumbSkin is IMeasureObject)
            {
               _loc9_ = _currentThumbSkin;
               if(_loc7_ < _loc9_.get_minHeight())
               {
                  _loc7_ = _loc9_.get_minHeight();
               }
            }
            if(_loc7_ < 0)
            {
               _loc7_ = 0;
            }
            _currentThumbSkin.height = _loc7_;
         }
         _loc6_ = get_paddingLeft();
         _currentThumbSkin.x = _loc6_ + (_loc4_ - _currentThumbSkin.width) / 2;
         _currentThumbSkin.y = valueToLocation(_value);
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
            _loc1_ += int(Math.round(_currentThumbSkin.height / 2));
         }
         _currentSecondaryTrackSkin.y = 0;
         _currentSecondaryTrackSkin.height = _loc1_;
         _currentTrackSkin.y = _loc1_;
         _currentTrackSkin.height = actualHeight - _loc1_;
         if(_currentSecondaryTrackSkin is IValidating)
         {
            _currentSecondaryTrackSkin.validateNow();
         }
         if(_currentTrackSkin is IValidating)
         {
            _currentTrackSkin.validateNow();
         }
         _currentSecondaryTrackSkin.x = (actualWidth - _currentSecondaryTrackSkin.width) / 2;
         _currentTrackSkin.x = (actualWidth - _currentTrackSkin.width) / 2;
      }
      
      override public function layoutSingleTrack() : void
      {
         if(_currentTrackSkin == null)
         {
            return;
         }
         _currentTrackSkin.y = 0;
         _currentTrackSkin.height = actualHeight;
         if(_currentTrackSkin is IValidating)
         {
            _currentTrackSkin.validateNow();
         }
         _currentTrackSkin.x = (actualWidth - _currentTrackSkin.width) / 2;
      }
      
      public function initializeVScrollBarTheme() : void
      {
         SteelVScrollBarStyles.initialize();
      }
      
      override public function get_styleContext() : Class
      {
         return VScrollBar;
      }
   }
}

