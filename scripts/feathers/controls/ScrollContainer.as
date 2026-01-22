package feathers.controls
{
   import feathers.controls.supportClasses.BaseScrollContainer;
   import feathers.controls.supportClasses.IViewPort;
   import feathers.controls.supportClasses.LayoutViewPort;
   import feathers.core.IFocusContainer;
   import feathers.core.InvalidationFlag;
   import feathers.events.FeathersEvent;
   import feathers.layout.AutoSizeMode;
   import feathers.layout.ILayout;
   import feathers.layout.ILayoutObject;
   import feathers.layout.IScrollLayout;
   import feathers.themes.steel.components.SteelScrollContainerStyles;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class ScrollContainer extends BaseScrollContainer implements IFocusContainer
   {
      
      public static var __meta__:* = {"obj":{"defaultXmlProperty":["xmlContent"]}};
      
      public var layoutViewPort:LayoutViewPort;
      
      public var items:Array;
      
      public var _xmlContent:Array;
      
      public var _ignoreChildChanges:Boolean;
      
      public var _ignoreChangesButSetFlags:Boolean;
      
      public var _displayListBypassEnabled:Boolean;
      
      public var _childFocusEnabled:Boolean;
      
      public var _autoSizeMode:AutoSizeMode;
      
      public var __layout:ILayout;
      
      public function ScrollContainer()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __layout = null;
         _autoSizeMode = AutoSizeMode.CONTENT;
         _childFocusEnabled = true;
         _xmlContent = null;
         items = [];
         _displayListBypassEnabled = true;
         _ignoreChangesButSetFlags = false;
         _ignoreChildChanges = false;
         initializeScrollContainerTheme();
         super();
         if(get_viewPort() == null)
         {
            layoutViewPort = new LayoutViewPort();
            addRawChild(layoutViewPort);
            set_viewPort(layoutViewPort);
         }
         addEventListener(Event.ADDED_TO_STAGE,scrollContainer_addedToStageHandler);
      }
      
      override public function validateNow() : void
      {
         var _loc1_:Boolean = _ignoreChangesButSetFlags;
         _ignoreChangesButSetFlags = true;
         super.validateNow();
         _ignoreChangesButSetFlags = _loc1_;
      }
      
      override public function update() : void
      {
         _ignoreChangesButSetFlags = false;
         var _loc1_:Boolean = isInvalid(InvalidationFlag.LAYOUT);
         var _loc2_:Boolean = isInvalid(InvalidationFlag.STYLES);
         if(_loc1_ || _loc2_)
         {
            refreshLayout();
         }
         var _loc3_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc4_:Boolean = _ignoreChildChanges;
         _ignoreChildChanges = true;
         super.update();
         _ignoreChildChanges = _loc4_;
         _displayListBypassEnabled = _loc3_;
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
      
      public function set_childFocusEnabled(param1:Boolean) : Boolean
      {
         if(_childFocusEnabled == param1)
         {
            return _childFocusEnabled;
         }
         _childFocusEnabled = param1;
         return _childFocusEnabled;
      }
      
      public function set childFocusEnabled(param1:Boolean) : void
      {
         set_childFocusEnabled(param1);
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
               stage.addEventListener(Event.RESIZE,scrollContainer_stage_resizeHandler,false,0,true);
               addEventListener(Event.REMOVED_FROM_STAGE,scrollContainer_removedFromStageHandler);
            }
            else
            {
               stage.removeEventListener(Event.RESIZE,scrollContainer_stage_resizeHandler);
               removeEventListener(Event.REMOVED_FROM_STAGE,scrollContainer_removedFromStageHandler);
            }
         }
         return _autoSizeMode;
      }
      
      public function set autoSizeMode(param1:AutoSizeMode) : void
      {
         set_autoSizeMode(param1);
      }
      
      public function setRawChildIndex(param1:DisplayObject, param2:int) : void
      {
         var _loc3_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         setChildIndex(param1,param2);
         _displayListBypassEnabled = _loc3_;
      }
      
      override public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         if(!_displayListBypassEnabled)
         {
            super.setChildIndex(param1,param2);
            return;
         }
         items.remove(param1);
         items.insert(param2,param1);
      }
      
      public function scrollContainer_stage_resizeHandler(param1:Event) : void
      {
         setInvalid(InvalidationFlag.SIZE);
      }
      
      public function scrollContainer_removedFromStageHandler(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,scrollContainer_removedFromStageHandler);
         stage.removeEventListener(Event.RESIZE,scrollContainer_stage_resizeHandler);
      }
      
      public function scrollContainer_child_resizeHandler(param1:Event) : void
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
      
      public function scrollContainer_child_layoutDataChangeHandler(param1:FeathersEvent) : void
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
      
      public function scrollContainer_addedToStageHandler(param1:Event) : void
      {
         if(_autoSizeMode == AutoSizeMode.STAGE)
         {
            setInvalid(InvalidationFlag.SIZE);
            addEventListener(Event.REMOVED_FROM_STAGE,scrollContainer_removedFromStageHandler);
            stage.addEventListener(Event.RESIZE,scrollContainer_stage_resizeHandler,false,0,true);
         }
      }
      
      public function removeRawChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         var _loc3_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         removeChildren(param1,param2);
         _displayListBypassEnabled = _loc3_;
      }
      
      public function removeRawChildAt(param1:int) : DisplayObject
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:DisplayObject = removeChildAt(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      public function removeRawChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:DisplayObject = removeChild(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      override public function removeChildren(param1:int = 0, param2:int = 2147483647) : void
      {
         if(!_displayListBypassEnabled)
         {
            super.removeChildren(param1,param2);
            return;
         }
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
         if(!_displayListBypassEnabled)
         {
            return super.removeChildAt(param1);
         }
         return removeChild(layoutViewPort.getChildAt(param1));
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         if(!_displayListBypassEnabled)
         {
            return super.removeChild(param1);
         }
         if(param1 == null || param1.parent != layoutViewPort)
         {
            return param1;
         }
         items.remove(param1);
         var _loc2_:DisplayObject = layoutViewPort.removeChild(param1);
         param1.removeEventListener(Event.RESIZE,scrollContainer_child_resizeHandler);
         if(param1 is ILayoutObject)
         {
            param1.removeEventListener("layoutDataChange",scrollContainer_child_layoutDataChangeHandler);
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _loc2_;
      }
      
      override public function refreshViewPortBoundsForMeasurement() : void
      {
         var _loc1_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = true;
         super.refreshViewPortBoundsForMeasurement();
         _displayListBypassEnabled = _loc1_;
      }
      
      override public function refreshViewPortBoundsForLayout() : void
      {
         var _loc1_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = true;
         super.refreshViewPortBoundsForLayout();
         _displayListBypassEnabled = _loc1_;
      }
      
      override public function refreshScrollerValues() : void
      {
         var _loc1_:* = null as IScrollLayout;
         super.refreshScrollerValues();
         if(get_layout() is IScrollLayout)
         {
            _loc1_ = get_layout();
            scroller.forceElasticTop = _loc1_.get_elasticTop();
            scroller.forceElasticRight = _loc1_.get_elasticRight();
            scroller.forceElasticBottom = _loc1_.get_elasticBottom();
            scroller.forceElasticLeft = _loc1_.get_elasticLeft();
         }
         else
         {
            scroller.forceElasticTop = false;
            scroller.forceElasticRight = false;
            scroller.forceElasticBottom = false;
            scroller.forceElasticLeft = false;
         }
         scroller.snapPositionsX = layoutViewPort.get_snapPositionsX();
         scroller.snapPositionsY = layoutViewPort.get_snapPositionsY();
      }
      
      public function refreshLayout() : void
      {
         layoutViewPort.set_layout(get_layout());
      }
      
      override public function needsScrollMeasurement() : Boolean
      {
         return get_layout() is IScrollLayout;
      }
      
      override public function measure() : Boolean
      {
         var _loc7_:* = null as Point;
         var _loc8_:* = null as Point;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc1_:* = get_explicitWidth() == null;
         var _loc2_:* = get_explicitHeight() == null;
         var _loc3_:* = get_explicitMinWidth() == null;
         var _loc4_:* = get_explicitMinHeight() == null;
         var _loc5_:* = get_explicitMaxWidth() == null;
         var _loc6_:* = get_explicitMaxHeight() == null;
         if(!_loc1_ && !_loc2_ && !_loc3_ && !_loc4_ && !_loc5_ && !_loc6_)
         {
            return false;
         }
         if(_autoSizeMode == AutoSizeMode.STAGE && stage != null)
         {
            _loc7_ = globalToLocal(new Point());
            _loc8_ = globalToLocal(new Point(stage.stageWidth,stage.stageHeight));
            _loc9_ = _loc8_.x - _loc7_.x;
            _loc10_ = _loc8_.y - _loc7_.y;
            return saveMeasurements(_loc9_,_loc10_,_loc9_,_loc10_);
         }
         return super.measure();
      }
      
      public function initializeScrollContainerTheme() : void
      {
         SteelScrollContainerStyles.initialize();
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
         return ScrollContainer;
      }
      
      public function get_numRawChildren() : int
      {
         var _loc1_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc2_:int = numChildren;
         _displayListBypassEnabled = _loc1_;
         return _loc2_;
      }
      
      public function get numRawChildren() : int
      {
         return get_numRawChildren();
      }
      
      override public function get numChildren() : int
      {
         if(!_displayListBypassEnabled)
         {
            return super.numChildren;
         }
         return layoutViewPort.numChildren;
      }
      
      public function get_layout() : ILayout
      {
         return __layout;
      }
      
      public function get layout() : ILayout
      {
         return get_layout();
      }
      
      public function get_childFocusEnabled() : Boolean
      {
         if(_enabled)
         {
            return _childFocusEnabled;
         }
         return false;
      }
      
      public function get childFocusEnabled() : Boolean
      {
         return get_childFocusEnabled();
      }
      
      public function get_autoSizeMode() : AutoSizeMode
      {
         return _autoSizeMode;
      }
      
      public function get autoSizeMode() : AutoSizeMode
      {
         return get_autoSizeMode();
      }
      
      public function getRawChildIndex(param1:DisplayObject) : int
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:int = getChildIndex(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      public function getRawChildByName(param1:String) : DisplayObject
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:DisplayObject = getChildByName(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      public function getRawChildAt(param1:int) : DisplayObject
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:DisplayObject = getChildAt(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      override public function getChildIndex(param1:DisplayObject) : int
      {
         if(!_displayListBypassEnabled)
         {
            return super.getChildIndex(param1);
         }
         return int(items.indexOf(param1));
      }
      
      override public function getChildByName(param1:String) : DisplayObject
      {
         var _loc4_:* = null as DisplayObject;
         if(!_displayListBypassEnabled)
         {
            return super.getChildByName(param1);
         }
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
         if(!_displayListBypassEnabled)
         {
            return super.removeChildAt(param1);
         }
         return layoutViewPort.getChildAt(param1);
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = true;
         var _loc3_:Boolean = super.dispatchEvent(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      public function clearStyle_layout() : ILayout
      {
         set_layout(null);
         return get_layout();
      }
      
      public function addRawChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         var _loc3_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc4_:DisplayObject = addChildAt(param1,param2);
         _displayListBypassEnabled = _loc3_;
         return _loc4_;
      }
      
      public function addRawChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:Boolean = _displayListBypassEnabled;
         _displayListBypassEnabled = false;
         var _loc3_:DisplayObject = addChild(param1);
         _displayListBypassEnabled = _loc2_;
         return _loc3_;
      }
      
      override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         if(!_displayListBypassEnabled)
         {
            return super.addChildAt(param1,param2);
         }
         var _loc3_:int = int(items.indexOf(param1));
         if(_loc3_ == param2)
         {
            return param1;
         }
         if(_loc3_ >= 0)
         {
            items.remove(param1);
         }
         items.insert(param2,param1);
         var _loc4_:DisplayObject = layoutViewPort.addChildAt(param1,param2);
         param1.addEventListener(Event.RESIZE,scrollContainer_child_resizeHandler);
         if(param1 is ILayoutObject)
         {
            param1.addEventListener("layoutDataChange",scrollContainer_child_layoutDataChangeHandler,false,0,true);
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _loc4_;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         if(!_displayListBypassEnabled)
         {
            return super.addChild(param1);
         }
         return addChildAt(param1,layoutViewPort.numChildren);
      }
   }
}

