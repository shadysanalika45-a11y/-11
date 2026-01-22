package com.oyunstudyosu.panel
{
   import flash.events.IEventDispatcher;
   
   public interface IPanel extends IEventDispatcher
   {
      
      function init() : void;
      
      function dispose() : void;
      
      function show() : void;
      
      function get isDisposed() : Boolean;
      
      function get data() : PanelVO;
      
      function set data(param1:PanelVO) : void;
   }
}

