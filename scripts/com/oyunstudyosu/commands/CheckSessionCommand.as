package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.Dispatcher;
   import com.smartfoxserver.v2.requests.LogoutRequest;
   import flash.external.ExternalInterface;
   
   public class CheckSessionCommand extends Command
   {
      
      public function CheckSessionCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         complete();
      }
      
      private function checkSession() : void
      {
         if(ExternalInterface.available)
         {
            if(ExternalInterface.call("cs"))
            {
               complete();
            }
            else
            {
               logout();
            }
         }
         else
         {
            logout();
         }
      }
      
      private function logout() : void
      {
         alertHim();
         Sanalika.instance.cookieModel.stopCheck();
         Sanalika.instance.serviceModel.sfs.send(new LogoutRequest());
      }
      
      private function alertHim() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "Error";
         _loc1_.description = LanguageKeys.INSTANCE_CHECK_ERROR;
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
   }
}

