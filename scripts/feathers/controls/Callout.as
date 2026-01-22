package feathers.controls
{
   import feathers.core.FeathersControl;
   import feathers.core.IMeasureObject;
   import feathers.core.IPopUpManager;
   import feathers.core.IUIControl;
   import feathers.core.IValidating;
   import feathers.core.InvalidationFlag;
   import feathers.core.PopUpManager;
   import feathers.events.FeathersEvent;
   import feathers.layout.HorizontalAlign;
   import feathers.layout.Measurements;
   import feathers.layout.RelativePosition;
   import feathers.layout.VerticalAlign;
   import feathers.skins.IProgrammaticSkin;
   import feathers.themes.steel.components.SteelCalloutStyles;
   import feathers.utils.MeasurementsUtil;
   import flash.Boot;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TouchEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import openfl.display._internal.FlashGraphics;
   
   public class Callout extends FeathersControl
   {
      
      public static var __meta__:* = {"obj":{"defaultXmlProperty":["content"]}};
      
      public static var INVALIDATION_FLAG_ORIGIN:InvalidationFlag = InvalidationFlag.CUSTOM("origin");
      
      public var supportedPositions:Array;
      
      public var closeOnPointerOutside:Boolean;
      
      public var _origin:DisplayObject;
      
      public var _lastPopUpOriginBounds:Rectangle;
      
      public var _ignoreContentResize:Boolean;
      
      public var _currentBackgroundSkin:DisplayObject;
      
      public var _currentArrowSkin:DisplayObject;
      
      public var _contentMeasurements:Measurements;
      
      public var _content:DisplayObject;
      
      public var _backgroundSkinMeasurements:Measurements;
      
      public var _arrowOffset:Number;
      
      public var __verticalAlign:VerticalAlign;
      
      public var __topArrowSkin:DisplayObject;
      
      public var __topArrowGap:Number;
      
      public var __rightArrowSkin:DisplayObject;
      
      public var __rightArrowGap:Number;
      
      public var __paddingTop:Number;
      
      public var __paddingRight:Number;
      
      public var __paddingLeft:Number;
      
      public var __paddingBottom:Number;
      
      public var __marginTop:Number;
      
      public var __marginRight:Number;
      
      public var __marginLeft:Number;
      
      public var __marginBottom:Number;
      
      public var __leftArrowSkin:DisplayObject;
      
      public var __leftArrowGap:Number;
      
      public var __horizontalAlign:HorizontalAlign;
      
      public var __gap:Number;
      
      public var __bottomArrowSkin:DisplayObject;
      
      public var __bottomArrowGap:Number;
      
      public var __backgroundSkin:DisplayObject;
      
      public var __arrowPosition:RelativePosition;
      
      public function Callout(param1:DisplayObject = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __leftArrowGap = 0;
         __bottomArrowGap = 0;
         __rightArrowGap = 0;
         __topArrowGap = 0;
         __leftArrowSkin = null;
         __bottomArrowSkin = null;
         __rightArrowSkin = null;
         __topArrowSkin = null;
         __backgroundSkin = null;
         __arrowPosition = RelativePosition.TOP;
         __verticalAlign = VerticalAlign.MIDDLE;
         __horizontalAlign = HorizontalAlign.CENTER;
         __paddingLeft = 0;
         __paddingBottom = 0;
         __paddingRight = 0;
         __paddingTop = 0;
         __marginLeft = 0;
         __marginBottom = 0;
         __marginRight = 0;
         __marginTop = 0;
         __gap = 0;
         closeOnPointerOutside = true;
         _ignoreContentResize = false;
         _arrowOffset = 0;
         initializeCalloutTheme();
         super();
         set_content(param1);
         addEventListener(Event.ADDED_TO_STAGE,callout_addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,callout_removedFromStageHandler);
      }
      
      public static function show(param1:DisplayObject, param2:DisplayObject, param3:Array = undefined, param4:Boolean = true, param5:Object = undefined) : Callout
      {
         var _loc6_:Callout = new Callout();
         _loc6_.set_content(param1);
         return Callout.showCallout(_loc6_,param2,param3,param4,param5);
      }
      
      public static function showCallout(param1:Callout, param2:DisplayObject, param3:Array = undefined, param4:Boolean = true, param5:Object = undefined) : Callout
      {
         param1.supportedPositions = param3;
         param1.set_origin(param2);
         var _loc6_:Object = param5;
         if(_loc6_ == null)
         {
            _loc6_ = function():DisplayObject
            {
               var _loc1_:Sprite = new Sprite();
               var _loc2_:Graphics = _loc1_.graphics;
               var _loc3_:BitmapData = null;
               FlashGraphics.bitmapFill[_loc2_] = _loc3_;
               _loc2_.beginFill(16711935,0);
               _loc1_.graphics.drawRect(0,0,1,1);
               _loc2_ = _loc1_.graphics;
               _loc3_ = null;
               FlashGraphics.bitmapFill[_loc2_] = _loc3_;
               _loc2_.endFill();
               return _loc1_;
            };
         }
         PopUpManager.addPopUp(param1,param2,param4,false,_loc6_);
         return param1;
      }
      
      public static function positionBelowOrigin(param1:Callout, param2:Rectangle) : void
      {
         param1.measureWithArrowPosition(RelativePosition.TOP);
         var _loc3_:DisplayObjectContainer = PopUpManager.forStage(param1.stage).get_root();
         var _loc4_:Point = new Point();
         _loc4_ = _loc3_.globalToLocal(_loc4_);
         var _loc5_:Point = new Point(param1.stage.stageWidth,param1.stage.stageHeight);
         _loc5_ = _loc3_.globalToLocal(_loc5_);
         var _loc6_:Number = param2.x;
         switch(param1.get_horizontalAlign().index)
         {
            case 1:
               _loc6_ += (param2.width - param1.width) / 2;
               break;
            case 2:
               _loc6_ += param2.width - param1.width;
         }
         var _loc7_:Number = _loc4_.x + param1.get_marginLeft();
         var _loc8_:Number = _loc5_.x - param1.width - param1.get_marginRight();
         var _loc9_:Number = _loc6_;
         if(_loc9_ < _loc7_)
         {
            _loc9_ = _loc7_;
         }
         else if(_loc9_ > _loc8_)
         {
            _loc9_ = _loc8_;
         }
         param1.x = _loc9_;
         param1.y = param2.y + param2.height + param1.get_gap();
         param1._arrowOffset = _loc6_ - _loc9_;
         param1.set_arrowPosition(RelativePosition.TOP);
      }
      
      public static function positionAboveOrigin(param1:Callout, param2:Rectangle) : void
      {
         param1.measureWithArrowPosition(RelativePosition.BOTTOM);
         var _loc3_:DisplayObjectContainer = PopUpManager.forStage(param1.stage).get_root();
         var _loc4_:Point = new Point();
         _loc4_ = _loc3_.globalToLocal(_loc4_);
         var _loc5_:Point = new Point(param1.stage.stageWidth,param1.stage.stageHeight);
         _loc5_ = _loc3_.globalToLocal(_loc5_);
         var _loc6_:Number = param2.x;
         switch(param1.get_horizontalAlign().index)
         {
            case 1:
               _loc6_ += (param2.width - param1.width) / 2;
               break;
            case 2:
               _loc6_ += param2.width - param1.width;
         }
         var _loc7_:Number = _loc4_.x + param1.get_marginLeft();
         var _loc8_:Number = _loc5_.x - param1.width - param1.get_marginRight();
         var _loc9_:Number = _loc6_;
         if(_loc9_ < _loc7_)
         {
            _loc9_ = _loc7_;
         }
         else if(_loc9_ > _loc8_)
         {
            _loc9_ = _loc8_;
         }
         param1.x = _loc9_;
         param1.y = param2.y - param1.height - param1.get_gap();
         param1._arrowOffset = _loc6_ - _loc9_;
         param1.set_arrowPosition(RelativePosition.BOTTOM);
      }
      
      public static function positionLeftOfOrigin(param1:Callout, param2:Rectangle) : void
      {
         param1.measureWithArrowPosition(RelativePosition.RIGHT);
         var _loc3_:DisplayObjectContainer = PopUpManager.forStage(param1.stage).get_root();
         var _loc4_:Point = new Point();
         _loc4_ = _loc3_.globalToLocal(_loc4_);
         var _loc5_:Point = new Point(param1.stage.stageWidth,param1.stage.stageHeight);
         _loc5_ = _loc3_.globalToLocal(_loc5_);
         var _loc6_:Number = param2.y;
         switch(param1.get_verticalAlign().index)
         {
            case 1:
               _loc6_ += (param2.height - param1.height) / 2;
               break;
            case 2:
               _loc6_ += param2.height - param1.height;
         }
         var _loc7_:Number = _loc4_.y + param1.get_marginTop();
         var _loc8_:Number = _loc5_.y - param1.height - param1.get_marginBottom();
         var _loc9_:Number = _loc6_;
         if(_loc9_ < _loc7_)
         {
            _loc9_ = _loc7_;
         }
         else if(_loc9_ > _loc8_)
         {
            _loc9_ = _loc8_;
         }
         param1.x = param2.x - param1.width - param1.get_gap();
         param1.y = _loc9_;
         param1._arrowOffset = _loc6_ - _loc9_;
         param1.set_arrowPosition(RelativePosition.RIGHT);
      }
      
      public static function positionRightOfOrigin(param1:Callout, param2:Rectangle) : void
      {
         param1.measureWithArrowPosition(RelativePosition.RIGHT);
         var _loc3_:DisplayObjectContainer = PopUpManager.forStage(param1.stage).get_root();
         var _loc4_:Point = new Point();
         _loc4_ = _loc3_.globalToLocal(_loc4_);
         var _loc5_:Point = new Point(param1.stage.stageWidth,param1.stage.stageHeight);
         _loc5_ = _loc3_.globalToLocal(_loc5_);
         var _loc6_:Number = param2.y;
         switch(param1.get_verticalAlign().index)
         {
            case 1:
               _loc6_ += (param2.height - param1.height) / 2;
               break;
            case 2:
               _loc6_ += param2.height - param1.height;
         }
         var _loc7_:Number = _loc4_.y + param1.get_marginTop();
         var _loc8_:Number = _loc5_.y - param1.height - param1.get_marginBottom();
         var _loc9_:Number = _loc6_;
         if(_loc9_ < _loc7_)
         {
            _loc9_ = _loc7_;
         }
         else if(_loc9_ > _loc8_)
         {
            _loc9_ = _loc8_;
         }
         param1.x = param2.x + param2.width + param1.get_gap();
         param1.y = _loc9_;
         param1._arrowOffset = _loc6_ - _loc9_;
         param1.set_arrowPosition(RelativePosition.LEFT);
      }
      
      override public function update() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationFlag.DATA);
         var _loc2_:Boolean = isInvalid(Callout.INVALIDATION_FLAG_ORIGIN);
         var _loc3_:Boolean = isInvalid(InvalidationFlag.SIZE);
         var _loc4_:Boolean = isInvalid(InvalidationFlag.STATE);
         var _loc5_:Boolean = isInvalid(InvalidationFlag.STYLES);
         if(_loc3_)
         {
            _lastPopUpOriginBounds = null;
            _loc2_ = true;
         }
         if(_loc5_ || _loc4_)
         {
            refreshBackgroundSkin();
         }
         if(_loc5_ || _loc4_)
         {
            refreshArrowSkin();
         }
         if(_loc2_)
         {
            positionRelativeToOrigin();
         }
         if(_loc4_ || _loc1_)
         {
            refreshEnabled();
         }
         if(measure())
         {
            _loc3_ = true;
         }
         layoutChildren();
      }
      
      public function set_verticalAlign(param1:VerticalAlign) : VerticalAlign
      {
         if(!setStyle("verticalAlign"))
         {
            return __verticalAlign;
         }
         if(__verticalAlign == param1)
         {
            return __verticalAlign;
         }
         _previousClearStyle = clearStyle_verticalAlign;
         __verticalAlign = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __verticalAlign;
      }
      
      public function set verticalAlign(param1:VerticalAlign) : void
      {
         set_verticalAlign(param1);
      }
      
      public function set_topArrowSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("topArrowSkin"))
         {
            return __topArrowSkin;
         }
         if(__topArrowSkin == param1)
         {
            return __topArrowSkin;
         }
         _previousClearStyle = clearStyle_topArrowSkin;
         __topArrowSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __topArrowSkin;
      }
      
      public function set topArrowSkin(param1:DisplayObject) : void
      {
         set_topArrowSkin(param1);
      }
      
      public function set_topArrowGap(param1:Number) : Number
      {
         if(!setStyle("topArrowGap"))
         {
            return __topArrowGap;
         }
         if(__topArrowGap == param1)
         {
            return __topArrowGap;
         }
         _previousClearStyle = clearStyle_topArrowGap;
         __topArrowGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __topArrowGap;
      }
      
      public function set topArrowGap(param1:Number) : void
      {
         set_topArrowGap(param1);
      }
      
      public function set_rightArrowSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("rightArrowSkin"))
         {
            return __rightArrowSkin;
         }
         if(__rightArrowSkin == param1)
         {
            return __rightArrowSkin;
         }
         _previousClearStyle = clearStyle_rightArrowSkin;
         __rightArrowSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __rightArrowSkin;
      }
      
      public function set rightArrowSkin(param1:DisplayObject) : void
      {
         set_rightArrowSkin(param1);
      }
      
      public function set_rightArrowGap(param1:Number) : Number
      {
         if(!setStyle("rightArrowGap"))
         {
            return __rightArrowGap;
         }
         if(__rightArrowGap == param1)
         {
            return __rightArrowGap;
         }
         _previousClearStyle = clearStyle_rightArrowGap;
         __rightArrowGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __rightArrowGap;
      }
      
      public function set rightArrowGap(param1:Number) : void
      {
         set_rightArrowGap(param1);
      }
      
      public function set_paddingTop(param1:Number) : Number
      {
         if(!setStyle("paddingTop"))
         {
            return __paddingTop;
         }
         if(__paddingTop == param1)
         {
            return __paddingTop;
         }
         _previousClearStyle = clearStyle_paddingTop;
         __paddingTop = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         set_paddingTop(param1);
      }
      
      public function set_paddingRight(param1:Number) : Number
      {
         if(!setStyle("paddingRight"))
         {
            return __paddingRight;
         }
         if(__paddingRight == param1)
         {
            return __paddingRight;
         }
         _previousClearStyle = clearStyle_paddingRight;
         __paddingRight = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         set_paddingRight(param1);
      }
      
      public function set_paddingLeft(param1:Number) : Number
      {
         if(!setStyle("paddingLeft"))
         {
            return __paddingLeft;
         }
         if(__paddingLeft == param1)
         {
            return __paddingLeft;
         }
         _previousClearStyle = clearStyle_paddingLeft;
         __paddingLeft = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         set_paddingLeft(param1);
      }
      
      public function set_paddingBottom(param1:Number) : Number
      {
         if(!setStyle("paddingBottom"))
         {
            return __paddingBottom;
         }
         if(__paddingBottom == param1)
         {
            return __paddingBottom;
         }
         _previousClearStyle = clearStyle_paddingBottom;
         __paddingBottom = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         set_paddingBottom(param1);
      }
      
      public function set_origin(param1:DisplayObject) : DisplayObject
      {
         if(_origin == param1)
         {
            return _origin;
         }
         if(param1 != null && param1.stage == null)
         {
            throw new ArgumentError("origin must be added to the stage.");
         }
         if(_origin != null)
         {
            _origin.removeEventListener(Event.REMOVED_FROM_STAGE,callout_origin_removedFromStageHandler);
            removeEventListener(Event.ENTER_FRAME,callout_enterFrameHandler);
         }
         _origin = param1;
         if(_origin != null)
         {
            _origin.addEventListener(Event.REMOVED_FROM_STAGE,callout_origin_removedFromStageHandler);
            if(stage != null)
            {
               addEventListener(Event.ENTER_FRAME,callout_enterFrameHandler);
            }
         }
         _lastPopUpOriginBounds = null;
         setInvalid(Callout.INVALIDATION_FLAG_ORIGIN);
         return _origin;
      }
      
      public function set origin(param1:DisplayObject) : void
      {
         set_origin(param1);
      }
      
      public function set_marginTop(param1:Number) : Number
      {
         if(!setStyle("marginTop"))
         {
            return __marginTop;
         }
         if(__marginTop == param1)
         {
            return __marginTop;
         }
         _previousClearStyle = clearStyle_marginTop;
         __marginTop = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __marginTop;
      }
      
      public function set marginTop(param1:Number) : void
      {
         set_marginTop(param1);
      }
      
      public function set_marginRight(param1:Number) : Number
      {
         if(!setStyle("marginRight"))
         {
            return __marginRight;
         }
         if(__marginRight == param1)
         {
            return __marginRight;
         }
         _previousClearStyle = clearStyle_marginRight;
         __marginRight = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __marginRight;
      }
      
      public function set marginRight(param1:Number) : void
      {
         set_marginRight(param1);
      }
      
      public function set_marginLeft(param1:Number) : Number
      {
         if(!setStyle("marginLeft"))
         {
            return __marginLeft;
         }
         if(__marginLeft == param1)
         {
            return __marginLeft;
         }
         _previousClearStyle = clearStyle_marginLeft;
         __marginLeft = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __marginLeft;
      }
      
      public function set marginLeft(param1:Number) : void
      {
         set_marginLeft(param1);
      }
      
      public function set_marginBottom(param1:Number) : Number
      {
         if(!setStyle("marginBottom"))
         {
            return __marginBottom;
         }
         if(__marginBottom == param1)
         {
            return __marginBottom;
         }
         _previousClearStyle = clearStyle_marginBottom;
         __marginBottom = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __marginBottom;
      }
      
      public function set marginBottom(param1:Number) : void
      {
         set_marginBottom(param1);
      }
      
      public function set_leftArrowSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("leftArrowSkin"))
         {
            return __leftArrowSkin;
         }
         if(__leftArrowSkin == param1)
         {
            return __leftArrowSkin;
         }
         _previousClearStyle = clearStyle_leftArrowSkin;
         __leftArrowSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __leftArrowSkin;
      }
      
      public function set leftArrowSkin(param1:DisplayObject) : void
      {
         set_leftArrowSkin(param1);
      }
      
      public function set_leftArrowGap(param1:Number) : Number
      {
         if(!setStyle("leftArrowGap"))
         {
            return __leftArrowGap;
         }
         if(__leftArrowGap == param1)
         {
            return __leftArrowGap;
         }
         _previousClearStyle = clearStyle_leftArrowGap;
         __leftArrowGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __leftArrowGap;
      }
      
      public function set leftArrowGap(param1:Number) : void
      {
         set_leftArrowGap(param1);
      }
      
      public function set_horizontalAlign(param1:HorizontalAlign) : HorizontalAlign
      {
         if(!setStyle("horizontalAlign"))
         {
            return __horizontalAlign;
         }
         if(__horizontalAlign == param1)
         {
            return __horizontalAlign;
         }
         _previousClearStyle = clearStyle_horizontalAlign;
         __horizontalAlign = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __horizontalAlign;
      }
      
      public function set horizontalAlign(param1:HorizontalAlign) : void
      {
         set_horizontalAlign(param1);
      }
      
      public function set_gap(param1:Number) : Number
      {
         if(!setStyle("gap"))
         {
            return __gap;
         }
         if(__gap == param1)
         {
            return __gap;
         }
         _previousClearStyle = clearStyle_gap;
         __gap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __gap;
      }
      
      public function set gap(param1:Number) : void
      {
         set_gap(param1);
      }
      
      public function set_content(param1:DisplayObject) : DisplayObject
      {
         if(_content == param1)
         {
            return _content;
         }
         if(_content != null)
         {
            _content.removeEventListener(Event.RESIZE,callout_content_resizeHandler);
            _contentMeasurements.restore(_content);
            if(_content.parent == this)
            {
               removeChild(_content);
            }
         }
         _content = param1;
         if(_content != null)
         {
            _content.addEventListener(Event.RESIZE,callout_content_resizeHandler,false,0,true);
            addChild(_content);
            if(_content is IUIControl)
            {
               _content.initializeNow();
            }
            if(_contentMeasurements == null)
            {
               _contentMeasurements = new Measurements(_content);
            }
            else
            {
               _contentMeasurements.save(_content);
            }
         }
         setInvalid(InvalidationFlag.DATA);
         setInvalid(InvalidationFlag.SIZE);
         return _content;
      }
      
      public function set content(param1:DisplayObject) : void
      {
         set_content(param1);
      }
      
      public function set_bottomArrowSkin(param1:DisplayObject) : DisplayObject
      {
         if(!setStyle("bottomArrowSkin"))
         {
            return __bottomArrowSkin;
         }
         if(__bottomArrowSkin == param1)
         {
            return __bottomArrowSkin;
         }
         _previousClearStyle = clearStyle_bottomArrowSkin;
         __bottomArrowSkin = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __bottomArrowSkin;
      }
      
      public function set bottomArrowSkin(param1:DisplayObject) : void
      {
         set_bottomArrowSkin(param1);
      }
      
      public function set_bottomArrowGap(param1:Number) : Number
      {
         if(!setStyle("bottomArrowGap"))
         {
            return __bottomArrowGap;
         }
         if(__bottomArrowGap == param1)
         {
            return __bottomArrowGap;
         }
         _previousClearStyle = clearStyle_bottomArrowGap;
         __bottomArrowGap = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __bottomArrowGap;
      }
      
      public function set bottomArrowGap(param1:Number) : void
      {
         set_bottomArrowGap(param1);
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
      
      public function set_arrowPosition(param1:RelativePosition) : RelativePosition
      {
         if(!setStyle("arrowPosition"))
         {
            return __arrowPosition;
         }
         if(__arrowPosition == param1)
         {
            return __arrowPosition;
         }
         _previousClearStyle = clearStyle_arrowPosition;
         __arrowPosition = param1;
         setInvalid(InvalidationFlag.STYLES);
         return __arrowPosition;
      }
      
      public function set arrowPosition(param1:RelativePosition) : void
      {
         set_arrowPosition(param1);
      }
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function removeCurrentBackgroundSkin(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1 is IProgrammaticSkin)
         {
            param1.set_uiContext(this);
         }
         _backgroundSkinMeasurements.restore(param1);
         if(param1.parent == this)
         {
            removeChild(param1);
         }
      }
      
      public function removeCurrentArrowSkin(param1:DisplayObject) : void
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
            removeChild(param1);
         }
      }
      
      public function refreshEnabled() : void
      {
         if(_content is IUIControl)
         {
            _content.set_enabled(_enabled);
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
      
      public function refreshArrowSkin() : void
      {
         var _loc1_:DisplayObject = _currentArrowSkin;
         _currentArrowSkin = getCurrentArrowSkin();
         if(_loc1_ == _currentArrowSkin)
         {
            return;
         }
         removeCurrentArrowSkin(_loc1_);
         if(_currentArrowSkin is IProgrammaticSkin)
         {
            _currentArrowSkin.set_uiContext(this);
         }
         addChild(_currentArrowSkin);
      }
      
      public function positionRelativeToOrigin() : void
      {
         var _loc9_:* = null as RelativePosition;
         checkForOriginMoved();
         var _loc1_:DisplayObjectContainer = PopUpManager.forStage(stage).get_root();
         var _loc2_:Point = new Point(stage.stageWidth,stage.stageHeight);
         _loc2_ = _loc1_.globalToLocal(_loc2_);
         var _loc3_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc4_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc5_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc6_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc7_:Array = supportedPositions;
         if(_loc7_ == null)
         {
            _loc7_ = [RelativePosition.BOTTOM,RelativePosition.TOP,RelativePosition.RIGHT,RelativePosition.LEFT];
         }
         var _loc8_:int = 0;
         loop0:
         while(true)
         {
            if(_loc8_ >= int(_loc7_.length))
            {
               if(_loc4_ != Number(Math.NEGATIVE_INFINITY) && _loc4_ >= _loc3_ && _loc4_ >= _loc5_ && _loc4_ >= _loc6_)
               {
                  Callout.positionBelowOrigin(this,_lastPopUpOriginBounds);
               }
               else if(_loc3_ != Number(Math.NEGATIVE_INFINITY) && _loc3_ >= _loc5_ && _loc3_ >= _loc6_)
               {
                  Callout.positionAboveOrigin(this,_lastPopUpOriginBounds);
               }
               else if(_loc5_ != Number(Math.NEGATIVE_INFINITY) && _loc5_ >= _loc6_)
               {
                  Callout.positionRightOfOrigin(this,_lastPopUpOriginBounds);
               }
               else if(_loc6_ != Number(Math.NEGATIVE_INFINITY))
               {
                  Callout.positionLeftOfOrigin(this,_lastPopUpOriginBounds);
               }
               else
               {
                  Callout.positionBelowOrigin(this,_lastPopUpOriginBounds);
               }
               return;
            }
            _loc9_ = _loc7_[_loc8_];
            switch((++_loc9_).index)
            {
               case 0:
                  measureWithArrowPosition(RelativePosition.BOTTOM);
                  _loc3_ = _lastPopUpOriginBounds.y - actualHeight;
                  if(_loc3_ >= get_marginTop())
                  {
                     Callout.positionAboveOrigin(this,_lastPopUpOriginBounds);
                     return;
                  }
                  if(_loc3_ < 0)
                  {
                     _loc3_ = 0;
                  }
                  break;
               case 1:
                  measureWithArrowPosition(RelativePosition.LEFT);
                  _loc5_ = _loc2_.x - actualWidth - (_lastPopUpOriginBounds.x + _lastPopUpOriginBounds.width);
                  if(_loc5_ >= get_marginRight())
                  {
                     Callout.positionRightOfOrigin(this,_lastPopUpOriginBounds);
                     return;
                  }
                  if(_loc5_ < 0)
                  {
                     _loc5_ = 0;
                  }
                  break;
               case 3:
                  measureWithArrowPosition(RelativePosition.RIGHT);
                  _loc6_ = _lastPopUpOriginBounds.x - actualWidth;
                  if(_loc6_ >= get_marginLeft())
                  {
                     Callout.positionLeftOfOrigin(this,_lastPopUpOriginBounds);
                     return;
                  }
                  if(_loc6_ < 0)
                  {
                     _loc6_ = 0;
                  }
                  break;
               default:
                  measureWithArrowPosition(RelativePosition.TOP);
                  _loc4_ = _loc2_.y - actualHeight - (_lastPopUpOriginBounds.y + _lastPopUpOriginBounds.height);
                  if(_loc4_ >= get_marginBottom())
                  {
                     break loop0;
                  }
                  if(_loc4_ < 0)
                  {
                     _loc4_ = 0;
                  }
            }
         }
         Callout.positionBelowOrigin(this,_lastPopUpOriginBounds);
      }
      
      public function measureWithArrowPosition(param1:RelativePosition) : Boolean
      {
         var _loc10_:* = null as Point;
         var _loc11_:* = null as Point;
         var _loc13_:Number = NaN;
         var _loc20_:Boolean = false;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc2_:* = get_explicitWidth() == null;
         var _loc3_:* = get_explicitHeight() == null;
         var _loc4_:* = get_explicitMinWidth() == null;
         var _loc5_:* = get_explicitMinHeight() == null;
         var _loc6_:* = get_explicitMaxWidth() == null;
         var _loc7_:* = get_explicitMaxHeight() == null;
         if(!_loc2_ && !_loc3_ && !_loc4_ && !_loc5_ && !_loc6_ && !_loc7_)
         {
            return false;
         }
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         if(stage != null)
         {
            _loc10_ = new Point();
            _loc10_ = globalToLocal(_loc10_);
            _loc11_ = new Point(stage.stageWidth,stage.stageHeight);
            _loc11_ = globalToLocal(_loc11_);
            _loc8_ = _loc11_.x - _loc10_.x;
            _loc9_ = _loc11_.y - _loc10_.y;
         }
         var _loc12_:Object = get_explicitMaxWidth();
         if(stage != null)
         {
            _loc13_ = _loc8_ - get_marginLeft() - get_marginRight();
            if(_loc12_ == null || _loc12_ < _loc13_)
            {
               _loc12_ = _loc13_;
            }
         }
         else
         {
            _loc12_ = 1 / 0;
         }
         var _loc14_:Object = get_explicitMaxHeight();
         if(stage != null)
         {
            _loc13_ = _loc9_ - get_marginTop() - get_marginBottom();
            if(_loc14_ == null || _loc14_ < _loc13_)
            {
               _loc14_ = _loc13_;
            }
         }
         else
         {
            _loc14_ = 1 / 0;
         }
         if(_currentBackgroundSkin != null)
         {
            MeasurementsUtil.resetFluidlyWithParentValues(_backgroundSkinMeasurements,_currentBackgroundSkin,get_explicitWidth(),get_explicitHeight(),get_explicitMinWidth(),get_explicitMinHeight(),_loc12_,_loc14_);
         }
         var _loc15_:IMeasureObject = null;
         if(_currentBackgroundSkin is IMeasureObject)
         {
            _loc15_ = _currentBackgroundSkin;
         }
         if(_currentBackgroundSkin is IValidating)
         {
            _currentBackgroundSkin.validateNow();
         }
         if(get_topArrowSkin() is IValidating)
         {
            get_topArrowSkin().validateNow();
         }
         if(get_rightArrowSkin() is IValidating)
         {
            get_rightArrowSkin().validateNow();
         }
         if(get_bottomArrowSkin() is IValidating)
         {
            get_bottomArrowSkin().validateNow();
         }
         if(get_leftArrowSkin() is IValidating)
         {
            get_leftArrowSkin().validateNow();
         }
         _loc13_ = 0;
         var _loc16_:Number = 0;
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         if(_currentArrowSkin != null)
         {
            switch(param1.index)
            {
               case 1:
                  _loc13_ = get_rightArrowSkin().width + get_rightArrowGap();
                  _loc16_ = get_rightArrowSkin().height;
                  break;
               case 2:
                  _loc17_ = get_bottomArrowSkin().width;
                  _loc18_ = get_bottomArrowSkin().height + get_bottomArrowGap();
                  break;
               case 3:
                  _loc13_ = get_leftArrowSkin().width + get_leftArrowGap();
                  _loc16_ = get_leftArrowSkin().height;
                  break;
               default:
                  _loc17_ = get_topArrowSkin().width;
                  _loc18_ = get_topArrowSkin().height + get_topArrowGap();
            }
         }
         var _loc19_:IMeasureObject = null;
         if(_content is IMeasureObject)
         {
            _loc19_ = _content;
         }
         if(_content != null)
         {
            _loc20_ = _ignoreContentResize;
            _ignoreContentResize = true;
            MeasurementsUtil.resetFluidlyWithParentValues(_contentMeasurements,_content,get_explicitWidth() != null ? get_explicitWidth() - _loc13_ - get_paddingLeft() - get_paddingRight() : null,get_explicitHeight() != null ? get_explicitHeight() - _loc18_ - get_paddingTop() - get_paddingBottom() : null,get_explicitMinWidth() != null ? get_explicitMinWidth() - _loc13_ - get_paddingLeft() - get_paddingRight() : null,get_explicitMinHeight() != null ? get_explicitMinHeight() - _loc18_ - get_paddingLeft() - get_paddingRight() : null,_loc12_ != null ? _loc12_ - _loc13_ - get_paddingLeft() - get_paddingRight() : null,_loc14_ != null ? _loc14_ - _loc18_ - get_paddingLeft() - get_paddingRight() : null);
            if(_content is IValidating)
            {
               _content.validateNow();
            }
            _ignoreContentResize = _loc20_;
         }
         var _loc21_:Object = get_explicitWidth();
         if(_loc2_)
         {
            _loc22_ = 0;
            if(_content != null)
            {
               _loc22_ = _content.width;
            }
            if(_loc22_ < _loc17_)
            {
               _loc22_ = _loc17_;
            }
            _loc21_ = _loc22_ + get_paddingLeft() + get_paddingRight();
            if(_currentBackgroundSkin != null)
            {
               _loc23_ = _currentBackgroundSkin.width;
               if(_loc21_ < _loc23_)
               {
                  _loc21_ = _loc23_;
               }
            }
            _loc21_ += _loc13_;
         }
         var _loc24_:Object = get_explicitHeight();
         if(_loc3_)
         {
            _loc22_ = 0;
            if(_content != null)
            {
               _loc22_ = _content.height;
            }
            if(_loc22_ < _loc16_)
            {
               _loc22_ = _loc16_;
            }
            _loc24_ = _loc22_ + get_paddingTop() + get_paddingBottom();
            if(_currentBackgroundSkin != null)
            {
               _loc23_ = _currentBackgroundSkin.height;
               if(_loc24_ < _loc23_)
               {
                  _loc24_ = _loc23_;
               }
            }
            _loc24_ += _loc18_;
         }
         var _loc25_:Object = get_explicitMinWidth();
         if(_loc4_)
         {
            _loc22_ = 0;
            if(_loc19_ != null)
            {
               _loc22_ = _loc19_.get_minWidth();
            }
            else if(_contentMeasurements != null)
            {
               _loc22_ = Number(_contentMeasurements.minWidth);
            }
            if(_loc22_ < _loc17_)
            {
               _loc22_ = _loc17_;
            }
            _loc25_ = _loc22_ + get_paddingLeft() + get_paddingRight();
            _loc23_ = 0;
            if(_loc15_ != null)
            {
               _loc23_ = _loc15_.get_minWidth();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc23_ = Number(_backgroundSkinMeasurements.minWidth);
            }
            if(_loc25_ < _loc23_)
            {
               _loc25_ = _loc23_;
            }
            _loc25_ += _loc13_;
            if(_loc25_ > _loc12_)
            {
               _loc25_ = _loc12_;
            }
         }
         var _loc26_:Object = get_explicitMinHeight();
         if(_loc5_)
         {
            _loc22_ = 0;
            if(_loc19_ != null)
            {
               _loc22_ = _loc19_.get_minWidth();
            }
            else if(_contentMeasurements != null)
            {
               _loc22_ = Number(_contentMeasurements.minHeight);
            }
            if(_loc22_ < _loc16_)
            {
               _loc22_ = _loc16_;
            }
            _loc26_ = _loc22_ + get_paddingTop() + get_paddingBottom();
            _loc23_ = 0;
            if(_loc15_ != null)
            {
               _loc23_ = _loc15_.get_minHeight();
            }
            else if(_backgroundSkinMeasurements != null)
            {
               _loc23_ = Number(_backgroundSkinMeasurements.minHeight);
            }
            if(_loc26_ < _loc23_)
            {
               _loc26_ = _loc23_;
            }
            _loc26_ += _loc18_;
            if(_loc26_ > _loc14_)
            {
               _loc26_ = _loc14_;
            }
         }
         var _loc27_:Object = _loc12_;
         var _loc28_:Object = _loc14_;
         return saveMeasurements(_loc21_,_loc24_,_loc25_,_loc26_,_loc27_,_loc28_);
      }
      
      public function measure() : Boolean
      {
         return measureWithArrowPosition(get_arrowPosition());
      }
      
      public function layoutChildren() : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         if(_currentArrowSkin is IValidating)
         {
            _currentArrowSkin.validateNow();
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(_currentArrowSkin != null)
         {
            switch(get_arrowPosition().index)
            {
               case 1:
                  _loc3_ = _currentArrowSkin.width + get_rightArrowGap();
                  break;
               case 2:
                  _loc4_ = _currentArrowSkin.height + get_bottomArrowGap();
                  break;
               case 3:
                  _loc1_ = _currentArrowSkin.width + get_leftArrowGap();
                  break;
               default:
                  _loc2_ = _currentArrowSkin.height + get_topArrowGap();
            }
         }
         var _loc5_:Number = actualWidth - _loc1_ - _loc3_;
         var _loc6_:Number = actualHeight - _loc2_ - _loc4_;
         if(_currentBackgroundSkin != null)
         {
            _currentBackgroundSkin.x = _loc1_;
            _currentBackgroundSkin.y = _loc2_;
            _currentBackgroundSkin.width = _loc5_;
            _currentBackgroundSkin.height = _loc6_;
         }
         if(_currentArrowSkin != null)
         {
            _loc7_ = _loc5_ - get_paddingLeft() - get_paddingRight();
            _loc8_ = _loc6_ - get_paddingTop() - get_paddingBottom();
            switch(get_arrowPosition().index)
            {
               case 1:
                  _loc9_ = get_rightArrowGap();
                  get_rightArrowSkin().x = _loc1_ + _loc5_ + _loc9_;
                  _loc10_ = _arrowOffset + _loc2_ + get_paddingTop();
                  if(get_verticalAlign() == VerticalAlign.MIDDLE)
                  {
                     _loc10_ += Math.round((_loc8_ - get_rightArrowSkin().height) / 2);
                  }
                  else if(get_verticalAlign() == VerticalAlign.BOTTOM)
                  {
                     _loc10_ += _loc8_ - get_rightArrowSkin().height;
                  }
                  _loc11_ = _loc2_ + get_paddingTop();
                  if(_loc11_ > _loc10_)
                  {
                     _loc10_ = _loc11_;
                  }
                  else
                  {
                     _loc12_ = _loc2_ + get_paddingTop() + _loc8_ - get_rightArrowSkin().height;
                     if(_loc12_ < _loc10_)
                     {
                        _loc10_ = _loc12_;
                     }
                  }
                  get_rightArrowSkin().y = _loc10_;
                  break;
               case 2:
                  _loc9_ = _arrowOffset + _loc1_ + get_paddingLeft();
                  if(get_horizontalAlign() == HorizontalAlign.CENTER)
                  {
                     _loc9_ += Math.round((_loc7_ - get_bottomArrowSkin().width) / 2);
                  }
                  else if(get_horizontalAlign() == HorizontalAlign.RIGHT)
                  {
                     _loc9_ += _loc7_ - get_bottomArrowSkin().width;
                  }
                  _loc10_ = _loc1_ + get_paddingLeft();
                  if(_loc10_ > _loc9_)
                  {
                     _loc9_ = _loc10_;
                  }
                  else
                  {
                     _loc11_ = _loc1_ + get_paddingLeft() + _loc7_ - get_bottomArrowSkin().width;
                     if(_loc11_ < _loc9_)
                     {
                        _loc9_ = _loc11_;
                     }
                  }
                  get_bottomArrowSkin().x = _loc9_;
                  _loc11_ = get_bottomArrowGap();
                  get_bottomArrowSkin().y = _loc2_ + _loc6_ + _loc11_;
                  break;
               case 3:
                  _loc9_ = _loc1_ - get_leftArrowSkin().width;
                  _loc10_ = get_leftArrowGap();
                  get_leftArrowSkin().x = _loc9_ - _loc10_;
                  _loc11_ = _arrowOffset + _loc2_ + get_paddingTop();
                  if(get_verticalAlign() == VerticalAlign.MIDDLE)
                  {
                     _loc11_ += Math.round((_loc8_ - get_leftArrowSkin().height) / 2);
                  }
                  else if(get_verticalAlign() == VerticalAlign.BOTTOM)
                  {
                     _loc11_ += _loc8_ - get_leftArrowSkin().height;
                  }
                  _loc12_ = _loc2_ + get_paddingTop();
                  if(_loc12_ > _loc11_)
                  {
                     _loc11_ = _loc12_;
                  }
                  else
                  {
                     _loc13_ = _loc2_ + get_paddingTop() + _loc8_ - get_leftArrowSkin().height;
                     if(_loc13_ < _loc11_)
                     {
                        _loc11_ = _loc13_;
                     }
                  }
                  get_leftArrowSkin().y = _loc11_;
                  break;
               default:
                  _loc9_ = _arrowOffset + _loc1_ + get_paddingLeft();
                  if(get_horizontalAlign() == HorizontalAlign.CENTER)
                  {
                     _loc9_ += Math.round((_loc7_ - get_topArrowSkin().width) / 2);
                  }
                  else if(get_horizontalAlign() == HorizontalAlign.RIGHT)
                  {
                     _loc9_ += _loc7_ - get_topArrowSkin().width;
                  }
                  _loc10_ = _loc1_ + get_paddingLeft();
                  if(_loc10_ > _loc9_)
                  {
                     _loc9_ = _loc10_;
                  }
                  else
                  {
                     _loc11_ = _loc1_ + get_paddingLeft() + _loc7_ - get_topArrowSkin().width;
                     if(_loc11_ < _loc9_)
                     {
                        _loc9_ = _loc11_;
                     }
                  }
                  get_topArrowSkin().x = _loc9_;
                  _loc11_ = _loc2_ - get_topArrowSkin().height;
                  _loc12_ = get_topArrowGap();
                  get_topArrowSkin().y = _loc11_ - _loc12_;
            }
         }
         if(_content != null)
         {
            _loc7_ = get_paddingLeft();
            _content.x = _loc1_ + _loc7_;
            _loc8_ = get_paddingTop();
            _content.y = _loc2_ + _loc8_;
            _loc14_ = _ignoreContentResize;
            _ignoreContentResize = true;
            _loc9_ = _loc5_ - get_paddingLeft();
            _loc10_ = get_paddingRight();
            _content.width = _loc9_ - _loc10_;
            _loc11_ = _loc6_ - get_paddingTop();
            _loc12_ = get_paddingBottom();
            _content.height = _loc11_ - _loc12_;
            if(_content is IValidating)
            {
               _content.validateNow();
            }
            _ignoreContentResize = _loc14_;
         }
      }
      
      public function initializeCalloutTheme() : void
      {
         SteelCalloutStyles.initialize();
      }
      
      public function get_verticalAlign() : VerticalAlign
      {
         return __verticalAlign;
      }
      
      public function get verticalAlign() : VerticalAlign
      {
         return get_verticalAlign();
      }
      
      public function get_topArrowSkin() : DisplayObject
      {
         return __topArrowSkin;
      }
      
      public function get topArrowSkin() : DisplayObject
      {
         return get_topArrowSkin();
      }
      
      public function get_topArrowGap() : Number
      {
         return __topArrowGap;
      }
      
      public function get topArrowGap() : Number
      {
         return get_topArrowGap();
      }
      
      override public function get_styleContext() : Class
      {
         return Callout;
      }
      
      public function get_rightArrowSkin() : DisplayObject
      {
         return __rightArrowSkin;
      }
      
      public function get rightArrowSkin() : DisplayObject
      {
         return get_rightArrowSkin();
      }
      
      public function get_rightArrowGap() : Number
      {
         return __rightArrowGap;
      }
      
      public function get rightArrowGap() : Number
      {
         return get_rightArrowGap();
      }
      
      public function get_paddingTop() : Number
      {
         return __paddingTop;
      }
      
      public function get paddingTop() : Number
      {
         return get_paddingTop();
      }
      
      public function get_paddingRight() : Number
      {
         return __paddingRight;
      }
      
      public function get paddingRight() : Number
      {
         return get_paddingRight();
      }
      
      public function get_paddingLeft() : Number
      {
         return __paddingLeft;
      }
      
      public function get paddingLeft() : Number
      {
         return get_paddingLeft();
      }
      
      public function get_paddingBottom() : Number
      {
         return __paddingBottom;
      }
      
      public function get paddingBottom() : Number
      {
         return get_paddingBottom();
      }
      
      public function get_origin() : DisplayObject
      {
         return _origin;
      }
      
      public function get origin() : DisplayObject
      {
         return get_origin();
      }
      
      public function get_marginTop() : Number
      {
         return __marginTop;
      }
      
      public function get marginTop() : Number
      {
         return get_marginTop();
      }
      
      public function get_marginRight() : Number
      {
         return __marginRight;
      }
      
      public function get marginRight() : Number
      {
         return get_marginRight();
      }
      
      public function get_marginLeft() : Number
      {
         return __marginLeft;
      }
      
      public function get marginLeft() : Number
      {
         return get_marginLeft();
      }
      
      public function get_marginBottom() : Number
      {
         return __marginBottom;
      }
      
      public function get marginBottom() : Number
      {
         return get_marginBottom();
      }
      
      public function get_leftArrowSkin() : DisplayObject
      {
         return __leftArrowSkin;
      }
      
      public function get leftArrowSkin() : DisplayObject
      {
         return get_leftArrowSkin();
      }
      
      public function get_leftArrowGap() : Number
      {
         return __leftArrowGap;
      }
      
      public function get leftArrowGap() : Number
      {
         return get_leftArrowGap();
      }
      
      public function get_horizontalAlign() : HorizontalAlign
      {
         return __horizontalAlign;
      }
      
      public function get horizontalAlign() : HorizontalAlign
      {
         return get_horizontalAlign();
      }
      
      public function get_gap() : Number
      {
         return __gap;
      }
      
      public function get gap() : Number
      {
         return get_gap();
      }
      
      public function get_content() : DisplayObject
      {
         return _content;
      }
      
      public function get content() : DisplayObject
      {
         return get_content();
      }
      
      public function get_bottomArrowSkin() : DisplayObject
      {
         return __bottomArrowSkin;
      }
      
      public function get bottomArrowSkin() : DisplayObject
      {
         return get_bottomArrowSkin();
      }
      
      public function get_bottomArrowGap() : Number
      {
         return __bottomArrowGap;
      }
      
      public function get bottomArrowGap() : Number
      {
         return get_bottomArrowGap();
      }
      
      public function get_backgroundSkin() : DisplayObject
      {
         return __backgroundSkin;
      }
      
      public function get backgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function get_arrowPosition() : RelativePosition
      {
         return __arrowPosition;
      }
      
      public function get arrowPosition() : RelativePosition
      {
         return get_arrowPosition();
      }
      
      public function getCurrentBackgroundSkin() : DisplayObject
      {
         return get_backgroundSkin();
      }
      
      public function getCurrentArrowSkin() : DisplayObject
      {
         switch(get_arrowPosition().index)
         {
            case 1:
               return get_rightArrowSkin();
            case 2:
               return get_bottomArrowSkin();
            case 3:
               return get_leftArrowSkin();
            default:
               return get_topArrowSkin();
         }
      }
      
      public function close() : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
      
      public function clearStyle_verticalAlign() : VerticalAlign
      {
         set_verticalAlign(VerticalAlign.MIDDLE);
         return get_verticalAlign();
      }
      
      public function clearStyle_topArrowSkin() : DisplayObject
      {
         set_topArrowSkin(null);
         return get_topArrowSkin();
      }
      
      public function clearStyle_topArrowGap() : Number
      {
         set_topArrowGap(0);
         return get_topArrowGap();
      }
      
      public function clearStyle_rightArrowSkin() : DisplayObject
      {
         set_rightArrowSkin(null);
         return get_rightArrowSkin();
      }
      
      public function clearStyle_rightArrowGap() : Number
      {
         set_rightArrowGap(0);
         return get_rightArrowGap();
      }
      
      public function clearStyle_paddingTop() : Number
      {
         set_paddingTop(0);
         return get_paddingTop();
      }
      
      public function clearStyle_paddingRight() : Number
      {
         set_paddingRight(0);
         return get_paddingRight();
      }
      
      public function clearStyle_paddingLeft() : Number
      {
         set_paddingLeft(0);
         return get_paddingLeft();
      }
      
      public function clearStyle_paddingBottom() : Number
      {
         set_paddingBottom(0);
         return get_paddingBottom();
      }
      
      public function clearStyle_marginTop() : Number
      {
         set_marginTop(0);
         return get_marginTop();
      }
      
      public function clearStyle_marginRight() : Number
      {
         set_marginRight(0);
         return get_marginRight();
      }
      
      public function clearStyle_marginLeft() : Number
      {
         set_marginLeft(0);
         return get_marginLeft();
      }
      
      public function clearStyle_marginBottom() : Number
      {
         set_marginBottom(0);
         return get_marginBottom();
      }
      
      public function clearStyle_leftArrowSkin() : DisplayObject
      {
         set_leftArrowSkin(null);
         return get_leftArrowSkin();
      }
      
      public function clearStyle_leftArrowGap() : Number
      {
         set_leftArrowGap(0);
         return get_leftArrowGap();
      }
      
      public function clearStyle_horizontalAlign() : HorizontalAlign
      {
         set_horizontalAlign(HorizontalAlign.CENTER);
         return get_horizontalAlign();
      }
      
      public function clearStyle_gap() : Number
      {
         set_gap(0);
         return get_gap();
      }
      
      public function clearStyle_bottomArrowSkin() : DisplayObject
      {
         set_bottomArrowSkin(null);
         return get_bottomArrowSkin();
      }
      
      public function clearStyle_bottomArrowGap() : Number
      {
         set_bottomArrowGap(0);
         return get_bottomArrowGap();
      }
      
      public function clearStyle_backgroundSkin() : DisplayObject
      {
         set_backgroundSkin(null);
         return get_backgroundSkin();
      }
      
      public function clearStyle_arrowPosition() : RelativePosition
      {
         set_arrowPosition(RelativePosition.TOP);
         return get_arrowPosition();
      }
      
      public function checkForOriginMoved() : Boolean
      {
         if(_origin == null)
         {
            return false;
         }
         var _loc1_:DisplayObjectContainer = PopUpManager.forStage(stage).get_root();
         var _loc2_:Rectangle = _origin.getBounds(_loc1_);
         var _loc3_:* = _lastPopUpOriginBounds != null;
         if(_loc3_ && _lastPopUpOriginBounds.equals(_loc2_))
         {
            return false;
         }
         _lastPopUpOriginBounds = _loc2_;
         return true;
      }
      
      public function callout_stage_touchBeginHandler(param1:TouchEvent) : void
      {
         if(param1.isPrimaryTouchPoint)
         {
            return;
         }
         if(!closeOnPointerOutside)
         {
            return;
         }
         if(hitTestPoint(param1.stageX,param1.stageY))
         {
            return;
         }
         close();
      }
      
      public function callout_stage_mouseDownHandler(param1:MouseEvent) : void
      {
         if(!closeOnPointerOutside)
         {
            return;
         }
         if(hitTestPoint(param1.stageX,param1.stageY))
         {
            return;
         }
         close();
      }
      
      public function callout_removedFromStageHandler(param1:Event) : void
      {
         stage.removeEventListener(MouseEvent.MOUSE_DOWN,callout_stage_mouseDownHandler);
         stage.removeEventListener(TouchEvent.TOUCH_BEGIN,callout_stage_touchBeginHandler);
         removeEventListener(Event.ENTER_FRAME,callout_enterFrameHandler);
         FeathersEvent.dispatch(this,Event.CLOSE);
      }
      
      public function callout_origin_removedFromStageHandler(param1:Event) : void
      {
         close();
      }
      
      public function callout_enterFrameHandler(param1:Event) : void
      {
         if(!checkForOriginMoved())
         {
            return;
         }
         setInvalid(Callout.INVALIDATION_FLAG_ORIGIN);
      }
      
      public function callout_content_resizeHandler(param1:Event) : void
      {
         if(_ignoreContentResize)
         {
            return;
         }
         _contentMeasurements.save(get_content());
         setInvalid(InvalidationFlag.SIZE);
      }
      
      public function callout_addedToStageHandler(param1:Event) : void
      {
         stage.addEventListener(MouseEvent.MOUSE_DOWN,callout_stage_mouseDownHandler,false,0,true);
         stage.addEventListener(TouchEvent.TOUCH_BEGIN,callout_stage_touchBeginHandler,false,0,true);
         if(_origin != null)
         {
            addEventListener(Event.ENTER_FRAME,callout_enterFrameHandler);
         }
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
         addChildAt(param1,0);
      }
   }
}

import feathers.core.InvalidationFlag;

