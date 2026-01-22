package feathers.themes.steel
{
   import feathers.events.StyleProviderEvent;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import feathers.graphics._CreateGradientBoxMatrix.CreateGradientBoxMatrix_Impl_;
   import feathers.style.ClassVariantStyleProvider;
   import feathers.style.IDarkModeTheme;
   import feathers.text.TextFormat;
   import feathers.themes.ClassVariantTheme;
   import flash.Boot;
   
   public class BaseSteelTheme extends ClassVariantTheme implements IDarkModeTheme
   {
      
      public var themeColor:int;
      
      public var textColor:int;
      
      public var subHeadingFillColor:int;
      
      public var subHeadingDividerColor:int;
      
      public var selectedInsetBorderColor:int;
      
      public var selectedBorderColor:int;
      
      public var secondaryTextColor:int;
      
      public var scrollBarThumbFillColor:int;
      
      public var scrollBarThumbDisabledFillColor:int;
      
      public var rootFillColor:int;
      
      public var overlayFillColor:int;
      
      public var offsetThemeColor:int;
      
      public var offsetDangerFillColor:int;
      
      public var insetFillColor:int;
      
      public var insetBorderColor:int;
      
      public var headerFontSize:int;
      
      public var headerFillColor:int;
      
      public var fontSize:int;
      
      public var fontName:String;
      
      public var focusBorderColor:int;
      
      public var dividerColor:int;
      
      public var disabledTextColor:int;
      
      public var disabledInsetFillColor:int;
      
      public var disabledInsetBorderColor:int;
      
      public var detailFontSize:int;
      
      public var dangerTextColor:int;
      
      public var dangerFillColor:int;
      
      public var dangerBorderColor:int;
      
      public var customThemeColor:Object;
      
      public var customDarkThemeColor:Object;
      
      public var controlFillColor2:int;
      
      public var controlFillColor1:int;
      
      public var controlDisabledFillColor:int;
      
      public var containerFillColor:int;
      
      public var borderColor:int;
      
      public var activeFillBorderColor:int;
      
      public var _darkMode:Boolean;
      
      public function BaseSteelTheme(param1:Object = undefined, param2:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _darkMode = false;
         super();
         customThemeColor = param1;
         customDarkThemeColor = param2;
         refreshColors();
         refreshFonts();
         styleProvider = new ClassVariantStyleProvider();
      }
      
      public function set_darkMode(param1:Boolean) : Boolean
      {
         if(_darkMode == param1)
         {
            return _darkMode;
         }
         _darkMode = param1;
         refreshColors();
         StyleProviderEvent.dispatch(styleProvider,"stylesChange");
         return _darkMode;
      }
      
      public function set darkMode(param1:Boolean) : void
      {
         set_darkMode(param1);
      }
      
      public function refreshFonts() : void
      {
         fontName = "_sans";
         refreshFontSizes();
      }
      
      public function refreshFontSizes() : void
      {
         fontSize = 14;
         headerFontSize = 18;
         detailFontSize = 12;
      }
      
      public function refreshColors() : void
      {
         if(_darkMode)
         {
            if(customDarkThemeColor != null)
            {
               themeColor = customDarkThemeColor;
            }
            else if(customThemeColor != null)
            {
               themeColor = customThemeColor;
            }
            else
            {
               themeColor = 5205919;
            }
            offsetThemeColor = darken(themeColor,986895);
            rootFillColor = 3684408;
            controlFillColor1 = 6250335;
            controlFillColor2 = 5000268;
            controlDisabledFillColor = 3158064;
            scrollBarThumbFillColor = 7303023;
            scrollBarThumbDisabledFillColor = 4144959;
            insetFillColor = 1579032;
            disabledInsetFillColor = 2631720;
            insetBorderColor = 4737096;
            disabledInsetBorderColor = 3684408;
            selectedInsetBorderColor = themeColor;
            activeFillBorderColor = darken(themeColor,3092271);
            selectedBorderColor = lighten(themeColor,986895);
            focusBorderColor = lighten(themeColor,986895);
            containerFillColor = 3684408;
            headerFillColor = 4144959;
            overlayFillColor = 7303023;
            subHeadingFillColor = 2894892;
            dangerFillColor = 10440527;
            offsetDangerFillColor = darken(dangerFillColor,986895);
            dangerBorderColor = darken(dangerFillColor,3092271);
            borderColor = 526344;
            dividerColor = 2631720;
            subHeadingDividerColor = 789516;
            textColor = 15856113;
            disabledTextColor = 9408399;
            secondaryTextColor = 11513775;
            dangerTextColor = 13385535;
         }
         else
         {
            if(customThemeColor != null)
            {
               themeColor = customThemeColor;
            }
            else
            {
               themeColor = 10535152;
            }
            offsetThemeColor = darken(themeColor,986895);
            rootFillColor = 16316664;
            controlFillColor1 = 16777215;
            controlFillColor2 = 15263976;
            controlDisabledFillColor = 15724527;
            scrollBarThumbFillColor = 9408399;
            scrollBarThumbDisabledFillColor = 13619151;
            insetFillColor = 16579836;
            disabledInsetFillColor = 15856113;
            insetBorderColor = 11316396;
            disabledInsetBorderColor = 13421772;
            selectedInsetBorderColor = darken(themeColor,3092271);
            activeFillBorderColor = darken(themeColor,3092271);
            selectedBorderColor = darken(themeColor,3092271);
            focusBorderColor = darken(themeColor,3092271);
            containerFillColor = 16316664;
            headerFillColor = 15527148;
            overlayFillColor = 9408399;
            subHeadingFillColor = 14671839;
            dangerFillColor = 15769760;
            offsetDangerFillColor = darken(dangerFillColor,986895);
            dangerBorderColor = darken(dangerFillColor,3092271);
            borderColor = 11316396;
            dividerColor = 14671839;
            subHeadingDividerColor = 13619151;
            textColor = 2039583;
            disabledTextColor = 10461087;
            secondaryTextColor = 7303023;
            dangerTextColor = 13385535;
         }
      }
      
      public function lighten(param1:int, param2:int) : int
      {
         var _loc3_:* = param1 >> 16 & 0xFF;
         var _loc4_:* = param1 >> 8 & 0xFF;
         var _loc5_:* = param1 & 0xFF;
         var _loc6_:* = param2 >> 16 & 0xFF;
         var _loc7_:* = param2 >> 8 & 0xFF;
         var _loc8_:* = param2 & 0xFF;
         _loc3_ += _loc6_;
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         _loc4_ += _loc7_;
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         _loc5_ += _loc8_;
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         return (_loc3_ << 16) + (_loc4_ << 8) + _loc5_;
      }
      
      public function get_darkMode() : Boolean
      {
         return _darkMode;
      }
      
      public function get darkMode() : Boolean
      {
         return get_darkMode();
      }
      
      public function getThemeFill() : FillStyle
      {
         return FillStyle.SolidColor(themeColor);
      }
      
      public function getThemeBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,themeColor);
      }
      
      public function getTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,fontSize,textColor,null,null,null,null,null,param1);
      }
      
      public function getSubHeadingFill() : FillStyle
      {
         return FillStyle.SolidColor(subHeadingFillColor);
      }
      
      public function getSubHeadingDividerFill() : FillStyle
      {
         return FillStyle.SolidColor(subHeadingDividerColor);
      }
      
      public function getSubHeadingDividerBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,subHeadingDividerColor);
      }
      
      public function getSelectedInsetBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,selectedInsetBorderColor);
      }
      
      public function getSelectedBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,selectedBorderColor);
      }
      
      public function getSecondaryTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,fontSize,secondaryTextColor,null,null,null,null,null,param1);
      }
      
      public function getScrollBarThumbFill() : FillStyle
      {
         return FillStyle.SolidColor(scrollBarThumbFillColor);
      }
      
      public function getScrollBarThumbDisabledFill() : FillStyle
      {
         return FillStyle.SolidColor(scrollBarThumbDisabledFillColor,0.7);
      }
      
      public function getRootFill() : FillStyle
      {
         return FillStyle.SolidColor(rootFillColor);
      }
      
      public function getReversedDangerFill() : FillStyle
      {
         var _loc1_:Array = [offsetDangerFillColor,dangerFillColor];
         return FillStyle.Gradient("linear",_loc1_,[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getReversedActiveThemeFill() : FillStyle
      {
         var _loc1_:Array = [offsetThemeColor,themeColor];
         return FillStyle.Gradient("linear",_loc1_,[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getOverlayFill() : FillStyle
      {
         return FillStyle.SolidColor(overlayFillColor,0.8);
      }
      
      public function getInsetFill() : FillStyle
      {
         return FillStyle.SolidColor(insetFillColor);
      }
      
      public function getInsetBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,insetBorderColor);
      }
      
      public function getHeaderTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,headerFontSize,textColor,null,null,null,null,null,param1);
      }
      
      public function getHeaderFill() : FillStyle
      {
         return FillStyle.SolidColor(headerFillColor);
      }
      
      public function getFocusBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,focusBorderColor);
      }
      
      public function getDividerFill() : FillStyle
      {
         return FillStyle.SolidColor(dividerColor);
      }
      
      public function getDividerBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,dividerColor);
      }
      
      public function getDisabledTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,fontSize,disabledTextColor,null,null,null,null,null,param1);
      }
      
      public function getDisabledInsetFill() : FillStyle
      {
         return FillStyle.SolidColor(disabledInsetFillColor);
      }
      
      public function getDisabledInsetBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,disabledInsetBorderColor);
      }
      
      public function getDisabledHeaderTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,headerFontSize,disabledTextColor,null,null,null,null,null,param1);
      }
      
      public function getDisabledDetailTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,detailFontSize,disabledTextColor,null,null,null,null,null,param1);
      }
      
      public function getDetailTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,detailFontSize,secondaryTextColor,null,null,null,null,null,param1);
      }
      
      public function getDangerTextFormat(param1:String = undefined) : TextFormat
      {
         if(param1 == null)
         {
            param1 = "left";
         }
         return new TextFormat(fontName,fontSize,dangerTextColor,null,null,null,null,null,param1);
      }
      
      public function getDangerFill() : FillStyle
      {
         var _loc1_:Array = [dangerFillColor,offsetDangerFillColor];
         return FillStyle.Gradient("linear",_loc1_,[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getDangerBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,dangerBorderColor);
      }
      
      public function getControlFill() : FillStyle
      {
         return FillStyle.SolidColor(controlFillColor2);
      }
      
      public function getControlDisabledFill() : FillStyle
      {
         return FillStyle.SolidColor(controlDisabledFillColor,0.7);
      }
      
      public function getContainerFill() : FillStyle
      {
         return FillStyle.SolidColor(containerFillColor);
      }
      
      public function getContainerBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,borderColor);
      }
      
      public function getButtonFill() : FillStyle
      {
         return FillStyle.Gradient("linear",[controlFillColor1,controlFillColor2],[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getButtonDownFill() : FillStyle
      {
         return FillStyle.Gradient("linear",[controlFillColor2,controlFillColor1],[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getButtonDisabledFill() : FillStyle
      {
         return FillStyle.SolidColor(controlDisabledFillColor,0.7);
      }
      
      public function getButtonBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,borderColor);
      }
      
      public function getBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,borderColor);
      }
      
      public function getActiveThemeFill() : FillStyle
      {
         var _loc1_:Array = [themeColor,offsetThemeColor];
         return FillStyle.Gradient("linear",_loc1_,[1,1],[0,255],CreateGradientBoxMatrix_Impl_.fromRadians(Math.PI / 2));
      }
      
      public function getActiveFillBorder(param1:Number = 1) : LineStyle
      {
         return LineStyle.SolidColor(param1,activeFillBorderColor);
      }
      
      public function darken(param1:int, param2:int) : int
      {
         var _loc3_:* = param1 >> 16 & 0xFF;
         var _loc4_:* = param1 >> 8 & 0xFF;
         var _loc5_:* = param1 & 0xFF;
         var _loc6_:* = param2 >> 16 & 0xFF;
         var _loc7_:* = param2 >> 8 & 0xFF;
         var _loc8_:* = param2 & 0xFF;
         _loc3_ -= _loc6_;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         _loc4_ -= _loc7_;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         _loc5_ -= _loc8_;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         return (_loc3_ << 16) + (_loc4_ << 8) + _loc5_;
      }
   }
}

