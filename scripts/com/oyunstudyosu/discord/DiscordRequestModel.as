package com.oyunstudyosu.discord
{
   import com.adobe.crypto.MD5;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   
   public class DiscordRequestModel
   {
      
      private var key:String;
      
      private var username:String;
      
      public function DiscordRequestModel(param1:String)
      {
         super();
         this.key = MD5.hash(param1);
         var _loc2_:Object = JSON.parse(param1);
         this.username = _loc2_.user.username + "#" + _loc2_.user.discriminator;
         this.show();
      }
      
      public function show() : void
      {
         var _loc1_:AlertVo = new AlertVo();
         _loc1_.alertType = "Confirm";
         _loc1_.title = "Discord isteği";
         _loc1_.description = "Discord kullanıcısı " + this.username + " size katılmak istiyor.";
         _loc1_.secretSession = key;
         _loc1_.callBack = onJoinRequestEventCallback;
         Dispatcher.dispatchEvent(new AlertEvent(_loc1_));
      }
      
      private function onJoinRequestEventCallback(param1:int) : void
      {
         if(param1 == 2)
         {
            Sanalika.instance.discordModel.acceptJoinRequest(key);
         }
         else
         {
            Sanalika.instance.discordModel.rejectJoinRequest(key);
         }
      }
   }
}

