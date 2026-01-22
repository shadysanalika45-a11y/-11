package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.HudEvent;
   
   public interface IHudModel
   {
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function init() : void;
      
      function addHudEvents() : void;
      
      function removeHudEvents() : void;
      
      function addSpesificListener(param1:String, param2:Function) : void;
      
      function removeSpesificListener(param1:String, param2:Function) : void;
      
      function openInventoryPanel(param1:HudEvent = null) : void;
      
      function setQuestIndicator(param1:int) : void;
      
      function onSceneResize(param1:GameEvent) : void;
      
      function dispose() : void;
   }
}

