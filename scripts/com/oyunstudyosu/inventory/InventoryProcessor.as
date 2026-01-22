package com.oyunstudyosu.inventory
{
   import com.oyunstudyosu.auth.Permission;
   
   public class InventoryProcessor
   {
      
      private var item:Item;
      
      private var items:Array;
      
      public function InventoryProcessor()
      {
         super();
      }
      
      public function processInventory(param1:Array) : Array
      {
         var _loc2_:Object = null;
         this.items = [];
         for each(_loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               if(!(_loc2_.timeLeft != null && _loc2_.timeLeft < 0))
               {
                  this.processItem(_loc2_);
               }
            }
         }
         return this.items;
      }
      
      private function processItem(param1:Object) : void
      {
         this.item = new Item(param1.transferrable,param1.productID,param1.clip,param1.lifeTime,param1.timeLeft,param1.subType,param1.createdAt,param1.id,param1.quantity,Permission.getGrantedIndexes(param1.roles));
         this.items.push(this.item);
      }
      
      public function isParentGroupByObject(param1:Object) : Boolean
      {
         var _loc2_:int = int(this.items.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.item = this.items[_loc3_];
            if(this.item.productID == param1.productID && (this.item.lifeTime == param1.lifeTime || this.item.lifeTime == 0 && param1.lifeTime == null) && (this.item.timeLeft == param1.timeLeft || this.item.timeLeft == 0 && param1.timeLeft == null))
            {
               ++this.item.quantity;
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

