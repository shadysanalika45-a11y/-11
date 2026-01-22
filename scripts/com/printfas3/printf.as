package com.printfas3
{
   public function printf(param1:String, ... rest) : String
   {
      var _loc6_:Match = null;
      var _loc11_:* = undefined;
      var _loc12_:String = null;
      var _loc13_:String = null;
      var _loc14_:String = null;
      var _loc15_:String = null;
      var _loc16_:int = 0;
      var _loc17_:String = null;
      var _loc19_:Match = null;
      var _loc21_:String = null;
      var _loc22_:Number = NaN;
      var _loc3_:RegExp = /%(?!^%)(\((?P<var_name>[\w]+[\w_\d]+)\))?(?P<padding>[0-9]{1,2})?(\.(?P<precision>[0-9]+))?(?P<formater>[sxofaAbBcdHIjmMpSUwWxXyYZ])/ig;
      if(param1 == null)
      {
         return "";
      }
      var _loc4_:Array = [];
      var _loc5_:Object = _loc3_.exec(param1);
      var _loc7_:int = 0;
      var _loc8_:int = 0;
      var _loc9_:int = int(rest.length);
      var _loc10_:* = !Boolean(param1.match(/%\(\s*[\w\d_]+\s*\)/));
      while(Boolean(_loc5_))
      {
         _loc6_ = new Match();
         _loc6_.startIndex = _loc5_.index;
         _loc6_.length = String(_loc5_[0]).length;
         _loc6_.endIndex = _loc6_.startIndex + _loc6_.length;
         _loc6_.content = String(_loc5_[0]);
         _loc12_ = _loc5_.formater;
         _loc13_ = _loc5_.var_name;
         _loc14_ = _loc5_.precision;
         _loc15_ = _loc5_.padding;
         if(_loc15_)
         {
            if(_loc15_.length == 1)
            {
               _loc16_ = int(_loc15_);
               _loc17_ = " ";
            }
            else
            {
               _loc16_ = int(_loc15_.substr(-1,1));
               _loc17_ = _loc15_.substr(-2,1);
               if(_loc17_ != "0")
               {
                  _loc16_ *= int(_loc17_);
                  _loc17_ = " ";
               }
            }
         }
         if(_loc10_)
         {
            _loc11_ = rest[_loc4_.length];
         }
         else
         {
            _loc11_ = rest[0] == null ? undefined : rest[0][_loc13_];
         }
         if(_loc11_ == undefined)
         {
            _loc11_ = "";
         }
         if(_loc11_ != undefined)
         {
            if(_loc12_ == STRING_FORMATTER)
            {
               _loc6_.replacement = padString(_loc11_.toString(),_loc16_,_loc17_);
            }
            else if(_loc12_ == FLOAT_FORMATER)
            {
               if(_loc14_)
               {
                  _loc6_.replacement = padString(Number(_loc11_).toFixed(int(_loc14_)),_loc16_,_loc17_);
               }
               else
               {
                  _loc6_.replacement = padString(_loc11_.toString(),_loc16_,_loc17_);
               }
            }
            else if(_loc12_ == INTEGER_FORMATER)
            {
               _loc6_.replacement = padString(int(_loc11_).toString(),_loc16_,_loc17_);
            }
            else if(_loc12_ == OCTAL_FORMATER)
            {
               _loc6_.replacement = "0" + int(_loc11_).toString(8);
            }
            else if(_loc12_ == HEXA_FORMATER)
            {
               _loc6_.replacement = "0x" + int(_loc11_).toString(16);
            }
            else if(DATES_FORMATERS.indexOf(_loc12_) > -1)
            {
               switch(_loc12_)
               {
                  case DATE_DAY_FORMATTER:
                     _loc6_.replacement = _loc11_.date;
                     break;
                  case DATE_FULLYEAR_FORMATTER:
                     _loc6_.replacement = _loc11_.fullYear;
                     break;
                  case DATE_YEAR_FORMATTER:
                     _loc6_.replacement = _loc11_.fullYear.toString().substr(2,2);
                     break;
                  case DATE_MONTH_FORMATTER:
                     _loc6_.replacement = _loc11_.month + 1;
                     break;
                  case DATE_HOUR24_FORMATTER:
                     _loc6_.replacement = _loc11_.hours;
                     break;
                  case DATE_HOUR_FORMATTER:
                     _loc22_ = Number(_loc11_.hours);
                     _loc6_.replacement = (_loc22_ - 12).toString();
                     break;
                  case DATE_HOUR_AMPM_FORMATTER:
                     _loc6_.replacement = _loc11_.hours >= 12 ? "p.m" : "a.m";
                     break;
                  case DATE_TOLOCALE_FORMATTER:
                     _loc6_.replacement = _loc11_.toLocaleString();
                     break;
                  case DATE_MINUTES_FORMATTER:
                     _loc6_.replacement = _loc11_.minutes;
                     break;
                  case DATE_SECONDS_FORMATTER:
                     _loc6_.replacement = _loc11_.seconds;
               }
            }
            _loc4_.push(_loc6_);
         }
         if(++_loc7_ > 10000)
         {
            break;
         }
         _loc8_++;
         _loc5_ = _loc3_.exec(param1);
      }
      if(_loc4_.length == 0)
      {
         return param1;
      }
      var _loc18_:Array = [];
      var _loc20_:String = param1.substr(0,_loc4_[0].startIndex);
      for each(_loc6_ in _loc4_)
      {
         if(_loc19_)
         {
            _loc20_ = param1.substring(_loc19_.endIndex,_loc6_.startIndex);
         }
         _loc18_.push(_loc20_);
         _loc18_.push(_loc6_.replacement);
         _loc19_ = _loc6_;
      }
      _loc18_.push(param1.substr(_loc6_.endIndex,param1.length - _loc6_.endIndex));
      return _loc18_.join("");
   }
}

