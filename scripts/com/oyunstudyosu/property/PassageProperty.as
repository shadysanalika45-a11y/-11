package com.oyunstudyosu.property
{
   public class PassageProperty extends Property
   {
      
      public function PassageProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         if(data.type == "door")
         {
            return;
         }
         Sanalika.instance.roomModel.doorModel.busy = true;
         Sanalika.instance.roomModel.mapInitalized = false;
         Sanalika.instance.serviceModel.requestData("usedoor",{
            "key":param1,
            "type":data.type
         },null);
      }
   }
}

