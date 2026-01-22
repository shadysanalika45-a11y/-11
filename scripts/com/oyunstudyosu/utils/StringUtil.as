package com.oyunstudyosu.utils
{
   import com.oyunstudyosu.local.$;
   import com.printfas3.printf;
   
   public class StringUtil
   {
      
      public function StringUtil()
      {
         super();
      }
      
      public static function getTimeString(param1:int) : String
      {
         return int(param1 / 1000) + "." + param1 % 1000 + "s";
      }
      
      public static function getRPString(param1:int) : String
      {
         return param1.toString() + " RP";
      }
      
      public static function replaceCarriageReturnsToBr(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:RegExp = /\r/gi;
         _loc2_ = param1.replace(_loc3_,"");
         var _loc4_:RegExp = /\n/gi;
         return _loc2_.replace(_loc4_,"<br>");
      }
      
      public static function replaceCarriageReturnsToSpace(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = /\r/gi;
         _loc2_ = param1.replace(_loc3_,"");
         var _loc4_:RegExp = /\n/gi;
         return _loc2_.replace(_loc4_," ");
      }
      
      public static function removeCarriageReturnsAndNewLines(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = /\r/gi;
         _loc2_ = param1.replace(_loc3_,"");
         var _loc4_:RegExp = /\n/gi;
         return _loc2_.replace(_loc4_,"");
      }
      
      public static function nas(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:RegExp = /\r/gi;
         _loc2_ = param1.replace(_loc3_,"");
         var _loc4_:RegExp = /\n/gi;
         return _loc2_.replace(_loc4_,"<br>");
      }
      
      public static function txt2link(param1:String, param2:String = "0000dd") : String
      {
         var _loc3_:RegExp = /(https:\/\/|http:\/\/|www\.)[^\s]+/gi;
         param1 = param1.replace(_loc3_,"<font color=\"#" + param2 + "\"><u><a href=\"$&\" target=\'_blank\'>$&</a></u></font>");
         return param1.split(/href="www./).join("href=\"http://www.");
      }
      
      public static function wrapHtmlTags(param1:String) : String
      {
         var _loc2_:RegExp = /<([^>\s]+)(\s[^>]+)*>/g;
         var _loc3_:Array = param1.match(_loc2_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            param1 = param1.replace(_loc3_[_loc4_],"");
            _loc4_++;
         }
         return param1;
      }
      
      public static function strReplace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function secondToString(param1:int) : String
      {
         if(param1 <= 0)
         {
            return $("unLmt");
         }
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:int = param1 % 60;
         param1 = (param1 - _loc5_) / 60;
         if(_loc5_ > 0)
         {
            _loc2_ = printf($("second"),_loc5_) + " ";
         }
         var _loc6_:int = param1 % 60;
         param1 = (param1 - _loc6_) / 60;
         if(_loc6_ > 0)
         {
            _loc3_ = printf($("minute"),_loc6_) + " ";
         }
         var _loc7_:int = param1 % 24;
         param1 = (param1 - _loc7_) / 24;
         if(_loc7_ > 0)
         {
            _loc4_ = printf($("hour"),_loc7_) + " ";
         }
         if(param1 == 0)
         {
            return _loc4_ + _loc3_ + _loc2_;
         }
         if(_loc4_ == "" && _loc3_ == "" && _loc2_ == "")
         {
            return printf($("day"),param1);
         }
         return printf($("day"),param1) + " " + _loc4_ + _loc3_ + _loc2_;
      }
      
      public static function getInfoByGift(param1:Object) : String
      {
         var _loc2_:String = null;
         if(param1.type == null)
         {
            return "";
         }
         if(param1.type == "SANIL" || param1.type == "DIAMOND")
         {
            _loc2_ = param1.quantity + " " + $(param1.type);
         }
         else
         {
            _loc2_ = param1.quantity + " " + $("pro_" + param1.clip);
         }
         return _loc2_;
      }
   }
}

