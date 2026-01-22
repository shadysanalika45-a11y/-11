package feathers.skins
{
   import feathers.controls.IToggle;
   import feathers.core.IStateContext;
   import feathers.core.IUIControl;
   import feathers.core.InvalidationFlag;
   import feathers.graphics.FillStyle;
   import feathers.graphics.LineStyle;
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   import haxe.IMap;
   import haxe.ds.EnumValueMap;
   import openfl.display._internal.FlashGraphics;
   
   public class BaseGraphicsPathSkin extends ProgrammaticSkin
   {
      
      public var _stateToFill:IMap;
      
      public var _stateToBorder:IMap;
      
      public var _selectedFill:FillStyle;
      
      public var _selectedBorder:LineStyle;
      
      public var _previousFill:FillStyle;
      
      public var _previousBorder:LineStyle;
      
      public var _fill:FillStyle;
      
      public var _disabledFill:FillStyle;
      
      public var _disabledBorder:LineStyle;
      
      public var _border:LineStyle;
      
      public function BaseGraphicsPathSkin(param1:FillStyle = undefined, param2:LineStyle = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _previousFill = null;
         _previousBorder = null;
         super();
         set_fill(param1);
         set_border(param2);
      }
      
      override public function update() : void
      {
         _previousBorder = getCurrentBorder();
         _previousFill = getCurrentFill();
         graphics.clear();
         draw();
      }
      
      public function set_selectedFill(param1:FillStyle) : FillStyle
      {
         if(_selectedFill == param1)
         {
            return _selectedFill;
         }
         if(_previousFill == _selectedFill)
         {
            _previousFill = null;
         }
         _selectedFill = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _selectedFill;
      }
      
      public function set selectedFill(param1:FillStyle) : void
      {
         set_selectedFill(param1);
      }
      
      public function set_selectedBorder(param1:LineStyle) : LineStyle
      {
         if(_selectedBorder == param1)
         {
            return _selectedBorder;
         }
         if(_previousBorder == _selectedBorder)
         {
            _previousBorder = null;
         }
         _selectedBorder = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _selectedBorder;
      }
      
      public function set selectedBorder(param1:LineStyle) : void
      {
         set_selectedBorder(param1);
      }
      
      public function set_fill(param1:FillStyle) : FillStyle
      {
         if(_fill == param1)
         {
            return _fill;
         }
         if(_previousFill == _fill)
         {
            _previousFill = null;
         }
         _fill = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _fill;
      }
      
      public function set fill(param1:FillStyle) : void
      {
         set_fill(param1);
      }
      
      public function set_disabledFill(param1:FillStyle) : FillStyle
      {
         if(_disabledFill == param1)
         {
            return _disabledFill;
         }
         if(_previousFill == _disabledFill)
         {
            _previousFill = null;
         }
         _disabledFill = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _disabledFill;
      }
      
      public function set disabledFill(param1:FillStyle) : void
      {
         set_disabledFill(param1);
      }
      
      public function set_disabledBorder(param1:LineStyle) : LineStyle
      {
         if(_disabledBorder == param1)
         {
            return _disabledBorder;
         }
         if(_previousBorder == _disabledBorder)
         {
            _previousBorder = null;
         }
         _disabledBorder = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _disabledBorder;
      }
      
      public function set disabledBorder(param1:LineStyle) : void
      {
         set_disabledBorder(param1);
      }
      
      public function set_border(param1:LineStyle) : LineStyle
      {
         if(_border == param1)
         {
            return _border;
         }
         if(_previousBorder == _border)
         {
            _previousBorder = null;
         }
         _border = param1;
         setInvalid(InvalidationFlag.STYLES);
         return _border;
      }
      
      public function set border(param1:LineStyle) : void
      {
         set_border(param1);
      }
      
      public function setFillForState(param1:Object, param2:FillStyle) : void
      {
         if(_stateToFill == null)
         {
            _stateToFill = new EnumValueMap();
         }
         var _loc3_:FillStyle = _stateToFill._SafeStr_2(param1);
         if(_loc3_ == param2)
         {
            return;
         }
         if(_previousFill == _loc3_)
         {
            _previousFill = null;
         }
         _stateToFill._SafeStr_1(param1,param2);
         setInvalid(InvalidationFlag.STYLES);
      }
      
      public function setBorderForState(param1:Object, param2:LineStyle) : void
      {
         if(_stateToBorder == null)
         {
            _stateToBorder = new EnumValueMap();
         }
         var _loc3_:LineStyle = _stateToBorder._SafeStr_2(param1);
         if(_loc3_ == param2)
         {
            return;
         }
         if(_previousBorder == _loc3_)
         {
            _previousBorder = null;
         }
         _stateToBorder._SafeStr_1(param1,param2);
         setInvalid(InvalidationFlag.STYLES);
      }
      
      override public function needsStateUpdate() : Boolean
      {
         var _loc1_:Boolean = false;
         if(_previousBorder != getCurrentBorderWithoutCache())
         {
            _previousBorder = null;
            _loc1_ = true;
         }
         if(_previousFill != getCurrentFillWithoutCache())
         {
            _previousFill = null;
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get_selectedFill() : FillStyle
      {
         return _selectedFill;
      }
      
      public function get selectedFill() : FillStyle
      {
         return get_selectedFill();
      }
      
      public function get_selectedBorder() : LineStyle
      {
         return _selectedBorder;
      }
      
      public function get selectedBorder() : LineStyle
      {
         return get_selectedBorder();
      }
      
      public function get_fill() : FillStyle
      {
         return _fill;
      }
      
      public function get fill() : FillStyle
      {
         return get_fill();
      }
      
      public function get_disabledFill() : FillStyle
      {
         return _disabledFill;
      }
      
      public function get disabledFill() : FillStyle
      {
         return get_disabledFill();
      }
      
      public function get_disabledBorder() : LineStyle
      {
         return _disabledBorder;
      }
      
      public function get disabledBorder() : LineStyle
      {
         return get_disabledBorder();
      }
      
      public function get_border() : LineStyle
      {
         return _border;
      }
      
      public function get border() : LineStyle
      {
         return get_border();
      }
      
      public function getLineThickness(param1:LineStyle) : Number
      {
         var _loc2_:* = null as Object;
         var _loc3_:* = null as Object;
         var _loc4_:* = null as Object;
         var _loc5_:* = null as String;
         var _loc6_:* = null as String;
         var _loc7_:* = null as String;
         var _loc8_:* = null as Object;
         var _loc9_:* = null as Object;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as Array;
         var _loc12_:* = null as Array;
         var _loc13_:* = null as Array;
         if(param1 == null)
         {
            return 0;
         }
         switch(param1.index)
         {
            case 0:
               _loc2_ = param1.params[1];
               _loc3_ = param1.params[2];
               _loc4_ = param1.params[3];
               _loc5_ = param1.params[4];
               _loc6_ = param1.params[5];
               _loc7_ = param1.params[6];
               _loc8_ = param1.params[7];
               return param1.params[0];
            case 2:
               _loc2_ = param1.params[5];
               _loc5_ = param1.params[6];
               _loc6_ = param1.params[7];
               _loc3_ = param1.params[8];
               _loc10_ = Number(param1.params[0]);
               _loc7_ = param1.params[1];
               _loc11_ = param1.params[2];
               _loc12_ = param1.params[3];
               _loc13_ = param1.params[4];
               return _loc10_;
            default:
               return 0;
         }
      }
      
      public function getFillForState(param1:Object) : FillStyle
      {
         if(_stateToFill == null)
         {
            return null;
         }
         return _stateToFill._SafeStr_2(param1);
      }
      
      public function getDefaultGradientMatrixWidth() : Number
      {
         return actualWidth;
      }
      
      public function getDefaultGradientMatrixTy() : Number
      {
         return 0;
      }
      
      public function getDefaultGradientMatrixTx() : Number
      {
         return 0;
      }
      
      public function getDefaultGradientMatrixRadians() : Number
      {
         return 0;
      }
      
      public function getDefaultGradientMatrixHeight() : Number
      {
         return actualHeight;
      }
      
      public function getDefaultGradientMatrix(param1:Number, param2:Number, param3:Object = undefined, param4:Object = undefined, param5:Object = undefined) : Matrix
      {
         if(param3 == null)
         {
            param3 = 0;
         }
         if(param4 == null)
         {
            param4 = 0;
         }
         if(param5 == null)
         {
            param5 = 0;
         }
         var _loc6_:Matrix = new Matrix();
         _loc6_.createGradientBox(param1,param2,param3,param4,param5);
         return _loc6_;
      }
      
      public function getCurrentFillWithoutCache() : FillStyle
      {
         var _loc2_:* = null as FillStyle;
         var _loc3_:* = null as IToggle;
         var _loc1_:IStateContext = _stateContext;
         if(_loc1_ == null && _uiContext is IStateContext)
         {
            _loc1_ = _uiContext;
         }
         if(_stateToFill != null && _loc1_ != null)
         {
            _loc2_ = _stateToFill._SafeStr_2(_loc1_.get_currentState());
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         if(_uiContext == null)
         {
            return _fill;
         }
         if(_disabledFill != null)
         {
            if(!_uiContext.get_enabled())
            {
               return _disabledFill;
            }
         }
         if(_selectedFill != null && _uiContext is IToggle)
         {
            _loc3_ = _uiContext;
            if(_loc3_.get_selected())
            {
               return _selectedFill;
            }
         }
         return _fill;
      }
      
      public function getCurrentFill() : FillStyle
      {
         if(_previousFill != null)
         {
            return _previousFill;
         }
         return getCurrentFillWithoutCache();
      }
      
      public function getCurrentBorderWithoutCache() : LineStyle
      {
         var _loc2_:* = null as LineStyle;
         var _loc3_:* = null as IToggle;
         var _loc1_:IStateContext = _stateContext;
         if(_loc1_ == null && _uiContext is IStateContext)
         {
            _loc1_ = _uiContext;
         }
         if(_stateToBorder != null && _loc1_ != null)
         {
            _loc2_ = _stateToBorder._SafeStr_2(_loc1_.get_currentState());
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         if(_uiContext == null)
         {
            return _border;
         }
         if(_disabledBorder != null)
         {
            if(!_uiContext.get_enabled())
            {
               return _disabledBorder;
            }
         }
         if(_selectedBorder != null && _uiContext is IToggle)
         {
            _loc3_ = _uiContext;
            if(_loc3_.get_selected())
            {
               return _selectedBorder;
            }
         }
         return _border;
      }
      
      public function getCurrentBorder() : LineStyle
      {
         if(_previousBorder != null)
         {
            return _previousBorder;
         }
         return getCurrentBorderWithoutCache();
      }
      
      public function getBorderForState(param1:Object) : LineStyle
      {
         if(_stateToBorder == null)
         {
            return null;
         }
         return _stateToBorder._SafeStr_2(param1);
      }
      
      public function drawPath() : void
      {
      }
      
      public function draw() : void
      {
         var _loc2_:* = null as Graphics;
         var _loc3_:* = null as BitmapData;
         applyLineStyle(getCurrentBorder());
         var _loc1_:FillStyle = getCurrentFill();
         applyFillStyle(_loc1_);
         drawPath();
         if(_loc1_ != null && _loc1_ != FillStyle.None)
         {
            _loc2_ = graphics;
            _loc3_ = null;
            FlashGraphics.bitmapFill[_loc2_] = _loc3_;
            _loc2_.endFill();
         }
      }
      
      public function applyLineStyle(param1:LineStyle) : void
      {
         var _loc2_:* = null as Object;
         var _loc3_:* = null as Object;
         var _loc4_:* = null as Object;
         var _loc5_:* = null as Object;
         var _loc6_:* = null as String;
         var _loc7_:* = null as String;
         var _loc8_:* = null as String;
         var _loc9_:* = null as Object;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as BitmapData;
         var _loc12_:* = null as Matrix;
         var _loc13_:* = null as Array;
         var _loc14_:* = null as Array;
         var _loc15_:* = null as Array;
         var _loc16_:* = null as Function;
         if(param1 == null)
         {
            return;
         }
         switch(param1.index)
         {
            case 0:
               _loc2_ = param1.params[0];
               _loc3_ = param1.params[1];
               _loc4_ = param1.params[2];
               _loc5_ = param1.params[3];
               _loc6_ = param1.params[4];
               _loc7_ = param1.params[5];
               _loc8_ = param1.params[6];
               _loc9_ = param1.params[7];
               if(_loc3_ == null)
               {
                  _loc3_ = 0;
               }
               if(_loc4_ == null)
               {
                  _loc4_ = 1;
               }
               if(_loc5_ == null)
               {
                  _loc5_ = false;
               }
               if(_loc6_ == null)
               {
                  _loc6_ = "normal";
               }
               if(_loc9_ == null)
               {
                  _loc9_ = 3;
               }
               graphics.lineStyle(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
               break;
            case 1:
               _loc10_ = Number(param1.params[0]);
               _loc11_ = param1.params[1];
               _loc12_ = param1.params[2];
               _loc2_ = param1.params[3];
               _loc3_ = param1.params[4];
               if(_loc2_ == null)
               {
                  _loc2_ = true;
               }
               if(_loc3_ == null)
               {
                  _loc3_ = false;
               }
               graphics.lineStyle(_loc10_);
               graphics.lineBitmapStyle(_loc11_,_loc12_,_loc2_,_loc3_);
               break;
            case 2:
               _loc10_ = Number(param1.params[0]);
               _loc6_ = param1.params[1];
               _loc13_ = param1.params[2];
               _loc14_ = param1.params[3];
               _loc15_ = param1.params[4];
               _loc2_ = param1.params[5];
               _loc7_ = param1.params[6];
               _loc8_ = param1.params[7];
               _loc3_ = param1.params[8];
               _loc16_ = _loc2_;
               if(_loc16_ == null)
               {
                  _loc16_ = getDefaultGradientMatrix;
               }
               if(_loc7_ == null)
               {
                  _loc7_ = "pad";
               }
               if(_loc8_ == null)
               {
                  _loc8_ = "rgb";
               }
               if(_loc3_ == null)
               {
                  _loc3_ = 0;
               }
               _loc12_ = _loc16_(getDefaultGradientMatrixWidth(),getDefaultGradientMatrixHeight(),getDefaultGradientMatrixRadians(),getDefaultGradientMatrixTx(),getDefaultGradientMatrixTy());
               graphics.lineStyle(_loc10_);
               graphics.lineGradientStyle(_loc6_,_loc13_,_loc14_,_loc15_,_loc12_,_loc7_,_loc8_,_loc3_);
               break;
            case 3:
               graphics.lineStyle(Number(Math.NaN),0,0);
         }
      }
      
      public function applyFillStyle(param1:FillStyle) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Object;
         var _loc4_:* = null as Graphics;
         var _loc5_:* = null as BitmapData;
         var _loc6_:* = null as Matrix;
         var _loc7_:* = null as Object;
         var _loc8_:* = null as String;
         var _loc9_:* = null as Array;
         var _loc10_:* = null as Array;
         var _loc11_:* = null as Array;
         var _loc12_:* = null as String;
         var _loc13_:* = null as String;
         var _loc14_:* = null as Function;
         if(param1 == null)
         {
            return;
         }
         switch(param1.index)
         {
            case 0:
               _loc2_ = int(param1.params[0]);
               _loc3_ = param1.params[1];
               if(_loc3_ == null)
               {
                  _loc3_ = 1;
               }
               _loc4_ = graphics;
               _loc5_ = null;
               FlashGraphics.bitmapFill[_loc4_] = _loc5_;
               _loc4_.beginFill(_loc2_,Number(_loc3_));
               break;
            case 1:
               _loc5_ = param1.params[0];
               _loc6_ = param1.params[1];
               _loc3_ = param1.params[2];
               _loc7_ = param1.params[3];
               if(_loc3_ == null)
               {
                  _loc3_ = true;
               }
               if(_loc7_ == null)
               {
                  _loc7_ = false;
               }
               _loc4_ = graphics;
               FlashGraphics.bitmapFill[_loc4_] = _loc5_;
               _loc4_.beginBitmapFill(_loc5_,_loc6_,Boolean(_loc3_),Boolean(_loc7_));
               break;
            case 2:
               _loc8_ = param1.params[0];
               _loc9_ = param1.params[1];
               _loc10_ = param1.params[2];
               _loc11_ = param1.params[3];
               _loc3_ = param1.params[4];
               _loc12_ = param1.params[5];
               _loc13_ = param1.params[6];
               _loc7_ = param1.params[7];
               _loc14_ = _loc3_;
               if(_loc14_ == null)
               {
                  _loc14_ = getDefaultGradientMatrix;
               }
               if(_loc12_ == null)
               {
                  _loc12_ = "pad";
               }
               if(_loc13_ == null)
               {
                  _loc13_ = "rgb";
               }
               if(_loc7_ == null)
               {
                  _loc7_ = 0;
               }
               _loc6_ = _loc14_(getDefaultGradientMatrixWidth(),getDefaultGradientMatrixHeight(),getDefaultGradientMatrixRadians(),getDefaultGradientMatrixTx(),getDefaultGradientMatrixTy());
               _loc4_ = graphics;
               _loc5_ = null;
               FlashGraphics.bitmapFill[_loc4_] = _loc5_;
               _loc4_.beginGradientFill(_loc8_,_loc9_,_loc10_,_loc11_,_loc6_,_loc12_,_loc13_,_loc7_);
               break;
            case 3:
               return;
         }
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
