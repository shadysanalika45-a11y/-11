package com.oyunstudyosu.property
{
   public class FlatExitProperty extends Property
   {
      
      public function FlatExitProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         Sanalika.instance.roomModel.doorModel.busy = true;
         Sanalika.instance.roomModel.mapInitalized = false;
         Sanalika.instance.serviceModel.requestData("usedoor",{
            "key":param1,
            "type":data.type
         },null);
      }
   }
}

