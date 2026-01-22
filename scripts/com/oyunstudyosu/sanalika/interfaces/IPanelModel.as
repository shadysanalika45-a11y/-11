package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.panel.IPanel;
   import com.oyunstudyosu.panel.PanelVO;
   
   public interface IPanelModel
   {
      
      function showBg(param1:PanelVO, param2:IPanel) : void;
      
      function openPanel(param1:PanelVO) : void;
      
      function isOpen(param1:String) : Boolean;
      
      function getLatestPanel() : IPanel;
      
      function dispose() : void;
      
      function clearPanelsByType(param1:String, param2:Boolean = false) : void;
   }
}

