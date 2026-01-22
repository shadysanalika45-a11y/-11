package com.oyunstudyosu.utils
{
   public class TimeConverter
   {
      
      public static const HOUR_MINUTE_SECOND_TYPE:String = "hourMinuteSecondType";
      
      public static const HOUR_MINUTE_TYPE:String = "hourMinuteType";
      
      public static const MINUTE_SECOND_TYPE:String = "minuteSecondType";
      
      public static const DYNAMIC_TWO_VALUES_TYPE:String = "dynamicTwoValuesType";
      
      public function TimeConverter()
      {
         super();
      }
      
      public static function fromMinutes(param1:Number) : uint
      {
         return Math.round(fromSeconds(param1 * 60));
      }
      
      public static function fromSeconds(param1:Number) : uint
      {
         return Math.round(param1 * 1000);
      }
      
      public static function fromHours(param1:Number) : uint
      {
         return Math.round(fromMinutes(param1 * 60));
      }
      
      public static function fromTime(param1:Number, param2:Number, param3:Number) : uint
      {
         return fromHours(param1) + fromMinutes(param2) + fromSeconds(param3);
      }
      
      public static function toSeconds(param1:Number) : Number
      {
         return param1 / 1000;
      }
      
      public static function toMinutes(param1:Number) : Number
      {
         return toSeconds(param1) / 60;
      }
      
      public static function toHours(param1:Number) : Number
      {
         return toMinutes(param1) / 60;
      }
      
      public static function toDays(param1:Number) : Number
      {
         return toHours(param1) / 24;
      }
      
      public static function toObjectTime(param1:Number) : Object
      {
         param1 = Math.abs(param1);
         var _loc2_:Number = Math.round(toSeconds(param1));
         var _loc3_:uint = _loc2_ % 60;
         var _loc4_:uint = Math.floor(_loc2_ / 60) % 60;
         var _loc5_:uint = Math.floor(_loc2_ / (60 * 60)) % 24;
         var _loc6_:uint = Math.floor(_loc2_ / (60 * 60));
         var _loc7_:uint = Math.floor(_loc6_ / 24);
         return {
            "days":_loc7_,
            "hours":_loc5_,
            "minutes":_loc4_,
            "seconds":_loc3_,
            "totalHours":_loc6_
         };
      }
      
      public static function toTime(param1:Number, param2:String = "hourMinuteSecondType", param3:String = ":") : String
      {
         var _loc4_:Object = toObjectTime(param1);
         var _loc5_:String = _loc4_.seconds;
         var _loc6_:String = _loc4_.minutes;
         var _loc7_:String = _loc4_.totalHours;
         var _loc8_:String = "";
         if(_loc5_.length == 1)
         {
            _loc5_ = "0" + _loc5_;
         }
         if(_loc6_.length == 1)
         {
            _loc6_ = "0" + _loc6_;
         }
         if(_loc7_.length == 1)
         {
            _loc7_ = "0" + _loc7_;
         }
         if(param2 == HOUR_MINUTE_SECOND_TYPE)
         {
            _loc8_ = _loc7_ + param3 + _loc6_ + param3 + _loc5_;
         }
         else if(param2 == HOUR_MINUTE_TYPE)
         {
            _loc8_ = _loc7_ + param3 + _loc6_;
         }
         else if(param2 == MINUTE_SECOND_TYPE)
         {
            _loc8_ = _loc6_ + param3 + _loc5_;
         }
         else if(param2 == DYNAMIC_TWO_VALUES_TYPE)
         {
            if(parseInt(_loc7_) > 0)
            {
               _loc8_ = _loc7_ + param3 + _loc6_;
            }
            else
            {
               _loc8_ = _loc6_ + param3 + _loc5_;
            }
         }
         return _loc8_;
      }
      
      public static function toHMSString(param1:int) : String
      {
         return toTime(param1,HOUR_MINUTE_SECOND_TYPE);
      }
      
      public static function toHMString(param1:int) : String
      {
         return toTime(param1,HOUR_MINUTE_TYPE);
      }
      
      public static function getTimeString(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:uint = param1 / (60 * 60) % 24;
         var _loc4_:uint = param1 / 60 % 60;
         var _loc5_:uint = param1 % 60;
         if(_loc3_ > 0)
         {
            _loc2_ = _loc2_ + _loc3_.toString() + ":";
         }
         if(_loc4_ > 0)
         {
            if(_loc4_ < 10)
            {
               _loc2_ += "0";
            }
            _loc2_ = _loc2_ + _loc4_.toString() + ":";
         }
         else
         {
            _loc2_ += "00:";
         }
         if(_loc5_ > 0)
         {
            if(_loc5_ < 10)
            {
               _loc2_ += "0";
            }
            _loc2_ += _loc5_.toString();
         }
         else
         {
            _loc2_ += "00";
         }
         return _loc2_;
      }
      
      public static function convertTimestampToString(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc3_:uint = _loc2_.fullYear;
         var _loc4_:uint = _loc2_.month + 1;
         var _loc5_:uint = _loc2_.date;
         var _loc6_:uint = _loc2_.hours;
         var _loc7_:uint = _loc2_.minutes;
         var _loc8_:uint = _loc2_.seconds;
         return String(_loc3_) + "-" + (_loc4_ < 10 ? "0" : "") + String(_loc4_) + "-" + (_loc5_ < 10 ? "0" : "") + String(_loc5_) + " " + (_loc6_ < 10 ? "0" : "") + String(_loc6_) + ":" + (_loc7_ < 10 ? "0" : "") + String(_loc7_) + ":" + (_loc8_ < 10 ? "0" : "") + String(_loc8_);
      }
   }
}

