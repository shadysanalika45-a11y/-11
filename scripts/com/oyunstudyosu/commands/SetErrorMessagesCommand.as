package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.local.LocalTranslation;
   import com.smartfoxserver.v2.util.SFSErrorCodes;
   
   public class SetErrorMessagesCommand extends Command
   {
      
      public function SetErrorMessagesCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         SFSErrorCodes.setErrorMessage(4,"{0} {1}");
         SFSErrorCodes.setErrorMessage(10000,LocalTranslation.translate("LOGIN_ACCOUNT_REVIEWING"));
         SFSErrorCodes.setErrorMessage(10001,LocalTranslation.translate("LOGIN_IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED"));
         SFSErrorCodes.setErrorMessage(10002,LocalTranslation.translate("IP_ADDRESS_MAXIMUM_CONNECTION_LIMIT_EXCEEDED"));
         complete();
      }
   }
}

