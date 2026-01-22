package feathers.controls.supportClasses
{
   import feathers.controls.LayoutGroup;
   import feathers.core.InvalidationFlag;
   import feathers.layout.AutoSizeMode;
   import feathers.layout.ILayout;
   import feathers.layout.IScrollLayout;
   import feathers.layout.ISnapLayout;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Point;
   import openfl.display._internal.FlashGraphics;
   
   public class LayoutViewPort extends LayoutGroup implements IViewPort
   {
      
      public var _viewPortBackground:Sprite;
      
      public var _snapPositionsY:Array;
      
      public var _snapPositionsX:Array;
      
      public var _scrollY:Number;
      
      public var _scrollX:Number;
      
      public var _maxVisibleWidth:Object;
      
      public var _maxVisibleHeight:Object;
      
      public var _explicitVisibleWidth:Object;
      
      public var _explicitVisibleHeight:Object;
      
      public var _explicitMinVisibleWidth:Object;
      
      public var _explicitMinVisibleHeight:Object;
      
      public var _actualVisibleWidth:Number;
      
      public var _actualVisibleHeight:Number;
      
      public var _actualMinVisibleWidth:Number;
      
      public var _actualMinVisibleHeight:Number;
      
      public function LayoutViewPort()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _snapPositionsY = null;
         _snapPositionsX = null;
         _scrollY = 0;
         _scrollX = 0;
         _explicitVisibleHeight = null;
         _actualVisibleHeight = 0;
         _maxVisibleHeight = 1 / 0;
         _actualMinVisibleHeight = 0;
         _explicitVisibleWidth = null;
         _actualVisibleWidth = 0;
         _maxVisibleWidth = 1 / 0;
         _explicitMinVisibleWidth = null;
         _actualMinVisibleWidth = 0;
         super();
         _viewPortBackground = new Sprite();
         var _loc1_:Graphics = _viewPortBackground.graphics;
         var _loc2_:BitmapData = null;
         FlashGraphics.bitmapFill[_loc1_] = _loc2_;
         _loc1_.beginFill(16711935,0);
         _viewPortBackground.graphics.drawRect(0,0,1,1);
         _loc1_ = _viewPortBackground.graphics;
         _loc2_ = null;
         FlashGraphics.bitmapFill[_loc1_] = _loc2_;
         _loc1_.endFill();
         _addChildAt(_viewPortBackground,0);
      }
      
      public function set_visibleWidth(param1:Object) : Object
      {
         if(_explicitVisibleWidth == param1)
         {
            return _explicitVisibleWidth;
         }
         _explicitVisibleWidth = param1;
         if(_actualVisibleWidth != param1)
         {
            setInvalid(InvalidationFlag.SIZE);
         }
         return _explicitVisibleWidth;
      }
      
      public function set visibleWidth(param1:Object) : void
      {
         set_visibleWidth(param1);
      }
      
      public function set_visibleHeight(param1:Object) : Object
      {
         if(_explicitVisibleHeight == param1)
         {
            return _explicitVisibleHeight;
         }
         _explicitVisibleHeight = param1;
         if(_actualVisibleHeight != param1)
         {
            setInvalid(InvalidationFlag.SIZE);
         }
         return _explicitVisibleWidth;
      }
      
      public function set visibleHeight(param1:Object) : void
      {
         set_visibleHeight(param1);
      }
      
      public function set_scrollY(param1:Number) : Number
      {
         if(_scrollY == param1)
         {
            return _scrollY;
         }
         _scrollY = param1;
         if(_currentLayout is IScrollLayout)
         {
            setInvalid(InvalidationFlag.LAYOUT);
         }
         return _scrollY;
      }
      
      public function set scrollY(param1:Number) : void
      {
         set_scrollY(param1);
      }
      
      public function set_scrollX(param1:Number) : Number
      {
         if(_scrollX == param1)
         {
            return _scrollX;
         }
         _scrollX = param1;
         if(_currentLayout is IScrollLayout)
         {
            setInvalid(InvalidationFlag.LAYOUT);
         }
         return _scrollX;
      }
      
      public function set scrollX(param1:Number) : void
      {
         set_scrollX(param1);
      }
      
      public function set_minVisibleWidth(param1:Object) : Object
      {
         if(_explicitMinVisibleWidth == param1)
         {
            return _explicitMinVisibleWidth;
         }
         var _loc2_:Object = _explicitMinVisibleWidth;
         _explicitMinVisibleWidth = param1;
         if(param1 == null)
         {
            _actualMinVisibleWidth = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _actualMinVisibleWidth = param1;
            if(_explicitVisibleWidth == null && (_actualVisibleWidth < param1 || _actualVisibleWidth == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMinVisibleWidth;
      }
      
      public function set minVisibleWidth(param1:Object) : void
      {
         set_minVisibleWidth(param1);
      }
      
      public function set_minVisibleHeight(param1:Object) : Object
      {
         if(_explicitMinVisibleHeight == param1)
         {
            return _explicitMinVisibleHeight;
         }
         var _loc2_:Object = _explicitMinVisibleHeight;
         _explicitMinVisibleHeight = param1;
         if(param1 == null)
         {
            _actualMinVisibleHeight = 0;
            setInvalid(InvalidationFlag.SIZE);
         }
         else
         {
            _actualMinVisibleHeight = param1;
            if(_explicitVisibleHeight == null && (_actualVisibleHeight < param1 || _actualVisibleHeight == _loc2_))
            {
               setInvalid(InvalidationFlag.SIZE);
            }
         }
         return _explicitMinVisibleHeight;
      }
      
      public function set minVisibleHeight(param1:Object) : void
      {
         set_minVisibleHeight(param1);
      }
      
      public function set_maxVisibleWidth(param1:Object) : Object
      {
         if(_maxVisibleWidth == param1)
         {
            return _maxVisibleWidth;
         }
         if(param1 == null)
         {
            throw new ArgumentError("maxVisibleWidth cannot be null");
         }
         var _loc2_:Object = _maxVisibleWidth;
         _maxVisibleWidth = param1;
         if(_explicitVisibleWidth == null && (_actualVisibleWidth > param1 || _actualVisibleWidth == _loc2_))
         {
            setInvalid(InvalidationFlag.SIZE);
         }
         return _maxVisibleWidth;
      }
      
      public function set maxVisibleWidth(param1:Object) : void
      {
         set_maxVisibleWidth(param1);
      }
      
      public function set_maxVisibleHeight(param1:Object) : Object
      {
         if(_maxVisibleHeight == param1)
         {
            return _maxVisibleHeight;
         }
         if(param1 == null)
         {
            throw new ArgumentError("maxVisibleHeight cannot be null");
         }
         var _loc2_:Object = _maxVisibleHeight;
         _maxVisibleHeight = param1;
         if(_explicitVisibleHeight == null && (_actualVisibleHeight > param1 || _actualVisibleHeight == _loc2_))
         {
            setInvalid(InvalidationFlag.SIZE);
         }
         return _maxVisibleHeight;
      }
      
      public function set maxVisibleHeight(param1:Object) : void
      {
         set_maxVisibleHeight(param1);
      }
      
      override public function refreshViewPortBounds() : void
      {
         var _loc10_:* = null as Point;
         var _loc11_:* = null as Point;
         var _loc1_:* = _explicitVisibleWidth == null;
         var _loc2_:* = _explicitVisibleHeight == null;
         var _loc3_:* = _explicitMinVisibleWidth == null;
         var _loc4_:* = _explicitMinVisibleHeight == null;
         var _loc5_:* = _maxVisibleWidth == null;
         var _loc6_:* = _maxVisibleHeight == null;
         if(_currentBackgroundSkin != null)
         {
            MeasurementsUtil.resetFluidlyWithParent(_backgroundSkinMeasurements,_currentBackgroundSkin,this);
         }
         var _loc7_:Boolean = get_autoSizeMode() == AutoSizeMode.CONTENT || stage == null;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         if(!_loc7_)
         {
            _loc10_ = globalToLocal(new Point());
            _loc11_ = globalToLocal(new Point(stage.stageWidth,stage.stageHeight));
            _loc8_ = _loc11_.x - _loc10_.x;
            _loc9_ = _loc11_.y - _loc10_.y;
         }
         if(_loc1_ && !_loc7_)
         {
            _layoutMeasurements.width = _loc8_;
         }
         else
         {
            _layoutMeasurements.width = _explicitVisibleWidth;
         }
         if(_loc2_ && !_loc7_)
         {
            _layoutMeasurements.height = _loc9_;
         }
         else
         {
            _layoutMeasurements.height = _explicitVisibleHeight;
         }
         var _loc12_:Object = _explicitMinVisibleWidth;
         if(_loc3_)
         {
            _loc12_ = 0;
         }
         var _loc13_:Object = _explicitMinVisibleHeight;
         if(_loc4_)
         {
            _loc13_ = 0;
         }
         var _loc14_:Object = _maxVisibleWidth;
         if(_loc5_)
         {
            _loc14_ = 1 / 0;
         }
         var _loc15_:Object = _maxVisibleHeight;
         if(_loc6_)
         {
            _loc15_ = 1 / 0;
         }
         if(_currentBackgroundSkin != null)
         {
            if(_currentBackgroundSkin.width > _loc12_)
            {
               _loc12_ = _currentBackgroundSkin.width;
            }
            if(_currentBackgroundSkin.height > _loc13_)
            {
               _loc13_ = _currentBackgroundSkin.height;
            }
         }
         _layoutMeasurements.minWidth = _loc12_;
         _layoutMeasurements.minHeight = _loc13_;
         _layoutMeasurements.maxWidth = _loc14_;
         _layoutMeasurements.maxHeight = _loc15_;
      }
      
      override public function handleLayoutResult() : void
      {
         var _loc5_:* = null as ISnapLayout;
         saveMeasurements(_layoutResult.contentWidth,_layoutResult.contentHeight,_layoutResult.contentMinWidth,_layoutResult.contentMinHeight);
         var _loc1_:Number = _layoutResult.viewPortWidth;
         var _loc2_:Number = _layoutResult.viewPortHeight;
         _actualVisibleWidth = _loc1_;
         _actualVisibleHeight = _loc2_;
         _actualMinVisibleWidth = _layoutResult.contentMinWidth;
         _actualMinVisibleHeight = _layoutResult.contentMinHeight;
         var _loc3_:Number = get_scrollX();
         _viewPortBackground.x = Math.min(_loc3_,0);
         var _loc4_:Number = get_scrollY();
         _viewPortBackground.y = Math.min(_loc4_,0);
         _viewPortBackground.width = Math.max(actualWidth,_actualVisibleWidth);
         _viewPortBackground.height = Math.max(actualHeight,_actualVisibleHeight);
         if(get_layout() is ISnapLayout)
         {
            _loc5_ = get_layout();
            _snapPositionsX = _loc5_.getSnapPositionsX(items,_actualVisibleWidth,_actualVisibleHeight,_snapPositionsX);
            _snapPositionsY = _loc5_.getSnapPositionsY(items,_actualVisibleWidth,_actualVisibleHeight,_snapPositionsY);
         }
         else
         {
            _snapPositionsX = null;
            _snapPositionsY = null;
         }
      }
      
      override public function handleCustomLayout() : void
      {
         var _loc2_:* = null as IScrollLayout;
         var _loc1_:Boolean = _ignoreLayoutChanges;
         _ignoreLayoutChanges = true;
         if(_currentLayout is IScrollLayout)
         {
            _loc2_ = _currentLayout;
            _loc2_.set_scrollX(_scrollX);
            _loc2_.set_scrollY(_scrollY);
         }
         _ignoreLayoutChanges = _loc1_;
         super.handleCustomLayout();
      }
      
      public function get_visibleWidth() : Object
      {
         if(_explicitVisibleWidth == null)
         {
            return _actualVisibleWidth;
         }
         return _explicitVisibleWidth;
      }
      
      public function get visibleWidth() : Object
      {
         return get_visibleWidth();
      }
      
      public function get_visibleHeight() : Object
      {
         if(_explicitVisibleHeight == null)
         {
            return _actualVisibleHeight;
         }
         return _explicitVisibleHeight;
      }
      
      public function get visibleHeight() : Object
      {
         return get_visibleHeight();
      }
      
      public function get_snapPositionsY() : Array
      {
         return _snapPositionsY;
      }
      
      public function get snapPositionsY() : Array
      {
         return get_snapPositionsY();
      }
      
      public function get_snapPositionsX() : Array
      {
         return _snapPositionsX;
      }
      
      public function get snapPositionsX() : Array
      {
         return get_snapPositionsX();
      }
      
      public function get_scrollY() : Number
      {
         return _scrollY;
      }
      
      public function get scrollY() : Number
      {
         return get_scrollY();
      }
      
      public function get_scrollX() : Number
      {
         return _scrollX;
      }
      
      public function get scrollX() : Number
      {
         return get_scrollX();
      }
      
      public function get_minVisibleWidth() : Object
      {
         if(_explicitMinVisibleWidth == null)
         {
            return _actualMinVisibleWidth;
         }
         return _explicitMinVisibleWidth;
      }
      
      public function get minVisibleWidth() : Object
      {
         return get_minVisibleWidth();
      }
      
      public function get_minVisibleHeight() : Object
      {
         if(_explicitMinVisibleHeight == null)
         {
            return _actualMinVisibleHeight;
         }
         return _explicitMinVisibleHeight;
      }
      
      public function get minVisibleHeight() : Object
      {
         return get_minVisibleHeight();
      }
      
      public function get_maxVisibleWidth() : Object
      {
         return _maxVisibleWidth;
      }
      
      public function get maxVisibleWidth() : Object
      {
         return get_maxVisibleWidth();
      }
      
      public function get_maxVisibleHeight() : Object
      {
         return _maxVisibleHeight;
      }
      
      public function get maxVisibleHeight() : Object
      {
         return get_maxVisibleHeight();
      }
   }
}

