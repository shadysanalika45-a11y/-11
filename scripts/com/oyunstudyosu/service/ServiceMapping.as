package com.oyunstudyosu.service
{
   import com.oyunstudyosu.enums.RequestDataKey;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PurchaseEvent;
   import com.oyunstudyosu.sanalika.interfaces.IServiceMapping;
   import flash.utils.Dictionary;
   
   public class ServiceMapping implements IServiceMapping
   {
      
      public static const IMMORTAL:int = 18000;
      
      public static const TIME_10S:int = 10;
      
      public static const TIME_30S:int = 30;
      
      public static const TIME_60S:int = 60;
      
      private var map:Dictionary;
      
      private var date:Date;
      
      private var saveTime:int = 30;
      
      public function ServiceMapping()
      {
         super();
         this.map = new Dictionary(false);
         Dispatcher.addEventListener(PurchaseEvent.FLAT_PURCHASE_COMPLETED,this.flatCacheClear);
      }
      
      private function flatCacheClear(param1:PurchaseEvent) : void
      {
         var _loc2_:Object = param1.succesfullFlatList[0];
         var _loc3_:Array = String(_loc2_.clip).split("_");
         var _loc4_:int = int(_loc3_[_loc3_.length - 1]);
         this.clear(RequestDataKey.FLAT_LIST + "_" + _loc4_);
      }
      
      public function add(param1:String, param2:Object, param3:int = 60) : void
      {
         this.date = new Date();
         this.map[param1] = {
            "data":param2,
            "mapTime":this.date.getTime(),
            "saveTime":param3
         };
      }
      
      public function contains(param1:String) : Object
      {
         var _loc2_:int = 0;
         if(this.map[param1])
         {
            this.date = new Date();
            _loc2_ = (this.date.getTime() - this.map[param1].mapTime) / 1000;
            if(this.map[param1].saveTime == IMMORTAL || _loc2_ < this.map[param1].saveTime)
            {
               return this.map[param1].data;
            }
            delete this.map[param1];
         }
         return null;
      }
      
      public function clear(param1:String) : void
      {
         if(this.map[param1])
         {
            delete this.map[param1];
         }
      }
   }
}

