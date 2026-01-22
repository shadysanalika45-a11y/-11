package com.oyunstudyosu.item
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.assets.AssetData;
   import com.oyunstudyosu.assets.AssetModel;
   import com.oyunstudyosu.cloth.CharPreviewManager;
   import com.oyunstudyosu.cloth.ClothData;
   import com.oyunstudyosu.cloth.InventoryItemData;
   import com.oyunstudyosu.cloth.ItemFileData;
   import com.oyunstudyosu.cloth.SmileyData;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.PackItemEvent;
   import com.oyunstudyosu.events.PackPngEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.IItemModel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.system.System;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.LoadingAnimationBig;
   import org.oyunstudyosu.assets.clips.LoadingAnimationSmall;
   
   public class ItemModel extends EventDispatcher implements IItemModel
   {
      
      private var filePath:String;
      
      private var infoFileDownloaded:Boolean;
      
      private var itemClassDictionary:Dictionary = new Dictionary();
      
      private var itemBitmapdataDictionary:Dictionary = new Dictionary();
      
      public const downloadTestClothItems:Boolean = false;
      
      public const downloadTestInventoryItems:Boolean = false;
      
      public const downloadTestInventoryPngs:Boolean = false;
      
      private var pngTaskList:Vector.<PngAssetVO> = new Vector.<PngAssetVO>();
      
      private var taskDownloadPng:PngRequest;
      
      private var swfTaskList:Vector.<SwfAssetVO> = new Vector.<SwfAssetVO>();
      
      private var taskDownloadSwf:SwfRequest;
      
      private var reDownloadFile:Boolean;
      
      private var fileParser:InfoFileParser;
      
      private var itemFileDataDict:Dictionary = new Dictionary();
      
      private var clothDataDict:Dictionary = new Dictionary();
      
      private var inventoryItemDataDict:Dictionary = new Dictionary();
      
      private var smileyDataDict:Dictionary = new Dictionary();
      
      public function ItemModel(param1:String)
      {
         super();
         this.filePath = param1;
         getInfoFile();
         if(Sanalika.instance.configModel != null)
         {
            Sanalika.instance.configModel.listenVariable("itemFile",updateItemFile);
            Sanalika.instance.serviceModel.listenExtension("itemData",updateItemData);
         }
      }
      
      private function updateItemFile(param1:String) : void
      {
         Sanalika.instance.gameModel.itemInfoFile = filePath = "/static/" + param1;
         getInfoFile();
      }
      
      private function updateItemData(param1:Object) : void
      {
         var _loc4_:Array = Base64.decode(param1.data).toString().split("\n");
         var _loc2_:InfoFileParser = new InfoFileParser(this,filePath,true,false);
         for each(var _loc3_ in _loc4_)
         {
            _loc2_.processLine(_loc3_);
         }
      }
      
      private function updateFileVersion(param1:Object) : void
      {
         updateVersion(param1.filePath);
      }
      
      public function deleteBitmapdata(param1:String) : void
      {
         delete itemBitmapdataDictionary[param1];
      }
      
      public function removeItemCache() : void
      {
         itemClassDictionary = null;
         itemClassDictionary = new Dictionary();
      }
      
      public function getBitmapdata(param1:String) : BitmapData
      {
         var _loc2_:* = itemBitmapdataDictionary[param1];
         if(_loc2_ != null)
         {
            if(!(_loc2_ is BitmapData))
            {
               _loc2_ = null;
            }
         }
         return _loc2_;
      }
      
      public function setBitmapdata(param1:String, param2:String, param3:int, param4:BitmapData, param5:Boolean) : void
      {
         var _loc10_:int = 0;
         var _loc9_:PngAssetVO = null;
         itemBitmapdataDictionary[param1] = param4;
         var _loc6_:Boolean = false;
         var _loc8_:int = int(pngTaskList.length);
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc9_ = null;
            try
            {
               _loc9_ = pngTaskList[_loc10_];
            }
            catch(e:Error)
            {
            }
            if(_loc9_ != null)
            {
               if(_loc9_.filename == param1)
               {
                  if(_loc9_.version == param3)
                  {
                     pngTaskList.splice(_loc10_,1);
                     _loc6_ = true;
                     _loc10_--;
                  }
               }
            }
            _loc10_++;
         }
         var _loc7_:PackPngEvent = new PackPngEvent("png",param1,param2,param4);
         if(param5)
         {
            if(_loc6_)
            {
               dispatchEvent_pngLoaded(_loc7_);
            }
         }
         else
         {
            dispatchEvent_pngLoaded(_loc7_);
         }
      }
      
      private function dispatchEvent_pngLoaded(param1:PackPngEvent) : void
      {
         if(hasEventListener("png"))
         {
            dispatchEvent(param1);
         }
      }
      
      public function deleteItemFileData(param1:String) : void
      {
         var _loc2_:ItemFileData = getItemFileData(param1);
         if(_loc2_ != null)
         {
            delete itemFileDataDict[param1];
            if(Std.isOfType(_loc2_,ClothData))
            {
               delete clothDataDict[param1];
            }
            else if(Std.isOfType(_loc2_,InventoryItemData))
            {
               delete inventoryItemDataDict[param1];
            }
            else if(Std.isOfType(_loc2_,SmileyData))
            {
               delete smileyDataDict[param1];
            }
         }
      }
      
      private function getItemFileData(param1:String) : ItemFileData
      {
         return itemFileDataDict[param1];
      }
      
      public function getItemFileDataDict() : Dictionary
      {
         return itemFileDataDict;
      }
      
      public function setItemFileData(param1:String, param2:ItemFileData) : void
      {
         itemFileDataDict[param1] = param2;
         if(param2 is ClothData)
         {
            clothDataDict[param1] = param2;
         }
         else if(param2 is InventoryItemData)
         {
            inventoryItemDataDict[param1] = param2;
         }
         else if(param2 is SmileyData)
         {
            smileyDataDict[param1] = param2;
         }
      }
      
      public function deleteClass(param1:String) : void
      {
         delete itemClassDictionary[param1];
      }
      
      public function getClass(param1:String) : Class
      {
         return itemClassDictionary[param1];
      }
      
      public function setClass(param1:String, param2:String, param3:Class, param4:Boolean, param5:Boolean = false) : void
      {
         var _loc12_:int = 0;
         var _loc11_:SwfAssetVO = null;
         var _loc7_:SceneCharacterComponent = null;
         itemClassDictionary[param1] = param3;
         param3 = null;
         var _loc8_:Boolean = false;
         var _loc6_:String = param4 ? param1 : param1.substr(2);
         _loc12_ = 0;
         while(_loc12_ < swfTaskList.length)
         {
            _loc11_ = null;
            try
            {
               _loc11_ = swfTaskList[_loc12_];
            }
            catch(e:Error)
            {
            }
            if(_loc11_ != null)
            {
               if(_loc11_.isClothItem == param4)
               {
                  if(_loc11_.filename == _loc6_)
                  {
                     if(_loc11_.version.toString() == param2)
                     {
                        swfTaskList.splice(_loc12_,1);
                        _loc8_ = true;
                        _loc12_--;
                     }
                  }
               }
            }
            _loc12_++;
         }
         var _loc10_:PackItemEvent = new PackItemEvent("item",param1,param4);
         if(param5)
         {
            if(_loc8_)
            {
               dispatchEvent_itemLoaded(_loc10_);
            }
            if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
            {
               _loc7_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
               if(_loc7_.characterList != null)
               {
                  for each(var _loc9_ in _loc7_.characterList)
                  {
                     _loc9_.urgentUpdate4Item(_loc10_);
                  }
               }
            }
         }
         else
         {
            dispatchEvent_itemLoaded(_loc10_);
         }
      }
      
      private function dispatchEvent_itemLoaded(param1:PackItemEvent) : void
      {
         if(hasEventListener("item"))
         {
            dispatchEvent(param1);
         }
      }
      
      public function updateVersion(param1:String) : void
      {
         if(filePath == param1)
         {
            return;
         }
         filePath = param1;
         if(fileParser == null)
         {
            getInfoFile();
         }
         else
         {
            reDownloadFile = true;
         }
      }
      
      private function getInfoFile() : void
      {
         trace("getInfoFile() : firstLoad[" + !infoFileDownloaded + "]");
         fileParser = new InfoFileParser(this,filePath,!infoFileDownloaded);
      }
      
      public function getInfoFile_SUCCESS(param1:Boolean) : void
      {
         trace("getInfoFile_SUCCESS");
         fileParser = null;
         if(param1 && swfTaskList.length > 0)
         {
            startDownloadSwf();
         }
         if(reDownloadFile)
         {
            reDownloadFile = false;
            getInfoFile();
            return;
         }
         infoFileDownloaded = true;
         Dispatcher.dispatchEvent(new GameEvent("ITEM_INFO_FILE_LOADED"));
      }
      
      private function preDownloadAllMyClothes() : void
      {
         var _loc3_:int = 0;
         var _loc1_:String = Sanalika.instance.avatarModel.allClothes;
         var _loc2_:Array = _loc1_.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            addSwfJob(_loc2_[_loc3_],true);
            _loc3_++;
         }
      }
      
      public function getInfoFile_FAILED() : void
      {
         trace("getInfoFile_FAILED");
         reDownloadFile = false;
         fileParser = null;
      }
      
      public function addSwfJob(param1:String, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:SwfAssetVO = null;
         var _loc7_:int = getVersion(param1);
         if(_loc7_ < 0)
         {
            return;
         }
         param1 = param2 ? param1 : param1.substr(2);
         var _loc6_:Boolean = false;
         var _loc3_:int = int(swfTaskList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = swfTaskList[_loc5_];
            if(_loc4_.isClothItem == param2)
            {
               if(_loc4_.filename == param1)
               {
                  if(_loc4_.version == _loc7_)
                  {
                     _loc6_ = true;
                     break;
                  }
               }
            }
            _loc5_++;
         }
         if(_loc6_)
         {
            return;
         }
         swfTaskList.push(new SwfAssetVO(param1,_loc7_,param2));
         startDownloadSwf();
      }
      
      private function startDownloadSwf() : void
      {
         taskDownloadSwf = new SwfRequest(this,swfTaskList);
         swfTaskList = new Vector.<SwfAssetVO>();
      }
      
      public function getSwfFiles_SUCCESS() : void
      {
         if(swfTaskList.length > 0)
         {
            startDownloadSwf();
         }
         else
         {
            taskDownloadSwf = null;
         }
      }
      
      public function addPngJob(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc3_:PngAssetVO = null;
         var _loc7_:int = getVersion(param1);
         if(_loc7_ < 0)
         {
            trace("addPngJob() : key[" + param1 + "] : VERSION NOT FOUND !!!");
            return;
         }
         var _loc2_:String = param1.substr(0,1);
         param1 = param1.substr(2);
         var _loc6_:Boolean = false;
         var _loc4_:int = int(pngTaskList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = pngTaskList[_loc5_];
            if(_loc3_.filename == param1)
            {
               _loc6_ = true;
               break;
            }
            _loc5_++;
         }
         if(_loc6_)
         {
            return;
         }
         pngTaskList.push(new PngAssetVO(param1,_loc2_,_loc7_));
         if(taskDownloadPng == null)
         {
            startDownloadPng();
         }
      }
      
      private function startDownloadPng() : void
      {
         taskDownloadPng = new PngRequest(this,pngTaskList);
         pngTaskList = new Vector.<PngAssetVO>();
      }
      
      public function getPngFiles_SUCCESS() : void
      {
         if(pngTaskList.length > 0)
         {
            startDownloadPng();
         }
         else
         {
            taskDownloadPng = null;
         }
      }
      
      public function addItemListener(param1:Function) : void
      {
         this.addEventListener("item",param1);
      }
      
      public function removeItemListener(param1:Function) : void
      {
         this.removeEventListener("item",param1);
      }
      
      public function addPngListener(param1:Function) : void
      {
         this.addEventListener("png",param1);
      }
      
      public function removePngListener(param1:Function) : void
      {
         this.removeEventListener("png",param1);
      }
      
      public function getClothMovieClip(param1:String) : MovieClip
      {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ == null)
         {
            addSwfJob(param1,true);
            return null;
         }
         return new _loc2_();
      }
      
      public function getBodyPart(param1:String) : MovieClip
      {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ == null)
         {
            addSwfJob(param1,true);
            return null;
         }
         return new _loc2_();
      }
      
      public function getClothClass(param1:String) : Class
      {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ == null)
         {
            addSwfJob(param1,true);
         }
         return _loc2_;
      }
      
      public function getSmiley(param1:String) : SmileyData
      {
         return smileyDataDict[param1];
      }
      
      public function getCloth(param1:String) : ClothData
      {
         return clothDataDict[param1];
      }
      
      public function clearSWFMemory() : void
      {
         var _loc1_:Dictionary = new Dictionary();
         itemClassDictionary = new Dictionary();
         System.pauseForGCIfCollectionImminent();
         System.gc();
         _loc1_ = Connectr.instance.assetModel.loaderList;
         trace("loaderList.length: " + _loc1_.length);
         for each(var _loc3_ in _loc1_)
         {
            for each(var _loc2_ in _loc3_)
            {
               try
               {
                  trace("unloadAndStop: " + _loc2_.contentLoaderInfo.url);
                  _loc2_.unloadAndStop(true);
                  _loc2_.parent.removeChild(_loc2_);
               }
               catch(e:Error)
               {
               }
               _loc2_ = null;
            }
            _loc1_.splice(0,_loc1_.length);
         }
      }
      
      public function clearMemoryWithModuleType(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:AssetModel = Sanalika.instance.assetModel as AssetModel;
         Sanalika.instance.domainModel.clearContext(param1);
         var _loc6_:Vector.<String> = CharPreviewManager.getUsingItems();
         var _loc4_:Vector.<AssetData> = new Vector.<AssetData>();
         for each(var _loc8_ in _loc3_.assetList)
         {
            if(_loc8_.type == param1)
            {
               _loc2_ = false;
               for each(var _loc5_ in _loc6_)
               {
                  if(param1 == "ModuleType.INVENTORY" && _loc5_.split("_").length == 2)
                  {
                     _loc5_ = _loc5_.split("_")[1];
                  }
                  else if(!(param1 == "ModuleType.CLOTH" && _loc5_.split("_").length == 3))
                  {
                     continue;
                  }
                  if(_loc8_.assetId.indexOf(_loc5_ + ".swf") != -1)
                  {
                     _loc2_ = true;
                  }
               }
               if(_loc2_)
               {
                  trace("ItemModel",_loc8_.assetId + " swf already using!");
               }
               else
               {
                  if(param1 == "ModuleType.CLOTH" || param1 == "ModuleType.INVENTORY")
                  {
                     trace("ItemModel","delete class: ",_loc8_.assetId);
                     deleteClass(_loc8_.key);
                  }
                  _loc4_.push(_loc8_);
               }
            }
         }
         for each(var _loc7_ in _loc4_)
         {
            trace("ItemModel",_loc7_.assetId,"disposed!");
            delete _loc3_.loadingList[_loc7_.assetId];
            delete _loc3_.pendingList[_loc7_.assetId];
            _loc3_.assetList.splice(_loc3_.assetList.indexOf(_loc7_),1);
            _loc7_.dispose();
            _loc7_ = null;
         }
         _loc4_.splice(0,_loc4_.length);
      }
      
      public function getClothPlaceBit(param1:String) : int
      {
         var _loc2_:ClothData = getCloth(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.placeBit;
      }
      
      public function getClothFrameBit(param1:String) : int
      {
         var _loc2_:ClothData = getCloth(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.states;
      }
      
      public function getClothAdjustX(param1:String) : int
      {
         var _loc2_:ClothData = getCloth(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.adjustX;
      }
      
      public function getClothAdjustY(param1:String) : int
      {
         var _loc2_:ClothData = getCloth(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.adjustY;
      }
      
      public function getClothAdjustObject(param1:String) : Object
      {
         var _loc2_:ClothData = getCloth(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return {
            "x":_loc2_.adjustX,
            "y":_loc2_.adjustY
         };
      }
      
      public function getItemMovieClip(param1:String) : MovieClip
      {
         var _loc5_:String = param1.split("_")[1];
         var _loc3_:String = "m_" + _loc5_;
         var _loc4_:String = "f_" + _loc5_;
         if(getClass(_loc3_) == null && getClass(_loc4_) == null)
         {
            trace("addSwfJob");
            addSwfJob(param1,false);
            return null;
         }
         var _loc2_:Class = getClass(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return new _loc2_();
      }
      
      public function getItemClass(param1:String) : Class
      {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ == null)
         {
            addSwfJob(param1,false);
         }
         return _loc2_;
      }
      
      public function getItemImage(param1:String) : MovieClip
      {
         var _loc2_:BitmapData = getBitmapdata(param1.substr(2));
         if(_loc2_ == null)
         {
            addPngJob(param1);
            return null;
         }
         var _loc4_:MovieClip = new MovieClip();
         var _loc3_:Bitmap = new Bitmap(_loc2_);
         _loc3_.x = -_loc3_.width / 2;
         _loc3_.y = -_loc3_.height / 2;
         _loc4_.addChild(_loc3_);
         return _loc4_;
      }
      
      public function getItem(param1:String) : InventoryItemData
      {
         return inventoryItemDataDict[param1];
      }
      
      public function getItemType(param1:String) : uint
      {
         var _loc2_:InventoryItemData = getItem(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.itemType;
      }
      
      public function getItemStay(param1:String) : int
      {
         var _loc2_:InventoryItemData = getItem(param1);
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.stayIdle;
      }
      
      public function getVersion(param1:String) : int
      {
         var _loc2_:ItemFileData = getItemFileData(param1);
         if(_loc2_ == null)
         {
            return 0;
         }
         return _loc2_.version;
      }
      
      public function getSmallLoadingAnimation() : MovieClip
      {
         return new LoadingAnimationSmall();
      }
      
      public function getBigLoadingAnimation() : MovieClip
      {
         return new LoadingAnimationBig();
      }
      
      public function isInfoFileDownloaded() : Boolean
      {
         return infoFileDownloaded;
      }
   }
}

