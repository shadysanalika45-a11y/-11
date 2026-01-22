package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.service.IServiceModel;
   import com.oyunstudyosu.service.ServiceErrorCode;
   
   public class ConfigCommand extends Command
   {
      
      private var serviceModel:IServiceModel;
      
      public function ConfigCommand()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
      }
      
      override public function execute() : void
      {
         serviceModel.requestData("config",{},responseFunction);
      }
      
      private function responseFunction(param1:Object) : void
      {
         trace("data: " + param1);
         trace("string: " + JSON.stringify(param1));
         trace("0");
         Sanalika.instance.buddyModel.moods = param1.moods;
         trace("1");
         Sanalika.instance.chatBalloonModel.activeBalloons = param1.chatBaloons;
         trace("2");
         Sanalika.instance.gameModel.itemInfoFile = "/static/" + param1.itemFile;
         Sanalika.instance.gameModel.versionFile = "/static/" + param1.versionFile;
         Sanalika.instance.gameModel.languageFileVersion = "/static/" + param1.langFile + ".mo";
         Sanalika.instance.gameModel.fileServer = param1.fileServer[0] + "/global";
         Sanalika.instance.gameModel.webServer = param1.webServer;
         Sanalika.instance.gameModel.firewall = "ACTIVE";
         Sanalika.instance.gameModel.language = param1.language;
         trace("3");
         Sanalika.instance.gameModel.farmCleaningCost = param1.farmCleaningCost;
         Sanalika.instance.gameModel.farmMaxPlantedItemSize = param1.farmMaxPlantedItemSize;
         Sanalika.instance.gameModel.avatarOrderLifeTime = param1.order.avatarOrderLifeTime;
         Sanalika.instance.gameModel.orderLifeTime = param1.order.orderLifeTime;
         Sanalika.instance.gameModel.prepareLifeTime = param1.order.prepareLifeTime;
         trace("4");
         if(param1.roomTheme)
         {
            Sanalika.instance.gameModel.roomTheme = param1.roomTheme;
         }
         trace("devam 1");
         ServiceErrorCode.setData(param1.masterRoles);
         trace("devam 2");
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.CONFIG_READY));
         complete();
         serviceModel = null;
      }
   }
}

