package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.interfaces.ILocalConnectionModel;
   import flash.events.AsyncErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.StatusEvent;
   import flash.net.LocalConnection;
   
   public class LocalConnectionModel implements ILocalConnectionModel
   {
      
      private var connection:LocalConnection;
      
      private var ctrlDown:Boolean;
      
      public function LocalConnectionModel()
      {
         super();
         connection = new LocalConnection();
         connection.addEventListener("asyncError",onError);
         connection.addEventListener("securityError",onSError);
         connection.addEventListener("status",onStatus);
      }
      
      public function send(param1:String, param2:Object) : void
      {
         if(param2 == null)
         {
            param2 = {};
         }
         param2.instance = Sanalika.instance.gameModel.serverName;
         param2.roomKey = Sanalika.instance.roomModel.key;
         param2.type = param1;
         try
         {
            connection.send("_gameListener","dispatchInfo",param2);
         }
         catch(e:Error)
         {
            trace("local:",e.toString());
         }
      }
      
      protected function onStatus(param1:StatusEvent) : void
      {
      }
      
      protected function onError(param1:AsyncErrorEvent) : void
      {
      }
      
      protected function onSError(param1:SecurityErrorEvent) : void
      {
      }
   }
}

