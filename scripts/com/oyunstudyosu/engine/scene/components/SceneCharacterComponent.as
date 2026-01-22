package com.oyunstudyosu.engine.scene.components
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import flash.utils.Dictionary;
   
   public class SceneCharacterComponent extends BaseSceneComponent implements ISceneCharacterComponent
   {
      
      private var _characterList:Dictionary;
      
      private var _myChar:ICharacter;
      
      public function SceneCharacterComponent(param1:IScene)
      {
         super(param1);
         _characterList = new Dictionary();
      }
      
      public function get characterList() : Dictionary
      {
         return _characterList;
      }
      
      public function set characterList(param1:Dictionary) : void
      {
         _characterList = param1;
      }
      
      public function get myChar() : ICharacter
      {
         return _myChar;
      }
      
      public function set myChar(param1:ICharacter) : void
      {
         _myChar = param1;
      }
      
      public function addChar(param1:ICharacter) : void
      {
         characterList[param1.id] = param1;
      }
      
      public function existsWithCharacter(param1:ICharacter) : Boolean
      {
         return existsWithAvatarId(param1.id);
      }
      
      public function existsWithAvatarId(param1:String) : Boolean
      {
         return characterList[param1] != null;
      }
      
      public function singleMode(param1:Boolean) : void
      {
         for each(var _loc2_ in characterList)
         {
            if(!_loc2_.isMe && !_loc2_.isNPC)
            {
               _loc2_.hide = param1;
            }
         }
      }
      
      public function getCharByTile(param1:IntPoint) : ICharacter
      {
         for(var _loc2_ in characterList)
         {
            if(_loc2_.currentTile.equals(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAvatarById(param1:String) : ICharacter
      {
         return characterList[param1];
      }
      
      public function removeWithCharacter(param1:ICharacter) : Boolean
      {
         return removeWithAvatarId(param1.id);
      }
      
      public function removeWithAvatarId(param1:String) : Boolean
      {
         var _loc2_:ICharacter = getAvatarById(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         delete characterList[param1];
         _loc2_.terminate();
         if(_loc2_ == myChar)
         {
            _myChar = null;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         isDisposed = true;
         _myChar = null;
         for each(var _loc1_ in characterList)
         {
            _loc1_.terminate();
         }
         characterList = new Dictionary();
      }
   }
}

