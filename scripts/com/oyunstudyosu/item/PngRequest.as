package com.oyunstudyosu.item
{
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class PngRequest
   {
      
      private var pack:ItemModel;
      
      private var pngTaskList:Vector.<PngAssetVO>;
      
      private var loadedCount:uint;
      
      public function PngRequest(param1:ItemModel, param2:Vector.<PngAssetVO>)
      {
         super();
         this.pack = param1;
         this.pngTaskList = param2;
         getPng();
      }
      
      private function getPng() : void
      {
         var _loc3_:int = 0;
         var _loc2_:PngAssetVO = null;
         var _loc1_:IAssetRequest = null;
         loadedCount = 0;
         _loc3_ = 0;
         while(_loc3_ < pngTaskList.length)
         {
            _loc2_ = pngTaskList[_loc3_];
            _loc1_ = new AssetRequest();
            _loc1_.assetId = Sanalika.instance.moduleModel.getPath(_loc2_.filename,"ModuleType.INVENTORY") + ".png?v=" + _loc2_.version;
            _loc1_.type = "ModuleType.PNG";
            _loc1_.loadedFunction = onLoaded;
            _loc1_.errorFunction = onError;
            _loc1_.data = _loc3_;
            _loc1_.name = _loc2_.filename;
            _loc1_.context = Sanalika.instance.domainModel.assetContext;
            Sanalika.instance.assetModel.request(_loc1_);
            _loc3_++;
         }
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc6_:String = param1.name;
         var _loc3_:int = param1.data;
         var _loc2_:String = (pngTaskList[_loc3_] as PngAssetVO).sex;
         var _loc7_:int = (pngTaskList[_loc3_] as PngAssetVO).version;
         var _loc4_:BitmapData = (param1.display as Bitmap).bitmapData;
         param1.dispose();
         var _loc5_:* = pack.getBitmapdata(_loc6_) != null;
         pack.setBitmapdata(_loc6_,_loc2_,_loc7_,_loc4_,_loc5_);
         loadedCount = loadedCount + 1;
         if(pngTaskList.length == loadedCount)
         {
            pngTaskList = null;
            pack.getPngFiles_SUCCESS();
         }
      }
      
      private function onError(param1:IAssetRequest) : void
      {
         Cc.warn("Load error: " + param1.name);
         loadedCount = loadedCount + 1;
         param1.dispose();
         if(pngTaskList.length == loadedCount)
         {
            pngTaskList = null;
            pack.getPngFiles_SUCCESS();
         }
      }
   }
}

