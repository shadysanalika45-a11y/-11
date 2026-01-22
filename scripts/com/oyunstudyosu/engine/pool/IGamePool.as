package com.oyunstudyosu.engine.pool
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.pool.chars.PoolItem;
   
   public interface IGamePool
   {
      
      function setValues(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void;
      
      function addItem(param1:ICharacter, param2:IScene) : void;
      
      function removeItem(param1:String) : void;
      
      function getItemByName(param1:String) : PoolItem;
      
      function updateItem(param1:String, param2:String) : void;
      
      function depthSort() : void;
   }
}

