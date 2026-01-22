package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IntPoint;
   import flash.utils.Dictionary;
   
   public interface ISceneCharacterComponent extends ISceneComponent
   {
      
      function get characterList() : Dictionary;
      
      function get myChar() : ICharacter;
      
      function set myChar(param1:ICharacter) : void;
      
      function addChar(param1:ICharacter) : void;
      
      function existsWithCharacter(param1:ICharacter) : Boolean;
      
      function existsWithAvatarId(param1:String) : Boolean;
      
      function singleMode(param1:Boolean) : void;
      
      function getCharByTile(param1:IntPoint) : ICharacter;
      
      function getAvatarById(param1:String) : ICharacter;
      
      function removeWithCharacter(param1:ICharacter) : Boolean;
      
      function removeWithAvatarId(param1:String) : Boolean;
   }
}

