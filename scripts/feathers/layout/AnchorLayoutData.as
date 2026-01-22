package feathers.layout
{
   import feathers.events.FeathersEvent;
   import feathers.layout._AnchorLayout.AbstractAnchor_Impl_;
   import flash.Boot;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class AnchorLayoutData extends EventDispatcher implements ILayoutData
   {
      
      public var _verticalCenter:Object;
      
      public var _top:Anchor;
      
      public var _right:Anchor;
      
      public var _left:Anchor;
      
      public var _horizontalCenter:Object;
      
      public var _bottom:Anchor;
      
      public function AnchorLayoutData(param1:Anchor = undefined, param2:Anchor = undefined, param3:Anchor = undefined, param4:Anchor = undefined, param5:Object = undefined, param6:Object = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _verticalCenter = null;
         _horizontalCenter = null;
         _left = null;
         _bottom = null;
         _right = null;
         _top = null;
         super();
         set_top(param1);
         set_right(param2);
         set_bottom(param3);
         set_left(param4);
         set_horizontalCenter(param5);
         set_verticalCenter(param6);
      }
      
      public static function center(param1:Object = undefined, param2:Object = undefined) : AnchorLayoutData
      {
         if(param1 == null)
         {
            param1 = 0;
         }
         if(param2 == null)
         {
            param2 = 0;
         }
         return new AnchorLayoutData(null,null,null,null,param1,param2);
      }
      
      public static function fill(param1:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(AbstractAnchor_Impl_.fromPixels(param1),AbstractAnchor_Impl_.fromPixels(param1),AbstractAnchor_Impl_.fromPixels(param1),AbstractAnchor_Impl_.fromPixels(param1));
      }
      
      public static function fillHorizontal(param1:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,AbstractAnchor_Impl_.fromPixels(param1),null,AbstractAnchor_Impl_.fromPixels(param1));
      }
      
      public static function fillVertical(param1:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(AbstractAnchor_Impl_.fromPixels(param1),null,AbstractAnchor_Impl_.fromPixels(param1),null);
      }
      
      public static function topLeft(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(AbstractAnchor_Impl_.fromPixels(param1),null,null,AbstractAnchor_Impl_.fromPixels(param2));
      }
      
      public static function topCenter(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(AbstractAnchor_Impl_.fromPixels(param1),null,null,null,param2);
      }
      
      public static function topRight(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(AbstractAnchor_Impl_.fromPixels(param1),AbstractAnchor_Impl_.fromPixels(param2));
      }
      
      public static function middleLeft(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,null,null,AbstractAnchor_Impl_.fromPixels(param2),null,param1);
      }
      
      public static function middleRight(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,AbstractAnchor_Impl_.fromPixels(param2),null,null,null,param1);
      }
      
      public static function bottomLeft(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,null,AbstractAnchor_Impl_.fromPixels(param1),AbstractAnchor_Impl_.fromPixels(param2));
      }
      
      public static function bottomCenter(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,null,AbstractAnchor_Impl_.fromPixels(param1),null,param2);
      }
      
      public static function bottomRight(param1:Number = 0, param2:Number = 0) : AnchorLayoutData
      {
         return new AnchorLayoutData(null,AbstractAnchor_Impl_.fromPixels(param2),AbstractAnchor_Impl_.fromPixels(param1));
      }
      
      public function set_verticalCenter(param1:Object) : Object
      {
         if(_verticalCenter == param1)
         {
            return _verticalCenter;
         }
         _verticalCenter = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _verticalCenter;
      }
      
      public function set verticalCenter(param1:Object) : void
      {
         set_verticalCenter(param1);
      }
      
      public function set_top(param1:Anchor) : Anchor
      {
         var _loc2_:* = null as Anchor;
         if(_top == param1)
         {
            return _top;
         }
         if(_top != null)
         {
            _loc2_ = _top;
            _loc2_.removeEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler);
         }
         _top = param1;
         if(_top != null)
         {
            _loc2_ = _top;
            _loc2_.addEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler,false,0,true);
         }
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _top;
      }
      
      public function set top(param1:Anchor) : void
      {
         set_top(param1);
      }
      
      public function set_right(param1:Anchor) : Anchor
      {
         var _loc2_:* = null as Anchor;
         if(_right == param1)
         {
            return _right;
         }
         if(_right != null)
         {
            _loc2_ = _right;
            _loc2_.removeEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler);
         }
         _right = param1;
         if(_right != null)
         {
            _loc2_ = _right;
            _loc2_.addEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler,false,0,true);
         }
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _right;
      }
      
      public function set right(param1:Anchor) : void
      {
         set_right(param1);
      }
      
      public function set_left(param1:Anchor) : Anchor
      {
         var _loc2_:* = null as Anchor;
         if(_left == param1)
         {
            return _left;
         }
         if(_left != null)
         {
            _loc2_ = _left;
            _loc2_.removeEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler);
         }
         _left = param1;
         if(_left != null)
         {
            _loc2_ = _left;
            _loc2_.addEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler,false,0,true);
         }
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _left;
      }
      
      public function set left(param1:Anchor) : void
      {
         set_left(param1);
      }
      
      public function set_horizontalCenter(param1:Object) : Object
      {
         if(_horizontalCenter == param1)
         {
            return _horizontalCenter;
         }
         _horizontalCenter = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _horizontalCenter;
      }
      
      public function set horizontalCenter(param1:Object) : void
      {
         set_horizontalCenter(param1);
      }
      
      public function set_bottom(param1:Anchor) : Anchor
      {
         var _loc2_:* = null as Anchor;
         if(_bottom == param1)
         {
            return _bottom;
         }
         if(_bottom != null)
         {
            _loc2_ = _bottom;
            _loc2_.removeEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler);
         }
         _bottom = param1;
         if(_bottom != null)
         {
            _loc2_ = _bottom;
            _loc2_.addEventListener(Event.CHANGE,anchorLayoutData_anchor_changeHandler,false,0,true);
         }
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _bottom;
      }
      
      public function set bottom(param1:Anchor) : void
      {
         set_bottom(param1);
      }
      
      public function get_verticalCenter() : Object
      {
         return _verticalCenter;
      }
      
      public function get verticalCenter() : Object
      {
         return get_verticalCenter();
      }
      
      public function get_top() : Anchor
      {
         return _top;
      }
      
      public function get top() : Anchor
      {
         return get_top();
      }
      
      public function get_right() : Anchor
      {
         return _right;
      }
      
      public function get right() : Anchor
      {
         return get_right();
      }
      
      public function get_left() : Anchor
      {
         return _left;
      }
      
      public function get left() : Anchor
      {
         return get_left();
      }
      
      public function get_horizontalCenter() : Object
      {
         return _horizontalCenter;
      }
      
      public function get horizontalCenter() : Object
      {
         return get_horizontalCenter();
      }
      
      public function get_bottom() : Anchor
      {
         return _bottom;
      }
      
      public function get bottom() : Anchor
      {
         return get_bottom();
      }
      
      public function anchorLayoutData_anchor_changeHandler(param1:Event) : void
      {
         FeathersEvent.dispatch(this,Event.CHANGE);
      }
   }
}

