package com.oyunstudyosu.cloth
{
   import flash.display.DisplayObject;
   
   public interface ICloth
   {
      
      function set maxPlaceBitIndex(param1:int) : void;
      
      function get maxPlaceBitIndex() : int;
      
      function get id() : int;
      
      function set id(param1:int) : void;
      
      function get quantity() : int;
      
      function set quantity(param1:int) : void;
      
      function getPreviewID() : int;
      
      function get key() : String;
      
      function set key(param1:String) : void;
      
      function get lifeTime() : int;
      
      function set lifeTime(param1:int) : void;
      
      function get timeLeft() : int;
      
      function set timeLeft(param1:int) : void;
      
      function get isAccessory() : Boolean;
      
      function set isAccessory(param1:Boolean) : void;
      
      function get placeBit() : int;
      
      function set placeBit(param1:int) : void;
      
      function get color() : int;
      
      function set color(param1:int) : void;
      
      function get infoInventoryItem() : InventoryItemData;
      
      function set infoInventoryItem(param1:InventoryItemData) : void;
      
      function get previewImage() : DisplayObject;
      
      function set previewImage(param1:DisplayObject) : void;
      
      function set previewLoaded(param1:Boolean) : void;
      
      function get previewLoaded() : Boolean;
      
      function reload() : void;
      
      function getProductID() : String;
      
      function getProductName() : String;
      
      function getLanguageKey() : String;
      
      function clone() : ICloth;
   }
}

