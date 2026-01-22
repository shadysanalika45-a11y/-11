package feathers.controls
{
   import feathers.controls.supportClasses.LayoutViewPort;
   import feathers.core.IFocusExtras;
   import feathers.core.IMeasureObject;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.layout.Measurements;
   import feathers.themes.steel.components.SteelPanelStyles;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.Event;
   
   public class Panel extends ScrollContainer implements IFocusExtras
   {
      
      public var _ignoreHeaderResize:Boolean;
      
      public var _ignoreFooterResize:Boolean;
      
      public var _headerMeasurements:Measurements;
      
      public var _header:DisplayObject;
      
      public var _footerMeasurements:Measurements;
      
      public var _footer:DisplayObject;
      
      public var _focusExtrasBefore:Array;
      
      public var _focusExtrasAfter:Array;
      
      public function Panel()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _focusExtrasAfter = [];
         _focusExtrasBefore = [];
         _footer = null;
         _footerMeasurements = null;
         _ignoreFooterResize = false;
         _header = null;
         _headerMeasurements = null;
         _ignoreHeaderResize = false;
         initializePanelTheme();
         super();
      }
      
      override public function update() : void
      {
         _ignoreChangesButSetFlags = false;
         super.update();
         var _loc1_:Boolean = _ignoreHeaderResize;
         _ignoreHeaderResize = true;
         layoutHeader();
         _ignoreHeaderResize = _loc1_;
         var _loc2_:Boolean = _ignoreFooterResize;
         _ignoreFooterResize = true;
         layoutFooter();
         _ignoreFooterResize = _loc2_;
      }
      
      public function set_header(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = 0;
         if(_header == param1)
         {
            return _header;
         }
         if(_header != null)
         {
            _header.removeEventListener(Event.RESIZE,panel_header_resizeHandler);
            _focusExtrasBefore.remove(_header);
            removeRawChild(_header);
         }
         _header = param1;
         if(_header != null)
         {
            _focusExtrasBefore.push(_header);
            _loc2_ = layoutViewPort != null ? getRawChildIndex(layoutViewPort) + 1 : 0;
            addRawChildAt(_header,_loc2_);
            if(_header is IUIControl)
            {
               _header.initializeNow();
            }
            if(_headerMeasurements == null)
            {
               _headerMeasurements = new Measurements(_header);
            }
            else
            {
               _headerMeasurements.save(_header);
            }
            _header.addEventListener(Event.RESIZE,panel_header_resizeHandler,false,0,true);
         }
         else
         {
            _headerMeasurements = null;
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _header;
      }
      
      public function set header(param1:DisplayObject) : void
      {
         set_header(param1);
      }
      
      public function set_footer(param1:DisplayObject) : DisplayObject
      {
         if(_footer == param1)
         {
            return _footer;
         }
         if(_footer != null)
         {
            _header.removeEventListener(Event.RESIZE,panel_header_resizeHandler);
            _focusExtrasAfter.remove(_footer);
            removeRawChild(_footer);
         }
         _footer = param1;
         if(_footer != null)
         {
            _focusExtrasAfter.push(_footer);
            addRawChild(_footer);
            if(_footer is IUIControl)
            {
               _footer.initializeNow();
            }
            if(_footerMeasurements == null)
            {
               _footerMeasurements = new Measurements(_footer);
            }
            else
            {
               _footerMeasurements.save(_footer);
            }
            _footer.addEventListener(Event.RESIZE,panel_footer_resizeHandler,false,0,true);
         }
         else
         {
            _footerMeasurements = null;
         }
         setInvalid(InvalidationFlag.LAYOUT);
         return _footer;
      }
      
      public function set footer(param1:DisplayObject) : void
      {
         set_footer(param1);
      }
      
      public function panel_header_resizeHandler(param1:Event) : void
      {
         if(_ignoreHeaderResize)
         {
            return;
         }
         if(_headerMeasurements != null)
         {
            _headerMeasurements.save(_header);
         }
         setInvalid(InvalidationFlag.SIZE);
      }
      
      public function panel_footer_resizeHandler(param1:Event) : void
      {
         if(_ignoreFooterResize)
         {
            return;
         }
         if(_footerMeasurements != null)
         {
            _footerMeasurements.save(_footer);
         }
         setInvalid(InvalidationFlag.SIZE);
      }
      
      public function layoutHeader() : void
      {
         if(_header == null)
         {
            return;
         }
         _header.x = get_paddingLeft();
         _header.y = get_paddingTop();
         var _loc1_:Number = actualWidth - get_paddingLeft();
         var _loc2_:Number = get_paddingRight();
         _header.width = _loc1_ - _loc2_;
         if(_header is IValidating)
         {
            _header.validateNow();
         }
      }
      
      public function layoutFooter() : void
      {
         if(_footer == null)
         {
            return;
         }
         _footer.x = get_paddingLeft();
         var _loc1_:Number = actualWidth - get_paddingLeft();
         var _loc2_:Number = get_paddingRight();
         _footer.width = _loc1_ - _loc2_;
         if(_footer is IValidating)
         {
            _footer.validateNow();
         }
         var _loc3_:Number = actualHeight - _footer.height;
         var _loc4_:Number = get_paddingBottom();
         _footer.y = _loc3_ - _loc4_;
      }
      
      public function initializePanelTheme() : void
      {
         SteelPanelStyles.initialize();
      }
      
      override public function get_styleContext() : Class
      {
         return Panel;
      }
      
      public function get_header() : DisplayObject
      {
         return _header;
      }
      
      public function get header() : DisplayObject
      {
         return get_header();
      }
      
      public function get_footer() : DisplayObject
      {
         return _footer;
      }
      
      public function get footer() : DisplayObject
      {
         return get_footer();
      }
      
      public function get_focusExtrasBefore() : Array
      {
         return _focusExtrasBefore;
      }
      
      public function get focusExtrasBefore() : Array
      {
         return get_focusExtrasBefore();
      }
      
      public function get_focusExtrasAfter() : Array
      {
         return _focusExtrasAfter;
      }
      
      public function get focusExtrasAfter() : Array
      {
         return get_focusExtrasAfter();
      }
      
      override public function calculateViewPortOffsets(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:* = null as IMeasureObject;
         if(_header != null)
         {
            _loc3_ = _ignoreHeaderResize;
            _ignoreHeaderResize = true;
            if(_headerMeasurements != null)
            {
               _headerMeasurements.restore(_header);
            }
            if(_header is IValidating)
            {
               _header.validateNow();
            }
            topViewPortOffset += _header.height;
            chromeMeasuredWidth = Math.max(chromeMeasuredWidth,_header.width);
            if(_header is IMeasureObject)
            {
               _loc4_ = _header;
               chromeMeasuredMinWidth = Math.max(chromeMeasuredMinWidth,_loc4_.get_minWidth());
            }
            _ignoreHeaderResize = _loc3_;
         }
         if(_footer != null)
         {
            _loc3_ = _ignoreFooterResize;
            _ignoreFooterResize = true;
            if(_footerMeasurements != null)
            {
               _footerMeasurements.restore(_footer);
            }
            if(_footer is IValidating)
            {
               _footer.validateNow();
            }
            bottomViewPortOffset += _footer.height;
            chromeMeasuredWidth = Math.max(chromeMeasuredWidth,_footer.width);
            if(_footer is IMeasureObject)
            {
               _loc4_ = _footer;
               chromeMeasuredMinWidth = Math.max(chromeMeasuredMinWidth,_loc4_.get_minWidth());
            }
            _ignoreFooterResize = _loc3_;
         }
         super.calculateViewPortOffsets(param1,param2);
      }
   }
}

