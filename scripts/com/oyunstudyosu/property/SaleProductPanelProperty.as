package com.oyunstudyosu.property
{
   import com.oyunstudyosu.panel.PanelVO;
   
   public class SaleProductPanelProperty extends PanelProperty
   {
      
      public function SaleProductPanelProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         trace("SaleProductPanel");
         var _loc2_:PanelVO = new PanelVO("SaleProductPanel");
         _loc2_.type = "static";
         _loc2_.params = data;
         _loc2_.params.botKey = param1;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
   }
}

