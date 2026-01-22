package com.oyunstudyosu.debug
{
   import com.adobe.serialization.json.JSON;
   import com.junkbyte.console.Cc;
   
   public class DebugModel
   {
      
      private var objectVector:Vector.<Object> = new Vector.<Object>();
      
      public function DebugModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("consoleLog",onConsoleLog);
         Sanalika.instance.serviceModel.listenExtension("consoleCommand",onConsoleCommand);
      }
      
      private function onConsoleCommand(param1:Object) : void
      {
         new DebugCommand(param1.name);
      }
      
      private function onConsoleLog(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = null;
         if(!Cc.instance)
         {
            Cc.config.commandLineAllowed = true;
            Cc.config.maxLines = 200000;
            Cc.startOnStage(Sanalika.instance,"console");
            Cc.visible = true;
            Cc.addSlashCommand("d",onDebugCommand);
         }
         if(param1.message.indexOf("{") == 0 && param1.message.lastIndexOf("}") == param1.message.length - 1)
         {
            _loc3_ = com.adobe.serialization.json.JSON.decode(param1.message);
            objectVector.push(_loc3_);
            _loc2_ = _loc3_;
         }
         else
         {
            _loc2_ = param1.message;
         }
         Cc.instance.addLine([_loc2_],param1.type,param1.channel);
      }
      
      private function onDebugCommand(param1:String = "") : void
      {
         Sanalika.instance.serviceModel.requestData("debugcommand",{"params":param1},null,null);
      }
   }
}

