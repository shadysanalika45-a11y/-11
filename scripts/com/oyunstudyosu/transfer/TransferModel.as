package com.oyunstudyosu.transfer
{
   import com.oyunstudyosu.inventory.Item;
   import com.oyunstudyosu.sanalika.interfaces.ITransferModel;
   
   public class TransferModel implements ITransferModel
   {
      
      private var _transferItem:Item;
      
      public function TransferModel()
      {
         super();
      }
      
      public function get transferItem() : Item
      {
         return _transferItem;
      }
      
      public function set transferItem(param1:Item) : void
      {
         _transferItem = param1;
      }
   }
}