class Match
{
   
   public var startIndex:int;
   
   public var endIndex:int;
   
   public var length:int;
   
   public var content:String;
   
   public var replacement:String;
   
   public var before:String;
   
   public function Match()
   {
      super();
   }
   
   public function toString() : String
   {
      return "Match [" + this.startIndex + " - " + this.endIndex + "] (" + this.length + ") " + this.content + ", replacement:" + this.replacement + ";";
   }
}

function padString(param1:String, param2:int, param3:String = " "):String
{
   var _loc4_:int = 0;
   if(param3 == null)
   {
      return param1;
   }
   var _loc5_:Array = [];
   _loc4_ = 0;
   while(_loc4_ < Math.abs(param2) - param1.length)
   {
      _loc5_.push(param3);
      _loc4_++;
   }
   if(param2 < 0)
   {
      _loc5_.unshift(param1);
   }
   else
   {
      _loc5_.push(param1);
   }
   return _loc5_.join("");
}
const BAD_VARIABLE_NUMBER:String = "The number of variables to be replaced and template holes don\'t match";

const STRING_FORMATTER:String = "s";

const FLOAT_FORMATER:String = "f";

const INTEGER_FORMATER:String = "d";

const OCTAL_FORMATER:String = "o";

const HEXA_FORMATER:String = "x";

const DATES_FORMATERS:String = "aAbBcDHIjmMpSUwWxXyYZ";

const DATE_DAY_FORMATTER:String = "D";

const DATE_FULLYEAR_FORMATTER:String = "Y";

const DATE_YEAR_FORMATTER:String = "y";

const DATE_MONTH_FORMATTER:String = "m";

const DATE_HOUR24_FORMATTER:String = "H";

const DATE_HOUR_FORMATTER:String = "I";

const DATE_HOUR_AMPM_FORMATTER:String = "p";

const DATE_MINUTES_FORMATTER:String = "M";

const DATE_SECONDS_FORMATTER:String = "S";

const DATE_TOLOCALE_FORMATTER:String = "c";

var version:String = "$Id$";

