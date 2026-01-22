package com.oyunstudyosu.assets
{
   import flash.display.DisplayObject;
   
   public class AssetData
   {
      
      public var key:String;
      
      public var type:String;
      
      public var content:DisplayObject;
      
      public var assetId:String;
      
      public function AssetData()
      {
         super();
      }
      
      public function dispose() : *
      {
         this.content = null;
         this.assetId = null;
         this.key = null;
      }
   }
}

