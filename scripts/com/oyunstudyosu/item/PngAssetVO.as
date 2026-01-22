package com.oyunstudyosu.item
{
   public class PngAssetVO
   {
      
      public var filename:String;
      
      public var sex:String;
      
      public var version:int;
      
      public function PngAssetVO(param1:String, param2:String, param3:int)
      {
         super();
         this.filename = param1;
         this.sex = param2;
         this.version = param3;
      }
   }
}

