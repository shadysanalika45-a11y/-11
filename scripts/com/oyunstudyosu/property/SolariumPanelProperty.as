package com.oyunstudyosu.property
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.PanelVO;
   
   public class SolariumPanelProperty extends Property
   {
      
      private var obj:IEntryVo;
      
      public function SolariumPanelProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc2_:PanelVO = null;
         trace("SolariumPanelProperty");
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            obj = Sanalika.instance.entryModel.getObjectById(param1);
            if(obj.s)
            {
               Sanalika.instance.serviceModel.requestData("avatarsalescollect",{"id":data.metaKey},onStateChange);
            }
         }
         else
         {
            _loc2_ = new PanelVO("SolariumPanel");
            _loc2_.type = "static";
            _loc2_.params = data;
            _loc2_.params.doorKey = param1;
            Sanalika.instance.panelModel.openPanel(_loc2_);
         }
      }
      
      private function onStateChange(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("avatarsalescollect",onStateChange);
         var _loc3_:String = "";
         for each(var _loc4_ in param1.gains)
         {
            _loc3_ += " | " + _loc4_.amount + ": " + _loc4_.currency;
         }
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = $("Revenue") + _loc3_;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
   }
}

