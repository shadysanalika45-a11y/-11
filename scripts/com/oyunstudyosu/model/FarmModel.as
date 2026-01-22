package com.oyunstudyosu.model
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.FarmEvent;
   import com.oyunstudyosu.local.$;
   
   public class FarmModel
   {
      
      public var farmObjectID:int;
      
      public function FarmModel()
      {
         super();
         Dispatcher.addEventListener("FarmEvent.IMPLANT",farmImplant);
      }
      
      private function farmImplant(param1:FarmEvent) : void
      {
         trace("e.objectID",param1.id);
         trace("e.itemID",param1.itemID);
         Sanalika.instance.serviceModel.requestData("farmimplantation",{
            "id":param1.id,
            "itemID":param1.itemID
         },onImplantResponse);
      }
      
      private function onImplantResponse(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         Sanalika.instance.serviceModel.removeRequestData("farmimplantation",onImplantResponse);
         if(param1.errorCode)
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $(param1.errorCode);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         else if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            Dispatcher.dispatchEvent(new FarmEvent("FarmEvent.IMPLANTED"));
         }
      }
   }
}

