package com.oyunstudyosu.property
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   
   public class FrameProperty extends Property
   {
      
      private var obj:IEntryVo;
      
      public function FrameProperty()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc2_:AlertVo = null;
         trace("FramePropertyExecute");
         if(Sanalika.instance.avatarModel.permission.check(20) || data.anyone == "1" || Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            Sanalika.instance.serviceModel.requestData("changeobjectframe",{"id":data.metaKey},onFrameChange);
         }
         else
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $("onlyOwnerCanInteract");
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
      }
      
      private function onFrameChange(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("changeobjectframe",onFrameChange);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

