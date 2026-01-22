package com.oyunstudyosu.events
{
   import com.oyunstudyosu.craft.InventoryItemVo;
   import flash.events.Event;
   
   public class CraftEvent extends Event
   {
      
      public static const BARTER_START_REQUEST:String = "BarterEvent.BARTER_START_REQUEST";
      
      public static const BARTER_CANCEL:String = "BarterEvent.BARTER_CANCEL";
      
      public static const INVENTORY_UPDATED:String = "BarterEvent.INVENTORY_UPDATED";
      
      public static const SALE_LIST_UPDATED:String = "BarterEvent.SALE_LIST_UPDATED";
      
      public var listVo:InventoryItemVo;
      
      public var avatarID:String;
      
      public function CraftEvent(param1:String)
      {
         super(param1);
      }
   }
}

