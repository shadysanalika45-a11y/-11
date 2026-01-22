package com.oyunstudyosu.events
{
   import com.oyunstudyosu.purchase.PurchaseVo;
   import flash.events.Event;
   
   public class PurchaseEvent extends Event
   {
      
      public static const PURCHASE:String = "PurchaseEvent.PURCHASE";
      
      public static const FLAT_PURCHASE:String = "PurchaseEvent.FLAT_PURCHASE";
      
      public static const HAIR_PURCHASE_COMPLETED:String = "PurchaseEvent.HAIR_PURCHASE_COMPLETED";
      
      public static const CLOTH_PURCHASE_COMPLETED:String = "PurchaseEvent.CLOTH_PURCHASE_COMPLETED";
      
      public static const HAND_ITEM_PURCHASE_COMPLETED:String = "PurchaseEvent.HAND_ITEM_PURCHASE_COMPLETED";
      
      public static const FURNITURE_PURCHASE_COMPLETED:String = "PurchaseEvent.FURNITURE_PURCHASE_COMPLETED";
      
      public static const CARD_PURCHASE_COMPLETED:String = "PurchaseEvent.CARD_PURCHASE_COMPLETED";
      
      public static const FLAT_PURCHASE_FAIL:String = "PurchaseEvent.FLAT_PURCHASE_FAIL";
      
      public static const FLAT_PURCHASE_COMPLETED:String = "PurchaseEvent.FLAT_PURCHASE_COMPLETED";
      
      public static const ITEM_PURCHASE_SUCCESSFULL:String = "PurchaseEvent.ITEM_PURCHASE_SUCCESSFULL";
      
      public static const CARD_PURCHASE_SUCCESSFULL:String = "PurchaseEvent.CARD_PURCHASE_SUCCESSFULL";
      
      public var purchaseList:Vector.<PurchaseVo>;
      
      public var purchaseItem:Object;
      
      public var succesfullHandList:Array;
      
      public var succesfullFlatList:Array;
      
      public var hairObject:Object;
      
      public var diamond:int;
      
      public var sanil:int;
      
      public var shopID:int;
      
      public var objectID:int = 0;
      
      public function PurchaseEvent(param1:String)
      {
         super(param1);
      }
   }
}

