package com.oyunstudyosu.local.arabic
{
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class ArabicLight
   {
      
      public var data:String;
      
      public var wrapFactor:Number = 0.99;
      
      public var embedFonts:Boolean = true;
      
      public var hindiNumeralsOnly:Boolean = false;
      
      private var tag_rgx:RegExp;
      
      private var specialChars:String = "اأإآدذرزژوؤء";
      
      private var arabicPunctuation:String;
      
      private var isMAC:Boolean;
      
      private var chars:String;
      
      private var temp:TextField;
      
      public function ArabicLight()
      {
         super();
         this.isMAC = false;
         var _loc1_:String = Capabilities.version;
         if(_loc1_.toLowerCase().indexOf("mac") != -1)
         {
            this.isMAC = true;
         }
         this.tag_rgx = /<.*?>/gim;
         this.specialChars += String.fromCharCode(65276,65275,65272,65271,65274,65273,65270,65269);
         this.arabicPunctuation = String.fromCharCode(1545,1546,1563,1566,1567,1548,1549,1642,1643,1644,1645,1748);
      }
      
      public function parseArabic(param1:String, param2:Number, param3:TextFormat) : String
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc9_:Array = null;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         var _loc14_:TextLineMetrics = null;
         if(!param3)
         {
            param3 = new TextFormat();
            param3.font = "Tahoma";
            param3.size = 10;
            param3.rightMargin = 4;
         }
         this.data = param1;
         var _loc4_:String = param1;
         _loc4_ = this.removeLineBreaks(_loc4_);
         var _loc7_:String = _loc4_ = this.splitBulletList(_loc4_);
         _loc4_ = _loc7_.replace(this.tag_rgx,"");
         var _loc8_:Number = _loc4_.length;
         var _loc12_:String = "";
         var _loc13_:Boolean = false;
         _loc9_ = _loc4_.split(" ");
         _loc10_ = _loc9_.length;
         this.temp = this.temp || this.createTemporaryTextField(param3);
         _loc4_ = "";
         _loc5_ = 0;
         while(_loc5_ < _loc10_)
         {
            _loc11_ = _loc9_[_loc5_];
            if(_loc4_ != "")
            {
               _loc4_ += " ";
            }
            _loc4_ += _loc11_;
            if(_loc12_ != "")
            {
               _loc12_ += " ";
            }
            _loc12_ += _loc11_;
            this.temp.text = _loc12_;
            this.temp.setTextFormat(param3);
            _loc13_ = false;
            if(this.isMAC)
            {
               _loc14_ = this.temp.getLineMetrics(0);
               if(_loc14_.width >= param2 * this.wrapFactor - (param3.leftMargin ? Number(param3.leftMargin) : 0) - (param3.rightMargin ? Number(param3.rightMargin) : 0))
               {
                  _loc13_ = true;
               }
            }
            else if(Math.ceil(this.temp.width) >= param2 * this.wrapFactor - (param3.leftMargin ? Number(param3.leftMargin) : 0) - (param3.rightMargin ? Number(param3.rightMargin) : 0))
            {
               _loc13_ = true;
            }
            if(_loc13_)
            {
               _loc4_ += "\n";
               _loc12_ = "";
            }
            _loc5_++;
         }
         _loc4_ = this.processTextLines(_loc4_);
         _loc4_ = _loc4_.split("<").join("&lt;");
         _loc4_ = _loc4_.split(">").join("&gt;");
         _loc4_ = this.flipBrackets(_loc4_);
         _loc4_ = this.fixBugs(_loc4_);
         if(this.hindiNumeralsOnly)
         {
            _loc4_ = this.convertNumbers(_loc4_);
         }
         return this.getHTMLFormat(_loc4_,param3);
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
      
      private function processTextLines(param1:String) : String
      {
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc16_:Number = NaN;
         var _loc2_:Array = param1.split("\n");
         var _loc3_:Number = _loc2_.length;
         var _loc10_:String = "";
         var _loc11_:String = "";
         var _loc14_:String = "";
         var _loc15_:Number = 0;
         while(_loc15_ < _loc3_)
         {
            _loc13_ = [];
            _loc5_ = _loc2_[_loc15_];
            _loc4_ = _loc5_.length;
            _loc16_ = 0;
            while(_loc16_ < _loc4_)
            {
               _loc6_ = Number(_loc5_.charCodeAt(_loc16_));
               _loc7_ = _loc6_ >= 1536 && _loc6_ <= 1631 || _loc6_ >= 1642 && _loc6_ <= 1791 || _loc6_ >= 65136 && _loc6_ <= 65279 || this.validateSymbol(_loc5_,_loc16_);
               if(_loc7_)
               {
                  _loc9_ = true;
               }
               else
               {
                  _loc9_ = false;
               }
               if(_loc9_)
               {
                  if(this.validateSymbol(_loc5_,_loc16_) && !this.validateNextArabicChar(_loc5_,_loc16_) && _loc11_ != "")
                  {
                     _loc9_ = false;
                  }
               }
               if(_loc9_)
               {
                  if(_loc11_ != "")
                  {
                     _loc13_.push(_loc11_);
                     _loc11_ = "";
                  }
                  _loc10_ += _loc5_.charAt(_loc16_);
               }
               else
               {
                  if(_loc10_ != "")
                  {
                     _loc10_ = this.replaceArabic(_loc10_);
                     if(this.embedFonts)
                     {
                        _loc12_ = _loc10_.split("");
                        _loc12_.reverse();
                        _loc10_ = _loc12_.join("");
                     }
                     _loc13_.push(_loc10_);
                     _loc10_ = "";
                  }
                  _loc11_ += _loc5_.charAt(_loc16_);
               }
               _loc16_++;
            }
            if(_loc10_ != "")
            {
               _loc10_ = this.replaceArabic(_loc10_);
               if(this.embedFonts)
               {
                  _loc12_ = _loc10_.split("");
                  _loc12_.reverse();
                  _loc10_ = _loc12_.join("");
               }
               _loc13_.push(_loc10_);
               _loc10_ = "";
            }
            if(_loc11_ != "")
            {
               _loc13_.push(_loc11_);
               _loc11_ = "";
            }
            if(this.embedFonts)
            {
               _loc13_.reverse();
            }
            _loc14_ += _loc13_.join("");
            if(_loc15_ < _loc3_ - 1)
            {
               _loc14_ += "\n";
            }
            _loc15_++;
         }
         return _loc14_;
      }
      
      private function replaceArabic(param1:String) : String
      {
         this.chars = param1;
         var _loc2_:String = "";
         var _loc3_:Number = this.chars.length;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ += this.replaceArabicChar(_loc4_);
            _loc4_++;
         }
         return _loc2_;
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
            case "<":
               _loc2_ = ">";
               break;
            case ">":
               _loc2_ = "<";
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
      
      private function validateArabicChar(param1:Number) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:Boolean = false;
         if(param1 >= 0 && param1 < this.chars.length)
         {
            _loc3_ = this.chars.charAt(param1);
            if(_loc3_.charCodeAt(0) >= 1536 && _loc3_.charCodeAt(0) <= 1791 || _loc3_.charCodeAt(0) >= 65136 && _loc3_.charCodeAt(0) <= 65279)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function validateArabicWord(param1:String, param2:Number) : Boolean
      {
         if(!param2)
         {
            param2 = 0;
         }
         var _loc3_:Number = param1.length - 2;
         var _loc4_:Number = Number(param1.charCodeAt(param2));
         var _loc5_:Boolean = _loc4_ >= 1536 && _loc4_ <= 1791 || _loc4_ >= 65136 && _loc4_ <= 65279;
         if(!_loc5_ && param2 < _loc3_)
         {
            _loc5_ = this.validateArabicWord(param1,param2 + 1);
         }
         return _loc5_;
      }
      
      private function validateNextArabicChar(param1:String, param2:Number) : Boolean
      {
         var _loc3_:Number = Number(param1.charCodeAt(param2));
         var _loc4_:Boolean = _loc3_ >= 1536 && _loc3_ <= 1791 || _loc3_ >= 65136 && _loc3_ <= 65279;
         if(!_loc4_)
         {
            if(param1.charAt(param2) == " " || this.validateSymbol(param1,param2))
            {
               _loc4_ = this.validateNextArabicChar(param1,param2 + 1);
            }
         }
         return _loc4_;
      }
      
      private function validateSymbol(param1:String, param2:Number) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:Number = Number(param1.charCodeAt(param2));
         if(_loc4_ >= 32 && _loc4_ <= 47 || _loc4_ >= 58 && _loc4_ <= 63 || _loc4_ >= 91 && _loc4_ <= 93 || _loc4_ >= 123 && _loc4_ <= 126 || _loc4_ == 163 || _loc4_ == 171 || _loc4_ == 187 || _loc4_ == 1548 || _loc4_ == 8226 || _loc4_ == 9642 || _loc4_ == 10216 || _loc4_ == 10217)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function cleanString(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Number = param1.length;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1.charCodeAt(_loc4_) > 31 && param1.charCodeAt(_loc4_) != 127)
            {
               _loc2_ += param1.charAt(_loc4_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function removeLineBreaks(param1:String) : String
      {
         param1 = param1.split("<br />").join("\n");
         param1 = param1.split("<br>").join("\n");
         param1 = param1.split("<BR />").join("\n");
         return param1.split("<BR>").join("\n");
      }
      
      private function splitBulletList(param1:String) : String
      {
         param1 = param1.split("<ul>").join("");
         param1 = param1.split("</ul>").join("\n");
         param1 = param1.split("<li>").join("\n• ");
         return param1.split("</li>").join("");
      }
      
      private function flipBrackets(param1:String) : String
      {
         param1 = param1.split("[").join("#LSB#");
         param1 = param1.split("]").join("#RSB#");
         param1 = param1.split("{").join("#LCB#");
         param1 = param1.split("}").join("#RCB#");
         param1 = param1.split("(").join("#LPT#");
         param1 = param1.split(")").join("#RPT#");
         param1 = param1.split("#LSB#").join("]");
         param1 = param1.split("#RSB#").join("[");
         param1 = param1.split("#LCB#").join("}");
         param1 = param1.split("#RCB#").join("{");
         param1 = param1.split("#LPT#").join(")");
         return param1.split("#RPT#").join("(");
      }
      
      private function fixBugs(param1:String) : String
      {
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:Array = null;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:Object = null;
         var _loc11_:Boolean = false;
         var _loc15_:Number = NaN;
         var _loc2_:String = "";
         var _loc3_:Array = param1.split("\n");
         var _loc4_:Number = _loc3_.length;
         var _loc12_:String = "";
         var _loc13_:String = ", ";
         var _loc14_:Number = 0;
         while(_loc14_ < _loc4_)
         {
            _loc5_ = _loc3_[_loc14_];
            _loc6_ = _loc5_.length;
            if(!this.embedFonts)
            {
               if(_loc5_.charAt(0) == "•")
               {
                  _loc8_ = Number(_loc5_.charCodeAt(2));
                  _loc9_ = _loc8_ >= 1536 && _loc8_ <= 1791 || _loc8_ >= 65136 && _loc8_ <= 65279;
                  if(!_loc9_)
                  {
                     _loc5_ = _loc5_.slice(1,_loc5_.length) + " •";
                  }
               }
               _loc10_ = this.getSingleBracket(_loc5_);
               if(_loc10_.bracket)
               {
                  _loc7_ = _loc5_.split(_loc10_.bracket);
                  _loc11_ = _loc5_.charCodeAt(0) >= 1536 && _loc5_.charCodeAt(0) <= 1791 || _loc5_.charCodeAt(0) >= 65136 && _loc5_.charCodeAt(0) <= 65279;
                  if(!_loc11_ && !this.isNumeric(_loc5_.charAt(0)) && !_loc10_.closed)
                  {
                     _loc7_.splice(1,0,_loc10_.bracket);
                     _loc7_.splice(0,0,String.fromCharCode(65142));
                     _loc5_ = _loc7_.join("");
                  }
               }
            }
            _loc15_ = 0;
            while(_loc15_ < _loc6_)
            {
               if(this.isNumeric(_loc12_ + _loc5_.charAt(_loc15_)))
               {
                  _loc12_ += _loc5_.charAt(_loc15_);
               }
               _loc15_++;
            }
            if(_loc12_.indexOf(_loc13_) != -1)
            {
               _loc7_ = _loc12_.split(_loc13_);
               _loc7_.reverse();
               _loc5_ = _loc5_.split(_loc12_).join(_loc7_.join(_loc13_));
            }
            if(_loc2_ != "")
            {
               _loc2_ += "\n";
            }
            _loc2_ += _loc5_;
            _loc14_++;
         }
         return _loc2_;
      }
      
      private function getSingleBracket(param1:String) : Object
      {
         var _loc3_:Number = NaN;
         var _loc5_:String = null;
         var _loc2_:Number = param1.length;
         var _loc4_:Number = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Number = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = Number(param1.charCodeAt(_loc7_));
            if(_loc3_ == 40 || _loc3_ == 91 || _loc3_ == 123 || _loc3_ == 171 || _loc3_ == 10216 || _loc3_ == 41 || _loc3_ == 93 || _loc3_ == 125 || _loc3_ == 187 || _loc3_ == 10217)
            {
               _loc5_ = param1.charAt(_loc7_);
               if(_loc3_ == 41 || _loc3_ == 93 || _loc3_ == 125 || _loc3_ == 187 || _loc3_ == 10217)
               {
                  _loc6_ = true;
               }
               _loc4_++;
            }
            if(_loc4_ > 1)
            {
               _loc5_ = null;
               break;
            }
            _loc7_++;
         }
         return {
            "bracket":_loc5_,
            "closed":_loc6_
         };
      }
      
      private function getHTMLFormat(param1:String, param2:TextFormat) : String
      {
         var _loc3_:String = "<textformat leftmargin=\"" + (param2.leftMargin ? param2.leftMargin : 0) + "\" rightmargin=\"" + (param2.rightMargin ? param2.rightMargin : 0) + "\" leading=\"" + (param2.leading ? param2.leading : 0) + "\"><p align=\"" + (param2.align ? param2.align : "left") + "\"><font face=\"" + (param2.font ? param2.font : "Arial") + "\" color=\"" + (param2.color ? this.getProperColor(Number(param2.color)) : "#000000") + "\" size=\"" + (param2.size ? param2.size : 12) + "\" letterspacing=\"" + (param2.letterSpacing ? param2.letterSpacing : 0) + "\" kerning=\"" + (param2.kerning ? param2.kerning : 0) + "\">";
         _loc3_ += param1;
         return _loc3_ + "</font></p></textformat>";
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
      
      private function isNumeric(param1:String) : Boolean
      {
         return !isNaN(parseInt(param1));
      }
      
      private function convertNumbers(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:Number = 0;
         while(_loc3_ < param1.length)
         {
            switch(param1.charAt(_loc3_))
            {
               case "0":
                  _loc2_ += String.fromCharCode(1632);
                  break;
               case "1":
                  _loc2_ += String.fromCharCode(1633);
                  break;
               case "2":
                  _loc2_ += String.fromCharCode(1634);
                  break;
               case "3":
                  _loc2_ += String.fromCharCode(1635);
                  break;
               case "4":
                  _loc2_ += String.fromCharCode(1636);
                  break;
               case "5":
                  _loc2_ += String.fromCharCode(1637);
                  break;
               case "6":
                  _loc2_ += String.fromCharCode(1638);
                  break;
               case "7":
                  _loc2_ += String.fromCharCode(1639);
                  break;
               case "8":
                  _loc2_ += String.fromCharCode(1640);
                  break;
               case "9":
                  _loc2_ += String.fromCharCode(1641);
                  break;
               default:
                  _loc2_ += param1.charAt(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function createTemporaryTextField(param1:TextFormat) : TextField
      {
         var _loc2_:TextField = new TextField();
         _loc2_.width = 10;
         _loc2_.height = Number(param1.size) + 4;
         _loc2_.autoSize = TextFieldAutoSize.LEFT;
         _loc2_.embedFonts = true;
         _loc2_.selectable = false;
         return _loc2_;
      }
   }
}

