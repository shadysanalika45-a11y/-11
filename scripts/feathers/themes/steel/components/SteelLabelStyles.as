package feathers.themes.steel.components
{
   import feathers.controls.Label;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.text.TextFormat;
   import feathers.themes.steel.BaseSteelTheme;
   
   public class SteelLabelStyles
   {
      
      public function SteelLabelStyles()
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
         if(_loc3_.getStyleFunction(Label,null) == null)
         {
            _loc3_.setStyleFunction(Label,null,function(param1:Label):void
            {
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
            });
         }
         if(_loc3_.getStyleFunction(Label,Label.VARIANT_HEADING) == null)
         {
            _loc3_.setStyleFunction(Label,Label.VARIANT_HEADING,function(param1:Label):void
            {
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getHeaderTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledHeaderTextFormat());
               }
            });
         }
         if(_loc3_.getStyleFunction(Label,Label.VARIANT_DETAIL) == null)
         {
            _loc3_.setStyleFunction(Label,Label.VARIANT_DETAIL,function(param1:Label):void
            {
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getDetailTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledDetailTextFormat());
               }
            });
         }
      }
   }
}

