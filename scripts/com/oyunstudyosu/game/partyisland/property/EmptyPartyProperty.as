package com.oyunstudyosu.game.partyisland.property
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.game.partyisland.components.IslandSceneHudComponent;
   
   public class EmptyPartyProperty implements IPartyProperty
   {
      
      public function EmptyPartyProperty()
      {
         super();
      }
      
      public function execute(param1:String, param2:Object) : void
      {
      }
      
      protected function setText(param1:String, param2:Array = null) : void
      {
         var _loc3_:IslandSceneHudComponent = null;
         if(Sanalika.instance.engine.scene.existsComponent(IslandSceneHudComponent))
         {
            if(param2 == null)
            {
               param2 = [];
            }
            _loc3_ = Sanalika.instance.engine.scene.getComponent(IslandSceneHudComponent) as IslandSceneHudComponent;
            _loc3_.updateNotifyText(param1,param2);
         }
      }
      
      protected function getAvatarById(param1:String) : ICharacter
      {
         var _loc2_:ISceneCharacterComponent = null;
         if(Sanalika.instance.engine.scene.existsComponent(ISceneCharacterComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(ISceneCharacterComponent) as ISceneCharacterComponent;
            return _loc2_.getAvatarById(param1);
         }
         return null;
      }
   }
}

