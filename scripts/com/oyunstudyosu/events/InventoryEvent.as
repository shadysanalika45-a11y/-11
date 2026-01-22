package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class InventoryEvent extends Event
   {
      
      public static const SET_INVENTORY_ITEMS:String = "setInventoryItems";
      
      public static const UPDATE_INVENTORY:String = "updateInventory";
      
      public var items:Array;
      
      public function InventoryEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new InventoryEvent(this.type);
      }
   }
}

