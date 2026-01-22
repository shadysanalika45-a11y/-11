package com.oyunstudyosu.property
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   
   public class ExchangeProperty extends Property
   {
      
      public function ExchangeProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc3_:AlertVo = null;
         var _loc2_:int = parseInt(Sanalika.instance.avatarModel.balance("DIAMOND"));
         if(_loc2_ < 1)
         {
            return;
         }
         _loc3_ = new AlertVo();
         _loc3_.alertType = "ExChange";
         _loc3_.title = $("ExChangePanel");
         _loc3_.callBack = exhangeQuantityResponse;
         _loc3_.minQuantity = 1;
         _loc3_.stepSize = 1;
         _loc3_.maxQuantity = _loc2_ <= 1000 ? _loc2_ : 1000;
         Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
      }
      
      private function exhangeQuantityResponse(param1:int, param2:int = -1) : void
      {
         if(param1 == 2 && param2 > 0)
         {
            Sanalika.instance.serviceModel.requestData("exchangediamond",{"diamondQuantity":param2},null);
         }
      }
   }
}

