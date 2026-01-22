package com.greensock.text
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.text.TextLineMetrics;
   
   public class SplitTextField extends Sprite
   {
      
      public static const version:Number = 0.64;
      
      public static const TYPE_CHARACTERS:String = "characters";
      
      public static const TYPE_WORDS:String = "words";
      
      public static const TYPE_LINES:String = "lines";
      
      private static const _propNames:Array = ["embedFonts","alpha","antiAliasType","blendMode","filters","focusRect","gridFitType","mouseEnabled","sharpness","selectable","textColor","thickness"];
      
      private var _splitType:String;
      
      private var _regOffsetX:Number;
      
      private var _regOffsetY:Number;
      
      private var _source:TextField;
      
      public var textFields:Array;
      
      public function SplitTextField(param1:TextField = null, param2:String = "characters", param3:Number = 0, param4:Number = 0)
      {
         super();
         this._source = param1;
         this._splitType = param2;
         this._regOffsetX = param3;
         this._regOffsetY = param4;
         this.mouseChildren = false;
         this.textFields = [];
         if(param1)
         {
            this.update();
         }
      }
      
      public static function split(param1:TextField, param2:String = "characters", param3:DisplayObjectContainer = null, param4:Point = null) : Array
      {
         var _loc6_:Array = null;
         var _loc12_:TextFormat = null;
         var _loc13_:TextField = null;
         var _loc14_:Number = NaN;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:int = 0;
         var _loc18_:uint = 0;
         var _loc19_:String = null;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:TextLineMetrics = null;
         var _loc23_:Number = NaN;
         if(param3 == null)
         {
            param3 = param1.parent;
         }
         if(param4 == null)
         {
            param4 = new Point(0,0);
         }
         var _loc5_:uint = param1.parent == param3 ? uint(param1.parent.getChildIndex(param1)) : uint(param3.numChildren);
         var _loc7_:uint = 0;
         param1.appendText("");
         var _loc8_:uint = uint(param1.numLines);
         var _loc9_:Rectangle = param1.getBounds(param1);
         var _loc10_:Number = _loc9_.y + param4.y;
         var _loc11_:Array = [];
         _loc15_ = 0;
         while(_loc15_ < _loc8_)
         {
            _loc19_ = param1.getLineText(_loc15_);
            _loc21_ = uint(param1.getLineOffset(_loc15_));
            _loc22_ = param1.getLineMetrics(_loc15_);
            if(param1.text.length > _loc21_)
            {
               _loc12_ = param1.getTextFormat(_loc21_,_loc21_ + 1);
               if(_loc12_.align == "left")
               {
                  _loc14_ = _loc9_.x + param4.x;
               }
               else if(_loc12_.align == "center")
               {
                  _loc14_ = _loc9_.x + param4.x - 2 + (param1.width - _loc22_.width) * 0.5;
               }
               else
               {
                  _loc14_ = _loc9_.x + param4.x - 4 + (param1.width - _loc22_.width);
               }
               if(param2 == TYPE_CHARACTERS)
               {
                  _loc6_ = _loc19_.split("");
               }
               else if(param2 == TYPE_WORDS)
               {
                  _loc6_ = _loc19_.split(" ").join("~#$ ~#$").split("~#$");
               }
               else
               {
                  _loc6_ = [_loc19_];
               }
               _loc20_ = _loc6_.length;
               _loc16_ = 0;
               while(_loc16_ < _loc20_)
               {
                  if(_loc6_[_loc16_].length != 0)
                  {
                     _loc13_ = new TextField();
                     _loc17_ = int(_propNames.length);
                     while(_loc17_--)
                     {
                        _loc13_[_propNames[_loc17_]] = param1[_propNames[_loc17_]];
                     }
                     _loc13_.autoSize = TextFieldAutoSize.LEFT;
                     _loc13_.selectable = _loc13_.multiline = _loc13_.wordWrap = false;
                     _loc13_.text = _loc6_[_loc16_];
                     _loc18_ = uint(_loc6_[_loc16_].length);
                     _loc17_ = 0;
                     while(_loc17_ < _loc18_)
                     {
                        _loc12_ = param1.getTextFormat(_loc21_,_loc21_ + 1);
                        _loc21_ += 1;
                        _loc12_.align = TextFormatAlign.LEFT;
                        _loc12_.leading = 0;
                        _loc13_.defaultTextFormat = _loc12_;
                        _loc13_.setTextFormat(_loc12_,_loc17_,_loc17_ + 1);
                        _loc17_++;
                     }
                     _loc13_.x = _loc14_;
                     _loc13_.y = _loc10_;
                     _loc23_ = _loc22_.ascent - _loc13_.getLineMetrics(0).ascent;
                     if(_loc23_)
                     {
                        _loc13_.y += _loc23_;
                     }
                     _loc14_ += _loc13_.textWidth;
                     if((_loc6_[_loc16_] != " " || _loc12_.underline) && _loc13_.textWidth != 0)
                     {
                        var _loc24_:*;
                        _loc11_[_loc24_ = _loc7_++] = _loc13_;
                     }
                  }
                  _loc16_++;
               }
               _loc10_ += _loc22_.height;
            }
            _loc15_++;
         }
         _loc16_ = _loc11_.length;
         while(--_loc16_ > -1)
         {
            param3.addChildAt(TextField(_loc11_[_loc16_]),_loc5_);
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         return _loc11_;
      }
      
      public function activate() : void
      {
         this.activated = true;
      }
      
      public function deactivate() : void
      {
         this.activated = false;
      }
      
      public function destroy() : void
      {
         this.activated = false;
         this.clear();
         this._source = null;
      }
      
      private function update() : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:Point = null;
         this.clear();
         if(this._source.parent)
         {
            _loc2_ = this._source.parent;
            _loc2_.addChildAt(this,_loc2_.getChildIndex(this._source));
            _loc2_.removeChild(this._source);
         }
         var _loc1_:Matrix = this._source.transform.matrix;
         if(this._regOffsetX != 0 || this._regOffsetY != 0)
         {
            _loc3_ = _loc1_.transformPoint(new Point(this._regOffsetX,this._regOffsetY));
            _loc1_.tx = _loc3_.x;
            _loc1_.ty = _loc3_.y;
         }
         this.transform.matrix = _loc1_;
         this.textFields = split(this._source,this._splitType,this,new Point(-this._regOffsetX,-this._regOffsetY));
      }
      
      private function clear() : void
      {
         var _loc1_:int = int(this.textFields.length);
         while(--_loc1_ > -1)
         {
            this.removeChild(this.textFields[_loc1_]);
         }
         this.textFields = [];
      }
      
      public function get source() : TextField
      {
         return this._source;
      }
      
      public function set source(param1:TextField) : void
      {
         this._source = param1;
         this.update();
      }
      
      public function get splitType() : String
      {
         return this._splitType;
      }
      
      public function set splitType(param1:String) : void
      {
         this._splitType = param1;
         this.update();
      }
      
      public function get regOffsetX() : Number
      {
         return this._regOffsetX;
      }
      
      public function set regOffsetX(param1:Number) : void
      {
         this._regOffsetX = param1;
         this.update();
      }
      
      public function get regOffsetY() : Number
      {
         return this._regOffsetY;
      }
      
      public function set regOffsetY(param1:Number) : void
      {
         this._regOffsetY = param1;
         this.update();
      }
      
      public function get activated() : Boolean
      {
         return Boolean(this.parent != null);
      }
      
      public function set activated(param1:Boolean) : void
      {
         if(this._source == null)
         {
            return;
         }
         if(Boolean(this._source.parent) && param1)
         {
            this._source.parent.addChildAt(this,this._source.parent.getChildIndex(this._source));
            this._source.parent.removeChild(this._source);
         }
         else if(Boolean(this.parent) && !param1)
         {
            this.parent.addChildAt(this._source,this.parent.getChildIndex(this));
            this.parent.removeChild(this);
         }
      }
   }
}

