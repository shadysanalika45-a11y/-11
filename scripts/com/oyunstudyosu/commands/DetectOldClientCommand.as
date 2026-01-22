package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   
   public class DetectOldClientCommand extends Command
   {
      
      public function DetectOldClientCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:AlertVo = null;
         var _loc3_:String = Capabilities.version.split(" ")[0];
         var _loc4_:String = Capabilities.version.split(" ")[1];
         var _loc1_:int = int(_loc4_.split(",")[0]);
         if(_loc3_ == "MAC" && _loc1_ < 50)
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "Error";
            _loc2_.description = Sanalika.instance.localizationModel.translate("Your app is expired, please download the new version.");
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
            navigateToURL(new URLRequest(Sanalika.instance.gameModel.webServer + "/download"));
            return;
         }
         complete();
      }
   }
}

