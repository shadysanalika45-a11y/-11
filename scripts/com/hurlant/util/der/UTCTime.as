package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public class UTCTime implements IAsn1Type
   {
      
      public var date:Date;
      
      protected var len:uint;
      
      protected var type:uint;
      
      public function UTCTime(param1:uint, param2:uint)
      {
         super();
         this.type = param1;
         this.len = param2;
      }
      
      public function getLength() : uint
      {
         return len;
      }
      
      public function toString() : String
      {
         return DER.indent + "UTCTime[" + type + "][" + len + "][" + date + "]";
      }
      
      public function getType() : uint
      {
         return type;
      }
      
      public function setUTCTime(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc2_ = parseInt(param1.substr(0,2));
         if(_loc2_ < 50)
         {
            _loc2_ += 2000;
         }
         else
         {
            _loc2_ += 1900;
         }
         _loc3_ = parseInt(param1.substr(2,2));
         _loc4_ = parseInt(param1.substr(4,2));
         _loc5_ = parseInt(param1.substr(6,2));
         _loc6_ = parseInt(param1.substr(8,2));
         date = new Date(_loc2_,_loc3_ - 1,_loc4_,_loc5_,_loc6_);
      }
      
      public function toDER() : ByteArray
      {
         return null;
      }
   }
}

