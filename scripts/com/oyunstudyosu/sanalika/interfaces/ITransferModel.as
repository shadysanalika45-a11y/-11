package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.inventory.Item;
   
   public interface ITransferModel
   {
      
      function get transferItem() : Item;
      
      function set transferItem(param1:Item) : void;
   }
}

