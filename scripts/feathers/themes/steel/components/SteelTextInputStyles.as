package feathers.themes.steel.components
{
   import feathers.controls.TextCallout;
   import feathers.controls.TextInput;
   import feathers.controls.TextInputState;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.layout.Direction;
   import feathers.skins.PillSkin;
   import feathers.skins.RectangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.text.TextFormat;
   import feathers.themes.steel.BaseSteelTheme;
   import flash.display.DisplayObject;
   
   public class SteelTextInputStyles
   {
      
      public function SteelTextInputStyles()
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
         if(_loc3_.getStyleFunction(TextInput,null) == null)
         {
            _loc3_.setStyleFunction(TextInput,null,function(param1:TextInput):void
            {
               var _loc2_:* = null as RectangleSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_cornerRadius(3);
                  _loc2_.width = 160;
                  _loc2_.set_fill(theme.getInsetFill());
                  _loc2_.set_border(theme.getInsetBorder());
                  _loc2_.set_disabledFill(theme.getDisabledInsetFill());
                  _loc2_.setBorderForState(TextInputState.FOCUSED,theme.getThemeBorder());
                  _loc2_.setBorderForState(TextInputState.ERROR,theme.getDangerBorder());
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
               if(param1.get_promptTextFormat() == null)
               {
                  param1.set_promptTextFormat(theme.getSecondaryTextFormat());
               }
               param1.set_paddingTop(6);
               param1.set_paddingRight(10);
               param1.set_paddingBottom(6);
               param1.set_paddingLeft(10);
            });
         }
         if(_loc3_.getStyleFunction(TextInput,TextInput.VARIANT_SEARCH) == null)
         {
            _loc3_.setStyleFunction(TextInput,TextInput.VARIANT_SEARCH,function(param1:TextInput):void
            {
               var _loc2_:* = null as PillSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new PillSkin();
                  _loc2_.set_capDirection(Direction.HORIZONTAL);
                  _loc2_.width = 160;
                  _loc2_.set_fill(theme.getInsetFill());
                  _loc2_.set_border(theme.getInsetBorder());
                  _loc2_.set_disabledFill(theme.getDisabledInsetFill());
                  _loc2_.setBorderForState(TextInputState.FOCUSED,theme.getThemeBorder());
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
               if(param1.get_promptTextFormat() == null)
               {
                  param1.set_promptTextFormat(theme.getSecondaryTextFormat());
               }
               param1.set_paddingTop(6);
               param1.set_paddingRight(10);
               param1.set_paddingBottom(6);
               param1.set_paddingLeft(10);
            });
         }
         if(_loc3_.getStyleFunction(TextCallout,TextInput.CHILD_VARIANT_ERROR_CALLOUT) == null)
         {
            _loc3_.setStyleFunction(TextCallout,TextInput.CHILD_VARIANT_ERROR_CALLOUT,function(param1:TextCallout):void
            {
               theme.styleProvider.getStyleFunction(TextCallout,TextCallout.VARIANT_DANGER)(param1);
            });
         }
      }
   }
}

