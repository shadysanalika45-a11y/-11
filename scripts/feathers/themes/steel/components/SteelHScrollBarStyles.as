package feathers.themes.steel.components
{
   import feathers.controls.BasicButton;
   import feathers.controls.HScrollBar;
   import feathers.graphics.FillStyle;
   import feathers.skins.RectangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.themes.steel.BaseSteelTheme;
   import feathers.utils.DeviceUtil;
   import flash.display.InteractiveObject;
   
   public class SteelHScrollBarStyles
   {
      
      public function SteelHScrollBarStyles()
      {
      }
      
      public static function initialize(param1:BaseSteelTheme = undefined) : void
      {
         var theme:BaseSteelTheme;
         var _loc2_:* = null as ITheme;
         theme = param1;
         if(theme == null)
         {
            _loc2_ = Theme.get_fallbackTheme();
            theme = _loc2_ as BaseSteelTheme;
         }
         if(theme == null)
         {
            return;
         }
         var _loc3_:ClassVariantStyleProvider = theme.styleProvider;
         if(_loc3_.getStyleFunction(HScrollBar,null) == null)
         {
            _loc3_.setStyleFunction(HScrollBar,null,function(param1:HScrollBar):void
            {
               var _loc3_:* = null as RectangleSkin;
               var _loc4_:Number = NaN;
               var _loc5_:* = null as BasicButton;
               var _loc2_:Boolean = DeviceUtil.isDesktop();
               if(param1.get_thumbSkin() == null)
               {
                  _loc3_ = new RectangleSkin();
                  _loc3_.set_fill(theme.getScrollBarThumbFill());
                  _loc3_.set_disabledFill(theme.getScrollBarThumbDisabledFill());
                  _loc4_ = _loc2_ ? 6 : 4;
                  _loc3_.width = _loc4_;
                  _loc3_.height = _loc4_;
                  _loc3_.set_minWidth(_loc4_);
                  _loc3_.set_minHeight(_loc4_);
                  _loc3_.set_cornerRadius(_loc4_ / 2);
                  _loc5_ = new BasicButton();
                  _loc5_.set_keepDownStateOnRollOut(true);
                  _loc5_.set_backgroundSkin(_loc3_);
                  param1.set_thumbSkin(_loc5_);
               }
               if(_loc2_ && param1.get_trackSkin() == null)
               {
                  _loc3_ = new RectangleSkin();
                  _loc3_.set_fill(theme.getControlFill());
                  _loc3_.set_disabledFill(theme.getControlDisabledFill());
                  _loc3_.width = 12;
                  _loc3_.height = 12;
                  _loc3_.set_minWidth(12);
                  _loc3_.set_minHeight(12);
                  param1.set_trackSkin(_loc3_);
               }
               param1.set_paddingTop(2);
               param1.set_paddingRight(2);
               param1.set_paddingBottom(2);
               param1.set_paddingLeft(2);
            });
         }
      }
   }
}

