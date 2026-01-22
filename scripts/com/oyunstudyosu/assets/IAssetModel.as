package com.oyunstudyosu.assets
{
   public interface IAssetModel
   {
      
      function requestQueue(param1:AssetRequestQueue) : void;
      
      function request(param1:IAssetRequest) : void;
      
      function getAsset(param1:String, param2:String) : AssetData;
   }
}

