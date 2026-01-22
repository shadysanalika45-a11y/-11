package com.oyunstudyosu.commands.security
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   
   public class OpenSecurityKeyCommand extends Command
   {
      
      private var sessionID:String;
      
      private var serviceName:String;
      
      private var serviceRequestId:int;
      
      public function OpenSecurityKeyCommand(param1:String, param2:String, param3:int)
      {
         super();
         this.sessionID = param1;
         this.serviceName = param2;
         this.serviceRequestId = param3;
      }
      
      override public function execute() : void
      {
         var _loc1_:AlertVo = null;
         trace(Sanalika.instance.gameModel.isSecurityKeyViewOpened);
         if(!Sanalika.instance.gameModel.isSecurityKeyViewOpened)
         {
            _loc1_ = new AlertVo();
            _loc1_.alertType = "SecurityKey";
            _loc1_.panelType = "alert";
            _loc1_.secretSession = sessionID;
            _loc1_.data = {
               "sn":serviceName,
               "rid":serviceRequestId,
               "closeable":serviceName != "init"
            };
            _loc1_.title = $("SecurityKey");
            Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
            complete();
         }
      }
   }
}

