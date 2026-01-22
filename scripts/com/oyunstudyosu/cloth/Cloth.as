package com.oyunstudyosu.cloth
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class Cloth implements ICloth
   {
      
      public var on:Boolean;
      
      public var base:Boolean;
      
      public var states:int;
      
      private var _clothData:ClothData;
      
      private var _previewLoaded:Boolean;
      
      private var _previewImage:DisplayObject;
      
      private var _infoInventoryItem:InventoryItemData;
      
      private var _color:int;
      
      private var _quantity:int;
      
      private var _placeBit:int;
      
      private var _isAccessory:Boolean;
      
      private var _lifeTime:int;
      
      private var _timeLeft:int;
      
      private var _key:String;
      
      private var _maxPlaceBitIndex:int;
      
      private var _id:int;
      
      public function Cloth(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:String, param6:int, param7:int, param8:Boolean = true)
      {
         super();
         this.id = param1;
         this.quantity = param2;
         this.on = param3;
         this.base = param4;
         this.key = param5;
         this.lifeTime = param6;
         this.timeLeft = param7;
         this.isAccessory = param8;
         if(Sanalika.instance.itemModel.isInfoFileDownloaded())
         {
            this.reload();
         }
      }
      
      public function getPreviewID() : int
      {
         if(quantity > 0)
         {
            return id;
         }
         return 0;
      }
      
      public function get clothData() : ClothData
      {
         return _clothData;
      }
      
      public function set clothData(param1:ClothData) : void
      {
         _clothData = param1;
      }
      
      public function get previewLoaded() : Boolean
      {
         return _previewLoaded;
      }
      
      public function set previewLoaded(param1:Boolean) : void
      {
         _previewLoaded = param1;
      }
      
      public function get previewImage() : DisplayObject
      {
         return _previewImage;
      }
      
      public function set previewImage(param1:DisplayObject) : void
      {
         _previewImage = param1;
         this.previewImage.x = (38 - this.previewImage.width) / 2;
         this.previewImage.y = (38 - this.previewImage.height) / 2;
      }
      
      public function get infoInventoryItem() : InventoryItemData
      {
         return _infoInventoryItem;
      }
      
      public function set infoInventoryItem(param1:InventoryItemData) : void
      {
         if(_infoInventoryItem == param1)
         {
            return;
         }
         _infoInventoryItem = param1;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function set color(param1:int) : void
      {
         if(_color == param1)
         {
            return;
         }
         _color = param1;
      }
      
      public function get quantity() : int
      {
         return _quantity;
      }
      
      public function set quantity(param1:int) : void
      {
         if(_quantity == param1)
         {
            return;
         }
         _quantity = param1;
      }
      
      public function get placeBit() : int
      {
         return _placeBit;
      }
      
      public function set placeBit(param1:int) : void
      {
         if(_placeBit == param1)
         {
            return;
         }
         _placeBit = param1;
      }
      
      public function get isAccessory() : Boolean
      {
         return _isAccessory;
      }
      
      public function set isAccessory(param1:Boolean) : void
      {
         if(_isAccessory == param1)
         {
            return;
         }
         _isAccessory = param1;
      }
      
      public function get lifeTime() : int
      {
         return _lifeTime;
      }
      
      public function set lifeTime(param1:int) : void
      {
         if(_lifeTime == param1)
         {
            return;
         }
         _lifeTime = param1;
      }
      
      public function get timeLeft() : int
      {
         return _timeLeft;
      }
      
      public function set timeLeft(param1:int) : void
      {
         if(_timeLeft == param1)
         {
            return;
         }
         _timeLeft = param1;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(param1:String) : void
      {
         if(_key == param1)
         {
            return;
         }
         _key = param1;
      }
      
      public function set maxPlaceBitIndex(param1:int) : void
      {
         if(_maxPlaceBitIndex == param1)
         {
            return;
         }
         _maxPlaceBitIndex = param1;
      }
      
      public function get maxPlaceBitIndex() : int
      {
         return _maxPlaceBitIndex;
      }
      
      public function set id(param1:int) : void
      {
         if(_id == param1)
         {
            return;
         }
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function reload() : void
      {
         var _loc1_:BitmapData = null;
         if(isAccessory)
         {
            clothData = Sanalika.instance.itemModel.getCloth(key);
            if(clothData == null)
            {
               trace("reload() : infoClothItem not found [" + key + "]");
            }
            else
            {
               this.placeBit = clothData.placeBit;
               this.color = clothData.color;
               this.maxPlaceBitIndex = clothData.maxPlaceBitIndex;
               this.states = clothData.states;
               _loc1_ = Sanalika.instance.clothModel.getBitmapdata(key);
               if(_loc1_ == null)
               {
                  this.previewImage = new MovieClip();
               }
               else
               {
                  this.previewImage = new Bitmap(_loc1_);
                  _loc1_.dispose();
                  _loc1_ = null;
                  this.previewLoaded = true;
               }
               this.previewImage.x = (38 - this.previewImage.width) / 2;
               this.previewImage.y = (38 - this.previewImage.height) / 2;
            }
         }
         else
         {
            infoInventoryItem = Sanalika.instance.itemModel.getItem(key);
            if(infoInventoryItem == null)
            {
               trace("reload() : info not found[" + key + "]");
            }
            else
            {
               this.placeBit = ClothType.BIT22_HANDITEM;
               this.maxPlaceBitIndex = 22;
               this.states = 127;
            }
         }
      }
      
      public function getProductID() : String
      {
         if(isAccessory)
         {
            return key.substr(0,key.lastIndexOf("_"));
         }
         return key;
      }
      
      public function getProductName() : String
      {
         if(isAccessory)
         {
            return key.substring(key.indexOf("_") + 1,key.lastIndexOf("_"));
         }
         return key;
      }
      
      public function getLanguageKey() : String
      {
         if(isAccessory)
         {
            return "pro_" + key.substring(key.indexOf("_") + 1,key.lastIndexOf("_"));
         }
         return "pro_" + key;
      }
      
      public function clone() : ICloth
      {
         var _loc1_:Cloth = new Cloth(id,quantity,on,base,key,lifeTime,timeLeft);
         if(previewLoaded)
         {
            _loc1_.previewImage = this.previewImage;
            _loc1_.previewLoaded = this.previewLoaded;
         }
         return _loc1_;
      }
   }
}

