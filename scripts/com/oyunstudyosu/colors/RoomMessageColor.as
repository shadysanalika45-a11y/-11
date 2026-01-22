package com.oyunstudyosu.colors
{
   public class RoomMessageColor
   {
      
      public static var tempList:Array = [];
      
      public static const TURQUOISE:RoomMessageColor = new RoomMessageColor(2,"FFFFFF","16a085","FFFFFF","1abc9c");
      
      public static const SILVER:RoomMessageColor = new RoomMessageColor(1,"202020","ecf0f1","202020","bdc3c7");
      
      public var id:int;
      
      public var background:String;
      
      public var progress:String;
      
      public var timerBg:String;
      
      public var border:String;
      
      public function RoomMessageColor(param1:int, param2:String, param3:String, param4:String, param5:String)
      {
         super();
         this.id = param1;
         this.background = param2;
         this.progress = param3;
         this.timerBg = param4;
         this.border = param5;
         tempList.push(this);
      }
      
      public static function getTempByID(param1:int) : RoomMessageColor
      {
         var _loc2_:int = 0;
         while(_loc2_ < tempList.length)
         {
            if(tempList[_loc2_].id == param1)
            {
               return tempList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

