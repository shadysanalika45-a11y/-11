package com.oyunstudyosu.item
{
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import com.oyunstudyosu.utils.Logger;
   import flash.external.ExternalInterface;
   import flash.system.ApplicationDomain;
   
   public class SwfRequest
   {
      
      private var pack:ItemModel;
      
      private var taskList:Vector.<SwfAssetVO>;
      
      private var loadedCount:uint;
      
      public function SwfRequest(param1:ItemModel, param2:Vector.<SwfAssetVO>)
      {
         super();
         this.pack = param1;
         this.taskList = param2;
         getMovieClips();
      }
      
      private function getMovieClips() : void
      {
         var _loc1_:IAssetRequest = null;
         var _loc3_:String = null;
         loadedCount = 0;
         for each(var _loc2_ in taskList)
         {
            _loc1_ = new AssetRequest();
            _loc1_.name = _loc2_.filename;
            _loc1_.data = {};
            _loc1_.data.isClothItem = _loc2_.isClothItem;
            _loc3_ = "";
            if(_loc2_.version > 0)
            {
               _loc3_ = "." + _loc2_.version;
            }
            if(_loc1_.data.isClothItem)
            {
               _loc1_.assetId = Sanalika.instance.moduleModel.getPath(_loc2_.filename,"ModuleType.CLOTH") + _loc3_ + ".swf";
               _loc1_.type = "ModuleType.CLOTH";
            }
            else
            {
               _loc1_.assetId = Sanalika.instance.moduleModel.getPath(_loc2_.filename,"ModuleType.INVENTORY") + _loc3_ + ".swf";
               _loc1_.type = "ModuleType.INVENTORY";
            }
            _loc1_.data.version = _loc2_.version;
            _loc1_.loadedFunction = onLoaded;
            _loc1_.errorFunction = onError;
            _loc1_.priority = 0;
            _loc1_.context = Sanalika.instance.domainModel.generateContext(_loc1_.type);
            Sanalika.instance.assetModel.request(_loc1_);
         }
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc4_:String = param1.name;
         var _loc3_:String = param1.data.version;
         var _loc2_:Boolean = Boolean(param1.data.isClothItem);
         if(_loc2_)
         {
            registerClass(_loc4_,_loc3_,_loc2_,param1.context.applicationDomain);
         }
         else
         {
            registerClass("f_" + _loc4_,_loc3_,_loc2_,param1.context.applicationDomain);
            registerClass("m_" + _loc4_,_loc3_,_loc2_,param1.context.applicationDomain);
         }
         loadedCount = loadedCount + 1;
         param1.dispose();
         if(loadedCount == taskList.length)
         {
            pack.getSwfFiles_SUCCESS();
            taskList = null;
            pack = null;
         }
      }
      
      private function onError(param1:IAssetRequest) : void
      {
         loadedCount = loadedCount + 1;
         param1.dispose();
         if(loadedCount == taskList.length)
         {
            pack.getSwfFiles_SUCCESS();
            taskList = null;
            pack = null;
         }
      }
      
      private function registerClass(param1:String, param2:String, param3:Boolean, param4:ApplicationDomain) : void
      {
         var _loc5_:* = false;
         var _loc6_:Class = DefinitionUtils.getClass(param4,param1);
         if(_loc6_ == null)
         {
            Cc.warn("registerClass() : F[" + param1 + "] V[" + param2 + "] isClothItem[" + param3 + "] : EXPORT NOT FOUND !!!",true);
            if(ExternalInterface.available)
            {
               ExternalInterface.call("console.log","registerClass() : F[" + param1 + "] V[" + param2 + "] isClothItem[" + param3 + "] : EXPORT NOT FOUND !!!");
            }
            loadedCount = loadedCount + 1;
            return;
         }
         if(pack)
         {
            _loc5_ = pack.getClass(param1) != null;
            pack.setClass(param1,param2,_loc6_,param3,_loc5_);
         }
         else
         {
            Logger.log("pack is null",true);
         }
      }
   }
}

