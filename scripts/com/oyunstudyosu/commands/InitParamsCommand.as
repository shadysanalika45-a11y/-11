package com.oyunstudyosu.commands
{
   import com.hurlant.util.Base64;
   import com.oyunstudyosu.assets.AssetModel;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.local.LocalInstanceConfig;
   import com.oyunstudyosu.local.LocalTranslation;
   import flash.display.Stage;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   
   public class InitParamsCommand extends Command
   {
      
      private var _params:Object;
      
      private var _stage:Stage;
      
      private var _sanalika:Sanalika;
      
      public function InitParamsCommand(param1:Stage, param2:Sanalika)
      {
         super();
         _params = param2.loaderInfo.parameters;
         _sanalika = param2;
         _stage = param1;
         ExternalInterface;
      }
      
      override public function execute() : void
      {
         setParams();
      }
      
      private function setParams() : void
      {
         var _loc1_:String = null;
         var _loc2_:Object = null;
         var _loc3_:String = null;
         trace("RELEASE");
         _loc1_ = _params.d;
         if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
         {
            _loc2_ = _params;
         }
         else
         {
            _loc3_ = Sanalika.instance.stage.loaderInfo.parameters.data;
            if(_loc3_ == null)
            {
               if(ExternalInterface.available)
               {
                  _loc3_ = ExternalInterface.call("Sanalika.getPRM");
               }
            }
            _loc2_ = JSON.parse(Base64.decode(_loc3_));
         }
         Sanalika.instance.gameModel.serverName = _loc2_.serverName;
         Sanalika.instance.gameModel.chatServer = _loc2_.chatServer;
         Sanalika.instance.gameModel.fileServer = _loc2_.fileServer;
         Sanalika.instance.gameModel.webServer = _loc2_.webServer;
         Sanalika.instance.gameModel.firewall = _loc2_.firewall;
         if(_loc2_.protocol)
         {
            Sanalika.instance.gameModel.protocol = _loc2_.protocol;
         }
         Sanalika.instance.gameModel.language = _loc2_.lang;
         if(_loc2_.ad)
         {
            Sanalika.instance.gameModel.agentData = _loc2_.ad;
         }
         Sanalika.instance.avatarModel.accessToken = _loc2_.at;
         Sanalika.instance.avatarModel.avatarId = _loc2_.aId;
         Sanalika.instance.avatarModel.playerId = _loc2_.pId;
         Sanalika.instance.avatarModel.location = _loc2_.location;
         Sanalika.instance.avatarModel.fbToken = _loc2_.fbToken;
         Sanalika.instance.gameModel.itemInfoFile = _loc2_.item;
         Sanalika.instance.gameModel.versionFile = _loc2_.version;
         Sanalika.instance.gameModel.languageFileVersion = _loc2_.locale;
         if(Sanalika.instance.airModel.isAndroid())
         {
            Sanalika.instance.avatarModel.platform = "android";
         }
         else
         {
            Sanalika.instance.avatarModel.platform = "app";
         }
         Sanalika.instance.assetModel = new AssetModel(_stage);
         LocalInstanceConfig.setInstance(Sanalika.instance.gameModel.serverName);
         LocalTranslation.setLanguage(LocalInstanceConfig._SafeStr_2("LANGUAGE"));
         Dispatcher.dispatchEvent(new GameEvent("INITCOMMAND"));
         complete();
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
