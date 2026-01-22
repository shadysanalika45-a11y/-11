package feathers.themes.steel.components
{
   import feathers.controls.ScrollContainer;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.skins.RectangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.themes.steel.BaseSteelTheme;
   import feathers.utils.DeviceUtil;
   import flash.display.DisplayObject;
   
   public class SteelScrollContainerStyles
   {
      
      public function SteelScrollContainerStyles()
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
         if(_loc3_.getStyleFunction(ScrollContainer,null) == null)
         {
            _loc3_.setStyleFunction(ScrollContainer,null,function(param1:ScrollContainer):void
            {
               var _loc3_:* = null as RectangleSkin;
               var _loc2_:Boolean = DeviceUtil.isDesktop();
               param1.set_autoHideScrollBars(!_loc2_);
               param1.set_fixedScrollBars(_loc2_);
               if(param1.get_backgroundSkin() == null)
               {
                  _loc3_ = new RectangleSkin();
                  _loc3_.set_fill(theme.getContainerFill());
                  param1.set_backgroundSkin(_loc3_);
               }
               if(param1.get_focusRectSkin() == null)
               {
                  _loc3_ = new RectangleSkin();
                  _loc3_.set_fill(null);
                  _loc3_.set_border(theme.getFocusBorder());
                  param1.set_focusRectSkin(_loc3_);
               }
            });
         }
      }
   }
}

