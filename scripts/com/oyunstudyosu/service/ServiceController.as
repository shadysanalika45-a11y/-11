package com.oyunstudyosu.service
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.timer.SyncTimer;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import flash.events.Event;
   
   public class ServiceController
   {
      
      private var sfs:SmartFox;
      
      private var serviceModel:IServiceModel;
      
      private var isBlocked:Boolean;
      
      private var vo:AlertVo = new AlertVo();
      
      private var isRestartWaiting:Boolean = false;
      
      private var isReconnecting:Boolean = false;
      
      public function ServiceController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         sfs = serviceModel.sfs;
         sfs.addEventListener("logout",onLogout);
         sfs.addEventListener("connectionLost",onConnectionLost);
         sfs.addEventListener("connectionRetry",onConnectionRetry);
         sfs.addEventListener("connectionResume",onConnectionResume);
         sfs.addEventListener("moderatorMessage",onModeratorMessage);
         serviceModel.listenExtension("coreOldVersion",onCoreOldVersion);
         serviceModel.listenExtension("disconnect",onDisconnectHandler);
         serviceModel.listenExtension("reloadStart",onReloadStartHandler);
         serviceModel.listenExtension("reloadSuccess",onReloadSuccessHandler);
         serviceModel.listenExtension("requestTimeout",onRequestTimeoutHandler);
         serviceModel.listenExtension("restartServer",onRestartServerHandler);
      }
      
      private function onCoreOldVersion(param1:Object) : void
      {
         vo.alertType = "Error";
         vo.description = $("CoreOldVersion");
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function onRequestTimeoutHandler(param1:Object) : void
      {
         SyncTimer.setTimestamp(param1.ts);
         vo.alertType = "Error";
         vo.description = $("RequestTimeout");
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function onRestartServerHandler(param1:Object) : void
      {
         isRestartWaiting = param1.isRestartWaiting;
         if(isRestartWaiting)
         {
            vo.alertType = "Info";
            vo.description = Sanalika.instance.localizationModel.translate(param1.reason);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function onReloadStartHandler(param1:Object) : void
      {
         (serviceModel as ServiceModel).extensionIdle = true;
      }
      
      private function onReloadSuccessHandler(param1:Object) : void
      {
         (serviceModel as ServiceModel).extensionIdle = false;
      }
      
      protected function onLogout(param1:SFSEvent) : void
      {
         trace("sfsonLogout");
         trace("sfsonLogout");
         ServiceRequestRate.reset();
         serviceModel.deactivate();
         Dispatcher.dispatchEvent(new GameEvent("TERMINATE_GAME"));
         Dispatcher.dispatchEvent(new Event("initManual"));
      }
      
      protected function onModeratorMessage(param1:SFSEvent) : void
      {
         if(param1.params.message)
         {
            vo.alertType = "Info";
            vo.description = $(param1.params.message);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function onDisconnectHandler(param1:Object) : void
      {
         isBlocked = true;
         if(param1.reason == "BAN")
         {
            vo.alertType = "Info";
            vo.description = Sanalika.instance.localizationModel.translate(LanguageKeys.BANNED_BY_MODERATOR);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else if(param1.reason == "USER_ONLINE")
         {
            vo.alertType = "Info";
            vo.description = Sanalika.instance.localizationModel.translate(LanguageKeys.ALREADY_CONNECTED);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else if(param1.reason == "USER_IP_EXIST")
         {
            vo.alertType = "Info";
            vo.description = Sanalika.instance.localizationModel.translate(LanguageKeys.USER_IP_EXIST);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else if(param1.reason == "OTHER_DEVICE")
         {
            vo.alertType = "Error";
            vo.description = Sanalika.instance.localizationModel.translate(LanguageKeys.OTHERDEVICE);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else
         {
            vo.alertType = "Info";
            vo.description = "Error " + param1.reason;
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function onConnectionLost(param1:SFSEvent) : void
      {
         var _loc2_:String = param1.params.reason;
         trace("onConnectionLost",_loc2_);
         if(isReconnecting)
         {
            enable();
         }
         if(isRestartWaiting)
         {
            isRestartWaiting = false;
            Sanalika.instance.reset();
         }
         else if(_loc2_ != "manual")
         {
            trace("notManual");
            if(_loc2_ == "idle")
            {
               trace("reason:ClientDisconnectionReason.IDLE");
               vo.alertType = "Info";
               vo.description = LanguageKeys.INACTIVITY;
               vo.callBack = reload;
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            }
            else if(_loc2_ == "unknown")
            {
               trace("reason:ClientDisconnectionReason.UNKNOWN");
               if(!isBlocked)
               {
                  trace("try reconnect after 10 secs");
                  vo.alertType = "Info";
                  vo.description = LanguageKeys.DISCONNECTED;
                  vo.callBack = reload;
                  Dispatcher.dispatchEvent(new AlertEvent(vo));
                  isBlocked = false;
                  return;
               }
            }
            else if(!isBlocked)
            {
               vo.alertType = "Error";
               vo.description = LanguageKeys.OTHERDEVICE;
               Dispatcher.dispatchEvent(new AlertEvent(vo));
               isBlocked = false;
               return;
            }
         }
         Dispatcher.dispatchEvent(new GameEvent("TERMINATE_GAME"));
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.PROGRESS_FULL));
      }
      
      private function reload(param1:Object) : void
      {
         Sanalika.instance.engine.reload();
      }
      
      private function onConnectionRetry(param1:SFSEvent) : void
      {
         trace("onConnectionRetry()");
         isReconnecting = true;
         disable();
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "Reconnecting";
         _loc2_.title = Sanalika.instance.localizationModel.translate("ReconnectingTitle");
         _loc2_.description = Sanalika.instance.localizationModel.translate("ReconnectingMessage");
         _loc2_.panelType = "alert";
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function onConnectionResume(param1:SFSEvent) : void
      {
         trace("onConnectionResume()");
         isReconnecting = false;
         enable();
      }
      
      private function disable() : void
      {
         Sanalika.instance.stage.mouseChildren = false;
         Sanalika.instance.engine.scene.disable();
      }
      
      private function enable() : void
      {
         Sanalika.instance.stage.mouseChildren = true;
         Sanalika.instance.engine.scene.enable();
      }
   }
}

