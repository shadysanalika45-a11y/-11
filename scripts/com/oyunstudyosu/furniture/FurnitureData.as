package com.oyunstudyosu.furniture
{
   import com.oyunstudyosu.local.$;
   
   public class FurnitureData
   {
      
      public static const GARDEN:FurnitureData = new FurnitureData(1,"objType_Garden");
      
      public static const HOUSE:FurnitureData = new FurnitureData(2,"objType_House");
      
      public static const CAFE:FurnitureData = new FurnitureData(4,"objType_Cafe");
      
      public static const HOSPITAL:FurnitureData = new FurnitureData(8,"objType_Hospital");
      
      public static const WALL:FurnitureData = new FurnitureData(16,"objType_Wall");
      
      public static const GARAGE:FurnitureData = new FurnitureData(32,"objType_Garage");
      
      public static const BEACH:FurnitureData = new FurnitureData(64,"objType_Beach");
      
      public static const SEA:FurnitureData = new FurnitureData(128,"objType_Sea");
      
      public static const EMPTY:FurnitureData = new FurnitureData(256,"objType_Empty");
      
      public static const OFFICE:FurnitureData = new FurnitureData(512,"objType_Office");
      
      public static const FARM:FurnitureData = new FurnitureData(1024,"objType_Farm");
      
      public static const SANALIKAX:FurnitureData = new FurnitureData(2048,"objType_SanalikaX");
      
      public static const FURNITURE_LOCATIONS:Array = [GARDEN,HOUSE,CAFE,HOSPITAL,WALL,GARAGE,BEACH,SEA,EMPTY,OFFICE,FARM,SANALIKAX];
      
      public var value:int;
      
      public var name:String;
      
      public function FurnitureData(param1:int, param2:String)
      {
         super();
         this.value = param1;
         this.name = param2;
      }
      
      public static function getStringValue(param1:Array) : String
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = int(param1[_loc3_]);
            _loc5_ = 0;
            while(_loc5_ < FURNITURE_LOCATIONS.length)
            {
               if(_loc4_ == FURNITURE_LOCATIONS[_loc5_].value)
               {
                  if(_loc2_.length > 0)
                  {
                     _loc2_ += ", ";
                  }
                  _loc2_ += $(FURNITURE_LOCATIONS[_loc5_].name);
               }
               _loc5_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getFlatFurnitureTypes(param1:Array) : Array
      {
         var _loc3_:FurnitureData = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         trace("flocs",JSON.stringify(param1));
         var _loc2_:Array = [];
         if(!param1)
         {
            return _loc2_;
         }
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = int(param1[_loc4_]);
            _loc6_ = 0;
            while(_loc6_ < FURNITURE_LOCATIONS.length)
            {
               _loc3_ = FURNITURE_LOCATIONS[_loc6_];
               if(_loc3_ != null)
               {
                  if((_loc3_.value & _loc5_) > 0 && _loc2_.indexOf(_loc3_.value) == -1)
                  {
                     _loc2_.push(_loc3_.value);
                  }
               }
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function clone() : FurnitureData
      {
         return new FurnitureData(this.value,this.name);
      }
   }
}

