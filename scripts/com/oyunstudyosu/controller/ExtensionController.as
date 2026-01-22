package com.oyunstudyosu.controller
{
   public class ExtensionController
   {
      
      public function ExtensionController()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("startextension",onStartExtension);
         Sanalika.instance.serviceModel.listenExtension("stopextension",onStopExtension);
      }
      
      protected function onStartExtension(param1:Object) : void
      {
         trace("startextension:" + JSON.stringify(param1));
         if(Sanalika.instance.extensionModel.getExtensionByName(param1.key))
         {
            trace("Extension already loaded!");
            Sanalika.instance.extensionModel.removeExtension(param1.key);
         }
         Sanalika.instance.extensionModel.loadExtension(param1.key,param1.property,0);
      }
      
      protected function onStopExtension(param1:Object) : void
      {
         trace("onStopExtension");
         Sanalika.instance.extensionModel.removeExtension(param1.key);
      }
   }
}

