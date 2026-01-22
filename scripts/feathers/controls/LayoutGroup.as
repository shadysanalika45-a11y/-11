package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.layout.AutoSizeMode;
   import feathers.layout.ILayout;
   import feathers.layout.ILayoutObject;
   import feathers.layout.LayoutBoundsResult;
   import feathers.layout.Measurements;
   import feathers.skins.IProgrammaticSkin;
   import feathers.themes.steel.components.SteelLayoutGroupStyles;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import openfl.display._internal.FlashGraphics;
   
   public class LayoutGroup extends FeathersControl
   {
      
      public static var __meta__:* = {"obj":{"defaultXmlProperty":["xmlContent"]}};
      
      public static var VARIANT_TOOL_BAR:String = "toolBar";
      
      public var items:Array;
      
      public var _xmlContent:Array;
      
      public var _layoutResult:LayoutBoundsResult;
      
      public var _layoutMeasurements:Measurements;
      
      public var _ignoreLayoutChanges:Boolean;
      
      public var _ignoreChildChanges:Boolean;
      
      public var _ignoreChangesButSetFlags:Boolean;
      
      public var _disabledOverlay:Sprite;
      
      public var _currentMaskSkin:DisplayObject;
      
      public var _currentLayout:ILayout;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var _autoSizeMode:AutoSizeMode;
      
      public var __maskSkin:DisplayObject;
      
      public var __layout:ILayout;
      
      public var __disabledBackgroundSkin:DisplayObject;
      
      public var __backgroundSkin:DisplayObject;
      
      public function LayoutGroup()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __maskSkin = null;
         __disabledBackgroundSkin = null;
         __backgroundSkin = null;
         __layout = null;
         _xmlContent = null;
         _autoSizeMode = AutoSizeMode.CONTENT;
         _currentMaskSkin = null;
         _backgroundSkinMeasurements = null;
         _currentBackgroundSkin = null;
         _ignoreLayoutChanges = false;
         _ignoreChangesButSetFlags = false;
         _ignoreChildChanges = false;
         _layoutMeasurements = new Measurements();
         _layoutResult = new LayoutBoundsResult();
         items = [];
         initializeLayoutGroupTheme();
         super();
         addEventListener(Event.ADDED_TO_STAGE,layoutGroup_addedToStageHandler);
      }
      
      override public function validateNow() : void
      {
         var _loc1_:Boolean = _ignoreChangesButSetFlags;
         _ignoreChangesButSetFlags = true;
         super.validateNow();
         _ignoreChangesButSetFlags = _loc1_;
      }
      
      public function validateChildren() : void
      {
         var _loc3_:* = null as DisplayObject;
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
         var _loc1_:int = 0;
         var _loc2_:Array = items;
         while(_loc1_ < int(_loc2_.length))
         {
            _loc3_ = _loc2_[_loc1_];
            if(++_loc3_ is IValidating)
            {
               _loc3_.validateNow();
            }
         }
      }
      
      override public function update() : void
      {
         _ignoreChangesButSetFlags = false;
         var _loc1_:Boolean = isInvalid(InvalidationFlag.LAYOUT);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.STYLES);
         var _loc4_:Boolean = isInvalid(InvalidationFlag.STATE);
         if(_loc3_ || _loc4_)
         {
            refreshBackgroundSkin();
         }
         if(_loc3_)
         {
            refreshMaskSkin();
            refreshLayout();
         }
         if(_loc2_ || _loc1_ || _loc3_ || _loc4_)
         {
            refreshViewPortBounds();
            if(_currentLayout != null)
            {
               handleCustomLayout();
            }
            else
            {
               handleManualLayout();
            }
            handleLayoutResult();
            refreshBackgroundLayout();
            refreshDisabledOverlay();
            refreshMaskLayout();
            validateChildren();
         }
      }
      
      public function set_xmlContent(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Array;
         var _loc4_:* = null as DisplayObject;
         if(_xmlContent == param1)
         {
            return _xmlContent;
         }
         if(_xmlContent != null)
         {
            _loc2_ = 0;
            _loc3_ = _xmlContent;
            while(_loc2_ < int(_loc3_.length))
            {
               _loc4_ = _loc3_[_loc2_];
               _loc2_++;
               removeChild(_loc4_);
            }
         }
         _xmlContent = param1;
         if(_xmlContent != null)
         {
            _loc2_ = 0;
            _loc3_ = _xmlContent;
            while(_loc2_ < int(_loc3_.length))
            {
               _loc4_ = _loc3_[_loc2_];
               _loc2_++;
               addChild(_loc4_);
            }
         }
         setInvalid(InvalidationFlag.STYLES);
         return _xmlContent;
      }
      
      public function set xmlContent(param1:Array) : void
      {
         set_xmlContent(param1);
      }
      
      public function set_maskSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("maskSkin"))
         {
            return __maskSkin;
         }
         if(__maskSkin == param1)
         {
            return __maskSkin;
         }
         _previousClearStyle = clearStyle_maskSkin;
         __maskSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __maskSkin;
      }
      
      public function set maskSkin(param1:DisplayObject) : void
      {
         set_maskSkin(param1);
      }
      
      public function set_layout(param1:ILayout) : ILayout
      {
         if(!setStyle("layout"))
         {
            return __layout;
         }
         if(__layout == param1)
         {
            return __layout;
         }
         _previousClearStyle = clearStyle_layout;
         __layout = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __layout;
      }
      
      public function set layout(param1:ILayout) : void
      {
         set_layout(param1);
      }
      
      public function set_disabledBackgroundSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("disabledBackgroundSkin"))
         {
            return __disabledBackgroundSkin;
         }
         if(__disabledBackgroundSkin == param1)
         {
            return __disabledBackgroundSkin;
         }
         _previousClearStyle = clearStyle_disabledBackgroundSkin;
         __disabledBackgroundSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __disabledBackgroundSkin;
      }
      
      public function set disabledBackgroundSkin(param1:DisplayObject) : void
      {
         set_disabledBackgroundSkin(param1);
      }
      
      public function set_backgroundSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("backgroundSkin"))
         {
            return __backgroundSkin;
         }
         if(__backgroundSkin == param1)
         {
            return __backgroundSkin;
         }
         _previousClearStyle = clearStyle_backgroundSkin;
         __backgroundSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __backgroundSkin;
      }
      
      public function set backgroundSkin(param1:DisplayObject) : void
      {
         set_backgroundSkin(param1);
      }
      
      public function set_autoSizeMode(param1:AutoSizeMode) : AutoSizeMode
      {
         if(_autoSizeMode == param1)
         {
            return _autoSizeMode;
         }
         _autoSizeMode = param1;
         setInvalid(InvalidationFlag.SIZE);
         if(stage != null)
         {
            if(_autoSizeMode == AutoSizeMode.STAGE)
            {
               stage.addEventListener(Event.RESIZE,layoutGroup_stage_resizeHandler,false,0,true);
               addEventListener(Event.REMOVED_FROM_STAGE,layoutGroup_removedFromStageHandler);
            }
            else
            {
               stage.removeEventListener(Event.RESIZE,layoutGroup_stage_resizeHandler);
               removeEventListener(Event.REMOVED_FROM_STAGE,layoutGroup_removedFromStageHandler);
            }
         }
         return _autoSizeMode;
      }
      
      public function set autoSizeMode(param1:AutoSizeMode) : void
      {
         set_autoSizeMode(param1);
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:int = getChildIndex(param1);
         if(_loc3_ == param2)
         {
            return;
         }
         _setChildIndex(param1,getPrivateIndexForPublicIndex(param2));
         items.remove(param1);
         items.insert(param2,param1);
         setInvalid(InvalidationFlag.LAYOUT);
      }
      
      public function removeCurrentMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         if(param1.parent == this)
         {
            _removeChild(param1);
         }
         mask = null;
      }
      
      public function removeCurrentBackgroundSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(null);
         }
         _backgroundSkinMeasurements.restore(param1);
         if(param1.parent == this)
         {
            _removeChild(param1);
         }
      }
      
      override public function removeChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         if(param2 == 2147483647)
         {
            param2 = int(items.length) - 1;
            if(param2 < 0)
            {
               return;
            }
         }
         if(param1 > int(items.length) - 1)
         {
            return;
         }
         if(param2 < param1 || param1 < 0 || param2 > int(items.length))
         {
            throw new RangeError("The supplied index is out of bounds.");
         }
         var _loc3_:* = param2 - param1;
         while(_loc3_ >= 0)
         {
            removeChildAt(param1);
            _loc3_--;
         }
      }
      
      override public function removeChildAt(param1:int) : DisplayObject
      {
         if(param1 >= 0 && param1 < int(items.length))
         {
            return removeChild(items[param1]);
         }
         return null;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(param1 == null || param1.parent != this)
         {
            return param1;
         }
         items.remove(param1);
         var _loc2_:DisplayObject = _removeChild(param1);
         param1.removeEventListener(Event.RESIZE,layoutGroup_child_resizeHandler);
         if(param1 is ILayoutObject)
         {
            param1.removeEventListener("layoutDataChange",layoutGroup_child_layoutDataChangeHandler);
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _loc2_;
      }
      
      public function refreshViewPortBounds() : void
      {
         var _loc10_:* = null as Point;
         var _loc11_:* = null as Point;
         var _loc1_:* = get_explicitWidth() == null;
         var _loc2_:* = get_explicitHeight() == null;
         var _loc3_:* = get_explicitMinWidth() == null;
         var _loc4_:* = get_explicitMinHeight() == null;
         var _loc5_:* = get_explicitMaxWidth() == null;
         var _loc6_:* = get_explicitMaxHeight() == null;
         if(_currentBackgroundSkin != null)
         {
            MeasurementsUtil.resetFluidlyWithParent(_backgroundSkinMeasurements,_currentBackgroundSkin,this);
            if(_currentBackgroundSkin is IValidating)
            {
               _currentBackgroundSkin.validateNow();
            }
         }
         var _loc7_:Boolean = _autoSizeMode == AutoSizeMode.CONTENT || stage == null;
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
            _layoutMeasurements.width = get_explicitWidth();
         }
         if(_loc2_ && !_loc7_)
         {
            _layoutMeasurements.height = _loc9_;
         }
         else
         {
            _layoutMeasurements.height = get_explicitHeight();
         }
         var _loc12_:Object = get_explicitMinWidth();
         if(_loc3_)
         {
            _loc12_ = 0;
         }
         var _loc13_:Object = get_explicitMinHeight();
         if(_loc4_)
         {
            _loc13_ = 0;
         }
         var _loc14_:Object = get_explicitMaxWidth();
         if(_loc5_)
         {
            _loc14_ = 1 / 0;
         }
         var _loc15_:Object = get_explicitMaxHeight();
         if(_loc6_)
         {
            _loc15_ = 1 / 0;
         }
         if(_backgroundSkinMeasurements != null)
         {
            if(_backgroundSkinMeasurements.width != null)
            {
               if(_backgroundSkinMeasurements.width > _loc12_)
               {
                  _loc12_ = _backgroundSkinMeasurements.width;
               }
            }
            else if(_backgroundSkinMeasurements.minWidth != null)
            {
               if(_backgroundSkinMeasurements.minWidth > _loc12_)
               {
                  _loc12_ = _backgroundSkinMeasurements.minWidth;
               }
            }
            if(_backgroundSkinMeasurements.height != null)
            {
               if(_backgroundSkinMeasurements.height > _loc13_)
               {
                  _loc13_ = _backgroundSkinMeasurements.height;
               }
            }
            else if(_backgroundSkinMeasurements.minHeight != null)
            {
               if(_backgroundSkinMeasurements.minHeight > _loc13_)
               {
                  _loc13_ = _backgroundSkinMeasurements.minHeight;
               }
            }
         }
         _layoutMeasurements.minWidth = _loc12_;
         _layoutMeasurements.minHeight = _loc13_;
         _layoutMeasurements.maxWidth = _loc14_;
         _layoutMeasurements.maxHeight = _loc15_;
      }
      
      public function refreshMaskSkin() : void
      {
         var _loc1_:DisplayObject = _currentMaskSkin;
         _currentMaskSkin = getCurrentMaskSkin();
         if(_currentMaskSkin == _loc1_)
         {
            return;
         }
         removeCurrentMaskSkin(_loc1_);
         addCurrentMaskSkin(_currentMaskSkin);
      }
      
      public function refreshMaskLayout() : void
      {
         if(_currentMaskSkin == null)
         {
            return;
         }
         _currentMaskSkin.x = 0;
         _currentMaskSkin.y = 0;
         _currentMaskSkin.width = actualWidth;
         _currentMaskSkin.height = actualHeight;
         if(_currentMaskSkin is IValidating)
         {
            _currentMaskSkin.validateNow();
         }
      }
      
      public function refreshLayout() : void
      {
         var _loc1_:ILayout = get_layout();
         if(_currentLayout == _loc1_)
         {
            return;
         }
         if(_currentLayout != null)
         {
            _currentLayout.removeEventListener(Event.CHANGE,layoutGroup_layout_changeHandler);
         }
         _currentLayout = _loc1_;
         if(_currentLayout != null)
         {
            _currentLayout.addEventListener(Event.CHANGE,layoutGroup_layout_changeHandler);
         }
      }
      
      public function refreshDisabledOverlay() : void
      {
         var _loc1_:* = null as Graphics;
         var _loc2_:* = null as BitmapData;
         if(!_enabled)
         {
            if(_disabledOverlay == null)
            {
               _disabledOverlay = new Sprite();
               _loc1_ = _disabledOverlay.graphics;
               _loc2_ = null;
               FlashGraphics.bitmapFill[_loc1_] = _loc2_;
               _loc1_.beginFill(16711935,0);
               _disabledOverlay.graphics.drawRect(0,0,1,1);
               _loc1_ = _disabledOverlay.graphics;
               _loc2_ = null;
               FlashGraphics.bitmapFill[_loc1_] = _loc2_;
               _loc1_.endFill();
               _addChild(_disabledOverlay);
            }
            else
            {
               _setChildIndex(_disabledOverlay,get__numChildren() - 1);
            }
         }
         if(_disabledOverlay != null)
         {
            _disabledOverlay.visible = !_enabled;
            _disabledOverlay.x = 0;
            _disabledOverlay.y = 0;
            _disabledOverlay.width = actualWidth;
            _disabledOverlay.height = actualHeight;
         }
      }
      
      public function refreshBackgroundSkin() : void
      {
         var _loc1_:DisplayObject = _currentBackgroundSkin;
         _currentBackgroundSkin = getCurrentBackgroundSkin();
         if(_currentBackgroundSkin == _loc1_)
         {
            return;
         }
         removeCurrentBackgroundSkin(_loc1_);
         addCurrentBackgroundSkin(_currentBackgroundSkin);
      }
      
      public function refreshBackgroundLayout() : void
      {
         if(_currentBackgroundSkin == null)
         {
            return;
         }
         _currentBackgroundSkin.x = 0;
         _currentBackgroundSkin.y = 0;
         if(_currentBackgroundSkin.width != actualWidth)
         {
            _currentBackgroundSkin.width = actualWidth;
         }
         if(_currentBackgroundSkin.height != actualHeight)
         {
            _currentBackgroundSkin.height = actualHeight;
         }
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
      }
      
      public function layoutGroup_stage_resizeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.SIZE);
      }
      
      public function layoutGroup_removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,layoutGroup_removedFromStageHandler);
         stage.removeEventListener(Event.RESIZE,layoutGroup_stage_resizeHandler);
      }
      
      public function layoutGroup_layout_changeHandler(param1:Event) : void
      {
         if(_ignoreLayoutChanges)
         {
            return;
         }
         if(_ignoreChangesButSetFlags)
         {
            setInvalidationFlag(InvalidationFlag.LAYOUT);
            return;
         }
         setInvalid(InvalidationFlag.LAYOUT);
      }
      
      public function layoutGroup_child_resizeHandler(param1:Event) : void
      {
         if(_ignoreChildChanges)
         {
            return;
         }
         if(_ignoreChangesButSetFlags)
         {
            setInvalidationFlag(InvalidationFlag.LAYOUT);
            return;
         }
         setInvalid(InvalidationFlag.LAYOUT);
      }
      
      public function layoutGroup_child_layoutDataChangeHandler(param1:Event) : void
      {
         if(_ignoreChildChanges)
         {
            return;
         }
         if(_ignoreChangesButSetFlags)
         {
            setInvalidationFlag(InvalidationFlag.LAYOUT);
            return;
         }
         setInvalid(InvalidationFlag.LAYOUT);
      }
      
      public function layoutGroup_addedToStageHandler(param1:Event) : void
      {
         if(_autoSizeMode == AutoSizeMode.STAGE)
         {
            setInvalid(InvalidationFlag.SIZE);
            addEventListener(Event.REMOVED_FROM_STAGE,layoutGroup_removedFromStageHandler);
            stage.addEventListener(Event.RESIZE,layoutGroup_stage_resizeHandler,false,0,true);
         }
      }
      
      public function initializeLayoutGroupTheme() : void
      {
         SteelLayoutGroupStyles.initialize();
      }
      
      public function handleManualLayout() : void
      {
         var _loc6_:* = null as DisplayObject;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc1_:Object = _layoutMeasurements.width;
         if(_loc1_ == null)
         {
            _loc1_ = 0;
         }
         var _loc2_:Object = _layoutMeasurements.height;
         if(_loc2_ == null)
         {
            _loc2_ = 0;
         }
         var _loc3_:Boolean = _ignoreChildChanges;
         _ignoreChildChanges = true;
         var _loc4_:int = 0;
         var _loc5_:Array = items;
         while(_loc4_ < int(_loc5_.length))
         {
            _loc6_ = _loc5_[_loc4_];
            _loc4_++;
            if(!(_loc6_ is ILayoutObject && !_loc6_.get_includeInLayout()))
            {
               if(_loc6_ is IValidating)
               {
                  _loc6_.validateNow();
               }
               _loc7_ = _loc6_.x + _loc6_.width;
               _loc8_ = _loc6_.y + _loc6_.height;
               if(_loc1_ < _loc7_)
               {
                  _loc1_ = _loc7_;
               }
               if(_loc2_ < _loc8_)
               {
                  _loc2_ = _loc8_;
               }
            }
         }
         _ignoreChildChanges = _loc3_;
         _layoutResult.contentX = 0;
         _layoutResult.contentY = 0;
         _layoutResult.contentWidth = _loc1_;
         _layoutResult.contentHeight = _loc2_;
         if(_layoutMeasurements.width != null)
         {
            _layoutResult.viewPortWidth = _layoutMeasurements.width;
         }
         else
         {
            if(_layoutMeasurements.minWidth != null && _loc1_ < _layoutMeasurements.minWidth)
            {
               _loc1_ = _layoutMeasurements.minWidth;
            }
            else if(_layoutMeasurements.maxWidth != null && _loc1_ > _layoutMeasurements.maxWidth)
            {
               _loc1_ = _layoutMeasurements.maxWidth;
            }
            _layoutResult.viewPortWidth = _loc1_;
         }
         if(_layoutMeasurements.height != null)
         {
            _layoutResult.viewPortHeight = _layoutMeasurements.height;
         }
         else
         {
            if(_layoutMeasurements.minHeight != null && _loc2_ < _layoutMeasurements.minHeight)
            {
               _loc2_ = _layoutMeasurements.minHeight;
            }
            else if(_layoutMeasurements.maxHeight != null && _loc2_ > _layoutMeasurements.maxHeight)
            {
               _loc2_ = _layoutMeasurements.maxHeight;
            }
            _layoutResult.viewPortHeight = _loc2_;
         }
      }
      
      public function handleLayoutResult() : void
      {
         var _loc1_:Number = _layoutResult.viewPortWidth;
         var _loc2_:Number = _layoutResult.viewPortHeight;
         saveMeasurements(_loc1_,_loc2_,_loc1_,_loc2_);
      }
      
      public function handleCustomLayout() : void
      {
         var _loc1_:Boolean = _ignoreChildChanges;
         _ignoreChildChanges = true;
         _layoutResult.reset();
         _currentLayout.layout(items,_layoutMeasurements,_layoutResult);
         _ignoreChildChanges = _loc1_;
      }
      
      public function get_xmlContent() : Array
      {
         return _xmlContent;
      }
      
      public function get xmlContent() : Array
      {
         return get_xmlContent();
      }
      
      override public function get_styleContext() : Class
      {
         return LayoutGroup;
      }
      
      override public function get numChildren() : int
      {
         return int(items.length);
      }
      
      public function get_maskSkin() : DisplayObject
      {
         return __maskSkin;
      }
      
      public function get maskSkin() : DisplayObject
      {
         return get_maskSkin();
      }
      
      public function get_layout() : ILayout
      {
         return __layout;
      }
      
      public function get layout() : ILayout
      {
         return get_layout();
      }
      
      public function get_disabledBackgroundSkin() : DisplayObject
      {
         return __disabledBackgroundSkin;
      }
      
      public function get disabledBackgroundSkin() : DisplayObject
      {
         return get_disabledBackgroundSkin();
      }
      
      public function get_backgroundSkin() : DisplayObject
      {
         return __backgroundSkin;
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function get_autoSizeMode() : AutoSizeMode
      {
         return _autoSizeMode;
      }
      
      public function get autoSizeMode() : AutoSizeMode
      {
         return get_autoSizeMode();
      }
      
      public function get__numChildren() : int
      {
         return super.numChildren;
      }
      
      public function get _numChildren() : int
      {
         return get__numChildren();
      }
      
      public function getPrivateIndexForPublicIndex(param1:int) : int
      {
         if(int(items.length) > 0)
         {
            return param1 + _getChildIndex(items[0]);
         }
         if(get__numChildren() > 0)
         {
            return param1 + get__numChildren();
         }
         return param1;
      }
      
      public function getCurrentMaskSkin() : DisplayObject
      {
         return get_maskSkin();
      }
      
      public function getCurrentBackgroundSkin() : DisplayObject
      {
         if(!_enabled && get_disabledBackgroundSkin() != null)
         {
            return get_disabledBackgroundSkin();
         }
         return get_backgroundSkin();
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         return int(items.indexOf(param1));
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         var _loc4_:* = null as DisplayObject;
         var _loc2_:int = 0;
         var _loc3_:Array = items;
         while(_loc2_ < int(_loc3_.length))
         {
            _loc4_ = _loc3_[_loc2_];
            if((++_loc4_).name == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      override public function getChildAt(param1:int) : DisplayObject
      {
         return items[param1];
      }
      
      public function clearStyle_maskSkin() : DisplayObject
      {
         set_maskSkin(null);
         return get_maskSkin();
      }
      
      public function clearStyle_layout() : ILayout
      {
         set_layout(null);
         return get_layout();
      }
      
      public function clearStyle_disabledBackgroundSkin() : DisplayObject
      {
         set_disabledBackgroundSkin(null);
         return get_disabledBackgroundSkin();
      }
      
      public function clearStyle_backgroundSkin() : DisplayObject
      {
         set_backgroundSkin(null);
         return get_backgroundSkin();
      }
      
      public function addCurrentMaskSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         _addChild(param1);
         mask = param1;
      }
      
      public function addCurrentBackgroundSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            _backgroundSkinMeasurements = null;
            return;
         }
         if(param1 is IUIControl)
         {
            param1.initializeNow();
         }
         if(_backgroundSkinMeasurements == null)
         {
            _backgroundSkinMeasurements = new Measurements(param1);
         }
         else
         {
            _backgroundSkinMeasurements.save(param1);
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         _addChildAt(param1,0);
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:int = int(items.indexOf(param1));
         if(_loc3_ == param2)
         {
            return param1;
         }
         if(_loc3_ >= 0)
         {
            items.remove(param1);
         }
         var _loc4_:int = getPrivateIndexForPublicIndex(param2);
         items.insert(param2,param1);
         var _loc5_:DisplayObject = _addChildAt(param1,_loc4_);
         param1.addEventListener(Event.RESIZE,layoutGroup_child_resizeHandler);
         if(param1 is ILayoutObject)
         {
            param1.addEventListener("layoutDataChange",layoutGroup_child_layoutDataChangeHandler,false,0,true);
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _loc5_;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return addChildAt(param1,numChildren);
      }
      
      public function _setChildIndex(param1:DisplayObject, param2:int) : void
      {
         super.setChildIndex(param1,param2);
      }
      
      public function _removeChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         super.removeChildren(param1,param2);
      }
      
      public function _removeChildAt(param1:int) : DisplayObject
      {
         return super.removeChildAt(param1);
      }
      
      public function _removeChild(param1:DisplayObject) : DisplayObject
      {
         return super.removeChild(param1);
      }
      
      public function _getChildIndex(param1:DisplayObject) : int
      {
         return super.getChildIndex(param1);
      }
      
      public function _getChildByName(param1:String) : DisplayObject
      {
         return super.getChildByName(param1);
      }
      
      public function _getChildAt(param1:int) : DisplayObject
      {
         return super.getChildAt(param1);
      }
      
      public function _addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         return super.addChildAt(param1,param2);
      }
      
      public function _addChild(param1:DisplayObject) : DisplayObject
      {
         return super.addChildAt(param1,get__numChildren());
      }
   }
}

