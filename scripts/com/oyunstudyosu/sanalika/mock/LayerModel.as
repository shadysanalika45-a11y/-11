package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.sanalika.interfaces.ILayerModel;
   import flash.display.Sprite;
   import flash.display.Stage;
   
   public class LayerModel implements ILayerModel
   {
      
      protected var _stage:Stage;
      
      public function LayerModel(param1:Stage)
      {
         super();
         this._stage = param1;
      }
      
      public function get notificationMessageLayer() : Sprite
      {
         return null;
      }
      
      public function get stage() : Stage
      {
         return this._stage;
      }
      
      public function get backgroundLayer() : Sprite
      {
         return null;
      }
      
      public function get pageLayer() : Sprite
      {
         return null;
      }
      
      public function get panelLayer() : Sprite
      {
         return null;
      }
      
      public function get hudLayer() : Sprite
      {
         return null;
      }
      
      public function get gameLayer() : Sprite
      {
         return null;
      }
      
      public function get businessMessageLayer() : Sprite
      {
         return null;
      }
      
      public function get canvasHeight() : int
      {
         return 0;
      }
      
      public function get canvasWidth() : int
      {
         return 0;
      }
      
      public function get effectLayer() : Sprite
      {
         return null;
      }
      
      public function get gameHeight() : int
      {
         return 0;
      }
      
      public function set gameHeight(param1:int) : void
      {
      }
      
      public function get gameScale() : Number
      {
         return 0;
      }
      
      public function set gameScale(param1:Number) : void
      {
      }
      
      public function get gameWidth() : int
      {
         return 0;
      }
      
      public function set gameWidth(param1:int) : void
      {
      }
      
      public function set canvasHeight(param1:int) : void
      {
      }
      
      public function set canvasWidth(param1:int) : void
      {
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
      }
      
      public function get botMessageLayer() : Sprite
      {
         return null;
      }
   }
}

