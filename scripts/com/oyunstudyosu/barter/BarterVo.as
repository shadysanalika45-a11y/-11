package com.oyunstudyosu.barter
{
   public class BarterVo
   {
      
      private var _listVo:InventoryItemVo;
      
      private var _saleIDList:int = 0;
      
      private var _max:int;
      
      public function BarterVo()
      {
         super();
      }
      
      public function get max() : int
      {
         return this._max;
      }
      
      public function set max(param1:int) : void
      {
         this._max = param1;
      }
      
      public function get saleIDList() : int
      {
         return this._saleIDList;
      }
      
      public function set saleIDList(param1:int) : void
      {
         this._saleIDList = param1;
      }
      
      public function get listVo() : InventoryItemVo
      {
         return this._listVo;
      }
      
      public function set listVo(param1:InventoryItemVo) : void
      {
         this._listVo = param1;
         this.max = param1.inventoryIds;
      }
      
      public function add() : void
      {
         if(this.listVo.listIds <= 0)
         {
            return;
         }
         this.listVo.removeFromListById();
         ++this.saleIDList;
      }
      
      public function remove() : void
      {
         if(this.saleIDList <= 0)
         {
            return;
         }
         this.listVo.addToListById();
         --this.saleIDList;
      }
      
      public function removeAll() : void
      {
         if(this.saleIDList <= 0)
         {
            return;
         }
         this.saleIDList = 0;
         this.listVo.listIds = this.listVo.inventoryIds;
      }
   }
}

