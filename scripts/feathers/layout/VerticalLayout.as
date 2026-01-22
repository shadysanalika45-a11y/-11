package feathers.layout
{
   import feathers.core.IMeasureObject;
   import feathers.core.IValidating;
   import feathers.events.FeathersEvent;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class VerticalLayout extends EventDispatcher implements ILayout
   {
      
      public var _verticalAlign:VerticalAlign;
      
      public var _percentWidthResetEnabled:Boolean;
      
      public var _percentHeightResetEnabled:Boolean;
      
      public var _paddingTop:Number;
      
      public var _paddingRight:Number;
      
      public var _paddingLeft:Number;
      
      public var _paddingBottom:Number;
      
      public var _minGap:Number;
      
      public var _justifyResetEnabled:Boolean;
      
      public var _horizontalAlign:HorizontalAlign;
      
      public var _gap:Number;
      
      public function VerticalLayout()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         _percentHeightResetEnabled = false;
         _percentWidthResetEnabled = false;
         _justifyResetEnabled = false;
         _verticalAlign = VerticalAlign.TOP;
         _horizontalAlign = HorizontalAlign.LEFT;
         _minGap = 0;
         _gap = 0;
         _paddingLeft = 0;
         _paddingBottom = 0;
         _paddingRight = 0;
         _paddingTop = 0;
         super();
      }
      
      public function validateItems(param1:Array, param2:Measurements) : void
      {
         var _loc7_:* = null as DisplayObject;
         var _loc8_:* = null as Object;
         var _loc9_:* = null as Object;
         var _loc10_:* = null as ILayoutObject;
         var _loc11_:* = null as ILayoutData;
         var _loc12_:* = null as VerticalLayoutData;
         var _loc13_:Number = NaN;
         var _loc3_:* = _horizontalAlign == HorizontalAlign.JUSTIFY;
         var _loc4_:Object = param2.width;
         if(_loc4_ != null)
         {
            _loc4_ -= _paddingLeft + _paddingRight;
         }
         var _loc5_:Object = param2.height;
         if(_loc5_ != null)
         {
            _loc5_ -= _paddingTop + _paddingBottom;
         }
         var _loc6_:int = 0;
         while(_loc6_ < int(param1.length))
         {
            _loc7_ = param1[_loc6_];
            _loc6_++;
            _loc8_ = null;
            _loc9_ = null;
            if(_loc7_ is ILayoutObject)
            {
               _loc10_ = _loc7_;
               if(!_loc10_.get_includeInLayout())
               {
                  continue;
               }
               _loc11_ = _loc10_.get_layoutData();
               _loc12_ = (_loc11_) as VerticalLayoutData;
               if(_loc12_ != null)
               {
                  _loc8_ = _loc12_.get_percentWidth();
                  _loc9_ = _loc12_.get_percentHeight();
               }
            }
            if(_loc3_)
            {
               if(_loc4_ != null)
               {
                  _loc7_.width = _loc4_;
               }
               else if(_justifyResetEnabled && _loc7_ is IMeasureObject)
               {
                  _loc7_.resetWidth();
               }
            }
            else if(_loc4_ != null)
            {
               if(_loc8_ != null)
               {
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 0;
                  }
                  else if(_loc8_ > 100)
                  {
                     _loc8_ = 100;
                  }
                  _loc7_.width = _loc4_ * (_loc8_ / 100);
               }
            }
            else if(_loc8_ != null && _percentWidthResetEnabled && _loc7_ is IMeasureObject)
            {
               _loc7_.resetWidth();
            }
            if(_loc9_ != null && _percentHeightResetEnabled && _loc5_ == null && _loc7_ is IMeasureObject)
            {
               _loc7_.resetHeight();
            }
            if(_loc7_ is IValidating)
            {
               _loc7_.validateNow();
            }
            if(_loc3_ && _loc4_ == null && param2.maxWidth != null)
            {
               _loc13_ = param2.maxWidth - _paddingLeft - _paddingRight;
               if(_loc7_.width > _loc13_)
               {
                  _loc7_.width = _loc13_;
                  if(_loc7_ is IValidating)
                  {
                     _loc7_.validateNow();
                  }
               }
            }
         }
      }
      
      public function set_verticalAlign(param1:VerticalAlign) : VerticalAlign
      {
         if(_verticalAlign == param1)
         {
            return _verticalAlign;
         }
         _verticalAlign = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _verticalAlign;
      }
      
      public function set verticalAlign(param1:VerticalAlign) : void
      {
         set_verticalAlign(param1);
      }
      
      public function set_percentWidthResetEnabled(param1:Boolean) : Boolean
      {
         if(_percentWidthResetEnabled == param1)
         {
            return _percentWidthResetEnabled;
         }
         _percentWidthResetEnabled = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _percentWidthResetEnabled;
      }
      
      public function set percentWidthResetEnabled(param1:Boolean) : void
      {
         set_percentWidthResetEnabled(param1);
      }
      
      public function set_percentHeightResetEnabled(param1:Boolean) : Boolean
      {
         if(_percentHeightResetEnabled == param1)
         {
            return _percentHeightResetEnabled;
         }
         _percentHeightResetEnabled = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _percentHeightResetEnabled;
      }
      
      public function set percentHeightResetEnabled(param1:Boolean) : void
      {
         set_percentHeightResetEnabled(param1);
      }
      
      public function set_paddingTop(param1:Number) : Number
      {
         if(_paddingTop == param1)
         {
            return _paddingTop;
         }
         _paddingTop = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         set_paddingTop(param1);
      }
      
      public function set_paddingRight(param1:Number) : Number
      {
         if(_paddingRight == param1)
         {
            return _paddingRight;
         }
         _paddingRight = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         set_paddingRight(param1);
      }
      
      public function set_paddingLeft(param1:Number) : Number
      {
         if(_paddingLeft == param1)
         {
            return _paddingLeft;
         }
         _paddingLeft = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         set_paddingLeft(param1);
      }
      
      public function set_paddingBottom(param1:Number) : Number
      {
         if(_paddingBottom == param1)
         {
            return _paddingBottom;
         }
         _paddingBottom = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         set_paddingBottom(param1);
      }
      
      public function set_minGap(param1:Number) : Number
      {
         if(_minGap == param1)
         {
            return _minGap;
         }
         _minGap = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _minGap;
      }
      
      public function set minGap(param1:Number) : void
      {
         set_minGap(param1);
      }
      
      public function set_justifyResetEnabled(param1:Boolean) : Boolean
      {
         if(_justifyResetEnabled == param1)
         {
            return _justifyResetEnabled;
         }
         _justifyResetEnabled = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _justifyResetEnabled;
      }
      
      public function set justifyResetEnabled(param1:Boolean) : void
      {
         set_justifyResetEnabled(param1);
      }
      
      public function set_horizontalAlign(param1:HorizontalAlign) : HorizontalAlign
      {
         if(_horizontalAlign == param1)
         {
            return _horizontalAlign;
         }
         _horizontalAlign = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _horizontalAlign;
      }
      
      public function set horizontalAlign(param1:HorizontalAlign) : void
      {
         set_horizontalAlign(param1);
      }
      
      public function set_gap(param1:Number) : Number
      {
         if(_gap == param1)
         {
            return _gap;
         }
         _gap = param1;
         FeathersEvent.dispatch(this,Event.CHANGE);
         return _gap;
      }
      
      public function set gap(param1:Number) : void
      {
         set_gap(param1);
      }
      
      public function setPadding(param1:Number) : void
      {
         set_paddingTop(param1);
         set_paddingRight(param1);
         set_paddingBottom(param1);
         set_paddingLeft(param1);
      }
      
      public function layout(param1:Array, param2:Measurements, param3:LayoutBoundsResult = undefined) : LayoutBoundsResult
      {
         var _loc9_:int = 0;
         var _loc10_:* = null as DisplayObject;
         var _loc11_:* = null as Object;
         var _loc12_:* = null as Object;
         var _loc13_:* = null as ILayoutObject;
         var _loc14_:* = null as ILayoutData;
         var _loc15_:* = null as VerticalLayoutData;
         var _loc16_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc4_:Number = _gap;
         var _loc5_:* = _gap == 1 / 0;
         if(_loc5_)
         {
            _loc4_ = _minGap;
         }
         var _loc6_:* = _horizontalAlign == HorizontalAlign.JUSTIFY;
         var _loc7_:Object = param2.width;
         if(_loc7_ != null)
         {
            _loc7_ -= _paddingLeft + _paddingRight;
         }
         var _loc8_:Object = param2.height;
         if(_loc8_ != null)
         {
            _loc8_ -= _paddingTop + _paddingBottom;
         }
         _loc9_ = 0;
         while(_loc9_ < int(param1.length))
         {
            _loc10_ = param1[_loc9_];
            _loc9_++;
            _loc11_ = null;
            _loc12_ = null;
            if(_loc10_ is ILayoutObject)
            {
               _loc13_ = _loc10_;
               if(!_loc13_.get_includeInLayout())
               {
                  continue;
               }
               _loc14_ = _loc13_.get_layoutData();
               _loc15_ = (_loc14_) as VerticalLayoutData;
               if(_loc15_ != null)
               {
                  _loc11_ = _loc15_.get_percentWidth();
                  _loc12_ = _loc15_.get_percentHeight();
               }
            }
            if(_loc6_)
            {
               if(_loc7_ != null)
               {
                  _loc10_.width = _loc7_;
               }
               else if(_justifyResetEnabled && _loc10_ is IMeasureObject)
               {
                  _loc10_.resetWidth();
               }
            }
            else if(_loc7_ != null)
            {
               if(_loc11_ != null)
               {
                  if(_loc11_ < 0)
                  {
                     _loc11_ = 0;
                  }
                  else if(_loc11_ > 100)
                  {
                     _loc11_ = 100;
                  }
                  _loc10_.width = _loc7_ * (_loc11_ / 100);
               }
            }
            else if(_loc11_ != null && _percentWidthResetEnabled && _loc10_ is IMeasureObject)
            {
               _loc10_.resetWidth();
            }
            if(_loc12_ != null && _percentHeightResetEnabled && _loc8_ == null && _loc10_ is IMeasureObject)
            {
               _loc10_.resetHeight();
            }
            if(_loc10_ is IValidating)
            {
               _loc10_.validateNow();
            }
            if(_loc6_ && _loc7_ == null && param2.maxWidth != null)
            {
               _loc16_ = param2.maxWidth - _paddingLeft - _paddingRight;
               if(_loc10_.width > _loc16_)
               {
                  _loc10_.width = _loc16_;
                  if(_loc10_ is IValidating)
                  {
                     _loc10_.validateNow();
                  }
               }
            }
         }
         applyPercentHeight(param1,param2.height,param2.minHeight,param2.maxHeight,_loc4_);
         _loc16_ = 0;
         var _loc17_:Number = _paddingTop;
         _loc9_ = 0;
         while(_loc9_ < int(param1.length))
         {
            _loc10_ = param1[_loc9_];
            _loc9_++;
            _loc13_ = null;
            if(_loc10_ is ILayoutObject)
            {
               _loc13_ = _loc10_;
               if(!_loc13_.get_includeInLayout())
               {
                  continue;
               }
            }
            if(_loc10_ is IValidating)
            {
               _loc10_.validateNow();
            }
            if(_loc16_ < _loc10_.width)
            {
               _loc16_ = _loc10_.width;
            }
            _loc10_.y = _loc17_;
            _loc17_ += _loc10_.height + _loc4_;
         }
         var _loc18_:Number = _loc16_;
         _loc16_ += _paddingLeft + _paddingRight;
         _loc17_ += _paddingBottom;
         if(int(param1.length) > 0)
         {
            _loc17_ -= _loc4_;
         }
         var _loc19_:Number = _loc16_;
         if(param2.width != null)
         {
            _loc19_ = Number(param2.width);
         }
         else if(param2.minWidth != null && _loc19_ < param2.minWidth)
         {
            _loc19_ = Number(param2.minWidth);
         }
         else if(param2.maxWidth != null && _loc19_ > param2.maxWidth)
         {
            _loc19_ = Number(param2.maxWidth);
         }
         var _loc20_:Number = _loc17_;
         if(param2.height != null)
         {
            _loc20_ = Number(param2.height);
         }
         else if(param2.minHeight != null && _loc20_ < param2.minHeight)
         {
            _loc20_ = Number(param2.minHeight);
         }
         else if(param2.maxHeight != null && _loc20_ > param2.maxHeight)
         {
            _loc20_ = Number(param2.maxHeight);
         }
         applyPercentWidth(param1,_loc19_);
         _loc9_ = 0;
         while(_loc9_ < int(param1.length))
         {
            _loc10_ = param1[_loc9_];
            _loc9_++;
            _loc13_ = null;
            if(_loc10_ is ILayoutObject)
            {
               _loc13_ = _loc10_;
               if(!_loc13_.get_includeInLayout())
               {
                  continue;
               }
            }
            switch(_horizontalAlign.index)
            {
               case 0:
                  _loc10_.x = _paddingLeft;
                  break;
               case 1:
                  _loc10_.x = Math.max(_paddingLeft,_paddingLeft + (_loc19_ - _paddingLeft - _paddingRight - _loc10_.width) / 2);
                  break;
               case 2:
                  _loc10_.x = Math.max(_paddingLeft,_paddingLeft + (_loc19_ - _paddingLeft - _paddingRight) - _loc10_.width);
                  break;
               case 3:
                  _loc10_.x = _paddingLeft;
                  _loc10_.width = _loc19_ - _paddingLeft - _paddingRight;
            }
         }
         var _loc21_:Number = _loc17_ - _paddingTop - _paddingBottom;
         var _loc22_:Number = 0;
         var _loc23_:Number = 0;
         var _loc24_:Number = _loc20_ - _paddingTop - _paddingBottom;
         var _loc25_:Number = _gap;
         _loc6_ = _gap == 1 / 0;
         if(_loc6_)
         {
            _loc25_ = _minGap;
            if(int(param1.length) > 1 && _loc24_ > _loc21_)
            {
               _loc25_ += (_loc24_ - _loc21_) / (int(param1.length) - 1);
            }
            _loc23_ = _loc25_ - _minGap;
         }
         else
         {
            switch(_verticalAlign.index)
            {
               case 0:
                  _loc22_ = 0;
                  break;
               case 1:
                  _loc22_ = (_loc24_ - _loc21_) / 2;
                  break;
               case 2:
                  _loc22_ = _loc24_ - _loc21_;
                  break;
               default:
                  throw new ArgumentError("Unknown vertical align: " + Std.string(_verticalAlign));
            }
            if(_loc22_ < 0)
            {
               _loc22_ = 0;
            }
         }
         if(!(_loc22_ == 0 && _loc23_ == 0))
         {
            _loc26_ = _loc22_;
            _loc9_ = 0;
            while(_loc9_ < int(param1.length))
            {
               _loc10_ = param1[_loc9_];
               _loc9_++;
               _loc13_ = null;
               if(_loc10_ is ILayoutObject)
               {
                  _loc13_ = _loc10_;
                  if(!_loc13_.get_includeInLayout())
                  {
                     continue;
                  }
               }
               _loc10_.y = Math.max(_paddingTop,_loc10_.y + _loc26_);
               _loc26_ += _loc23_;
            }
         }
         if(_loc16_ < _loc19_)
         {
            _loc16_ = _loc19_;
         }
         if(_loc17_ < _loc20_)
         {
            _loc17_ = _loc20_;
         }
         if(param3 == null)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentX = 0;
         param3.contentY = 0;
         param3.contentWidth = _loc16_;
         param3.contentHeight = _loc17_;
         param3.viewPortWidth = _loc19_;
         param3.viewPortHeight = _loc20_;
         return param3;
      }
      
      public function get_verticalAlign() : VerticalAlign
      {
         return _verticalAlign;
      }
      
      public function get verticalAlign() : VerticalAlign
      {
         return get_verticalAlign();
      }
      
      public function get_percentWidthResetEnabled() : Boolean
      {
         return _percentWidthResetEnabled;
      }
      
      public function get percentWidthResetEnabled() : Boolean
      {
         return get_percentWidthResetEnabled();
      }
      
      public function get_percentHeightResetEnabled() : Boolean
      {
         return _percentHeightResetEnabled;
      }
      
      public function get percentHeightResetEnabled() : Boolean
      {
         return get_percentHeightResetEnabled();
      }
      
      public function get_paddingTop() : Number
      {
         return _paddingTop;
      }
      
      public function get paddingTop() : Number
      {
         return get_paddingTop();
      }
      
      public function get_paddingRight() : Number
      {
         return _paddingRight;
      }
      
      public function get paddingRight() : Number
      {
         return get_paddingRight();
      }
      
      public function get_paddingLeft() : Number
      {
         return _paddingLeft;
      }
      
      public function get paddingLeft() : Number
      {
         return get_paddingLeft();
      }
      
      public function get_paddingBottom() : Number
      {
         return _paddingBottom;
      }
      
      public function get paddingBottom() : Number
      {
         return get_paddingBottom();
      }
      
      public function get_minGap() : Number
      {
         return _minGap;
      }
      
      public function get minGap() : Number
      {
         return get_minGap();
      }
      
      public function get_justifyResetEnabled() : Boolean
      {
         return _justifyResetEnabled;
      }
      
      public function get justifyResetEnabled() : Boolean
      {
         return get_justifyResetEnabled();
      }
      
      public function get_horizontalAlign() : HorizontalAlign
      {
         return _horizontalAlign;
      }
      
      public function get horizontalAlign() : HorizontalAlign
      {
         return get_horizontalAlign();
      }
      
      public function get_gap() : Number
      {
         return _gap;
      }
      
      public function get gap() : Number
      {
         return get_gap();
      }
      
      public function applyVerticalAlign(param1:Array, param2:Number, param3:Number) : void
      {
         var _loc11_:* = null as DisplayObject;
         var _loc12_:* = null as ILayoutObject;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = param3 - _paddingTop - _paddingBottom;
         var _loc7_:Number = _gap;
         var _loc8_:* = _gap == 1 / 0;
         if(_loc8_)
         {
            _loc7_ = _minGap;
            if(int(param1.length) > 1 && _loc6_ > param2)
            {
               _loc7_ += (_loc6_ - param2) / (int(param1.length) - 1);
            }
            _loc5_ = _loc7_ - _minGap;
         }
         else
         {
            switch(_verticalAlign.index)
            {
               case 0:
                  _loc4_ = 0;
                  break;
               case 1:
                  _loc4_ = (_loc6_ - param2) / 2;
                  break;
               case 2:
                  _loc4_ = _loc6_ - param2;
                  break;
               default:
                  throw new ArgumentError("Unknown vertical align: " + Std.string(_verticalAlign));
            }
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
         }
         if(_loc4_ == 0 && _loc5_ == 0)
         {
            return;
         }
         var _loc9_:Number = _loc4_;
         var _loc10_:int = 0;
         while(_loc10_ < int(param1.length))
         {
            _loc11_ = param1[_loc10_];
            _loc10_++;
            _loc12_ = null;
            if(_loc11_ is ILayoutObject)
            {
               _loc12_ = _loc11_;
               if(!_loc12_.get_includeInLayout())
               {
                  continue;
               }
            }
            _loc11_.y = Math.max(_paddingTop,_loc11_.y + _loc9_);
            _loc9_ += _loc5_;
         }
      }
      
      public function applyPercentWidth(param1:Array, param2:Number) : void
      {
         var _loc5_:* = null as DisplayObject;
         var _loc6_:* = null as ILayoutObject;
         var _loc7_:* = null as ILayoutData;
         var _loc8_:* = null as VerticalLayoutData;
         var _loc9_:* = null as Object;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as IMeasureObject;
         var _loc12_:* = null as Object;
         var _loc13_:* = null as Object;
         var _loc3_:Number = param2 - _paddingLeft - _paddingRight;
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            if(++_loc5_ is ILayoutObject)
            {
               _loc6_ = _loc5_;
               if(_loc6_.get_includeInLayout())
               {
                  _loc7_ = _loc6_.get_layoutData();
                  _loc8_ = (_loc7_) as VerticalLayoutData;
                  if(_loc8_ != null)
                  {
                     _loc9_ = _loc8_.get_percentWidth();
                     if(_loc9_ != null)
                     {
                        if(_loc9_ < 0)
                        {
                           _loc9_ = 0;
                        }
                        else if(_loc9_ > 100)
                        {
                           _loc9_ = 100;
                        }
                        _loc10_ = _loc3_ * _loc9_ / 100;
                        if(_loc5_ is IMeasureObject)
                        {
                           _loc11_ = _loc5_;
                           _loc12_ = _loc11_.get_explicitMinWidth();
                           if(_loc12_ != null)
                           {
                              if(_loc12_ > _loc3_)
                              {
                                 _loc12_ = _loc3_;
                              }
                              if(_loc10_ < _loc12_)
                              {
                                 _loc10_ = Number(_loc12_);
                              }
                           }
                           _loc13_ = _loc11_.get_explicitMaxWidth();
                           if(_loc13_ != null && _loc10_ > _loc13_)
                           {
                              _loc10_ = Number(_loc13_);
                           }
                        }
                        _loc5_.width = _loc10_;
                     }
                  }
               }
            }
         }
      }
      
      public function applyPercentHeight(param1:Array, param2:Object, param3:Object, param4:Object, param5:Number) : void
      {
         var _loc10_:int = 0;
         var _loc11_:* = null as DisplayObject;
         var _loc12_:* = null as ILayoutObject;
         var _loc13_:* = null as ILayoutData;
         var _loc14_:* = null as VerticalLayoutData;
         var _loc15_:* = null as Object;
         var _loc16_:* = null as IMeasureObject;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:* = null as Object;
         var _loc6_:Array = [];
         var _loc7_:Number = 0;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc10_ = 0;
         while(_loc10_ < int(param1.length))
         {
            _loc11_ = param1[_loc10_];
            if(++_loc11_ is ILayoutObject)
            {
               _loc12_ = _loc11_;
               if(!_loc12_.get_includeInLayout())
               {
                  continue;
               }
               _loc13_ = _loc12_.get_layoutData();
               _loc14_ = (_loc13_) as VerticalLayoutData;
               if(_loc14_ != null)
               {
                  _loc15_ = _loc14_.get_percentHeight();
                  if(_loc15_ != null)
                  {
                     if(_loc15_ < 0)
                     {
                        _loc15_ = 0;
                     }
                     if(_loc12_ is IMeasureObject)
                     {
                        _loc16_ = _loc12_;
                        _loc8_ += _loc16_.get_minHeight();
                     }
                     _loc9_ += _loc15_;
                     _loc7_ += param5;
                     _loc6_.push(_loc12_);
                     continue;
                  }
               }
            }
            _loc7_ += _loc11_.height + param5;
         }
         _loc7_ -= param5;
         _loc7_ = _loc7_ + (_paddingTop + _paddingBottom);
         if(_loc9_ < 100)
         {
            _loc9_ = 100;
         }
         var _loc17_:Number = 0;
         if(param2 != null)
         {
            _loc17_ = Number(param2);
         }
         else
         {
            _loc17_ = _loc7_ + _loc8_;
            if(param3 != null && _loc17_ < param3)
            {
               _loc17_ = Number(param3);
            }
            else if(param4 != null && _loc17_ > param4)
            {
               _loc17_ = Number(param4);
            }
         }
         _loc17_ -= _loc7_;
         if(_loc17_ < 0)
         {
            _loc17_ = 0;
         }
         var _loc18_:Boolean = true;
         while(_loc18_)
         {
            _loc18_ = false;
            _loc19_ = _loc17_ / _loc9_;
            _loc10_ = 0;
            while(_loc10_ < int(_loc6_.length))
            {
               _loc12_ = _loc6_[_loc10_];
               _loc14_ = (++_loc12_).get_layoutData();
               _loc15_ = _loc14_.get_percentHeight();
               if(_loc15_ < 0)
               {
                  _loc15_ = 0;
               }
               _loc20_ = _loc19_ * _loc15_;
               if(_loc12_ is IMeasureObject)
               {
                  _loc16_ = _loc12_;
                  _loc21_ = _loc16_.get_explicitMinHeight();
                  if(_loc21_ != null && _loc21_ > _loc17_)
                  {
                     _loc21_ = _loc17_;
                  }
                  if(_loc20_ < _loc21_)
                  {
                     _loc20_ = Number(_loc21_);
                     _loc17_ -= _loc20_;
                     _loc9_ -= _loc15_;
                     _loc6_.remove(_loc12_);
                     _loc18_ = true;
                  }
               }
               _loc12_.height = _loc20_;
               if(_loc12_ is IValidating)
               {
                  _loc12_.validateNow();
               }
            }
         }
      }
      
      public function applyHorizontalAlign(param1:Array, param2:Number, param3:Number) : void
      {
         var _loc5_:* = null as DisplayObject;
         var _loc6_:* = null as ILayoutObject;
         var _loc4_:int = 0;
         while(_loc4_ < int(param1.length))
         {
            _loc5_ = param1[_loc4_];
            _loc4_++;
            _loc6_ = null;
            if(_loc5_ is ILayoutObject)
            {
               _loc6_ = _loc5_;
               if(!_loc6_.get_includeInLayout())
               {
                  continue;
               }
            }
            switch(_horizontalAlign.index)
            {
               case 0:
                  _loc5_.x = _paddingLeft;
                  break;
               case 1:
                  _loc5_.x = Math.max(_paddingLeft,_paddingLeft + (param3 - _paddingLeft - _paddingRight - _loc5_.width) / 2);
                  break;
               case 2:
                  _loc5_.x = Math.max(_paddingLeft,_paddingLeft + (param3 - _paddingLeft - _paddingRight) - _loc5_.width);
                  break;
               case 3:
                  _loc5_.x = _paddingLeft;
                  _loc5_.width = param3 - _paddingLeft - _paddingRight;
            }
         }
      }
   }
}

