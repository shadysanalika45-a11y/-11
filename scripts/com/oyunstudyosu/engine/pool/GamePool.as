package com.oyunstudyosu.engine.pool
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.pool.chars.PoolItem;
   import com.oyunstudyosu.engine.pool.manager.GamePoolManager;
   import com.oyunstudyosu.engine.pool.model.GamePoolModel;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class GamePool extends MovieClip implements IGamePool
   {
      
      public var location:Point;
      
      public var poolWidth:int = 10;
      
      public var poolHeight:int = 10;
      
      public var poolDepth:int = 0;
      
      public var gameSuits:Array;
      
      public var bounds:Shape;
      
      public var gameusers:Vector.<PoolItem> = new Vector.<PoolItem>();
      
      public var gameType:int;
      
      private var gamePoolManager:GamePoolManager;
      
      public function GamePool()
      {
         super();
      }
      
      public function setValues(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         gamePoolManager = new GamePoolManager();
         location = new Point(param1,param2);
         poolWidth = param4;
         poolHeight = param5;
         poolDepth = param3;
         gameType = param6;
         if(gameType == 1)
         {
            gameSuits = GamePoolModel.swimsuits;
         }
         if(gameType == 2)
         {
            gameSuits = GamePoolModel.icesuits;
         }
         bounds = new Shape();
         bounds.graphics.beginFill(0);
         bounds.graphics.drawRect(0,0,poolWidth,poolHeight);
         bounds.x = poolWidth;
         bounds.y = poolHeight;
         bounds.graphics.endFill();
      }
      
      public function addItem(param1:ICharacter, param2:IScene) : void
      {
         gamePoolManager.addItem(this,param1,param2);
      }
      
      public function getItemByName(param1:String) : PoolItem
      {
         return gamePoolManager.getItemByName(this,param1);
      }
      
      public function removeItem(param1:String) : void
      {
         gamePoolManager.removeItem(this,param1);
      }
      
      public function updateItem(param1:String, param2:String) : void
      {
         gamePoolManager.updateItem(this,param1,param2);
      }
      
      public function depthSort() : void
      {
         gamePoolManager.depthSort(this);
      }
   }
}

