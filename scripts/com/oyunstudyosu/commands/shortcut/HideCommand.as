package com.oyunstudyosu.commands.shortcut
{
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   
   public class HideCommand extends Command
   {
      
      public function HideCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         Sanalika.instance.avatarModel.isHideMode = !Sanalika.instance.avatarModel.isHideMode;
         process();
      }
      
      private function process() : void
      {
         if(Sanalika.instance.engine == null || !Sanalika.instance.engine.scene == null)
         {
            return;
         }
         var _loc1_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         if(_loc1_ != null)
         {
            _loc1_.singleMode(Sanalika.instance.avatarModel.isHideMode);
         }
         Sanalika.instance.engine.scene.ceilingContainer.visible = !Sanalika.instance.avatarModel.isHideMode;
      }
   }
}

