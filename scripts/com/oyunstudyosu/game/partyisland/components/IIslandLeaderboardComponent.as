package com.oyunstudyosu.game.partyisland.components
{
   import com.oyunstudyosu.engine.scene.components.ISceneComponent;
   
   public interface IIslandLeaderboardComponent extends ISceneComponent
   {
      
      function get orderedItems() : Array;
      
      function set orderedItems(param1:Array) : void;
   }
}

