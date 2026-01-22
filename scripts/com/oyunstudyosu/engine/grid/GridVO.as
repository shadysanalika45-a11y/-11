package com.oyunstudyosu.engine.grid
{
   import com.oyunstudyosu.engine.core.MapEntry;
   
   public class GridVO
   {
      
      public var freeAreaNo:int;
      
      public var mapEntry:MapEntry;
      
      public var isFilled:Boolean;
      
      public function GridVO(param1:Boolean, param2:MapEntry, param3:int = 0)
      {
         super();
         this.isFilled = param1;
         this.mapEntry = param2;
         this.freeAreaNo = param3;
      }
   }
}

