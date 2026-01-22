package com.oyunstudyosu.property
{
   import com.oyunstudyosu.panel.PanelVO;
   
   public class RoomPanelProperty extends Property
   {
      
      public function RoomPanelProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc2_:PanelVO = new PanelVO("RoomListPanel");
         _loc2_.type = "hud";
         _loc2_.params = data;
         _loc2_.params.doorKey = param1;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
   }
}

