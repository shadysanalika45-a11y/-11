package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   
   public class ConnectCommand extends Command
   {
      
      private var sfs:SmartFox;
      
      public function ConnectCommand()
      {
         super();
         sfs = Sanalika.instance.serviceModel.sfs;
      }
      
      override public function execute() : void
      {
         sfs.addEventListener("connection",onConnection);
         sfs.addEventListener("connectionResume",onConnectionResume);
         if(Sanalika.instance.gameModel.serverName == "local")
         {
            Sanalika.instance.gameModel.chatServer = "26.1.130.254";
         }
         else
         {
            Sanalika.instance.gameModel.chatServer = "26.1.130.254";
         }
         sfs.useWebSocket = true;
         sfs.useSSL = false;
         sfs.connect(Sanalika.instance.gameModel.chatServer,sfs.useSSL ? 8443 : 8080);
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.CONNECTING));
      }
      
      private function onConnection(param1:SFSEvent) : void
      {
         if(param1.params.success)
         {
            trace("sfs connected");
            Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.CONNECTED));
            complete();
            dispose();
         }
         else
         {
            Dispatcher.dispatchEvent(new GameEvent("RELOAD"));
            trace("Connection Failure: " + param1.params.errorMessage);
         }
      }
      
      private function onConnectionResume(param1:SFSEvent) : void
      {
         trace("onConnectionResume()");
         dispose();
      }
      
      private function dispose() : void
      {
         sfs.removeEventListener("connection",onConnection);
         sfs.removeEventListener("connectionResume",onConnectionResume);
         sfs = null;
      }
   }
}

