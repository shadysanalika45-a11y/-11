package com.oyunstudyosu.engine
{
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   
   public interface IIsoElement extends IEventDispatcher
   {
      
      function get container() : Sprite;
      
      function set container(param1:Sprite) : void;
      
      function get id() : String;
      
      function set id(param1:String) : void;
      
      function get currentTile() : IntPoint;
      
      function set currentTile(param1:IntPoint) : void;
   }
}

