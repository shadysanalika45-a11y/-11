package com.oyunstudyosu.cloth
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.events.PackPngEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class ClothModel extends EventDispatcher implements IClothModel
   {
      
      private var bitmapDataMap:Dictionary;
      
      private var _allClothes:Array;
      
      public function ClothModel()
      {
         super();
         bitmapDataMap = new Dictionary();
      }
      
      private function onClothList(param1:Object) : void
      {
         load(param1.items);
         Sanalika.instance.serviceModel.removeRequestData("clothlist",onClothList);
      }
      
      public function get allClothes() : Array
      {
         return _allClothes;
      }
      
      public function set allClothes(param1:Array) : void
      {
         if(_allClothes == param1)
         {
            return;
         }
         _allClothes = param1;
      }
      
      public function load(param1:Object) : void
      {
         _allClothes = [];
         for each(var _loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               _allClothes.push(new Cloth(_loc2_.id,_loc2_.quantity,_loc2_.active,_loc2_.base,Sanalika.instance.avatarModel.gender + "_" + _loc2_.clip,_loc2_.lifeTime ? _loc2_.lifeTime : -1,_loc2_.timeLeft ? _loc2_.timeLeft : -1));
            }
         }
         param1 = null;
      }
      
      public function getVisibleClothArray() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _allClothes)
         {
            for each(var _loc3_ in Sanalika.instance.avatarModel.clothesOn)
            {
               if(Sanalika.instance.avatarModel.gender + "_" + _loc3_ == _loc1_.key)
               {
                  _loc2_.push(_loc1_);
               }
            }
         }
         return _loc2_;
      }
      
      public function deleteBitmapdata(param1:String) : void
      {
         delete bitmapDataMap[param1];
      }
      
      public function getBitmapdata(param1:String) : BitmapData
      {
         return bitmapDataMap[param1];
      }
      
      public function setBitmapdata(param1:String, param2:BitmapData) : void
      {
         bitmapDataMap[param1] = param2;
      }
      
      public function isMemberOfShirtCategory(param1:int) : Boolean
      {
         if((param1 & ClothType.BIT09_SHIRT - 1) == 0 && param1 >> 15 == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfFullBody(param1:int) : Boolean
      {
         if(param1 == ClothType.BIT00_BODY_BOTTOM || param1 == ClothType.BIT01_BODY_MIDDLE || param1 == ClothType.BIT02_BODY_TOP)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfPantsCategory(param1:int) : Boolean
      {
         if(param1 == ClothType.BIT06_LEG_TOP || param1 == ClothType.BIT06_LEG_TOP + ClothType.BIT04_FOOT || param1 == ClothType.BIT08_LEG_ALL)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfShoesCategory(param1:int) : Boolean
      {
         if((param1 & ClothType.BIT04_FOOT - 1) == 0 && param1 >> 9 == 0)
         {
            if(!isMemberOfPantsCategory(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isMemberOfHeadCategory(param1:int) : Boolean
      {
         if((param1 & (ClothType.BIT20_HAT | ClothType.BIT21_EMOTICON | ClothType.BIT17_HAIR)) > 0 && (param1 & ClothType.BIT16_FACIAL_HAIR - 1) == 0 && param1 >> 22 == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfAccessoryCategory(param1:int) : Boolean
      {
         if((param1 & ClothType.BIT16_FACIAL_HAIR - 1) == 0 && param1 >> 20 == 0 && param1 != ClothType.BIT17_HAIR)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfEffectCategory(param1:int) : Boolean
      {
         if((param1 & ClothType.BIT26_EFFECT_ALL - 1) == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isMemberOfCostumeCategory(param1:int) : Boolean
      {
         if(isMemberOfFullBody(param1))
         {
            return false;
         }
         if(isMemberOfShirtCategory(param1))
         {
            return false;
         }
         if(isMemberOfPantsCategory(param1))
         {
            return false;
         }
         if(isMemberOfShoesCategory(param1))
         {
            return false;
         }
         if(isMemberOfHeadCategory(param1))
         {
            return false;
         }
         if(isMemberOfAccessoryCategory(param1))
         {
            return false;
         }
         return true;
      }
      
      public function isMemberOfCategory(param1:int, param2:String) : Boolean
      {
         var _loc3_:Boolean = false;
         switch(param2)
         {
            case "btnShirt":
               _loc3_ = isMemberOfShirtCategory(param1);
               break;
            case "btnPants":
               _loc3_ = isMemberOfPantsCategory(param1);
               break;
            case "btnShoes":
               _loc3_ = isMemberOfShoesCategory(param1);
               break;
            case "btnHead":
               _loc3_ = isMemberOfHeadCategory(param1);
               break;
            case "btnAccessory":
               _loc3_ = isMemberOfAccessoryCategory(param1);
               break;
            case "btnCostume":
               _loc3_ = isMemberOfCostumeCategory(param1);
         }
         return _loc3_;
      }
      
      public function getElementsWithCategory(param1:Array, param2:String) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:Cloth = null;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = param1[_loc5_];
            if(!(_loc4_.placeBit == ClothType.BIT00_BODY_BOTTOM || _loc4_.placeBit == ClothType.BIT01_BODY_MIDDLE || _loc4_.placeBit == ClothType.BIT02_BODY_TOP))
            {
               if(isMemberOfCategory(_loc4_.placeBit,param2))
               {
                  _loc3_.push(_loc4_.clone());
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:PackPngEvent = null;
         try
         {
            _loc2_ = new PackPngEvent("png",param1.name,Sanalika.instance.avatarModel.gender,(param1.display as Bitmap).bitmapData);
            if(hasEventListener("png"))
            {
               dispatchEvent(_loc2_);
            }
            param1.dispose();
         }
         catch(error:Error)
         {
            trace("onLoaded:",error.getStackTrace());
         }
      }
      
      public function addPngListener(param1:Function) : void
      {
         this.addEventListener("png",param1);
      }
      
      public function loadClothPreview(param1:Cloth) : void
      {
         var _loc2_:IAssetRequest = null;
         trace("loadClothPreview");
         if(!param1.previewLoaded)
         {
            _loc2_ = new AssetRequest();
            _loc2_.assetId = "/static/items/clothes/r_" + param1.key + ".png";
            _loc2_.name = "r_" + param1.key;
            _loc2_.data = param1;
            _loc2_.loadedFunction = onLoaded;
            _loc2_.type = "ModuleType.CLOTH_PNG";
            _loc2_.context = Sanalika.instance.domainModel.assetContext;
            Sanalika.instance.assetModel.request(_loc2_);
         }
      }
      
      public function getClothById(param1:Array, param2:int) : Cloth
      {
         var _loc4_:int = 0;
         var _loc3_:Cloth = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            if(_loc3_.id == param2)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getNewCharPreview(param1:MovieClip, param2:Object = null, param3:Boolean = false) : ICharPreview
      {
         if(param1 == null)
         {
            return null;
         }
         return new CharPreview(param1,param2,allClothes,param3);
      }
      
      public function dispose() : void
      {
         Sanalika.instance.serviceModel.removeRequestData("clothlist",onClothList);
      }
   }
}

