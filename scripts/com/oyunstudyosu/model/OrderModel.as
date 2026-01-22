package com.oyunstudyosu.model
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.OrderEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.IOrderModel;
   
   public class OrderModel implements IOrderModel
   {
      
      private var _orderCount:int;
      
      private var _orderRequest:Object;
      
      private var _orderList:Array;
      
      public function OrderModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("ordertimedout",orderTimedOut);
         Sanalika.instance.serviceModel.listenExtension("neworder",newOrder);
         Sanalika.instance.serviceModel.listenExtension("orderpreparing",onPrepare);
         Sanalika.instance.serviceModel.listenExtension("orderdelivered",onDeliver);
         Sanalika.instance.serviceModel.listenExtension("ordercancelled",onCancel);
      }
      
      private function orderTimedOut(param1:Object) : void
      {
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            orderList.splice(findOrderIndexById(param1.id),1);
         }
         else
         {
            orderRequest.status = "NEW";
         }
         Dispatcher.dispatchEvent(new OrderEvent("OrderEvent.TIMEDOUT"));
      }
      
      public function findOrderIndexById(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < orderList.length)
         {
            if(orderList[_loc2_].id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return 0;
      }
      
      private function newOrder(param1:Object) : void
      {
         trace("newOderReceived");
         trace("data",JSON.stringify(param1));
         if(!param1)
         {
            return;
         }
         if(orderList)
         {
            orderList.push(param1);
         }
         var _loc2_:OrderEvent = new OrderEvent("OrderEvent.NEW_ORDER");
         _loc2_.data = param1;
         Dispatcher.dispatchEvent(_loc2_);
         _loc2_ = null;
         var _loc3_:AlertVo = new AlertVo();
         _loc3_.alertType = "tooltip";
         _loc3_.description = $("orderRECEIVED");
         Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
         _loc3_ = null;
      }
      
      private function onCancel(param1:Object) : void
      {
         trace("Cancelled....");
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            orderList.splice(findOrderIndexById(param1.id),1);
         }
         else
         {
            orderRequest.status = "CANCELLED";
         }
         Dispatcher.dispatchEvent(new OrderEvent("OrderEvent.CANCELLED"));
      }
      
      private function onPrepare(param1:Object) : void
      {
         orderRequest.status = "PREPARING";
         Dispatcher.dispatchEvent(new OrderEvent("OrderEvent.PREPARING"));
      }
      
      private function onDeliver(param1:Object) : void
      {
         trace("Delivered....");
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            orderList.splice(findOrderIndexById(param1.id),1);
         }
         else
         {
            orderRequest.status = "DELIVERED";
         }
         Dispatcher.dispatchEvent(new OrderEvent("OrderEvent.DELIVERED"));
      }
      
      public function get orderCount() : int
      {
         return _orderList.length;
      }
      
      public function get orderRequest() : Object
      {
         return _orderRequest;
      }
      
      public function set orderRequest(param1:Object) : void
      {
         if(_orderRequest == param1)
         {
            return;
         }
         _orderRequest = param1;
      }
      
      public function get orderList() : Array
      {
         return _orderList;
      }
      
      public function set orderList(param1:Array) : void
      {
         if(_orderList == param1)
         {
            return;
         }
         _orderList = param1;
      }
   }
}

