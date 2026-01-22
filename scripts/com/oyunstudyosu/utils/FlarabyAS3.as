package com.oyunstudyosu.utils
{
   import com.oyunstudyosu.events.ConvertEvent;
   import com.oyunstudyosu.events.DirEvent;
   import com.oyunstudyosu.events.ExtraWidthEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class FlarabyAS3 extends TextField
   {
      
      private const RLM:String = "";
      
      private const LRM:String = "";
      
      private var flarabyInitialized:Boolean;
      
      private var ar:Vector.<String>;
      
      private var arOrd:Array;
      
      private var sep:Vector.<String>;
      
      private var tashkeel:Vector.<String>;
      
      private var tashkeelNoEmbed:Vector.<String>;
      
      private var tashkeelEmbed:Vector.<String>;
      
      private var tashkeelNoEmbedOrd:Array;
      
      private var tashkeelEmbedOrd:Array;
      
      private var tashkeelNoEmbedOn:Boolean;
      
      private var tashkeelEmbedOn:Boolean;
      
      private var digitsPunc:Vector.<String>;
      
      private var enclosures:Vector.<String>;
      
      private var revEnclosures:Vector.<String>;
      
      private var specialPunc:Vector.<String>;
      
      private var supportedTags:Vector.<String>;
      
      private var _Lines:Array;
      
      private var originaldir:String;
      
      private var spaceWidth:Number;
      
      private var tFType:String;
      
      private var tFLimit:Number;
      
      private var tFormat:TextFormat;
      
      private var newlineChar:String;
      
      private var _html:Boolean;
      
      private var _dir:String;
      
      private var _xcharwidth:Number;
      
      public function FlarabyAS3()
      {
         super();
         if(this.flarabyInitialized == false)
         {
            this.ar = new Vector.<String>();
            this.ar[0] = String.fromCharCode(1575);
            this.ar[1] = String.fromCharCode(1571);
            this.ar[2] = String.fromCharCode(1573);
            this.ar[3] = String.fromCharCode(1570);
            this.ar[4] = String.fromCharCode(1576);
            this.ar[5] = String.fromCharCode(1578);
            this.ar[6] = String.fromCharCode(1577);
            this.ar[7] = String.fromCharCode(1579);
            this.ar[8] = String.fromCharCode(1580);
            this.ar[9] = String.fromCharCode(1581);
            this.ar[10] = String.fromCharCode(1582);
            this.ar[11] = String.fromCharCode(1583);
            this.ar[12] = String.fromCharCode(1584);
            this.ar[13] = String.fromCharCode(1585);
            this.ar[14] = String.fromCharCode(1586);
            this.ar[15] = String.fromCharCode(1587);
            this.ar[16] = String.fromCharCode(1588);
            this.ar[17] = String.fromCharCode(1589);
            this.ar[18] = String.fromCharCode(1590);
            this.ar[19] = String.fromCharCode(1591);
            this.ar[20] = String.fromCharCode(1592);
            this.ar[21] = String.fromCharCode(1593);
            this.ar[22] = String.fromCharCode(1594);
            this.ar[23] = String.fromCharCode(1601);
            this.ar[24] = String.fromCharCode(1602);
            this.ar[25] = String.fromCharCode(1603);
            this.ar[26] = String.fromCharCode(1604);
            this.ar[27] = String.fromCharCode(1605);
            this.ar[28] = String.fromCharCode(1606);
            this.ar[29] = String.fromCharCode(1607);
            this.ar[30] = String.fromCharCode(1608);
            this.ar[31] = String.fromCharCode(1572);
            this.ar[32] = String.fromCharCode(1610);
            this.ar[33] = String.fromCharCode(1609);
            this.ar[34] = String.fromCharCode(1574);
            this.ar[35] = String.fromCharCode(1569);
            this.ar[36] = String.fromCharCode(65275);
            this.ar[37] = String.fromCharCode(65273);
            this.ar[38] = String.fromCharCode(65271);
            this.ar[39] = String.fromCharCode(65269);
            this.ar[40] = String.fromCharCode(1600);
            this.ar[41] = String.fromCharCode(1649);
            this.arOrd = [[65165,65166,65165,65166],[65155,65156,65155,65156],[65159,65160,65159,65160],[65153,65154,65153,65154],[65167,65168,65169,65170],[65173,65174,65175,65176],[65171,65172,65171,65172],[65177,65178,65179,65180],[65181,65182,65183,65184],[65185,65186,65187,65188],[65189,65190,65191,65192],[65193,65194,65193,65194],[65195,65196,65195,65196],[65197,65198,65197,65198],[65199,65200,65199,65200],[65201,65202,65203,65204],[65205,65206,65207,65208],[65209,65210,65211,65212],[65213,65214,65215,65216],[65217,65218,65219,65220],[65221,65222,65223,65224],[65225,65226,65227,65228],[65229,65230,65231,65232],[65233,65234,65235,65236],[65237,65238,65239,65240],[65241,65242,65243,65244],[65245,65246,65247,65248],[65249,65250,65251,65252],[65253,65254,65255,65256],[65257,65258,65259,65260],[65261,65262,65261,65262],[65157,65158,65157,65158],[65265,65266,65267,65268],[65263,65264,65263,65264],[65161,65162,65163,65164],[65152,65152,65152,65152],[65275,65276,65275,65276],[65273,65274,65273,65274]
            ,[65271,65272,65271,65272],[65269,65270,65269,65270],[1600,1600,1600,1600],[64336,64337,64336,64337]];
            this.sep = new Vector.<String>();
            this.sep[0] = String.fromCharCode(1575);
            this.sep[1] = String.fromCharCode(1571);
            this.sep[2] = String.fromCharCode(1573);
            this.sep[3] = String.fromCharCode(1570);
            this.sep[4] = String.fromCharCode(1585);
            this.sep[5] = String.fromCharCode(1586);
            this.sep[6] = String.fromCharCode(1608);
            this.sep[7] = String.fromCharCode(1572);
            this.sep[8] = String.fromCharCode(1583);
            this.sep[9] = String.fromCharCode(1584);
            this.sep[10] = String.fromCharCode(1569);
            this.sep[11] = String.fromCharCode(65275);
            this.sep[12] = String.fromCharCode(65273);
            this.sep[13] = String.fromCharCode(65271);
            this.sep[14] = String.fromCharCode(65269);
            this.sep[15] = String.fromCharCode(1649);
            this.tashkeelNoEmbed = new Vector.<String>(9,true);
            this.tashkeelNoEmbed[0] = String.fromCharCode(1611);
            this.tashkeelNoEmbed[1] = String.fromCharCode(1612);
            this.tashkeelNoEmbed[2] = String.fromCharCode(1613);
            this.tashkeelNoEmbed[3] = String.fromCharCode(1614);
            this.tashkeelNoEmbed[4] = String.fromCharCode(1615);
            this.tashkeelNoEmbed[5] = String.fromCharCode(1616);
            this.tashkeelNoEmbed[6] = String.fromCharCode(1617);
            this.tashkeelNoEmbed[7] = String.fromCharCode(1618);
            this.tashkeelNoEmbed[8] = String.fromCharCode(1648);
            this.tashkeelNoEmbedOrd = [[1611,1611,1611,1611],[1612,1612,1612,1612],[1613,1613,1613,1613],[1614,1614,1614,1614],[1615,1615,1615,1615],[1616,1616,1616,1616],[1617,1617,1617,1617],[1618,1618,1618,1618],[1648,1648,1648,1648]];
            this.tashkeelEmbed = new Vector.<String>(15,true);
            this.tashkeelEmbed[0] = String.fromCharCode(1611);
            this.tashkeelEmbed[1] = String.fromCharCode(1612);
            this.tashkeelEmbed[2] = String.fromCharCode(1613);
            this.tashkeelEmbed[3] = String.fromCharCode(1614);
            this.tashkeelEmbed[4] = String.fromCharCode(1615);
            this.tashkeelEmbed[5] = String.fromCharCode(1616);
            this.tashkeelEmbed[6] = String.fromCharCode(1617);
            this.tashkeelEmbed[7] = String.fromCharCode(1618);
            this.tashkeelEmbed[8] = String.fromCharCode(1648);
            this.tashkeelEmbed[9] = String.fromCharCode(59416);
            this.tashkeelEmbed[10] = String.fromCharCode(64606);
            this.tashkeelEmbed[11] = String.fromCharCode(60511);
            this.tashkeelEmbed[12] = String.fromCharCode(64608);
            this.tashkeelEmbed[13] = String.fromCharCode(64609);
            this.tashkeelEmbed[14] = String.fromCharCode(64610);
            this.tashkeelEmbedOrd = [[65136,65136,65136,65137],[65138,65138,65138,65138],[65140,65140,65140,65140],[65142,65142,65142,65143],[65144,65144,65144,65145],[65146,65146,65146,65147],[65148,65148,65148,65149],[65150,65150,65150,65151],[1648,1648,1648,1648],[59416,59416,59416,59417],[64606,64606,64606,59424],[60511,60511,60511,59425],[64608,64608,64608,64754],[64609,64609,64609,64755],[64610,64610,64610,64756]];
            this.digitsPunc = new Vector.<String>(2,true);
            this.digitsPunc[0] = ",";
            this.digitsPunc[1] = ".";
            this.enclosures = new Vector.<String>(8,true);
            this.enclosures[0] = "(";
            this.enclosures[1] = ")";
            this.enclosures[2] = "[";
            this.enclosures[3] = "]";
            this.enclosures[4] = "{";
            this.enclosures[5] = "}";
            this.enclosures[6] = "«";
            this.enclosures[7] = "»";
            this.revEnclosures = new Vector.<String>(8,true);
            this.revEnclosures[0] = ")";
            this.revEnclosures[1] = "(";
            this.revEnclosures[2] = "]";
            this.revEnclosures[3] = "[";
            this.revEnclosures[4] = "}";
            this.revEnclosures[5] = "{";
            this.revEnclosures[6] = "»";
            this.revEnclosures[7] = "«";
            this.specialPunc = new Vector.<String>(1,true);
            this.specialPunc[0] = "!";
            this.autoSize = TextFieldAutoSize.RIGHT;
            this._dir = this._dir == null ? "RTL" : this._dir;
            this.flarabyInitialized = true;
         }
      }
      
      public function removeTashkeel(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         if(!this.tashkeelNoEmbedOn && !this.tashkeelEmbedOn)
         {
            this.checkTashkeel();
         }
         var _loc3_:String = "";
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1.charAt(_loc4_);
            if(this.tashkeel.indexOf(_loc2_) == -1)
            {
               _loc3_ += _loc2_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function convertArabicString(param1:String, param2:Number, param3:TextFormat) : String
      {
         var _loc4_:String = null;
         this.refreshComponent(param2,param3);
         param1 = this.addLafthEljalalah(param1);
         param1 = this.replaceDoubleChars(param1);
         param1 = this.replaceNewLines(param1);
         this.checkTashkeel();
         if(this.multiline)
         {
            _loc4_ = this.convertBetweenLines(param1);
         }
         else
         {
            _loc4_ = this.processArabicString(param1);
         }
         this[this.tFType] = "";
         dispatchEvent(new ConvertEvent("convert"));
         return _loc4_;
      }
      
      public function convertArabicChar(param1:int, param2:String) : String
      {
         var _local_6:String = null;
         var _local_7:Object = null;
         var _local_8:String = null;
         var p:int = param1;
         var str:String = param2;
         var _local_3:String = str.charAt(p);
         var _local_4:String = this.getPrevLetter(p - 1,str);
         var _local_5:String = this.getNextLetter(p + 1,str);
         try
         {
            if(!this.isArabic(_local_4) && this.isArabic(_local_5))
            {
               _local_7 = this.ar.indexOf(_local_3);
               _local_6 = String.fromCharCode(this.arOrd[_local_7][2]);
            }
            else if(!this.isArabic(_local_5) && this.isArabic(_local_4))
            {
               if(this.sep.indexOf(_local_4) != -1)
               {
                  _local_7 = this.ar.indexOf(_local_3);
                  _local_6 = String.fromCharCode(this.arOrd[_local_7][0]);
               }
               else
               {
                  _local_7 = this.ar.indexOf(_local_3);
                  _local_6 = String.fromCharCode(this.arOrd[_local_7][1]);
               }
            }
            else
            {
               _local_8 = String.fromCharCode(1569);
               if(_local_5 == _local_8)
               {
                  if(this.sep.indexOf(_local_4) != -1)
                  {
                     _local_7 = this.ar.indexOf(_local_3);
                     _local_6 = String.fromCharCode(this.arOrd[_local_7][0]);
                  }
                  else
                  {
                     _local_7 = this.ar.indexOf(_local_3);
                     _local_6 = String.fromCharCode(this.arOrd[_local_7][1]);
                  }
               }
               else if(!this.isArabic(_local_5) && !this.isArabic(_local_4))
               {
                  _local_7 = this.ar.indexOf(_local_3);
                  _local_6 = String.fromCharCode(this.arOrd[_local_7][0]);
               }
               else if(this.isArabic(_local_4) && this.sep.indexOf(_local_4) != -1)
               {
                  _local_7 = this.ar.indexOf(_local_3);
                  _local_6 = String.fromCharCode(this.arOrd[_local_7][2]);
               }
               else
               {
                  _local_7 = this.ar.indexOf(_local_3);
                  _local_6 = String.fromCharCode(this.arOrd[_local_7][3]);
               }
            }
         }
         catch(error:Error)
         {
            return "";
         }
         return _local_6;
      }
      
      public function isArabic(param1:String) : Boolean
      {
         var _loc2_:uint = uint(param1.charCodeAt(0));
         if(!isNaN(_loc2_))
         {
            if(_loc2_ >= 1569 && _loc2_ <= 1594 || _loc2_ >= 1600 && _loc2_ <= 1618 || _loc2_ == 1648 || _loc2_ == 1649 || _loc2_ == 65269 || _loc2_ == 65271 || _loc2_ == 65273 || _loc2_ == 65275)
            {
               return true;
            }
            if(this.embedFonts)
            {
               if(_loc2_ == 60511 || _loc2_ >= 64606 && _loc2_ <= 64610 || _loc2_ >= 65136 && _loc2_ <= 65151 || _loc2_ >= 64754 && _loc2_ <= 64756 || _loc2_ == 59416 || _loc2_ == 59417 || _loc2_ == 59424 || _loc2_ == 59425)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function isLatin(param1:String) : Boolean
      {
         var _loc2_:uint = uint(param1.charCodeAt(0));
         if(_loc2_ >= 65 && _loc2_ <= 90 || _loc2_ >= 97 && _loc2_ <= 122 || _loc2_ >= 192 && _loc2_ <= 246 || _loc2_ >= 248 && _loc2_ <= 255)
         {
            return true;
         }
         return false;
      }
      
      public function isDigit(param1:String) : Boolean
      {
         if(!isNaN(parseInt(param1)))
         {
            return true;
         }
         var _loc2_:uint = uint(param1.charCodeAt(0));
         if(_loc2_ >= 1632 && _loc2_ <= 1641)
         {
            return true;
         }
         return false;
      }
      
      public function isPunc(param1:String) : Boolean
      {
         if(this.isArabic(param1) || this.isLatin(param1) || this.isDigit(param1))
         {
            return false;
         }
         return true;
      }
      
      public function isTag(param1:String) : Boolean
      {
         if(param1.charAt(0) == "<" && param1.charAt(param1.length - 1) == ">")
         {
            return true;
         }
         return false;
      }
      
      public function removeTags(param1:String) : String
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         if(!this.isTag(param1))
         {
            return param1;
         }
         var _loc3_:String = "";
         while(_loc4_ < param1.length)
         {
            if(param1.charAt(_loc4_) == "<")
            {
               _loc2_ = true;
            }
            else if(param1.charAt(_loc4_) == ">")
            {
               _loc2_ = false;
            }
            else if(!_loc2_)
            {
               _loc3_ += param1.charAt(_loc4_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getStringWidth(param1:String) : Number
      {
         this[this.tFType] = param1;
         this.defaultTextFormat = this.tFormat;
         return this.textWidth + this._xcharwidth;
      }
      
      public function getCharArrWidth(param1:Array) : Number
      {
         var _loc3_:int = 0;
         var _loc2_:Number = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += this.getStringWidth(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function replaceNewLines(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = this._html || !this.multiline ? " " : "\n";
         _loc2_ = param1.split("\r\n");
         param1 = _loc2_.join(_loc3_);
         _loc2_ = param1.split("\r");
         param1 = _loc2_.join(_loc3_);
         if(this._html)
         {
            _loc3_ = this.multiline ? "<br>" : " ";
            _loc2_ = param1.split("<br>");
            param1 = _loc2_.join(_loc3_);
         }
         return param1;
      }
      
      public function getLines() : Array
      {
         return this._Lines;
      }
      
      public function get html() : Boolean
      {
         return this._html;
      }
      
      public function set html(param1:Boolean) : void
      {
         this._html = param1;
      }
      
      public function get dir() : String
      {
         return this._dir;
      }
      
      public function set dir(param1:String) : void
      {
         this._dir = param1;
         dispatchEvent(new DirEvent("dirChange"));
      }
      
      public function get extraCharWidth() : Number
      {
         return this._xcharwidth;
      }
      
      public function set extraCharWidth(param1:Number) : void
      {
         this._xcharwidth = param1;
         dispatchEvent(new ExtraWidthEvent("extraWidthChange"));
      }
      
      private function refreshComponent(param1:Number, param2:TextFormat) : void
      {
         var _loc3_:Number = NaN;
         this.tFType = this._html ? "htmlText" : "text";
         this.tFormat = param2;
         this.tFormat.align = null;
         if(this.multiline)
         {
            _loc3_ = Number(this.tFormat.size);
            this.extraCharWidth = isNaN(this._xcharwidth) ? (_loc3_ < 27 ? 0.1 : (_loc3_ < 43 ? 0.4 : (_loc3_ < 49 ? 0.8 : 1.2))) : this._xcharwidth;
            this.spaceWidth = this.getStringWidth(" ");
            this.tFLimit = param1;
         }
         if(this._html)
         {
            this.newlineChar = "<br>";
            this.supportedTags = new Vector.<String>(3,true);
            this.supportedTags[0] = "<f";
            this.supportedTags[1] = "<a";
            this.supportedTags[2] = "<u";
         }
         else
         {
            this.newlineChar = "\n";
         }
         this._Lines = [];
      }
      
      private function checkTashkeel() : void
      {
         if(this.embedFonts)
         {
            if(this.tashkeelNoEmbedOn)
            {
               this.removeTashkeelNoEmbed();
            }
            if(!this.tashkeelEmbedOn)
            {
               this.addTashkeelEmbed();
            }
         }
         else
         {
            if(this.tashkeelEmbedOn)
            {
               this.removeTashkeelEmbed();
            }
            if(!this.tashkeelNoEmbedOn)
            {
               this.addTashkeelNoEmbed();
            }
         }
      }
      
      private function addLafthEljalalah(param1:String) : String
      {
         return param1;
      }
      
      private function replaceDoubleChars(param1:String) : String
      {
         var _loc2_:Array = null;
         _loc2_ = param1.split(String.fromCharCode(1604,1575));
         param1 = _loc2_.join(String.fromCharCode(65275));
         _loc2_ = param1.split(String.fromCharCode(1604,1573));
         param1 = _loc2_.join(String.fromCharCode(65273));
         _loc2_ = param1.split(String.fromCharCode(1604,1571));
         param1 = _loc2_.join(String.fromCharCode(65271));
         _loc2_ = param1.split(String.fromCharCode(1604,1570));
         param1 = _loc2_.join(String.fromCharCode(65269));
         if(this.embedFonts)
         {
            _loc2_ = param1.split(String.fromCharCode(1617,1611));
            param1 = _loc2_.join(String.fromCharCode(59416));
            _loc2_ = param1.split(String.fromCharCode(1617,1612));
            param1 = _loc2_.join(String.fromCharCode(64606));
            _loc2_ = param1.split(String.fromCharCode(1617,1613));
            param1 = _loc2_.join(String.fromCharCode(60511));
            _loc2_ = param1.split(String.fromCharCode(1617,1614));
            param1 = _loc2_.join(String.fromCharCode(64608));
            _loc2_ = param1.split(String.fromCharCode(1617,1615));
            param1 = _loc2_.join(String.fromCharCode(64609));
            _loc2_ = param1.split(String.fromCharCode(1617,1616));
            param1 = _loc2_.join(String.fromCharCode(64610));
         }
         return param1;
      }
      
      private function addTashkeelNoEmbed() : void
      {
         this.ar = this.ar.concat(this.tashkeelNoEmbed);
         this.arOrd = this.arOrd.concat(this.tashkeelNoEmbedOrd);
         this.tashkeel = this.tashkeelNoEmbed;
         this.tashkeelNoEmbedOn = true;
      }
      
      private function removeTashkeelNoEmbed() : void
      {
         var _loc1_:uint = 0;
         while(this.ar.length > 0)
         {
            _loc1_ = uint(this.ar[this.ar.length - 1].charCodeAt(0));
            if(!(_loc1_ >= 1611 && _loc1_ <= 1618 || _loc1_ == 1648))
            {
               break;
            }
            this.ar.pop();
            this.arOrd.pop();
         }
         this.tashkeelNoEmbedOn = false;
      }
      
      private function addTashkeelEmbed() : void
      {
         this.ar = this.ar.concat(this.tashkeelEmbed);
         this.arOrd = this.arOrd.concat(this.tashkeelEmbedOrd);
         this.tashkeel = this.tashkeelEmbed;
         this.tashkeelEmbedOn = true;
      }
      
      private function removeTashkeelEmbed() : void
      {
         var _loc1_:uint = 0;
         while(this.ar.length > 0)
         {
            _loc1_ = uint(this.ar[this.ar.length - 1].charCodeAt(0));
            if(!(_loc1_ == 1648 || _loc1_ == 60511 || _loc1_ >= 64606 && _loc1_ <= 64610 || _loc1_ >= 65136 && _loc1_ <= 65151 || _loc1_ >= 64754 && _loc1_ <= 64756))
            {
               break;
            }
            this.ar.pop();
            this.arOrd.pop();
         }
         this.tashkeelEmbedOn = false;
      }
      
      private function convertBetweenLines(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         _loc2_ = param1.split(this.newlineChar);
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = this.processArabicString(_loc2_[_loc5_]);
            _loc4_.push(_loc3_);
            _loc5_++;
         }
         return _loc4_.join(this.newlineChar);
      }
      
      private function processArabicString(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc24_:Boolean = false;
         var _loc25_:Boolean = false;
         var _loc28_:int = 0;
         var _loc29_:RegExp = null;
         var _loc14_:Array = [];
         var _loc15_:Array = [];
         var _loc16_:Array = [];
         var _loc17_:Array = [];
         var _loc20_:Object = -1;
         var _loc21_:Number = 0;
         var _loc22_:Array = [];
         var _loc23_:Array = [];
         var _loc26_:Array = [];
         var _loc27_:int = -1;
         for(; _loc28_ < param1.length; _loc28_++)
         {
            _loc2_ = param1.charAt(_loc28_);
            if(_loc2_ == String.fromCharCode(1563) || _loc2_ == String.fromCharCode(1567))
            {
               if(this.multiline)
               {
                  if(_loc21_ > this.tFLimit)
                  {
                     if(_loc24_)
                     {
                        _loc16_ = _loc18_ != -1 ? _loc22_.slice(_loc22_.length - _loc18_,_loc22_.length) : [];
                        _loc17_ = _loc18_ != -1 ? _loc22_.slice(0,_loc22_.length - _loc18_ - 1) : _loc22_;
                        if(this._dir == "RTL")
                        {
                           _loc15_ = _loc16_.concat(_loc15_);
                        }
                        else
                        {
                           _loc15_ = _loc15_.concat(_loc16_);
                        }
                     }
                     else if(_loc25_)
                     {
                        _loc16_ = _loc19_ != -1 ? _loc23_.slice(0,_loc19_) : [];
                        _loc17_ = _loc19_ != -1 ? _loc23_.slice(_loc19_,_loc23_.length) : _loc23_;
                        if(this._dir == "RTL")
                        {
                           _loc15_ = _loc16_.concat(_loc15_);
                        }
                        else
                        {
                           _loc15_ = _loc15_.concat(_loc16_);
                        }
                     }
                     _loc14_.push(_loc15_.join(""));
                     _loc22_ = _loc24_ ? _loc17_ : [];
                     _loc23_ = _loc25_ ? _loc17_ : [];
                     _loc15_ = [];
                     _loc21_ = this.getCharArrWidth(_loc17_) + this.getStringWidth(_loc2_);
                  }
                  else
                  {
                     _loc21_ += this.getStringWidth(_loc2_);
                  }
               }
               if(this._html)
               {
                  _loc2_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc2_ + this.getTagsList(_loc26_,"cl") : _loc2_;
               }
               if(_loc24_)
               {
                  _loc22_.unshift(_loc2_);
               }
               else if(_loc25_)
               {
                  _loc23_.push(_loc2_);
               }
            }
            else
            {
               if(this._html)
               {
                  if(_loc2_ == "<")
                  {
                     _loc3_ = this.getTag(_loc28_,param1);
                     _loc28_ += _loc3_.length - 1;
                     if(_loc3_.charAt(1) == "/")
                     {
                        _loc26_.pop();
                        _loc27_--;
                     }
                     else
                     {
                        _loc4_ = this.getCloseTag(_loc3_);
                        _loc26_.push({
                           "op":_loc3_,
                           "cl":_loc4_
                        });
                        _loc27_++;
                     }
                     continue;
                  }
               }
               if(this.isArabic(_loc2_))
               {
                  if(_loc20_ != -1)
                  {
                     _loc22_ = [_loc20_];
                     _loc20_ = -1;
                  }
                  _loc2_ = this.convertArabicChar(_loc28_,param1);
                  if(_loc25_)
                  {
                     if(this._dir == "RTL")
                     {
                        _loc15_ = _loc23_.concat(_loc15_);
                     }
                     else
                     {
                        _loc15_ = _loc15_.concat(_loc23_);
                     }
                  }
                  if(this.multiline)
                  {
                     if(_loc21_ > this.tFLimit)
                     {
                        if(_loc25_)
                        {
                           _loc16_ = _loc19_ != -1 ? _loc23_.slice(0,_loc19_) : [];
                           _loc17_ = _loc19_ != -1 ? _loc23_.slice(_loc19_,_loc23_.length) : _loc23_;
                        }
                        else if(_loc24_)
                        {
                           _loc16_ = _loc18_ != -1 ? _loc22_.slice(_loc22_.length - _loc18_,_loc22_.length) : [];
                           _loc17_ = _loc18_ != -1 ? _loc22_.slice(0,_loc22_.length - _loc18_ - 1) : _loc22_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        _loc14_.push(_loc15_.join(""));
                        _loc22_ = _loc24_ ? _loc17_ : [];
                        _loc15_ = [];
                        _loc21_ = this.getCharArrWidth(_loc17_) + this.getStringWidth(_loc2_);
                     }
                     else
                     {
                        _loc21_ += this.getStringWidth(_loc2_);
                     }
                  }
                  _loc23_ = [];
                  _loc25_ = false;
                  _loc24_ = true;
                  if(this._html)
                  {
                     _loc2_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc2_ + this.getTagsList(_loc26_,"cl") : _loc2_;
                  }
                  _loc22_.unshift(_loc2_);
               }
               else if(this.isLatin(_loc2_))
               {
                  if(_loc20_ != -1)
                  {
                     _loc23_ = [_loc20_];
                     _loc20_ = -1;
                  }
                  if(_loc24_)
                  {
                     if(this._dir == "RTL")
                     {
                        _loc15_ = _loc22_.concat(_loc15_);
                     }
                     else
                     {
                        _loc15_ = _loc15_.concat(_loc22_);
                     }
                  }
                  if(this.multiline)
                  {
                     if(_loc21_ > this.tFLimit)
                     {
                        if(_loc24_)
                        {
                           _loc16_ = _loc18_ != -1 ? _loc22_.slice(_loc22_.length - _loc18_,_loc22_.length) : [];
                           _loc17_ = _loc18_ != -1 ? _loc22_.slice(0,_loc22_.length - _loc18_ - 1) : _loc22_;
                        }
                        else if(_loc25_)
                        {
                           _loc16_ = _loc19_ != -1 ? _loc23_.slice(0,_loc19_) : [];
                           _loc17_ = _loc19_ != -1 ? _loc23_.slice(_loc19_,_loc23_.length) : _loc23_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        _loc14_.push(_loc15_.join(""));
                        _loc23_ = _loc25_ ? _loc17_ : [];
                        _loc15_ = [];
                        _loc21_ = this.getCharArrWidth(_loc17_) + this.getStringWidth(_loc2_);
                     }
                     else
                     {
                        _loc21_ += this.getStringWidth(_loc2_);
                     }
                  }
                  _loc22_ = [];
                  _loc24_ = false;
                  _loc25_ = true;
                  if(this._html)
                  {
                     _loc2_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc2_ + this.getTagsList(_loc26_,"cl") : _loc2_;
                  }
                  _loc23_.push(_loc2_);
               }
               else if(this.isDigit(_loc2_))
               {
                  _loc5_ = _loc28_;
                  _loc6_ = "";
                  _loc8_ = _loc5_;
                  while(_loc8_ < param1.length)
                  {
                     _loc9_ = param1.charAt(_loc8_);
                     if(!(this.isDigit(_loc9_) || this.digitsPunc.indexOf(_loc9_) != -1 && this.isDigit(param1.charAt(_loc8_ + 1))))
                     {
                        if(this.isArabic(_loc9_))
                        {
                           _loc7_ = "a";
                        }
                        else if(this.isLatin(_loc9_))
                        {
                           _loc7_ = "l";
                        }
                        else
                        {
                           _loc7_ = "p";
                        }
                        _loc28_--;
                        break;
                     }
                     _loc6_ += _loc9_;
                     _loc28_++;
                     _loc8_++;
                  }
                  if(this.multiline)
                  {
                     if(_loc21_ > this.tFLimit)
                     {
                        if(_loc24_)
                        {
                           _loc16_ = _loc18_ != -1 ? _loc22_.slice(_loc22_.length - _loc18_,_loc22_.length) : [];
                           _loc17_ = _loc18_ != -1 ? _loc22_.slice(0,_loc22_.length - _loc18_ - 1) : _loc22_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        else if(_loc25_)
                        {
                           _loc16_ = _loc19_ != -1 ? _loc23_.slice(0,_loc19_) : [];
                           _loc17_ = _loc19_ != -1 ? _loc23_.slice(_loc19_,_loc23_.length) : _loc23_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        _loc14_.push(_loc15_.join(""));
                        _loc22_ = _loc24_ ? _loc17_ : [];
                        _loc23_ = _loc25_ ? _loc17_ : [];
                        _loc15_ = [];
                        _loc21_ = this.getCharArrWidth(_loc17_) + this.getStringWidth(_loc6_);
                     }
                     else
                     {
                        _loc21_ += this.getStringWidth(_loc6_);
                     }
                  }
                  if(this._html)
                  {
                     _loc6_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc6_ + this.getTagsList(_loc26_,"cl") : _loc6_;
                  }
                  if(_loc24_)
                  {
                     if(this._dir == "RTL")
                     {
                        if(_loc7_ == "l")
                        {
                           _loc20_ = _loc6_;
                        }
                        else
                        {
                           _loc22_.unshift(_loc6_);
                        }
                     }
                     else
                     {
                        _loc22_.unshift(_loc6_);
                     }
                  }
                  else if(_loc25_)
                  {
                     if(this._dir == "RTL")
                     {
                        _loc23_.push(_loc6_);
                     }
                     else if(_loc7_ == "a")
                     {
                        _loc20_ = _loc6_;
                     }
                     else
                     {
                        _loc23_.push(_loc6_);
                     }
                  }
                  else
                  {
                     _loc20_ = _loc6_;
                  }
               }
               else
               {
                  if(this.multiline)
                  {
                     if(_loc21_ > this.tFLimit)
                     {
                        if(_loc24_)
                        {
                           _loc16_ = _loc18_ != -1 ? _loc22_.slice(_loc22_.length - _loc18_,_loc22_.length) : [];
                           _loc17_ = _loc18_ != -1 ? _loc22_.slice(0,_loc22_.length - _loc18_ - 1) : _loc22_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        else if(_loc25_)
                        {
                           _loc16_ = _loc19_ != -1 ? _loc23_.slice(0,_loc19_) : [];
                           _loc17_ = _loc19_ != -1 ? _loc23_.slice(_loc19_,_loc23_.length) : _loc23_;
                           if(this._dir == "RTL")
                           {
                              _loc15_ = _loc16_.concat(_loc15_);
                           }
                           else
                           {
                              _loc15_ = _loc15_.concat(_loc16_);
                           }
                        }
                        _loc14_.push(_loc15_.join(""));
                        _loc22_ = _loc24_ ? _loc17_ : [];
                        _loc23_ = _loc25_ ? _loc17_ : [];
                        _loc15_ = [];
                        _loc21_ = this.getCharArrWidth(_loc17_) + (_loc2_ == " " ? this.spaceWidth : this.getStringWidth(_loc2_));
                     }
                     else
                     {
                        _loc21_ += _loc2_ == " " ? this.spaceWidth : this.getStringWidth(_loc2_);
                     }
                     if(_loc2_ == " ")
                     {
                        if(_loc24_)
                        {
                           _loc18_ = int(_loc22_.length);
                           _loc19_ = -1;
                        }
                        else if(_loc25_)
                        {
                           _loc19_ = int(_loc23_.length);
                           _loc18_ = -1;
                        }
                     }
                  }
                  _loc10_ = int(this.enclosures.indexOf(_loc2_));
                  _loc11_ = this.getPrevLetterType(_loc28_,param1);
                  _loc12_ = this.getNextLetterType(_loc28_,param1,true);
                  _loc13_ = this.getNextLetterType(_loc28_,param1,false);
                  if(this._dir == "LTR" && this.specialPunc.indexOf(_loc2_) != -1)
                  {
                     if(_loc11_ == "ar")
                     {
                        _loc2_ += this.RLM;
                     }
                  }
                  if(_loc11_ == "no")
                  {
                     if(_loc20_ != -1)
                     {
                        if(this._dir == "RTL")
                        {
                           _loc15_.unshift(_loc20_);
                        }
                        else
                        {
                           _loc15_.push(_loc20_);
                        }
                        _loc20_ = -1;
                     }
                  }
                  if(_loc12_ == "dg")
                  {
                     _loc12_ = _loc11_;
                  }
                  if(_loc10_ !== -1)
                  {
                     if(_loc11_ == "ar" && _loc12_ == "ar")
                     {
                        _loc2_ = this.revEnclosures[_loc10_];
                     }
                     else if(_loc11_ == "no" || _loc13_ == "no")
                     {
                        if(this._dir == "RTL")
                        {
                           _loc2_ = this.revEnclosures[_loc10_];
                        }
                     }
                     else if(_loc10_ % 2 == 0)
                     {
                        if(this._dir == "RTL")
                        {
                           if(_loc11_ == "ar" && _loc12_ != "ar" || _loc11_ != "ar" && _loc12_ == "ar")
                           {
                              _loc2_ = this.revEnclosures[_loc10_];
                           }
                        }
                     }
                     else if(this._dir == "RTL")
                     {
                        if(_loc11_ == "en" && _loc13_ != "en" || _loc11_ == "ar" && _loc13_ != "ar")
                        {
                           _loc2_ = this.revEnclosures[_loc10_];
                        }
                     }
                  }
                  if(_loc11_ == _loc12_)
                  {
                     if(this._html)
                     {
                        _loc2_ = _loc26_[_loc27_] != null && _loc2_ == " " ? (_loc11_ == "ar" ? this.RLM : this.LRM) + _loc2_ + (_loc12_ == "ar" ? this.RLM : this.LRM) : _loc2_;
                        _loc2_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc2_ + this.getTagsList(_loc26_,"cl") : _loc2_;
                     }
                     if(_loc24_)
                     {
                        _loc22_.unshift(_loc2_);
                     }
                     else if(_loc25_)
                     {
                        _loc23_.push(_loc2_);
                     }
                     else if(this._dir == "RTL")
                     {
                        _loc15_.unshift(_loc2_);
                     }
                     else
                     {
                        _loc15_.push(_loc2_);
                     }
                  }
                  else
                  {
                     if(_loc24_ || !_loc25_)
                     {
                        if(this._dir == "RTL")
                        {
                           _loc15_ = _loc22_.concat(_loc15_);
                        }
                        else
                        {
                           _loc15_ = _loc15_.concat(_loc22_);
                        }
                        _loc22_ = [];
                     }
                     else if(_loc25_)
                     {
                        if(this._dir == "RTL")
                        {
                           _loc15_ = _loc23_.concat(_loc15_);
                        }
                        else
                        {
                           _loc15_ = _loc15_.concat(_loc23_);
                        }
                        _loc23_ = [];
                     }
                     if(this._html)
                     {
                        _loc2_ = _loc26_[_loc27_] != null && _loc2_ == " " ? (_loc11_ == "ar" ? this.RLM : this.LRM) + _loc2_ + (_loc12_ == "ar" ? this.RLM : this.LRM) : _loc2_;
                        _loc2_ = _loc26_[_loc27_] != null ? this.getTagsList(_loc26_,"op") + _loc2_ + this.getTagsList(_loc26_,"cl") : _loc2_;
                     }
                     if(this._dir == "RTL")
                     {
                        _loc15_.unshift(_loc2_);
                     }
                     else
                     {
                        _loc15_.push(_loc2_);
                     }
                  }
               }
            }
         }
         if(_loc22_.length > 0)
         {
            if(this._dir == "RTL")
            {
               _loc15_ = _loc22_.concat(_loc15_);
            }
            else
            {
               _loc15_ = _loc15_.concat(_loc22_);
            }
         }
         else if(_loc23_.length > 0)
         {
            if(this._dir == "RTL")
            {
               _loc15_ = _loc23_.concat(_loc15_);
            }
            else
            {
               _loc15_ = _loc15_.concat(_loc23_);
            }
         }
         else if(_loc20_ != -1)
         {
            if(this._dir == "RTL")
            {
               _loc15_.unshift(_loc20_);
            }
            else
            {
               _loc15_.push(_loc20_);
            }
            _loc20_ = -1;
         }
         _loc14_.push(_loc15_.join(""));
         this._Lines = this._Lines.concat(_loc14_);
         if(_loc14_.length > 1)
         {
            param1 = _loc14_.join(this.newlineChar);
            _loc29_ = /(<br[\s|\/]*>){2}/gi;
            return param1.replace(_loc29_,"");
         }
         return _loc14_[0];
      }
      
      private function getPrevLetter(param1:int, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = param1;
         for(; _loc5_ >= 0; _loc5_--)
         {
            _loc3_ = param2.charAt(_loc5_);
            if(this._html)
            {
               if(_loc3_ == ">")
               {
                  _loc4_ = true;
                  continue;
               }
               if(_loc3_ == "<")
               {
                  _loc4_ = false;
                  continue;
               }
            }
            if(!_loc4_ && this.tashkeel.indexOf(_loc3_) == -1)
            {
               return _loc3_;
            }
         }
         return "";
      }
      
      private function getNextLetter(param1:int, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:int = param1;
         for(; _loc5_ < param2.length; _loc5_++)
         {
            _loc3_ = param2.charAt(_loc5_);
            if(this._html)
            {
               if(_loc3_ == "<")
               {
                  _loc4_ = true;
                  continue;
               }
               if(_loc3_ == ">")
               {
                  _loc4_ = false;
                  continue;
               }
            }
            if(!_loc4_ && this.tashkeel.indexOf(_loc3_) == -1)
            {
               return _loc3_;
            }
         }
         return "";
      }
      
      private function getPrevLetterType(param1:int, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         if(param1 == 0)
         {
            return "no";
         }
         var _loc5_:int = param1 - 1;
         for(; _loc5_ >= 0; _loc5_--)
         {
            _loc3_ = param2.charAt(_loc5_);
            if(this._html)
            {
               if(_loc3_ == ">")
               {
                  _loc4_ = true;
                  continue;
               }
               if(_loc3_ == "<")
               {
                  _loc4_ = false;
                  continue;
               }
            }
            if(!_loc4_)
            {
               if(this.isLatin(_loc3_) || _loc3_ == this.LRM)
               {
                  return "en";
               }
               if(this.isArabic(_loc3_) || _loc3_ == this.RLM)
               {
                  return "ar";
               }
            }
         }
         return "no";
      }
      
      private function getNextLetterType(param1:int, param2:String, param3:Boolean) : String
      {
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         if(param1 == param2.length - 1)
         {
            return "no";
         }
         var _loc6_:int = param1 + 1;
         for(; _loc6_ < param2.length; _loc6_++)
         {
            _loc4_ = param2.charAt(_loc6_);
            if(this._html)
            {
               if(_loc4_ == "<")
               {
                  _loc5_ = true;
                  continue;
               }
               if(_loc4_ == ">")
               {
                  _loc5_ = false;
                  continue;
               }
            }
            if(!_loc5_)
            {
               if(this.isLatin(_loc4_) || _loc4_ == this.LRM)
               {
                  return "en";
               }
               if(this.isArabic(_loc4_) || _loc4_ == this.RLM)
               {
                  return "ar";
               }
               if(param3)
               {
                  if(this.isDigit(_loc4_))
                  {
                     return "dg";
                  }
               }
            }
         }
         return "no";
      }
      
      private function getTag(param1:int, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = "";
         var _loc5_:int = param1;
         while(_loc5_ < param2.length)
         {
            _loc3_ = param2.charAt(_loc5_);
            _loc4_ += _loc3_;
            if(_loc3_ == ">")
            {
               break;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function getCloseTag(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         _loc2_ = param1.split(" ");
         if(_loc2_.length > 1)
         {
            _loc3_ = "</" + _loc2_[0].substr(1) + ">";
         }
         else
         {
            _loc3_ = "</" + _loc2_[0].substr(1);
         }
         return _loc3_;
      }
      
      private function getTagsList(param1:Array, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = "";
         while(_loc4_ < param1.length)
         {
            if(param2 == "op")
            {
               _loc3_ += param1[_loc4_][param2];
            }
            else
            {
               _loc3_ = param1[_loc4_][param2] + _loc3_;
            }
            _loc4_++;
         }
         return _loc3_;
      }
   }
}

