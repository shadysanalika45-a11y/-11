package com.oyunstudyosu.cloth
{
   public class ClothData extends ItemFileData
   {
      
      public var key:String;
      
      public var placeBit:int;
      
      public var states:int;
      
      public var adjustX:int;
      
      public var adjustY:int;
      
      public var gender:String;
      
      public var productKey:String;
      
      public var color:int;
      
      public var maxPlaceBitIndex:int;
      
      public var placeBitIndexes:Array;
      
      public function ClothData(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super();
         this.key = param1;
         this.forceUpdate(param2,param3,param4,param5,param6);
      }
      
      public function getMaxPlaceBitIndex(param1:int) : int
      {
         var _loc2_:int = -1;
         while(param1 != 0)
         {
            param1 >>= 1;
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function update(param1:int, param2:int, param3:int, param4:int, param5:int) : Boolean
      {
         if(this.placeBit == param1 && this.states == param2 && this.adjustX == param3 && this.adjustY == param4 && this.version == param5)
         {
            return false;
         }
         this.forceUpdate(param1,param2,param3,param4,param5);
         return true;
      }
      
      public function forceUpdate(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         this.placeBit = param1;
         this.states = param2;
         this.adjustX = param3;
         this.adjustY = param4;
         this.version = param5;
         this.placeBitIndexes = [];
         var _loc6_:int = 0;
         while(_loc6_ < 32)
         {
            if((param1 & 1 << _loc6_) != 0)
            {
               this.placeBitIndexes.push(_loc6_);
            }
            _loc6_++;
         }
         this.maxPlaceBitIndex = this.getMaxPlaceBitIndex(param1);
         var _loc7_:Array = this.key.split("_");
         this.gender = _loc7_[0];
         this.productKey = _loc7_[0] + "_" + _loc7_[1];
         this.color = int(_loc7_[2]);
      }
   }
}

