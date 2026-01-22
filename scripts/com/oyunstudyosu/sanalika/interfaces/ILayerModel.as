package com.oyunstudyosu.sanalika.interfaces
{
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public interface ILayerModel
   {
      
      function get backgroundLayer() : Sprite;
      
      function get pageLayer() : Sprite;
      
      function get panelLayer() : Sprite;
      
      function get hudLayer() : Sprite;
      
      function get gameLayer() : Sprite;
      
      function get effectLayer() : Sprite;
      
      function get businessMessageLayer() : Sprite;
      
      function get notificationMessageLayer() : Sprite;
      
      function get botMessageLayer() : Sprite;
      
      function get stage() : Stage;
      
      function updateSize(param1:int, param2:int) : void;
      
      function get canvasWidth() : int;
      
      function set canvasWidth(param1:int) : void;
      
      function get canvasHeight() : int;
      
      function set canvasHeight(param1:int) : void;
      
      function get gameWidth() : int;
      
      function set gameWidth(param1:int) : void;
      
      function get gameHeight() : int;
      
      function set gameHeight(param1:int) : void;
      
      function get gameScale() : Number;
      
      function set gameScale(param1:Number) : void;
   }
}

