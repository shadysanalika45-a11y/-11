package com.oyunstudyosu.model
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.bot.IBotMessage;
   import com.oyunstudyosu.events.BotMessageEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import extensions.notification.BotMessage;
   import extensions.notification.UserRoomMessage;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class AdminMessageModel
   {
      
      public var botMessageList:Dictionary;
      
      public var adminMessageList:Array;
      
      public function AdminMessageModel()
      {
         super();
         botMessageList = new Dictionary();
         Dispatcher.addEventListener("BotMessageEvent.REMOVE_MESSAGE",removeBotMessage);
         Sanalika.instance.serviceModel.listenExtension("adminMessage",onAdminMessage);
         Sanalika.instance.serviceModel.listenExtension("botMessage",onBotMessage);
         Sanalika.instance.serviceModel.listenExtension("guideMessage",onAdminMessage);
         Sanalika.instance.serviceModel.listenExtension("roommessage",processRoomMessage);
      }
      
      private function processRoomMessage(param1:Object) : void
      {
         var _loc2_:UserRoomMessage = null;
         var _loc3_:Object = null;
         if(param1.message && param1.senderID)
         {
            _loc2_ = new UserRoomMessage();
            _loc3_ = {};
            _loc3_.colorSet = 1;
            _loc3_.message = param1.message;
            _loc3_.senderName = param1.senderName;
            _loc3_.senderNick = param1.senderNick;
            _loc3_.senderID = Number(param1.senderID);
            _loc3_.imgPath = param1.imgPath;
            _loc3_.gender = param1.gender;
            _loc3_.duration = 15;
            _loc2_.data = _loc3_;
            addBotMessage(_loc2_);
         }
      }
      
      private function onBotMessage(param1:Object) : void
      {
         if(!Sanalika.instance.avatarModel.settings.showInvitations)
         {
            return;
         }
         var _loc2_:IBotMessage = new BotMessage();
         _loc2_.data = param1;
         (_loc2_ as MovieClip).scaleX = Sanalika.instance.scaleModel.uiScale;
         (_loc2_ as MovieClip).scaleY = Sanalika.instance.scaleModel.uiScale;
         addBotMessage(_loc2_);
      }
      
      private function onAdminMessage(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:AlertVo = null;
         if(param1.title)
         {
            _loc2_ = param1.title;
         }
         else
         {
            _loc2_ = "Municipalty Message";
         }
         if(_loc2_ == "Ban Info")
         {
            param1.message = $(param1.message) + "\n" + $("swear") + ": " + param1.swear + "\n" + "swearTime" + ": " + param1.swearTime + "\n" + $("endDate") + ": " + param1.endDate;
         }
         else
         {
            _loc3_ = new AlertVo();
            _loc3_.alertType = "Info";
            _loc3_.title = $(_loc2_);
            _loc3_.description = $(param1.message);
            Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
            _loc3_ = null;
         }
      }
      
      public function addBotMessage(param1:IBotMessage) : void
      {
         param1.init();
         Sanalika.instance.layerModel.botMessageLayer.addChildAt(param1 as MovieClip,0);
         botMessageList[param1] = param1;
         updateBotMessageViews();
      }
      
      public function removeBotMessage(param1:BotMessageEvent) : void
      {
         Sanalika.instance.layerModel.botMessageLayer.removeChild(param1.clip as MovieClip);
         delete botMessageList[param1.clip];
         updateBotMessageViews(false);
      }
      
      public function updateBotMessageViews(param1:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < Sanalika.instance.layerModel.botMessageLayer.numChildren)
         {
            _loc2_ = Sanalika.instance.layerModel.botMessageLayer.getChildAt(_loc4_) as MovieClip;
            _loc3_ = 110 * _loc4_;
            _loc2_.scaleX = _loc2_.scaleY = 1;
            if(param1)
            {
               _loc2_.y = 110 * (_loc4_ - 1);
            }
            TweenLite.to(_loc2_,0.3,{
               "y":_loc3_,
               "alpha":1,
               "ease":Back.easeOut
            });
            _loc4_++;
         }
      }
   }
}

