package com.oyunstudyosu.property
{
   import com.oyunstudyosu.panel.PanelVO;
   
   public class InviteGiftProperty extends Property
   {
      
      public function InviteGiftProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc2_:PanelVO = new PanelVO("InviteGiftPanel");
         _loc2_.type = "static";
         _loc2_.params = data;
         _loc2_.params.campaignID = data.campaignID;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
   }
}

