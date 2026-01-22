package feathers.themes.steel.components
{
   import feathers.controls.LayoutGroup;
   import feathers.graphics.FillStyle;
   import feathers.layout.HorizontalAlign;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.ILayout;
   import feathers.layout.VerticalAlign;
   import feathers.skins.RectangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.themes.steel.BaseSteelTheme;
   import flash.display.DisplayObject;
   
   public class SteelLayoutGroupStyles
   {
      
      public function SteelLayoutGroupStyles()
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
         if(_loc3_.getStyleFunction(LayoutGroup,LayoutGroup.VARIANT_TOOL_BAR) == null)
         {
            _loc3_.setStyleFunction(LayoutGroup,LayoutGroup.VARIANT_TOOL_BAR,function(param1:LayoutGroup):void
            {
               var _loc2_:* = null as RectangleSkin;
               var _loc3_:* = null as HorizontalLayout;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(theme.getHeaderFill());
                  _loc2_.width = 44;
                  _loc2_.height = 44;
                  _loc2_.set_minHeight(44);
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_layout() == null)
               {
                  _loc3_ = new HorizontalLayout();
                  _loc3_.set_horizontalAlign(HorizontalAlign.LEFT);
                  _loc3_.set_verticalAlign(VerticalAlign.MIDDLE);
                  _loc3_.set_paddingTop(4);
                  _loc3_.set_paddingRight(10);
                  _loc3_.set_paddingBottom(4);
                  _loc3_.set_paddingLeft(10);
                  _loc3_.set_gap(4);
                  param1.set_layout(_loc3_);
               }
            });
         }
      }
   }
}

