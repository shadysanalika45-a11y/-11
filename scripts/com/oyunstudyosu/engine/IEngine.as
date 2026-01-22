package com.oyunstudyosu.engine
{
   import flash.events.IEventDispatcher;
   
   public interface IEngine extends IEventDispatcher
   {
      
      function changeScene() : void;
      
      function showScene() : void;
      
      function loadIsoDesigner() : void;
      
      function reset() : void;
      
      function reload() : void;
      
      function terminate() : void;
      
      function get scene() : IScene;
      
      function set scene(param1:IScene) : void;
   }
}

