package com.oyunstudyosu.property
{
   public class TeleportProperty extends Property
   {
      
      public function TeleportProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         Sanalika.instance.serviceModel.requestData("teleport",{"roomKey":data.roomKey},null);
         Sanalika.instance.roomModel.doorModel.busy = true;
         Sanalika.instance.roomModel.mapInitalized = false;
      }
   }
}

