package com.oyunstudyosu.item
{
   public class SwfAssetVO
   {
      
      public var filename:String;
      
      public var version:int;
      
      public var isClothItem:Boolean;
      
      public function SwfAssetVO(param1:String, param2:int, param3:Boolean)
      {
         super();
         this.filename = param1;
         this.version = param2;
         this.isClothItem = param3;
      }
   }
}

