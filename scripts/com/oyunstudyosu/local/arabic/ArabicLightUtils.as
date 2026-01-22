package com.oyunstudyosu.local.arabic
{
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class ArabicLightUtils
   {
      
      private var chars:String;
      
      private var specialChars:String = "اأإآدذرزژوؤء";
      
      private var arabicPunctuation:String;
      
      private var isMAC:Boolean;
      
      public var data:String;
      
      public var wrapFactor:Number = 0.9;
      
      public var htmlLines:Array;
      
      public var embedFonts:Boolean = true;
      
      public var latinOnly:Boolean;
      
      public var hindiNumeralsOnly:Boolean = false;
      
      public var americanFormat:Boolean;
      
      public function ArabicLightUtils()
      {
         super();
         this.isMAC = false;
         var _loc1_:String = Capabilities.version;
         if(_loc1_.toLowerCase().indexOf("mac") != -1)
         {
            this.isMAC = true;
         }
         this.specialChars += String.fromCharCode(65276,65275,65272,65271,65274,65273,65270,65269);
         this.arabicPunctuation = String.fromCharCode(1545,1546,1563,1566,1567,1548,1549,1642,1643,1644,1645,1748);
      }
      
      public function parseArabic(param1:String, param2:Number, param3:TextFormat) : String
      {
         var _loc5_:TextField = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Array = null;
         var _loc22_:Object = null;
         var _loc23_:Array = null;
         var _loc24_:Array = null;
         var _loc25_:Array = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:TextLineMetrics = null;
         this.data = param1;
         if(!param3)
         {
            param3 = new TextFormat();
            param3.font = "Traditional Arabic";
            param3.size = 12;
            param3.align = "right";
            param3.rightMargin = 4;
         }
         this.htmlLines = [];
         var _loc4_:String = "";
         if(param1.length > 0)
         {
            this.chars = param1;
            this.chars = this.chars.split("\r\n").join("\n");
            this.chars = this.chars.split("\r").join("\n");
            this.chars = this.chars.split("\n").join("<br>");
            this.splitBulletList();
            this.chars = this.chars.split("<").join("&lt;");
            this.chars = this.chars.split(">").join("&gt;");
            if(this.hindiNumeralsOnly)
            {
               this.chars = this.convertNumbers();
            }
            this.chars = this.cleanString();
            _loc5_ = new TextField();
            _loc5_.x = -1000;
            _loc5_.y = -1000;
            _loc5_.width = 10;
            _loc5_.height = Number(param3.size) + 4;
            _loc5_.autoSize = TextFieldAutoSize.LEFT;
            _loc5_.embedFonts = true;
            _loc5_.selectable = false;
            _loc5_.text = "";
            _loc7_ = "";
            _loc9_ = "";
            _loc10_ = "";
            _loc11_ = "";
            _loc12_ = [];
            _loc14_ = false;
            _loc15_ = false;
            _loc16_ = false;
            _loc17_ = false;
            _loc18_ = false;
            _loc19_ = false;
            _loc20_ = false;
            _loc21_ = [];
            _loc23_ = [];
            _loc28_ = 0;
            _loc29_ = 0;
            while(_loc28_ < this.chars.length)
            {
               _loc13_ = Number(this.chars.charCodeAt(_loc28_));
               _loc17_ = this.chars.charAt(_loc28_) == "&" && this.chars.charAt(_loc28_ + 1) == "l" && this.chars.charAt(_loc28_ + 2) == "t" && this.chars.charAt(_loc28_ + 3) == ";" && this.chars.charAt(_loc28_ + 4) != " ";
               if(_loc17_)
               {
                  _loc14_ = true;
               }
               _loc20_ = this.validateArabicChar(_loc28_) && !_loc14_ || this.validateSymbol(_loc28_) && !_loc14_;
               if(_loc20_)
               {
                  _loc15_ = true;
               }
               else
               {
                  _loc15_ = false;
               }
               if(_loc15_)
               {
                  if(this.validateSymbol(_loc28_) && !this.validateNextArabicChar(_loc28_) && _loc11_ != "")
                  {
                     _loc15_ = false;
                  }
               }
               if(_loc14_)
               {
                  if(_loc9_ != "")
                  {
                     _loc12_.push({
                        "arabic":true,
                        "html":false,
                        "value":_loc9_
                     });
                     _loc9_ = "";
                  }
                  if(_loc11_ != "")
                  {
                     _loc12_.push({
                        "arabic":false,
                        "html":false,
                        "value":_loc11_
                     });
                     _loc11_ = "";
                  }
                  _loc10_ += this.chars.charAt(_loc28_);
               }
               else if(_loc15_)
               {
                  if(_loc11_ != "")
                  {
                     _loc12_.push({
                        "arabic":false,
                        "html":false,
                        "value":_loc11_
                     });
                     _loc11_ = "";
                  }
                  if(_loc10_ != "")
                  {
                     _loc10_ = _loc10_.toLowerCase();
                     if(_loc10_.indexOf("&lt;br /&gt;") != -1)
                     {
                        _loc21_ = _loc10_.split("&lt;br /&gt;");
                        _loc10_ = _loc21_.join("&lt;br&gt;");
                     }
                     if(_loc10_.indexOf("&lt;br&gt;") != -1)
                     {
                        _loc21_ = _loc10_.split("&lt;br&gt;");
                        _loc10_ = _loc21_.join("");
                     }
                     _loc12_.push({
                        "arabic":false,
                        "html":true,
                        "value":_loc10_
                     });
                     _loc10_ = "";
                  }
                  _loc9_ += this.replaceArabicChar(_loc28_);
               }
               else
               {
                  if(_loc9_ != "")
                  {
                     _loc12_.push({
                        "arabic":true,
                        "html":false,
                        "value":_loc9_
                     });
                     _loc9_ = "";
                  }
                  if(_loc10_ != "")
                  {
                     _loc10_ = _loc10_.toLowerCase();
                     if(_loc10_.indexOf("&lt;br /&gt;") != -1)
                     {
                        _loc21_ = _loc10_.split("&lt;br /&gt;");
                        _loc10_ = _loc21_.join("&lt;br&gt;");
                     }
                     if(_loc10_.indexOf("&lt;br&gt;") != -1)
                     {
                        _loc21_ = _loc10_.split("&lt;br&gt;");
                        _loc10_ = _loc21_.join("");
                     }
                     _loc12_.push({
                        "arabic":false,
                        "html":true,
                        "value":_loc10_
                     });
                     _loc10_ = "";
                  }
                  _loc11_ += this.chars.charAt(_loc28_);
               }
               if(!_loc14_)
               {
                  _loc7_ += this.chars.charAt(_loc28_);
                  if(_loc21_.length > 0)
                  {
                     _loc23_.push(_loc12_);
                     _loc12_ = [];
                     _loc7_ = "";
                     if(_loc21_.length >= 2)
                     {
                        _loc29_ = 0;
                        while(_loc29_ < _loc21_.length - 2)
                        {
                           _loc23_.push([]);
                           _loc29_++;
                        }
                     }
                     _loc21_ = [];
                  }
                  else
                  {
                     _loc5_.htmlText = _loc7_;
                     _loc5_.setTextFormat(param3);
                     _loc8_ = false;
                     if(this.isMAC)
                     {
                        _loc30_ = _loc5_.getLineMetrics(0);
                        if(_loc30_.width >= param2 * this.wrapFactor - (param3.leftMargin ? Number(param3.leftMargin) : 0) - (param3.rightMargin ? Number(param3.rightMargin) : 0))
                        {
                           _loc8_ = true;
                        }
                     }
                     else if(Math.ceil(_loc5_.width) >= param2 * this.wrapFactor - (param3.leftMargin ? Number(param3.leftMargin) : 0) - (param3.rightMargin ? Number(param3.rightMargin) : 0))
                     {
                        _loc8_ = true;
                     }
                     if(_loc8_ && this.chars.charAt(_loc28_) == " ")
                     {
                        if(_loc9_ != "")
                        {
                           _loc12_.push({
                              "arabic":true,
                              "html":false,
                              "value":_loc9_
                           });
                           _loc9_ = "";
                        }
                        if(_loc11_ != "")
                        {
                           _loc12_.push({
                              "arabic":false,
                              "html":false,
                              "value":_loc11_
                           });
                           _loc11_ = "";
                        }
                        _loc23_.push(_loc12_);
                        _loc12_ = [];
                        _loc7_ = "";
                     }
                  }
               }
               _loc18_ = this.chars.charAt(_loc28_ - 3) == "&" && this.chars.charAt(_loc28_ - 2) == "g" && this.chars.charAt(_loc28_ - 1) == "t" && this.chars.charAt(_loc28_) == ";";
               if(_loc18_)
               {
                  _loc14_ = false;
               }
               _loc28_++;
            }
            if(_loc10_ != "")
            {
               _loc10_ = _loc10_.toLowerCase();
               if(_loc10_.indexOf("&lt;br /&gt;") != -1)
               {
                  _loc25_ = _loc10_.split("&lt;br /&gt;");
                  _loc10_ = _loc25_.join("&lt;br&gt;");
               }
               if(_loc10_.indexOf("&lt;br&gt;") != -1)
               {
                  _loc25_ = _loc10_.split("&lt;br&gt;");
                  _loc10_ = _loc25_.join("");
               }
               _loc12_.push({
                  "arabic":false,
                  "html":true,
                  "value":_loc10_
               });
               _loc10_ = "";
            }
            if(_loc9_ != "")
            {
               _loc12_.push({
                  "arabic":true,
                  "html":false,
                  "value":_loc9_
               });
            }
            if(_loc11_ != "")
            {
               _loc12_.push({
                  "arabic":false,
                  "html":false,
                  "value":_loc11_
               });
            }
            if(_loc12_.length > 0)
            {
               _loc23_.push(_loc12_);
            }
            _loc25_ = [];
            _loc28_ = 0;
            while(_loc28_ < _loc23_.length)
            {
               _loc22_ = this.getLastHTMLTag(_loc23_[_loc28_]);
               if(!_loc22_.hasCloseTag)
               {
                  _loc23_[_loc28_].push({
                     "arabic":false,
                     "html":true,
                     "value":_loc22_.closeTag
                  });
                  _loc25_.push({
                     "index":_loc28_ + 1,
                     "value":_loc22_.openTag
                  });
               }
               _loc28_++;
            }
            if(_loc25_.length > 0)
            {
               _loc28_ = 0;
               while(_loc28_ < _loc25_.length)
               {
                  _loc23_[_loc25_[_loc28_].index].splice(0,0,{
                     "arabic":false,
                     "html":true,
                     "value":_loc25_[_loc28_].value
                  });
                  _loc28_++;
               }
            }
            _loc28_ = 0;
            while(_loc28_ < _loc23_.length)
            {
               _loc26_ = "";
               _loc24_ = _loc23_[_loc28_];
               _loc24_ = this.reorderHTMLTags(_loc23_[_loc28_]);
               _loc29_ = 0;
               while(_loc29_ < _loc24_.length)
               {
                  if(_loc24_[_loc29_].arabic)
                  {
                     if(this.embedFonts)
                     {
                        _loc25_ = _loc24_[_loc29_].value.split("");
                        _loc25_.reverse();
                        _loc24_[_loc29_].value = _loc25_.join("");
                     }
                  }
                  if(_loc24_[_loc29_].html)
                  {
                     _loc24_[_loc29_].value = _loc24_[_loc29_].value.split("&lt;").join("<");
                     _loc24_[_loc29_].value = _loc24_[_loc29_].value.split("&gt;").join(">");
                  }
                  _loc26_ += _loc24_[_loc29_].value;
                  _loc29_++;
               }
               _loc27_ = "";
               _loc14_ = false;
               _loc29_ = 0;
               while(_loc29_ < _loc26_.length)
               {
                  if(_loc26_.charAt(_loc29_) == "<" && _loc26_.charAt(_loc29_ + 1) != " ")
                  {
                     _loc14_ = true;
                  }
                  if(this.isNumeric(_loc27_ + _loc26_.charAt(_loc29_)))
                  {
                     _loc16_ = true;
                  }
                  else
                  {
                     _loc16_ = false;
                  }
                  if(!_loc14_ && _loc16_)
                  {
                     _loc27_ += _loc26_.charAt(_loc29_);
                  }
                  if(_loc26_.charAt(_loc29_) == ">")
                  {
                     _loc14_ = false;
                  }
                  _loc29_++;
               }
               if(_loc27_.indexOf(", ") != -1)
               {
                  _loc25_ = _loc27_.split(", ");
                  _loc25_.reverse();
                  _loc26_ = _loc26_.split(_loc27_).join(_loc25_.join(", "));
               }
               _loc6_ = this.flipBracket(_loc26_);
               _loc26_ = _loc6_.line;
               _loc26_ = _loc26_.split("؛lt&").join("&gt;");
               if(this.embedFonts)
               {
                  _loc26_ = _loc26_.split("؛gt&").join("&lt;");
               }
               else
               {
                  _loc26_ = _loc26_.split("&gt؛").join("&lt;");
                  if(_loc26_.charAt(1) == "•")
                  {
                     _loc13_ = Number(_loc26_.charCodeAt(3));
                     _loc19_ = _loc13_ == 1567 || _loc13_ >= 1569 && _loc13_ <= 1594 || _loc13_ >= 1600 && _loc13_ <= 1618 || _loc13_ >= 65154 && _loc13_ <= 65276 || _loc13_ == 1662 || _loc13_ == 1670 || _loc13_ == 1688 || _loc13_ == 1700 || _loc13_ == 1711;
                     if(!_loc19_)
                     {
                        _loc25_ = _loc26_.split(" • ");
                        _loc25_.reverse();
                        _loc26_ = _loc25_.join(" • ");
                     }
                  }
                  if(_loc6_.bracketsCount == 1)
                  {
                     _loc25_ = _loc26_.split(_loc6_.flippedBracket);
                     if(!this.validateArabicChunck(_loc25_[0]) && !this.isNumeric(_loc25_[0]))
                     {
                        _loc25_.splice(1,0,_loc6_.flippedBracket);
                        _loc25_.splice(0,0,String.fromCharCode(65142));
                        _loc26_ = _loc25_.join("");
                     }
                  }
               }
               this.htmlLines.push(_loc26_);
               _loc4_ += _loc26_ + "<br>";
               _loc28_++;
            }
            _loc4_ = "<p align=\"right\">" + _loc4_ + "</p>";
         }
         return this.getHTMLFormat(_loc4_,param3);
      }
      
      private function validateArabicChar(param1:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc2_:Boolean = false;
         if(param1 >= 0 && param1 < this.chars.length)
         {
            _loc3_ = Number(this.chars.charCodeAt(param1));
            if(_loc3_ == 1567 || _loc3_ >= 1569 && _loc3_ <= 1594 || _loc3_ >= 1600 && _loc3_ <= 1618 || _loc3_ >= 65154 && _loc3_ <= 65276 || _loc3_ == 1662 || _loc3_ == 1670 || _loc3_ == 1688 || _loc3_ == 1700 || _loc3_ == 1711)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function validateArabicChunck(param1:String) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc2_:Boolean = false;
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = Number(param1.charCodeAt(_loc3_));
            if(_loc4_ == 1567 || _loc4_ >= 1569 && _loc4_ <= 1594 || _loc4_ >= 1600 && _loc4_ <= 1618 || _loc4_ >= 65154 && _loc4_ <= 65276 || _loc4_ == 1662 || _loc4_ == 1670 || _loc4_ == 1688 || _loc4_ == 1700 || _loc4_ == 1711)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function validateNextArabicChar(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 >= 0 && param1 < this.chars.length)
         {
            if(this.validateArabicChar(param1))
            {
               _loc2_ = true;
            }
            if(this.chars.charAt(param1) == " " || this.validateSymbol(param1))
            {
               _loc2_ = this.validateNextArabicChar(param1 + 1);
            }
         }
         return _loc2_;
      }
      
      private function validatePrevArabicChar(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 >= 0 && param1 < this.chars.length)
         {
            if(this.validateArabicChar(param1))
            {
               _loc2_ = true;
            }
            if(this.chars.charAt(param1) == " " || this.validateSymbol(param1))
            {
               _loc2_ = this.validatePrevArabicChar(param1 - 1);
            }
         }
         return _loc2_;
      }
      
      private function validateSymbol(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = Number(this.chars.charCodeAt(param1));
         if(_loc3_ >= 32 && _loc3_ <= 47 || _loc3_ >= 58 && _loc3_ <= 63 || _loc3_ >= 91 && _loc3_ <= 93 || _loc3_ >= 123 && _loc3_ <= 126 || _loc3_ == 163 || _loc3_ == 171 || _loc3_ == 187 || _loc3_ == 1548 || _loc3_ == 8226 || _loc3_ == 9642 || _loc3_ == 10216 || _loc3_ == 10217)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function validateOpenBracket(param1:Number, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = Number(param2.charCodeAt(param1));
         if(_loc4_ == 40 || _loc4_ == 91 || _loc4_ == 123 || _loc4_ == 171 || _loc4_ == 10216)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function validateCloseBracket(param1:Number, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = Number(param2.charCodeAt(param1));
         if(_loc4_ == 41 || _loc4_ == 93 || _loc4_ == 125 || _loc4_ == 187 || _loc4_ == 10217)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function flipBracket(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         var _loc6_:Number = 0;
         while(_loc6_ < param1.length)
         {
            if(this.validateOpenBracket(_loc6_,param1) || this.validateCloseBracket(_loc6_,param1))
            {
               _loc2_.push({
                  "index":_loc6_,
                  "code":param1.charCodeAt(_loc6_)
               });
            }
            _loc6_++;
         }
         if(_loc2_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               _loc3_ = _loc2_[_loc6_];
               switch(_loc3_.code)
               {
                  case 40:
                     _loc4_ = String.fromCharCode(41);
                     break;
                  case 91:
                     _loc4_ = String.fromCharCode(93);
                     break;
                  case 123:
                     _loc4_ = String.fromCharCode(125);
                     break;
                  case 171:
                     _loc4_ = String.fromCharCode(187);
                     break;
                  case 10216:
                     _loc4_ = String.fromCharCode(10217);
                     break;
                  case 41:
                     _loc4_ = String.fromCharCode(40);
                     break;
                  case 93:
                     _loc4_ = String.fromCharCode(91);
                     break;
                  case 125:
                     _loc4_ = String.fromCharCode(123);
                     break;
                  case 187:
                     _loc4_ = String.fromCharCode(171);
                     break;
                  case 10217:
                     _loc4_ = String.fromCharCode(10216);
               }
               _loc5_ = param1.split("");
               _loc5_.splice(_loc3_.index,1,_loc4_);
               param1 = _loc5_.join("");
               _loc6_++;
            }
         }
         return {
            "line":param1,
            "bracketsCount":_loc2_.length,
            "flippedBracket":_loc4_
         };
      }
      
      private function splitBulletList() : void
      {
         this.chars = this.chars.split("<ul>").join("");
         this.chars = this.chars.split("</ul>").join("<br>");
         this.chars = this.chars.split("<li>").join("<br> • ");
         this.chars = this.chars.split("</li>").join("");
      }
      
      private function getLastHTMLTag(param1:Array) : Object
      {
         var _loc5_:Array = null;
         var _loc2_:Boolean = true;
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc6_:Number = param1.length - 1;
         if(param1.length > 0)
         {
            while(_loc6_ >= 0)
            {
               if(param1[_loc6_].html)
               {
                  if(param1[_loc6_].value.indexOf("&lt;/") == -1)
                  {
                     _loc3_ = param1[_loc6_].value;
                  }
                  break;
               }
               _loc6_--;
            }
         }
         if(_loc3_ != "")
         {
            _loc2_ = false;
            _loc5_ = _loc3_.split(" ");
            if(_loc5_.length > 0)
            {
               _loc6_ = _loc5_.length - 1;
               while(_loc6_ >= 0)
               {
                  if(_loc5_[_loc6_].indexOf("&lt;") != -1)
                  {
                     _loc4_ += "&lt;/" + _loc5_[_loc6_].slice(_loc5_[_loc6_].indexOf("&lt;") + 4) + "&gt;";
                     if(_loc4_.indexOf("&gt;&gt;") != -1)
                     {
                        _loc4_ = _loc4_.substr(0,-4);
                     }
                  }
                  _loc6_--;
               }
            }
         }
         return {
            "hasCloseTag":_loc2_,
            "openTag":_loc3_,
            "closeTag":_loc4_
         };
      }
      
      private function reorderTextLine(param1:Array) : Array
      {
         var _loc4_:Number = NaN;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(!param1[_loc4_].html)
            {
               _loc2_.push(_loc4_);
               _loc3_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         _loc3_.reverse();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            param1.splice(_loc2_[_loc4_],1,_loc3_[_loc4_]);
            _loc4_++;
         }
         return param1;
      }
      
      private function reorderHTMLTags(param1:Array) : Array
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Array = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         if(this.embedFonts)
         {
            _loc4_ = false;
            _loc5_ = [];
            _loc6_ = [];
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_].arabic)
               {
                  _loc4_ = true;
                  break;
               }
               _loc2_++;
            }
            if(_loc4_)
            {
               param1.reverse();
            }
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(param1[_loc2_].html)
               {
                  _loc5_.push(_loc2_);
                  _loc6_.push(param1[_loc2_]);
               }
               _loc2_++;
            }
            if(_loc4_)
            {
               _loc6_.reverse();
               _loc2_ = 0;
               while(_loc2_ < _loc5_.length)
               {
                  param1.splice(_loc5_[_loc2_],1,_loc6_[_loc2_]);
                  _loc2_++;
               }
            }
         }
         else
         {
            _loc7_ = false;
            _loc8_ = false;
            _loc9_ = false;
            _loc10_ = [];
            _loc11_ = [];
            _loc12_ = [];
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               if(Boolean(param1[_loc2_].html) || _loc9_)
               {
                  if(!_loc8_)
                  {
                     _loc7_ = true;
                  }
                  if(_loc12_.length > 0)
                  {
                     _loc10_.push(_loc12_);
                     _loc12_ = [];
                  }
                  _loc11_.push(param1[_loc2_]);
               }
               else
               {
                  _loc8_ = true;
                  if(_loc11_.length > 0)
                  {
                     _loc10_.push(_loc11_);
                     _loc11_ = [];
                  }
                  _loc12_.push(param1[_loc2_]);
               }
               if(param1[_loc2_].html)
               {
                  if(_loc9_)
                  {
                     _loc9_ = false;
                  }
                  else
                  {
                     _loc9_ = true;
                  }
               }
               _loc2_++;
            }
            if(_loc7_)
            {
               if(_loc11_.length > 0)
               {
                  _loc10_.push(_loc11_);
                  _loc11_ = [];
               }
               if(_loc12_.length > 0)
               {
                  _loc10_.push(_loc12_);
                  _loc12_ = [];
               }
            }
            else
            {
               if(_loc12_.length > 0)
               {
                  _loc10_.push(_loc12_);
                  _loc12_ = [];
               }
               if(_loc11_.length > 0)
               {
                  _loc10_.push(_loc11_);
                  _loc11_ = [];
               }
            }
            _loc10_.reverse();
            param1 = [];
            _loc2_ = 0;
            while(_loc2_ < _loc10_.length)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc10_[_loc2_].length)
               {
                  param1.push(_loc10_[_loc2_][_loc3_]);
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         return param1;
      }
      
      private function replaceArabicChar(param1:Number) : String
      {
         var _loc2_:String = null;
         switch(this.chars.charAt(param1))
         {
            case "ا":
               _loc2_ = this.setChar(param1,String.fromCharCode(1575),String.fromCharCode(1575),String.fromCharCode(65166),String.fromCharCode(65166));
               break;
            case "أ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1571),String.fromCharCode(1571),String.fromCharCode(65156),String.fromCharCode(65156));
               break;
            case "إ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1573),String.fromCharCode(1573),String.fromCharCode(65160),String.fromCharCode(65160));
               break;
            case "آ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1570),String.fromCharCode(1570),String.fromCharCode(65154),String.fromCharCode(65154));
               break;
            case "ب":
               _loc2_ = this.setChar(param1,String.fromCharCode(1576),String.fromCharCode(65169),String.fromCharCode(65170),String.fromCharCode(65168));
               break;
            case "پ":
               _loc2_ = this.setChar(param1,String.fromCharCode(64342),String.fromCharCode(64344),String.fromCharCode(64345),String.fromCharCode(64343));
               break;
            case "ت":
               _loc2_ = this.setChar(param1,String.fromCharCode(1578),String.fromCharCode(65175),String.fromCharCode(65176),String.fromCharCode(65174));
               break;
            case "ث":
               _loc2_ = this.setChar(param1,String.fromCharCode(1579),String.fromCharCode(65179),String.fromCharCode(65180),String.fromCharCode(65178));
               break;
            case "ج":
               _loc2_ = this.setChar(param1,String.fromCharCode(1580),String.fromCharCode(65183),String.fromCharCode(65184),String.fromCharCode(65182));
               break;
            case "چ":
               _loc2_ = this.setChar(param1,String.fromCharCode(64378),String.fromCharCode(64380),String.fromCharCode(64381),String.fromCharCode(64379));
               break;
            case "ح":
               _loc2_ = this.setChar(param1,String.fromCharCode(1581),String.fromCharCode(65187),String.fromCharCode(65188),String.fromCharCode(65186));
               break;
            case "خ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1582),String.fromCharCode(65191),String.fromCharCode(65192),String.fromCharCode(65190));
               break;
            case "د":
               _loc2_ = this.setChar(param1,String.fromCharCode(1583),String.fromCharCode(1583),String.fromCharCode(65194),String.fromCharCode(65194));
               break;
            case "ذ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1584),String.fromCharCode(1584),String.fromCharCode(65196),String.fromCharCode(65196));
               break;
            case "ر":
               _loc2_ = this.setChar(param1,String.fromCharCode(1585),String.fromCharCode(1585),String.fromCharCode(65198),String.fromCharCode(65198));
               break;
            case "ز":
               _loc2_ = this.setChar(param1,String.fromCharCode(1586),String.fromCharCode(1586),String.fromCharCode(65200),String.fromCharCode(65200));
               break;
            case "ژ":
               _loc2_ = this.setChar(param1,String.fromCharCode(64394),String.fromCharCode(64394),String.fromCharCode(64395),String.fromCharCode(64395));
               break;
            case "س":
               _loc2_ = this.setChar(param1,String.fromCharCode(1587),String.fromCharCode(65203),String.fromCharCode(65204),String.fromCharCode(65202));
               break;
            case "ش":
               _loc2_ = this.setChar(param1,String.fromCharCode(1588),String.fromCharCode(65207),String.fromCharCode(65208),String.fromCharCode(65206));
               break;
            case "ص":
               _loc2_ = this.setChar(param1,String.fromCharCode(1589),String.fromCharCode(65211),String.fromCharCode(65212),String.fromCharCode(65210));
               break;
            case "ض":
               _loc2_ = this.setChar(param1,String.fromCharCode(1590),String.fromCharCode(65215),String.fromCharCode(65216),String.fromCharCode(65214));
               break;
            case "ط":
               _loc2_ = this.setChar(param1,String.fromCharCode(1591),String.fromCharCode(65219),String.fromCharCode(65220),String.fromCharCode(65218));
               break;
            case "ظ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1592),String.fromCharCode(65223),String.fromCharCode(65224),String.fromCharCode(65222));
               break;
            case "ع":
               _loc2_ = this.setChar(param1,String.fromCharCode(1593),String.fromCharCode(65227),String.fromCharCode(65228),String.fromCharCode(65226));
               break;
            case "غ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1594),String.fromCharCode(65231),String.fromCharCode(65232),String.fromCharCode(65230));
               break;
            case "ف":
               _loc2_ = this.setChar(param1,String.fromCharCode(1601),String.fromCharCode(65235),String.fromCharCode(65236),String.fromCharCode(65234));
               break;
            case "ڤ":
               _loc2_ = this.setChar(param1,String.fromCharCode(64362),String.fromCharCode(64364),String.fromCharCode(64365),String.fromCharCode(64363));
               break;
            case "ق":
               _loc2_ = this.setChar(param1,String.fromCharCode(1602),String.fromCharCode(65239),String.fromCharCode(65240),String.fromCharCode(65238));
               break;
            case "ك":
               _loc2_ = this.setChar(param1,String.fromCharCode(1603),String.fromCharCode(65243),String.fromCharCode(65244),String.fromCharCode(65242));
               break;
            case "گ":
               _loc2_ = this.setChar(param1,String.fromCharCode(64402),String.fromCharCode(64404),String.fromCharCode(64405),String.fromCharCode(64403));
               break;
            case "ل":
               _loc2_ = this.setChar(param1,String.fromCharCode(1604),String.fromCharCode(65247),String.fromCharCode(65248),String.fromCharCode(65246));
               break;
            case "م":
               _loc2_ = this.setChar(param1,String.fromCharCode(1605),String.fromCharCode(65251),String.fromCharCode(65252),String.fromCharCode(65250));
               break;
            case "ن":
               _loc2_ = this.setChar(param1,String.fromCharCode(1606),String.fromCharCode(65255),String.fromCharCode(65256),String.fromCharCode(65254));
               break;
            case "ه":
               _loc2_ = this.setChar(param1,String.fromCharCode(1607),String.fromCharCode(65259),String.fromCharCode(65260),String.fromCharCode(65258));
               break;
            case "ة":
               _loc2_ = this.setChar(param1,String.fromCharCode(1577),"","",String.fromCharCode(65172));
               break;
            case "و":
               _loc2_ = this.setChar(param1,String.fromCharCode(1608),String.fromCharCode(1608),String.fromCharCode(65262),String.fromCharCode(65262));
               break;
            case "ؤ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1572),String.fromCharCode(1572),String.fromCharCode(65158),String.fromCharCode(65158));
               break;
            case "ى":
               _loc2_ = this.setChar(param1,String.fromCharCode(1609),String.fromCharCode(1609),String.fromCharCode(65264),String.fromCharCode(65264));
               break;
            case "ي":
               _loc2_ = this.setChar(param1,String.fromCharCode(1610),String.fromCharCode(65267),String.fromCharCode(65268),String.fromCharCode(65266));
               break;
            case "ئ":
               _loc2_ = this.setChar(param1,String.fromCharCode(1574),String.fromCharCode(65163),String.fromCharCode(65164),String.fromCharCode(65162));
               break;
            case "ء":
               _loc2_ = String.fromCharCode(1569);
               break;
            case "ـ":
               _loc2_ = String.fromCharCode(1600);
               break;
            case "َ":
               _loc2_ = this.setChar(param1,String.fromCharCode(65142),String.fromCharCode(65142),String.fromCharCode(65143),String.fromCharCode(65142));
               break;
            case "ً":
               _loc2_ = this.setChar(param1,String.fromCharCode(65136),String.fromCharCode(65136),String.fromCharCode(65137),String.fromCharCode(65136));
               break;
            case "ِ":
               _loc2_ = this.setChar(param1,String.fromCharCode(65146),String.fromCharCode(65146),String.fromCharCode(65147),String.fromCharCode(65146));
               break;
            case "ٍ":
               _loc2_ = String.fromCharCode(65140);
               break;
            case "ُ":
               _loc2_ = this.setChar(param1,String.fromCharCode(65144),String.fromCharCode(65144),String.fromCharCode(65145),String.fromCharCode(65144));
               break;
            case "ٌ":
               _loc2_ = String.fromCharCode(65138);
               break;
            case "ْ":
               _loc2_ = this.setChar(param1,String.fromCharCode(65150),String.fromCharCode(65150),String.fromCharCode(65151),String.fromCharCode(65150));
               break;
            case "ّ":
               _loc2_ = this.setChar(param1,String.fromCharCode(65148),String.fromCharCode(65148),String.fromCharCode(65151),String.fromCharCode(65148));
               break;
            case "?":
               _loc2_ = String.fromCharCode(1567);
               break;
            case ",":
               _loc2_ = String.fromCharCode(1548);
               break;
            case ";":
               _loc2_ = String.fromCharCode(1563);
               break;
            case "%":
               _loc2_ = String.fromCharCode(1642);
               break;
            default:
               _loc2_ = this.chars.charAt(param1);
         }
         return _loc2_;
      }
      
      private function setChar(param1:Number, param2:String, param3:String, param4:String, param5:String) : String
      {
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc6_:String = "";
         if(this.chars.charAt(param1) == "ل" && this.chars.charAt(param1 + 1) == "ا")
         {
            if(this.validateArabicChar(param1 - 1) && this.specialChars.indexOf(this.chars.charAt(param1 - 1)) == -1)
            {
               _loc6_ = String.fromCharCode(65276);
            }
            else
            {
               _loc6_ = String.fromCharCode(65275);
            }
            this.chars = this.chars.substring(0,param1) + _loc6_ + this.chars.substring(param1 + 2,this.chars.length);
         }
         else if(this.chars.charAt(param1) == "ل" && this.chars.charAt(param1 + 1) == "أ")
         {
            if(this.validateArabicChar(param1 - 1) && this.specialChars.indexOf(this.chars.charAt(param1 - 1)) == -1)
            {
               _loc6_ = String.fromCharCode(65272);
            }
            else
            {
               _loc6_ = String.fromCharCode(65271);
            }
            this.chars = this.chars.substring(0,param1) + _loc6_ + this.chars.substring(param1 + 2,this.chars.length);
         }
         else if(this.chars.charAt(param1) == "ل" && this.chars.charAt(param1 + 1) == "إ")
         {
            if(this.validateArabicChar(param1 - 1) && this.specialChars.indexOf(this.chars.charAt(param1 - 1)) == -1)
            {
               _loc6_ = String.fromCharCode(65274);
            }
            else
            {
               _loc6_ = String.fromCharCode(65273);
            }
            this.chars = this.chars.substring(0,param1) + _loc6_ + this.chars.substring(param1 + 2,this.chars.length);
         }
         else if(this.chars.charAt(param1) == "ل" && this.chars.charAt(param1 + 1) == "آ")
         {
            if(this.validateArabicChar(param1 - 1) && this.specialChars.indexOf(this.chars.charAt(param1 - 1)) == -1)
            {
               _loc6_ = String.fromCharCode(65270);
            }
            else
            {
               _loc6_ = String.fromCharCode(65269);
            }
            this.chars = this.chars.substring(0,param1) + _loc6_ + this.chars.substring(param1 + 2,this.chars.length);
         }
         else
         {
            _loc7_ = this.chars.charCodeAt(param1 - 1) >= 1611 && this.chars.charCodeAt(param1 - 1) <= 1618;
            _loc8_ = this.chars.charCodeAt(param1 + 1) >= 1611 && this.chars.charCodeAt(param1 + 1) <= 1618;
            if(param1 == 0)
            {
               if(this.specialChars.indexOf(this.chars.charAt(param1)) != -1 || !this.validateArabicChar(param1 + 1))
               {
                  _loc6_ = param2;
               }
               else
               {
                  _loc6_ = param3;
               }
            }
            else if(param1 == this.chars.length - 1)
            {
               if(this.specialChars.indexOf(this.chars.charAt(param1 - 1)) != -1 || !this.validateArabicChar(param1 - 1))
               {
                  _loc6_ = param2;
               }
               else
               {
                  _loc6_ = param5;
               }
            }
            else if(this.validateArabicChar(param1 - 1) && this.validateArabicChar(param1 + 1))
            {
               if(this.specialChars.indexOf(this.chars.charAt(param1 - 1)) != -1)
               {
                  if(this.specialChars.indexOf(this.chars.charAt(param1)) != -1 || _loc8_ && !this.validateArabicChar(param1 + 2))
                  {
                     _loc6_ = param2;
                  }
                  else
                  {
                     _loc6_ = param3;
                  }
               }
               else if(this.specialChars.indexOf(this.chars.charAt(param1)) != -1 || this.chars.charAt(param1 + 1) == "ء" || this.chars.charAt(param1) == "ة")
               {
                  if(this.chars.charAt(param1 - 1) != "ة")
                  {
                     if(_loc7_ && this.specialChars.indexOf(this.chars.charAt(param1 - 2)) != -1)
                     {
                        _loc6_ = param3;
                     }
                     else
                     {
                        _loc6_ = param5;
                     }
                  }
                  else
                  {
                     _loc6_ = param3;
                  }
               }
               else if(this.chars.charAt(param1 - 1) != "ة")
               {
                  if(_loc7_ && this.specialChars.indexOf(this.chars.charAt(param1 - 2)) != -1)
                  {
                     _loc6_ = param3;
                  }
                  else if(_loc8_ && !this.validateArabicChar(param1 + 2))
                  {
                     _loc6_ = param5;
                  }
                  else if(this.arabicPunctuation.indexOf(this.chars.charAt(param1 + 1)) != -1)
                  {
                     _loc6_ = param5;
                  }
                  else
                  {
                     _loc6_ = param4;
                  }
               }
               else
               {
                  _loc6_ = param3;
               }
            }
            else if(this.validateArabicChar(param1 - 1) && !this.validateArabicChar(param1 + 1))
            {
               if(this.specialChars.indexOf(this.chars.charAt(param1 - 1)) != -1 || _loc7_ && this.specialChars.indexOf(this.chars.charAt(param1 - 2)) != -1)
               {
                  _loc6_ = param2;
               }
               else
               {
                  _loc6_ = param5;
               }
            }
            else if(!this.validateArabicChar(param1 - 1) && this.validateArabicChar(param1 + 1))
            {
               if(this.specialChars.indexOf(this.chars.charAt(param1)) != -1)
               {
                  _loc6_ = param2;
               }
               else
               {
                  _loc6_ = param3;
               }
            }
            else if(!this.validateArabicChar(param1 - 1) && !this.validateArabicChar(param1 + 1))
            {
               _loc6_ = param2;
            }
         }
         return _loc6_;
      }
      
      private function cleanString() : String
      {
         var _loc1_:String = "";
         var _loc2_:Number = 0;
         while(_loc2_ < this.chars.length)
         {
            if(this.chars.charCodeAt(_loc2_) > 31 && this.chars.charCodeAt(_loc2_) != 127)
            {
               _loc1_ += this.chars.charAt(_loc2_);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function getHTMLFormat(param1:String, param2:TextFormat) : String
      {
         var _loc3_:String = "<textformat leftmargin=\"" + (param2.leftMargin ? param2.leftMargin : 0) + "\" rightmargin=\"" + (param2.rightMargin ? param2.rightMargin : 0) + "\" leading=\"" + (param2.leading ? param2.leading : 0) + "\"><p align=\"" + (param2.align ? param2.align : "left") + "\"><font face=\"" + (param2.font ? param2.font : "Arial") + "\" color=\"" + (param2.color ? this.getProperColor(Number(param2.color)) : "#000000") + "\" size=\"" + (param2.size ? param2.size : 12) + "\" letterspacing=\"" + (param2.letterSpacing ? param2.letterSpacing : 0) + "\" kerning=\"" + (param2.kerning ? param2.kerning : 0) + "\">";
         if(param2.bold)
         {
            _loc3_ += "<b>";
         }
         if(param2.italic)
         {
            _loc3_ += "<i>";
         }
         if(param2.underline)
         {
            _loc3_ += "<u>";
         }
         _loc3_ += param1;
         if(param2.underline)
         {
            _loc3_ += "</u>";
         }
         if(param2.italic)
         {
            _loc3_ += "</i>";
         }
         if(param2.bold)
         {
            _loc3_ += "</b>";
         }
         return _loc3_ + "</font></p></textformat>";
      }
      
      public function createArabicInput(param1:String, param2:String, param3:TextField, param4:Number, param5:Number) : void
      {
         var _loc6_:String = "#000000";
         if(param4)
         {
            _loc6_ = this.getProperColor(param4);
         }
         var _loc7_:String = "none";
         if(param5)
         {
            _loc7_ = this.getProperColor(param5);
         }
         var _loc8_:TextFormat = param3.getTextFormat();
         var _loc9_:Point = new Point(param3.x,param3.y);
         param3.localToGlobal(_loc9_);
         var _loc10_:String = "singleline";
         if(param3.multiline)
         {
            _loc10_ = "multiline";
         }
         ExternalInterface.call("createArabicInput",param1,param2,param3.text,_loc9_.x,_loc9_.y,param3.width,param3.height,_loc6_,_loc7_,_loc10_);
      }
      
      public function showArabicInput() : void
      {
         ExternalInterface.call("revealAllArabicInputs");
      }
      
      private function isNumeric(param1:String) : Boolean
      {
         return !isNaN(parseInt(param1));
      }
      
      private function convertNumbers() : String
      {
         var _loc1_:String = "";
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Array = [];
         var _loc6_:Number = 0;
         while(_loc6_ < this.chars.length)
         {
            _loc2_ = this.chars.charAt(_loc6_) == "&" && this.chars.charAt(_loc6_ + 1) == "l" && this.chars.charAt(_loc6_ + 2) == "t" && this.chars.charAt(_loc6_ + 3) == ";" && this.chars.charAt(_loc6_ + 4) != " ";
            if(_loc2_)
            {
               _loc4_ = true;
            }
            if(!_loc4_)
            {
               switch(this.chars.charAt(_loc6_))
               {
                  case "0":
                     _loc1_ += String.fromCharCode(1632);
                     break;
                  case "1":
                     _loc1_ += String.fromCharCode(1633);
                     break;
                  case "2":
                     _loc1_ += String.fromCharCode(1634);
                     break;
                  case "3":
                     _loc1_ += String.fromCharCode(1635);
                     break;
                  case "4":
                     _loc1_ += String.fromCharCode(1636);
                     break;
                  case "5":
                     _loc1_ += String.fromCharCode(1637);
                     break;
                  case "6":
                     _loc1_ += String.fromCharCode(1638);
                     break;
                  case "7":
                     _loc1_ += String.fromCharCode(1639);
                     break;
                  case "8":
                     _loc1_ += String.fromCharCode(1640);
                     break;
                  case "9":
                     _loc1_ += String.fromCharCode(1641);
                     break;
                  default:
                     _loc1_ += this.chars.charAt(_loc6_);
               }
            }
            else
            {
               _loc1_ += this.chars.charAt(_loc6_);
            }
            _loc3_ = this.chars.charAt(_loc6_ - 3) == "&" && this.chars.charAt(_loc6_ - 2) == "g" && this.chars.charAt(_loc6_ - 1) == "t" && this.chars.charAt(_loc6_) == ";";
            if(_loc3_)
            {
               _loc4_ = false;
            }
            _loc6_++;
         }
         return _loc1_;
      }
      
      private function toAmericanFormat(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Number = 0;
         var _loc4_:Number = param1.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_++;
            _loc2_ += param1.charAt(_loc4_);
            if(_loc3_ == 3)
            {
               _loc3_ = 0;
               _loc2_ += ",";
            }
            _loc4_--;
         }
         var _loc5_:Array = _loc2_.split("");
         _loc5_.reverse();
         return _loc5_.join("");
      }
      
      private function getProperColor(param1:Number) : String
      {
         var _loc2_:String = "#";
         var _loc3_:Number = 0;
         if(param1.toString(16).length < 6)
         {
            while(_loc3_ < 6 - param1.toString(16).length)
            {
               _loc2_ += "0";
               _loc3_++;
            }
         }
         return _loc2_ + param1.toString(16);
      }
   }
}

