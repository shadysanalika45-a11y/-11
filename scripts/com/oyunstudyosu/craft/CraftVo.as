package com.oyunstudyosu.craft
{
   public class CraftVo
   {
      
      private var _listVo:InventoryItemVo;
      
      private var _saleIDList:int = 0;
      
      public function CraftVo()
      {
         super();
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

