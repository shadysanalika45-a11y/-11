package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.local.LocalizationModel;
   import com.oyunstudyosu.model.ToolTipModel;
   import com.oyunstudyosu.progress.ProgressVo;
   import flash.events.Event;
   
   public class LocalizationCommand extends Command
   {
      
      public function LocalizationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         Sanalika.instance.localizationModel = new LocalizationModel();
         Sanalika.instance.toolTipModel = new ToolTipModel();
         Dispatcher.addEventListener("LOCALIZATION_DATA_READY",onComplete);
         var _loc1_:Object = {};
         _loc1_.stage = Sanalika.instance.layerModel.stage;
         _loc1_.toolTipModel = Sanalika.instance.toolTipModel;
         _loc1_.language = Sanalika.instance.gameModel.language;
         _loc1_.fileServer = Sanalika.instance.gameModel.fileServer;
         _loc1_.version = Sanalika.instance.gameModel.languageFileVersion;
         Sanalika.instance.localizationModel.init(_loc1_);
      }
      
      public function onComplete(param1:Event) : void
      {
         complete();
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.LANG_FILE_READY));
      }
   }
}

