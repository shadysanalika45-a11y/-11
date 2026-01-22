package com.oyunstudyosu.game.partyisland.components
{
   import com.oyunstudyosu.assets.AssetRequestQueue;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.scene.components.SceneProcessDataComponent;
   
   public class IslandProcessDataComponent extends SceneProcessDataComponent
   {
      
      private static const UI_ASSET:String = "SanalikaPartyIslandUI";
      
      public function IslandProcessDataComponent(param1:IScene)
      {
         super(param1);
      }
      
      override public function load() : void
      {
         trace("IslandProcessDataComponent.load()");
         super.load();
      }
      
      override protected function onLoaded(param1:AssetRequestQueue) : void
      {
         trace("onLoaded");
         super.onLoaded(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

