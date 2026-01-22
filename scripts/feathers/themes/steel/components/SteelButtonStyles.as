package feathers.themes.steel.components
{
   import feathers.controls.Button;
   import feathers.controls.ButtonState;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.skins.RectangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.text.TextFormat;
   import feathers.themes.steel.BaseSteelTheme;
   import flash.display.DisplayObject;
   
   public class SteelButtonStyles
   {
      
      public function SteelButtonStyles()
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
         if(_loc3_.getStyleFunction(Button,null) == null)
         {
            _loc3_.setStyleFunction(Button,null,function(param1:Button):void
            {
               var _loc2_:* = null as RectangleSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(theme.getButtonFill());
                  _loc2_.set_disabledFill(theme.getButtonDisabledFill());
                  _loc2_.setFillForState(ButtonState.DOWN,theme.getReversedActiveThemeFill());
                  _loc2_.set_border(theme.getButtonBorder());
                  _loc2_.setBorderForState(ButtonState.DOWN,theme.getActiveFillBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_focusRectSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(null);
                  _loc2_.set_border(theme.getFocusBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_focusRectSkin(_loc2_);
               }
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
               param1.set_paddingTop(4);
               param1.set_paddingRight(10);
               param1.set_paddingBottom(4);
               param1.set_paddingLeft(10);
               param1.set_gap(4);
            });
         }
         if(_loc3_.getStyleFunction(Button,Button.VARIANT_PRIMARY) == null)
         {
            _loc3_.setStyleFunction(Button,Button.VARIANT_PRIMARY,function(param1:Button):void
            {
               var _loc2_:* = null as RectangleSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(theme.getActiveThemeFill());
                  _loc2_.set_disabledFill(theme.getButtonDisabledFill());
                  _loc2_.setFillForState(ButtonState.DOWN,theme.getReversedActiveThemeFill());
                  _loc2_.set_border(theme.getActiveFillBorder());
                  _loc2_.set_disabledBorder(theme.getButtonBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_focusRectSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(null);
                  _loc2_.set_border(theme.getFocusBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_focusRectSkin(_loc2_);
               }
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
               param1.set_paddingTop(4);
               param1.set_paddingRight(10);
               param1.set_paddingBottom(4);
               param1.set_paddingLeft(10);
               param1.set_gap(4);
            });
         }
         if(_loc3_.getStyleFunction(Button,Button.VARIANT_DANGER) == null)
         {
            _loc3_.setStyleFunction(Button,Button.VARIANT_DANGER,function(param1:Button):void
            {
               var _loc2_:* = null as RectangleSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(theme.getDangerFill());
                  _loc2_.set_disabledFill(theme.getButtonDisabledFill());
                  _loc2_.setFillForState(ButtonState.DOWN,theme.getReversedDangerFill());
                  _loc2_.set_border(theme.getDangerBorder());
                  _loc2_.set_disabledBorder(theme.getButtonBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_focusRectSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(null);
                  _loc2_.set_border(theme.getFocusBorder());
                  _loc2_.set_cornerRadius(3);
                  param1.set_focusRectSkin(_loc2_);
               }
               if(param1.get_textFormat() == null)
               {
                  param1.set_textFormat(theme.getTextFormat());
               }
               if(param1.get_disabledTextFormat() == null)
               {
                  param1.set_disabledTextFormat(theme.getDisabledTextFormat());
               }
               param1.set_paddingTop(4);
               param1.set_paddingRight(10);
               param1.set_paddingBottom(4);
               param1.set_paddingLeft(10);
               param1.set_gap(4);
            });
         }
      }
   }
}

