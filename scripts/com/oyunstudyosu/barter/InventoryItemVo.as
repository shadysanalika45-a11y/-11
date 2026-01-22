package com.oyunstudyosu.barter
{
   public class InventoryItemVo
   {
      
      private var _id:int;
      
      private var _voID:int;
      
      private var _clip:String;
      
      private var _title:String;
      
      private var _currencyType:String;
      
      private var _amount:int;
      
      private var _inventoryIds:int = 0;
      
      private var _listIds:int = 0;
      
      private var _totalTime:int = 0;
      
      private var _leftTime:int = 0;
      
      public function InventoryItemVo()
      {
         super();
      }
      
      public function get leftTime() : int
      {
         return this._leftTime;
      }
      
      public function set leftTime(param1:int) : void
      {
         this._leftTime = param1;
      }
      
      public function get totalTime() : int
      {
         return this._totalTime;
      }
      
      public function set totalTime(param1:int) : void
      {
         this._totalTime = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get voID() : int
      {
         return this._voID;
      }
      
      public function set voID(param1:int) : void
      {
         this._voID = param1;
      }
      
      public function get listIds() : int
      {
         return this._listIds;
      }
      
      public function set listIds(param1:int) : void
      {
         this._listIds = param1;
      }
      
      public function get inventoryIds() : int
      {
         return this._inventoryIds;
      }
      
      public function set inventoryIds(param1:int) : void
      {
         this._inventoryIds = param1;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function set amount(param1:int) : void
      {
         this._amount = param1;
      }
      
      public function get currencyType() : String
      {
         return this._currencyType;
      }
      
      public function set currencyType(param1:String) : void
      {
         this._currencyType = param1;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get clip() : String
      {
         return this._clip;
      }
      
      public function set clip(param1:String) : void
      {
         this._clip = param1;
      }
      
      public function addToListById() : int
      {
         return this.listIds++;
      }
      
      public function removeFromListById() : int
      {
         return this.listIds--;
      }
   }
}

