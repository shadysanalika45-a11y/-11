package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.Stage;
   
   public class BaseSceneComponent implements ISceneComponent
   {
      
      protected var scene:IScene;
      
      protected var isDisposed:Boolean = false;
      
      public function BaseSceneComponent(param1:IScene)
      {
         super();
         this.scene = param1;
      }
      
      public function get stage() : Stage
      {
         return Connectr.instance.stage;
      }
      
      public function enable() : void
      {
      }
      
      public function disable() : void
      {
      }
      
      public function dispose() : void
      {
         throw new Error("Not implemented");
      }
   }
}

