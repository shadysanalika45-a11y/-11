package com.oyunstudyosu.sanalika.interfaces
{
   public interface IOrderModel
   {
      
      function get orderCount() : int;
      
      function get orderList() : Array;
      
      function set orderList(param1:Array) : void;
      
      function get orderRequest() : Object;
      
      function set orderRequest(param1:Object) : void;
      
      function findOrderIndexById(param1:int) : int;
   }
}

