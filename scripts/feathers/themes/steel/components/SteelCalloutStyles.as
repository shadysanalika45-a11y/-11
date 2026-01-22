package feathers.themes.steel.components
{
   import feathers.controls.Callout;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.layout.RelativePosition;
   import feathers.skins.RectangleSkin;
   import feathers.skins.TriangleSkin;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.ITheme;
   import feathers.style.Theme;
   import feathers.themes.steel.BaseSteelTheme;
   import flash.display.DisplayObject;
   
   public class SteelCalloutStyles
   {
      
      public function SteelCalloutStyles()
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
         if(_loc3_.getStyleFunction(Callout,null) == null)
         {
            _loc3_.setStyleFunction(Callout,null,function(param1:Callout):void
            {
               var _loc2_:* = null as RectangleSkin;
               var _loc3_:* = null as TriangleSkin;
               if(param1.get_backgroundSkin() == null)
               {
                  _loc2_ = new RectangleSkin();
                  _loc2_.set_fill(theme.getContainerFill());
                  _loc2_.set_border(theme.getContainerBorder());
                  param1.set_backgroundSkin(_loc2_);
               }
               if(param1.get_topArrowSkin() == null)
               {
                  _loc3_ = new TriangleSkin();
                  _loc3_.set_pointPosition(RelativePosition.TOP);
                  _loc3_.set_drawBaseBorder(false);
                  _loc3_.set_fill(theme.getContainerFill());
                  _loc3_.set_border(theme.getContainerBorder());
                  _loc3_.width = 14;
                  _loc3_.height = 8;
                  param1.set_topArrowSkin(_loc3_);
               }
               if(param1.get_rightArrowSkin() == null)
               {
                  _loc3_ = new TriangleSkin();
                  _loc3_.set_pointPosition(RelativePosition.RIGHT);
                  _loc3_.set_drawBaseBorder(false);
                  _loc3_.set_fill(theme.getContainerFill());
                  _loc3_.set_border(theme.getContainerBorder());
                  _loc3_.width = 8;
                  _loc3_.height = 14;
                  param1.set_rightArrowSkin(_loc3_);
               }
               if(param1.get_bottomArrowSkin() == null)
               {
                  _loc3_ = new TriangleSkin();
                  _loc3_.set_pointPosition(RelativePosition.BOTTOM);
                  _loc3_.set_drawBaseBorder(false);
                  _loc3_.set_fill(theme.getContainerFill());
                  _loc3_.set_border(theme.getContainerBorder());
                  _loc3_.width = 14;
                  _loc3_.height = 8;
                  param1.set_bottomArrowSkin(_loc3_);
               }
               if(param1.get_leftArrowSkin() == null)
               {
                  _loc3_ = new TriangleSkin();
                  _loc3_.set_pointPosition(RelativePosition.LEFT);
                  _loc3_.set_drawBaseBorder(false);
                  _loc3_.set_fill(theme.getContainerFill());
                  _loc3_.set_border(theme.getContainerBorder());
                  _loc3_.width = 8;
                  _loc3_.height = 14;
                  param1.set_leftArrowSkin(_loc3_);
               }
               param1.set_topArrowGap(-1);
               param1.set_rightArrowGap(-1);
               param1.set_bottomArrowGap(-1);
               param1.set_leftArrowGap(-1);
               param1.set_paddingTop(1);
               param1.set_paddingRight(1);
               param1.set_paddingBottom(1);
               param1.set_paddingLeft(1);
               param1.set_marginTop(10);
               param1.set_marginRight(10);
               param1.set_marginBottom(10);
               param1.set_marginLeft(10);
            });
         }
      }
   }
}

