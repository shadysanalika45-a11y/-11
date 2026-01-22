package com.oyunstudyosu.quest.commands
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.quest.QuestBot;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import flash.display.MovieClip;
   
   public class LoadBotViewCommand extends Command
   {
      
      private var questBot:QuestBot;
      
      private var swfPath:String;
      
      private var request:AssetRequest;
      
      private var botClip:MovieClip;
      
      public function LoadBotViewCommand(param1:QuestBot)
      {
         super();
         this.questBot = param1;
      }
      
      override public function execute() : void
      {
         trace("quest.LoadBotViewCommand");
         swfPath = Sanalika.instance.moduleModel.getPath(questBot.vo.botKey,"ModuleType.BOT") + ".swf?v";
         request = new AssetRequest();
         request.assetId = swfPath;
         request.type = "ModuleType.BOT";
         request.loadedFunction = onLoaded;
         request.errorFunction = onError;
         request.context = Sanalika.instance.domainModel.subContext;
         Sanalika.instance.assetModel.request(request);
      }
      
      private function onError(param1:Object) : void
      {
         request.dispose();
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc2_:Class = DefinitionUtils.getClass(param1.context.applicationDomain,questBot.vo.botKey);
         if(_loc2_)
         {
            botClip = new _loc2_();
            questBot.container.addChild(botClip);
            botClip.gotoAndStop(1);
         }
         param1.dispose();
      }
   }
}

