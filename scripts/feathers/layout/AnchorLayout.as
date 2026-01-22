package feathers.layout
{
   import feathers.core.IValidating;
   import flash.Boot;
   import flash.display.DisplayObject;
   import flash.errors.IllegalOperationError;
   import flash.events.EventDispatcher;
   
   public class AnchorLayout extends EventDispatcher implements ILayout
   {
      
      public function AnchorLayout()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      public function layout(param1:Array, param2:Measurements, param3:LayoutBoundsResult = undefined) : LayoutBoundsResult
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as DisplayObject;
         var _loc6_:* = null as ILayoutObject;
         var _loc7_:* = null as AnchorLayoutData;
         var _loc8_:* = null as Anchor;
         var _loc9_:* = null as Anchor;
         var _loc13_:int = 0;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as DisplayObject;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         _loc4_ = 0;
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
               _loc7_ = null;
               if(_loc6_ != null && _loc6_.get_layoutData() is AnchorLayoutData)
               {
                  _loc7_ = _loc6_.get_layoutData();
               }
               if(_loc7_ != null)
               {
                  if(param2.width != null)
                  {
                     _loc8_ = _loc7_.get_left();
                     _loc9_ = _loc7_.get_right();
                     if(_loc8_ != null && _loc9_ != null && _loc8_.get_relativeTo() == null && _loc9_.get_relativeTo() == null)
                     {
                        _loc5_.width = param2.width - _loc8_.get_value() - _loc9_.get_value();
                     }
                  }
                  if(param2.height != null)
                  {
                     _loc8_ = _loc7_.get_top();
                     _loc9_ = _loc7_.get_bottom();
                     if(_loc8_ != null && _loc9_ != null && _loc8_.get_relativeTo() == null && _loc9_.get_relativeTo() == null)
                     {
                        _loc5_.height = param2.height - _loc8_.get_value() - _loc9_.get_value();
                     }
                  }
               }
            }
            if(_loc5_ is IValidating)
            {
               _loc5_.validateNow();
            }
         }
         var _loc10_:Number = 0;
         var _loc11_:Number = 0;
         var _loc12_:Array = [];
         while(int(_loc12_.length) < int(param1.length))
         {
            _loc4_ = int(_loc12_.length);
            _loc13_ = 0;
            while(_loc13_ < int(param1.length))
            {
               _loc5_ = param1[_loc13_];
               if(int((++_loc12_).indexOf(_loc5_)) == -1)
               {
                  _loc6_ = null;
                  if(_loc5_ is ILayoutObject)
                  {
                     _loc6_ = _loc5_;
                     if(!_loc6_.get_includeInLayout())
                     {
                        _loc12_.push(_loc5_);
                        continue;
                     }
                  }
                  _loc7_ = null;
                  if(_loc6_ != null && _loc6_.get_layoutData() is AnchorLayoutData)
                  {
                     _loc7_ = _loc6_.get_layoutData();
                  }
                  if(_loc5_ is IValidating)
                  {
                     _loc5_.validateNow();
                  }
                  if(_loc7_ == null)
                  {
                     _loc14_ = _loc5_.x + _loc5_.width;
                     if(_loc10_ < _loc14_)
                     {
                        _loc10_ = _loc14_;
                     }
                     _loc15_ = _loc5_.y + _loc5_.height;
                     if(_loc11_ < _loc15_)
                     {
                        _loc11_ = _loc15_;
                     }
                  }
                  else
                  {
                     if(_loc7_.get_top() != null)
                     {
                        _loc8_ = _loc7_.get_top();
                        _loc14_ = _loc8_.get_value();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc5_.y = _loc14_;
                        if(_loc16_ != null)
                        {
                           _loc5_.y += _loc16_.y + _loc16_.height;
                        }
                     }
                     if(_loc7_.get_left() != null)
                     {
                        _loc8_ = _loc7_.get_left();
                        _loc14_ = _loc8_.get_value();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc5_.x = _loc14_;
                        if(_loc16_ != null)
                        {
                           _loc5_.x += _loc16_.x + _loc16_.width;
                        }
                     }
                     if(_loc7_.get_verticalCenter() == null)
                     {
                        _loc14_ = _loc5_.y + _loc5_.height;
                        if(_loc7_.get_bottom() != null)
                        {
                           _loc8_ = _loc7_.get_bottom();
                           _loc15_ = _loc8_.get_value();
                           if(_loc7_.get_top() != null)
                           {
                              _loc14_ += _loc15_;
                           }
                           else
                           {
                              _loc14_ = _loc5_.height + _loc15_;
                           }
                        }
                        if(_loc11_ < _loc14_)
                        {
                           _loc11_ = _loc14_;
                        }
                     }
                     else
                     {
                        _loc14_ = _loc5_.height;
                        if(_loc11_ < _loc14_)
                        {
                           _loc11_ = _loc14_;
                        }
                     }
                     if(_loc7_.get_horizontalCenter() == null)
                     {
                        _loc14_ = _loc5_.x + _loc5_.width;
                        if(_loc7_.get_right() != null)
                        {
                           _loc8_ = _loc7_.get_right();
                           _loc15_ = _loc8_.get_value();
                           if(_loc7_.get_left() != null)
                           {
                              _loc14_ += _loc15_;
                           }
                           else
                           {
                              _loc14_ = _loc5_.width + _loc15_;
                           }
                        }
                        if(_loc10_ < _loc14_)
                        {
                           _loc10_ = _loc14_;
                        }
                     }
                     else
                     {
                        _loc14_ = _loc5_.width;
                        if(_loc10_ < _loc14_)
                        {
                           _loc10_ = _loc14_;
                        }
                     }
                  }
                  _loc12_.push(_loc5_);
               }
            }
            if(_loc4_ == int(_loc12_.length))
            {
               throw new IllegalOperationError("AnchorLayout failed.");
            }
         }
         _loc14_ = 0;
         if(param2.width != null)
         {
            _loc14_ = Number(param2.width);
         }
         else
         {
            _loc14_ = _loc10_;
            if(param2.minWidth != null && _loc14_ < param2.minWidth)
            {
               _loc14_ = Number(param2.minWidth);
            }
            else if(param2.maxWidth != null && _loc14_ > param2.maxWidth)
            {
               _loc14_ = Number(param2.maxWidth);
            }
         }
         _loc15_ = 0;
         if(param2.height != null)
         {
            _loc15_ = Number(param2.height);
         }
         else
         {
            _loc15_ = _loc11_;
            if(param2.minHeight != null && _loc15_ < param2.minHeight)
            {
               _loc15_ = Number(param2.minHeight);
            }
            else if(param2.maxHeight != null && _loc15_ > param2.maxHeight)
            {
               _loc15_ = Number(param2.maxHeight);
            }
         }
         _loc12_.resize(0);
         while(int(_loc12_.length) < int(param1.length))
         {
            _loc4_ = int(_loc12_.length);
            _loc13_ = 0;
            while(_loc13_ < int(param1.length))
            {
               _loc5_ = param1[_loc13_];
               if(int((++_loc12_).indexOf(_loc5_)) == -1)
               {
                  _loc6_ = null;
                  if(_loc5_ is ILayoutObject)
                  {
                     _loc6_ = _loc5_;
                     if(!_loc6_.get_includeInLayout())
                     {
                        _loc12_.push(_loc5_);
                        continue;
                     }
                  }
                  _loc7_ = null;
                  if(_loc6_ != null && _loc6_.get_layoutData() is AnchorLayoutData)
                  {
                     _loc7_ = _loc6_.get_layoutData();
                  }
                  if(_loc7_ == null)
                  {
                     _loc12_.push(_loc5_);
                  }
                  else
                  {
                     if(_loc7_.get_top() != null)
                     {
                        _loc8_ = _loc7_.get_top();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc17_ = _loc8_.get_value();
                        if(_loc16_ != null)
                        {
                           _loc17_ += _loc16_.y + _loc16_.height;
                        }
                        _loc5_.y = _loc17_;
                     }
                     if(_loc7_.get_left() != null)
                     {
                        _loc8_ = _loc7_.get_left();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc17_ = _loc8_.get_value();
                        if(_loc16_ != null)
                        {
                           _loc17_ += _loc16_.x + _loc16_.width;
                        }
                        _loc5_.x = _loc17_;
                     }
                     if(_loc7_.get_bottom() != null)
                     {
                        _loc8_ = _loc7_.get_bottom();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc17_ = _loc8_.get_value();
                        _loc18_ = _loc15_;
                        if(_loc16_ != null)
                        {
                           _loc18_ = _loc16_.y;
                        }
                        if(_loc7_.get_top() == null)
                        {
                           _loc5_.y = _loc18_ - _loc17_ - _loc5_.height;
                        }
                        else
                        {
                           _loc19_ = _loc18_ - _loc17_ - _loc5_.y;
                           if(_loc19_ < 0)
                           {
                              _loc19_ = 0;
                           }
                           if(_loc5_.height != _loc19_)
                           {
                              _loc5_.height = _loc19_;
                           }
                        }
                     }
                     else if(_loc7_.get_verticalCenter() != null)
                     {
                        _loc5_.y = _loc7_.get_verticalCenter() + (_loc15_ - _loc5_.height) / 2;
                     }
                     if(_loc7_.get_right() != null)
                     {
                        _loc8_ = _loc7_.get_right();
                        _loc16_ = _loc8_.get_relativeTo();
                        if(_loc16_ != null && int(_loc12_.indexOf(_loc16_)) == -1)
                        {
                           continue;
                        }
                        _loc17_ = _loc8_.get_value();
                        _loc18_ = _loc14_;
                        if(_loc16_ != null)
                        {
                           _loc18_ = _loc16_.x;
                        }
                        if(_loc7_.get_left() == null)
                        {
                           _loc5_.x = _loc18_ - _loc17_ - _loc5_.width;
                        }
                        else
                        {
                           _loc19_ = _loc18_ - _loc17_ - _loc5_.x;
                           if(_loc19_ < 0)
                           {
                              _loc19_ = 0;
                           }
                           if(_loc5_.width != _loc19_)
                           {
                              _loc5_.width = _loc19_;
                           }
                        }
                     }
                     else if(_loc7_.get_horizontalCenter() != null)
                     {
                        _loc5_.x = _loc7_.get_horizontalCenter() + (_loc14_ - _loc5_.width) / 2;
                     }
                     _loc12_.push(_loc5_);
                  }
               }
            }
            if(_loc4_ == int(_loc12_.length))
            {
               throw new IllegalOperationError("AnchorLayout failed.");
            }
         }
         if(param3 == null)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentX = 0;
         param3.contentY = 0;
         param3.contentWidth = _loc14_;
         param3.contentHeight = _loc15_;
         param3.viewPortWidth = _loc14_;
         param3.viewPortHeight = _loc15_;
         return param3;
      }
   }
}

