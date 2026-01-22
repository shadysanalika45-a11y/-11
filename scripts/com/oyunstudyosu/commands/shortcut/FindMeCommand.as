package com.oyunstudyosu.commands.shortcut
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import flash.display.Sprite;
   
   public class FindMeCommand extends Command
   {
      
      public function FindMeCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(Sanalika.instance.engine == null || Sanalika.instance.engine.scene == null)
         {
            return;
         }
         if(Sanalika.instance.engine == null || !Sanalika.instance.engine.sceneLoaded || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         var _loc1_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc1_.myChar;
         var _loc2_:Sprite = _loc3_.container;
         if(_loc2_ != null)
         {
            TweenMax.killTweensOf(_loc2_);
            TweenMax.to(_loc2_,0,{
               "glowFilter":{
                  "color":9561600,
                  "alpha":0,
                  "blurX":0,
                  "blurY":0
               },
               "scaleX":1,
               "scaleY":1
            });
            TweenMax.to(_loc2_,0.3,{
               "glowFilter":{
                  "color":16777011,
                  "alpha":1,
                  "blurX":15,
                  "blurY":15,
                  "strength":3
               },
               "repeat":9999,
               "yoyo":true
            });
         }
      }
   }
}

