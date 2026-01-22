package com.oyunstudyosu.ban
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.BanEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.IBanModel;
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateModel;
   import com.oyunstudyosu.service.IServiceModel;
   
   public class BanModel implements IBanModel
   {
      
      public var banList:Array;
      
      private var banData:BanData;
      
      private var updateModel:IUpdateModel;
      
      private var serviceModel:IServiceModel;
      
      private var banDuration:String;
      
      public function BanModel()
      {
         super();
         banList = [];
         serviceModel = Sanalika.instance.serviceModel;
         updateModel = Sanalika.instance.updateModel;
         updateModel.getGroup(1000).addFunction(updateBanTime);
         serviceModel.listenExtension("banned",banned);
         serviceModel.listenExtension("banExpired",onBanExpired);
         serviceModel.listenExtension("unbanned",onBanExpired);
      }
      
      private function onBanExpired(param1:Object) : void
      {
         banList = [];
         Dispatcher.dispatchEvent(new BanEvent("BanEvent.CHAT_BANNED_COMPLETE"));
      }
      
      private function updateBanTime(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         if(banList.length == 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < banList.length)
         {
            banData == banList[_loc3_];
            if(banData.isLimited)
            {
               banData.banEndTime--;
               if(banData.banEndTime == 0)
               {
                  if(banData.banType == "CHAT")
                  {
                     Dispatcher.dispatchEvent(new BanEvent("BanEvent.CHAT_BANNED_COMPLETE"));
                  }
                  banList.splice(_loc3_,1);
                  return;
               }
            }
            _loc3_++;
         }
      }
      
      public function configBans(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            banned(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function banned(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         banData = new BanData();
         banData.banType = param1.type;
         banData.banEndTime = param1.timeLeft;
         banData.endDate = param1.endDate;
         banData.startDate = param1.startDate;
         if(banData.banEndTime == -1)
         {
            banData.isLimited = false;
         }
         banList.push(banData);
         if(banData.banType == "LOGIN")
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "Warning";
            if(banData.endDate != null)
            {
               banDuration = banData.endDate;
            }
            else
            {
               banDuration = $("ETHERNAL");
            }
            _loc2_.description = $("banned") + $("Ban Info") + ": " + banDuration;
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         if(banData.banType == "CHAT")
         {
            Dispatcher.dispatchEvent(new BanEvent("BanEvent.CHAT_BANNED"));
         }
      }
      
      public function getBanData(param1:String) : BanData
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < banList.length)
         {
            if(banList[_loc2_].banType == param1)
            {
               return banList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

