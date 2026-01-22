package com.oyunstudyosu.quest.commands
{
   import com.oyunstudyosu.bot.IBotVO;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   
   public class HideTargetBotCommand extends Command
   {
      
      private var botVo:IBotVO;
      
      private var bot:ISpeechable;
      
      private var metaKey:String;
      
      public function HideTargetBotCommand(param1:String)
      {
         super();
         this.metaKey = param1;
      }
      
      override public function execute() : void
      {
         var _loc4_:int = 0;
         if(!Sanalika.instance.engine.scene.existsComponent(SceneBotComponent))
         {
            return;
         }
         var _loc3_:SceneBotComponent = Sanalika.instance.engine.scene.getComponent(SceneBotComponent) as SceneBotComponent;
         var _loc1_:int = Sanalika.instance.roomModel.botModel.count;
         var _loc2_:Array = Sanalika.instance.roomModel.botModel.keyList;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            botVo = Sanalika.instance.roomModel.botModel.getBotByKey(_loc2_[_loc4_]);
            if(botVo && botVo.metaKey == metaKey)
            {
               bot = _loc3_.getBotByName(botVo.metaKey);
               if(bot)
               {
                  bot.getClip().visible = false;
               }
            }
            _loc4_++;
         }
      }
   }
}

