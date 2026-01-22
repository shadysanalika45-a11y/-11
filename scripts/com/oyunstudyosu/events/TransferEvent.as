package com.oyunstudyosu.events
{
   import com.oyunstudyosu.inventory.Item;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TransferEvent extends Event
   {
      
      public static const START_DRAGGING:String = "TransferEvent.START_DRAGGING";
      
      public static const STOP_DRAGGING:String = "TransferEvent.STOP_DRAGGING";
      
      public static const TRANSFER_COMPLETED:String = "TransferEvent.TRANFER_COMPLETED";
      
      public static const TRANSFER_CANCELLED:String = "TransferEvent.TRANSFER_CANCELLED";
      
      public static const DIAMOND_TRANSFER_CANCELLED:String = "TransferEvent.DIAMOND_TRANSFER_CANCELLED";
      
      public var draggingItem:Item;
      
      public var mouseEvent:MouseEvent;
      
      public function TransferEvent(param1:String)
      {
         super(param1);
      }
   }
}

