package com.oyunstudyosu.quest
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.quest.commands.HideTargetBotCommand;
   import com.oyunstudyosu.quest.commands.LoadBotViewCommand;
   import flash.events.MouseEvent;
   
   public class QuestBot extends Character
   {
      
      private var hideCommand:HideTargetBotCommand;
      
      private var loadCommand:LoadBotViewCommand;
      
      public var vo:IQuestBotVo;
      
      public function QuestBot()
      {
         super();
      }
      
      public function initBot(param1:IQuestBotVo) : void
      {
         super.init(param1.botKey,Sanalika.instance.engine.scene,1,null,null);
         this.vo = param1;
         avatarName = $(param1.botKey);
         hideCommand = new HideTargetBotCommand(param1.botKey);
         hideCommand.execute();
         loadCommand = new LoadBotViewCommand(this);
         loadCommand.execute();
         Dispatcher.addEventListener("TERMINATE_SCENE",terminateScene);
         reLocate(param1.posX,param1.posY,3);
         container.addEventListener("click",botClicked);
         container.addEventListener("rollOver",questBotOver);
         container.addEventListener("rollOut",questBotOut);
         container.mouseChildren = false;
      }
      
      protected function questBotOver(param1:MouseEvent) : void
      {
         TweenMax.to(container,0,{"glowFilter":{
            "color":16777215,
            "alpha":1,
            "blurX":4,
            "blurY":4,
            "strength":4
         }});
      }
      
      protected function questBotOut(param1:MouseEvent) : void
      {
         TweenMax.to(container,0,{"glowFilter":{
            "color":16777215,
            "alpha":0,
            "blurX":0,
            "blurY":0,
            "strength":0
         }});
      }
      
      protected function botClicked(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function terminateScene(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("TERMINATE_SCENE",terminateScene);
         dispose();
      }
      
      public function botTalk(param1:String) : void
      {
         super.talk(param1,5,1);
      }
      
      override public function dispose() : void
      {
         container.removeEventListener("click",botClicked);
         container.removeEventListener("rollOver",questBotOver);
         container.removeEventListener("rollOut",questBotOut);
         super.dispose();
      }
   }
}

