package com.oyunstudyosu.buddy
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.barter.BarterModel;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.BuddyEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.events.TransferEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.service.IServiceModel;
   import de.polygonal.core.fmt.Sprintf;
   
   public class BuddyController
   {
      
      private var serviceModel:IServiceModel;
      
      private var barterModel:BarterModel;
      
      private var diamondBalance:int;
      
      private var diamondTransferAvatarID:String;
      
      private var vo:AlertVo;
      
      private var avatarID:String;
      
      private var lastTransferReceiveData:Object;
      
      public function BuddyController()
      {
         super();
         Dispatcher.addEventListener("MyBuddyEvent.SHOW_PROFILE",showProfile);
         Dispatcher.addEventListener("MyBuddyEvent.CHANGE_RELATION",changeRelationRequest);
         Dispatcher.addEventListener("MyBuddyEvent.SEND_DIAMOND",sendDiamondRequest);
         Dispatcher.addEventListener("MyBuddyEvent.SEND_MESSAGE",sendMessageRequest);
         Dispatcher.addEventListener("MyBuddyEvent.BUDDY_LOCATE",buddyLocateRequest);
         Dispatcher.addEventListener("MyBuddyEvent.INVITE_LOCATION",buddyInviteLocationRequest);
         Dispatcher.addEventListener("MyBuddyEvent.REMOVE_FRIEND_CONFIRM",removeBuddyConfirm);
         Dispatcher.addEventListener("MyBuddyEvent.REMOVE_FRIEND",removeBuddyRequest);
         Dispatcher.addEventListener("MyBuddyEvent.ADD_FRIEND",addFriendRequest);
         Dispatcher.addEventListener("MyBuddyEvent.CHANGE_MOOD",moodChangeRequest);
         Dispatcher.addEventListener("MyBuddyEvent.CHANGE_STATUS_MESSAGE",statusMessageChangeRequest);
         Dispatcher.addEventListener("MyBuddyEvent.ACCEPT_FRIEND_REQUEST",friendRequestAccept);
         Dispatcher.addEventListener("MyBuddyEvent.REJECT_FRIEND_REQUEST",friendRequestRejected);
         serviceModel = Sanalika.instance.serviceModel;
         barterModel = Sanalika.instance.barterModel;
         serviceModel.listenExtension("buddyAdded",newBuddyAdded);
         serviceModel.listenExtension("buddyRemoved",buddyRemoved);
         serviceModel.listenExtension("buddyRelationUpdated",buddyRelationChanged);
         serviceModel.listenExtension("respondBuddyRequest",newRequestAdded);
         serviceModel.listenExtension("buddy.moodchanged",buddyMoodChanged);
         serviceModel.listenExtension("buddyOnlineStatus",buddyOnlineStatusChanged);
         serviceModel.listenExtension("buddy.changestatusmessage",buddyStatusMessageChanged);
         serviceModel.listenExtension("buddyrequestfulladded",buddyRequestFullResponse);
         serviceModel.listenExtension("buddyInviteLocation",buddyInviteResponse);
         serviceModel.listenExtension("buddyInviteLocationRespond",buddyInviteRespondResponse);
         serviceModel.listenExtension("buddyInviteGame",buddyInviteGameResponse);
         serviceModel.listenExtension("respondDiamondTransferRequest",transferReceiveRequest);
         serviceModel.listenExtension("diamondTransferResult",transferResult);
         serviceModel.listenExtension("diamondTransferCancelled",diamondTransferCancelled);
         serviceModel.listenExtension("diamondTransferDailyLimitExceeded",diamondTransferDailyLimitExceeded);
         serviceModel.requestData("buddylist",{},friendListResponse);
      }
      
      private function showProfile(param1:BuddyEvent) : void
      {
         var _loc2_:ProfileEvent = new ProfileEvent("AvatarProfileEvent.SHOW_PROFILE");
         _loc2_.avatarID = param1.avatarID;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      private function buddyInviteResponse(param1:Object) : void
      {
         var buddy:BuddyVo;
         var data:Object = param1;
         if(data.avatarID && Sanalika.instance.buddyModel.isBuddy(data.avatarID))
         {
            buddy = Sanalika.instance.buddyModel.getBuddyVoById(data.avatarID);
            vo = new AlertVo();
            vo.alertType = "Confirm";
            vo.title = LanguageKeys.BUDDY_INVITE_LOCATION_TITLE;
            vo.callBack = function(param1:int):void
            {
               serviceModel.requestData("buddyrespondinvitelocation",{
                  "avatarID":data.avatarID,
                  "response":param1
               },null);
            };
            if(data.flat)
            {
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_INVITE_FLAT_LOCATION_DESCRIPTION),[buddy.avatarName,data.flat]);
            }
            else
            {
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_INVITE_LOCATION_DESCRIPTION),[buddy.avatarName,$("universe_" + data.universe),$("room_" + data.street)]);
            }
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function buddyInviteRespondResponse(param1:Object) : void
      {
         var _loc2_:BuddyVo = null;
         if(param1.avatarID && Sanalika.instance.buddyModel.isBuddy(param1.avatarID))
         {
            _loc2_ = Sanalika.instance.buddyModel.getBuddyVoById(param1.avatarID);
            vo = new AlertVo();
            vo.title = LanguageKeys.BUDDY_INVITE_LOCATION_TITLE;
            if(param1.response == 2)
            {
               vo.alertType = "Info";
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_INVITE_LOCATION_ACCEPTED),[_loc2_.avatarName]);
            }
            else if(param1.response == 3)
            {
               vo.alertType = "Warning";
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_INVITE_LOCATION_REJECTED),[_loc2_.avatarName]);
            }
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      public function buddyInviteGameResponse(param1:Object) : void
      {
         var buddy:BuddyVo;
         var data:Object = param1;
         if(data.avatarID != null && Sanalika.instance.buddyModel.isBuddy(data.avatarID))
         {
            buddy = Sanalika.instance.buddyModel.getBuddyVoById(data.avatarID);
            vo = new AlertVo();
            vo.alertType = "Confirm";
            vo.callBack = function(param1:int):void
            {
               if(param1 == 2)
               {
                  Sanalika.instance.serviceModel.requestData("buddyacceptinvitegame",{
                     "avatarID":data.avatarID,
                     "game":data.game,
                     "key":data.key
                  },null);
               }
            };
            vo.title = Sanalika.instance.localizationModel.translate(LanguageKeys.BUDDY_INVITE_GAME_TITLE);
            vo.description = Sprintf.format(Sanalika.instance.localizationModel.translate(LanguageKeys.BUDDY_INVITE_GAME_DESCRIPTION),[buddy.avatarName,Sanalika.instance.localizationModel.translate("GAME_" + data.game)]);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function buddyInviteLocationRequest(param1:BuddyEvent) : void
      {
         var _loc2_:BuddyVo = null;
         var _loc3_:Object = null;
         if(Sanalika.instance.buddyModel.isBuddy(param1.avatarID))
         {
            _loc2_ = Sanalika.instance.buddyModel.getBuddyVoById(param1.avatarID);
            if(_loc2_.isOnline)
            {
               _loc3_ = {};
               _loc3_.avatarID = param1.avatarID;
               Sanalika.instance.serviceModel.requestData("buddyinvitelocation",_loc3_,null);
            }
         }
      }
      
      private function buddyLocateRequest(param1:BuddyEvent) : void
      {
         var _loc2_:Object = null;
         if(Sanalika.instance.buddyModel.isBuddy(param1.avatarID))
         {
            _loc2_ = {};
            _loc2_.avatarID = param1.avatarID;
            Sanalika.instance.serviceModel.requestData("buddylocate",_loc2_,buddyLocateResponse);
         }
      }
      
      private function buddyLocateResponse(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("buddylocate",buddyLocateResponse);
         if(param1.universe && param1.street)
         {
            vo = new AlertVo();
            vo.alertType = "Info";
            vo.title = LanguageKeys.BUDDY_LOCATE_TITLE;
            if(param1.flat)
            {
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_LOCATE_DESCRIPTION),[$("universe_" + param1.universe),param1.flat]);
            }
            else
            {
               vo.description = Sprintf.format($(LanguageKeys.BUDDY_LOCATE_DESCRIPTION),[$("universe_" + param1.universe),$("room_" + param1.street)]);
            }
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function buddyRequestFullResponse(param1:Object) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = Sprintf.format($("buddyrequestfulladded"),[param1.avatarName]);
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      private function diamondTransferCancelled(param1:Object) : void
      {
         if(lastTransferReceiveData != null && lastTransferReceiveData.transferID == param1.transferID)
         {
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.description = LanguageKeys.DIAMOND_TRANSFER_CANCELLED;
            Dispatcher.dispatchEvent(new AlertEvent(vo));
            Dispatcher.dispatchEvent(new TransferEvent("TransferEvent.DIAMOND_TRANSFER_CANCELLED"));
         }
      }
      
      private function diamondTransferDailyLimitExceeded(param1:Object) : void
      {
         vo = new AlertVo();
         vo.alertType = "tooltip";
         vo.description = LanguageKeys.DIAMOND_TRANSFER_DAILY_LIMIT_EXCEEDED;
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function transferResult(param1:Object) : void
      {
         var _loc2_:String = null;
         if(param1.status == "ACCEPTED")
         {
            if(param1.isMe)
            {
               _loc2_ = Sprintf.format(LanguageKeys.DIAMOND_TRANSFER_SEND_COMPLETED,[param1.avatarName,param1.quantity]);
               vo = new AlertVo();
               vo.alertType = "Info";
               vo.title = LanguageKeys.DIAMOND_TRANSFER_COMPLETE_TITLE;
               vo.description = _loc2_;
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            }
            else
            {
               _loc2_ = Sprintf.format(LanguageKeys.DIAMOND_TRANSFER_RECEIVED_COMPLETED,[param1.avatarName,param1.quantity]);
               vo = new AlertVo();
               vo.alertType = "Info";
               vo.title = LanguageKeys.DIAMOND_TRANSFER_COMPLETE_TITLE;
               vo.description = _loc2_;
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            }
         }
      }
      
      private function transferReceiveRequest(param1:Object) : void
      {
         if(lastTransferReceiveData != null || !Sanalika.instance.avatarModel.settings.transferRequests)
         {
            return;
         }
         lastTransferReceiveData = {};
         lastTransferReceiveData.senderID = param1.senderID;
         lastTransferReceiveData.diamondTransferID = param1.diamondTransferID;
         var _loc2_:String = Sprintf.format(LanguageKeys.DIAMOND_TRANSFER_REQUEST_RECEIVED_DESCRIPTION,[param1.senderName,param1.quantity]);
         vo = new AlertVo();
         vo.alertType = "Confirm";
         vo.isTransfer = true;
         vo.title = LanguageKeys.DIAMOND_TRANSFER_REQUEST_TITLE;
         vo.description = _loc2_;
         vo.callBack = transferConfirmResponse;
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function friendListResponse(param1:Object) : void
      {
         var _loc3_:AlertVo = null;
         for each(var _loc2_ in param1.buddies)
         {
            Sanalika.instance.buddyModel.add(_loc2_);
         }
         for each(var _loc4_ in param1.requests)
         {
            Sanalika.instance.buddyModel.addNewRequest(_loc4_,false);
         }
         if(param1.requests.length > 0)
         {
            _loc3_ = new AlertVo();
            _loc3_.alertType = "tooltip";
            _loc3_.description = $("newBuddyreqReceived");
            _loc3_.callBack = Sanalika.instance.buddyModel.buddyReqTipClicked;
            Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
         }
         Sanalika.instance.buddyModel.isActived = true;
         Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.REQUEST_LIST_INITALIZED"));
         Dispatcher.dispatchEvent(new BuddyEvent("MyBuddyEvent.BUDDY_LIST_INITALIZED"));
         serviceModel.removeRequestData("buddylist",friendListResponse);
      }
      
      private function sendDiamondRequest(param1:BuddyEvent) : void
      {
         diamondTransferAvatarID = param1.avatarID;
         var _loc2_:BuddyVo = Sanalika.instance.buddyModel.getBuddyVoById(diamondTransferAvatarID);
         diamondBalance = parseInt(Sanalika.instance.avatarModel.balance("DIAMOND"));
         if(_loc2_ == null || diamondBalance < 2)
         {
            return;
         }
         var _loc3_:String = Sprintf.format(LanguageKeys.DIAMOND_TRANSFER_REQUEST_DESCRIPTION,[_loc2_.avatarName]);
         vo = new AlertVo();
         vo.alertType = "Quantity";
         vo.title = LanguageKeys.DIAMOND_TRANSFER_REQUEST_TITLE;
         vo.description = _loc3_;
         vo.callBack = sendDiamondQuantityResponse;
         vo.stepperComment = LanguageKeys.DIAMOND_TRANSFER_REQUEST_STEPPER_DESCRIPTION;
         vo.minQuantity = 2;
         vo.stepSize = 1;
         vo.maxQuantity = diamondBalance <= 100 ? diamondBalance : 100;
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function transferConfirmResponse(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 2)
         {
            _loc2_ = "ACCEPTED";
         }
         else if(param1 == 3)
         {
            _loc2_ = "REJECTED";
         }
         if(_loc2_ == null)
         {
            lastTransferReceiveData = null;
            return;
         }
         Sanalika.instance.serviceModel.requestData("diamondtransferresponse",{
            "diamondTransferID":lastTransferReceiveData.diamondTransferID,
            "response":_loc2_
         },null);
         lastTransferReceiveData = null;
      }
      
      private function sendDiamondQuantityResponse(param1:int, param2:int = -1) : void
      {
         if(param1 == 2)
         {
            Sanalika.instance.serviceModel.requestData("diamondtransferrequest",{
               "avatarID":diamondTransferAvatarID,
               "quantity":param2
            },diamondRequestResponse);
         }
      }
      
      private function diamondRequestResponse(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         if(param1.errorCode != undefined)
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $(param1.errorCode);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
            return;
         }
      }
      
      private function buddyOnlineStatusChanged(param1:Object) : void
      {
         Sanalika.instance.buddyModel.changeOnlineStatus(param1);
      }
      
      private function buddyRelationChanged(param1:Object) : void
      {
         Sanalika.instance.buddyModel.changeRelation(param1);
      }
      
      private function buddyMoodChanged(param1:Object) : void
      {
         Sanalika.instance.buddyModel.changeMood(param1);
      }
      
      private function buddyStatusMessageChanged(param1:Object) : void
      {
         Sanalika.instance.buddyModel.changeStatusMessage(param1);
      }
      
      private function buddyRemoved(param1:Object) : void
      {
         Sanalika.instance.buddyModel.removeFromFriend(param1);
      }
      
      private function newBuddyAdded(param1:Object) : void
      {
         if(param1.avatarID == null)
         {
            return;
         }
         Sanalika.instance.buddyModel.addNewBuddy(param1);
      }
      
      private function newRequestAdded(param1:Object) : void
      {
         Sanalika.instance.buddyModel.addNewRequest(param1);
      }
      
      private function addFriendRequest(param1:BuddyEvent) : void
      {
         serviceModel.requestData("addbuddy",{"avatarID":param1.avatarID},null);
      }
      
      private function moodChangeRequest(param1:BuddyEvent) : void
      {
         serviceModel.requestData("changemood",{"mood":param1.moodID},null);
      }
      
      private function statusMessageChangeRequest(param1:BuddyEvent) : void
      {
         serviceModel.requestData("changestatusmessage",{"message":param1.message},null);
      }
      
      private function changeRelationRequest(param1:BuddyEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_.id = param1.avatarID;
         _loc2_.myRelationToBuddy = param1.relationID;
         buddyRelationChanged(_loc2_);
         serviceModel.requestData("changebuddyrating",{
            "avatarID":param1.avatarID,
            "rating":param1.relationID
         },null);
      }
      
      private function friendRequestAccept(param1:BuddyEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_.avatarID = param1.avatarID;
         _loc2_.response = "ACCEPTED";
         Sanalika.instance.buddyModel.removeRequest(_loc2_);
         Sanalika.instance.serviceModel.requestData("addbuddyresponse",_loc2_,friendRequestResponsed);
      }
      
      private function friendRequestRejected(param1:BuddyEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_.avatarID = param1.avatarID;
         _loc2_.response = "REJECTED";
         Sanalika.instance.buddyModel.removeRequest(_loc2_);
         Sanalika.instance.serviceModel.requestData("addbuddyresponse",_loc2_,friendRequestResponsed);
      }
      
      private function friendRequestResponsed(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("addbuddyresponse",friendRequestResponsed);
         for each(var _loc2_ in param1.requests)
         {
            Sanalika.instance.buddyModel.addNewRequest(_loc2_,false);
         }
      }
      
      private function removeBuddyConfirm(param1:BuddyEvent) : void
      {
         var event:BuddyEvent = param1;
         var buddyVo:BuddyVo = Sanalika.instance.buddyModel.getBuddyVoById(event.avatarID);
         var avatarName:String = buddyVo == null ? event.avatarID : buddyVo.avatarName;
         var vo:AlertVo = new AlertVo();
         vo.alertType = "Confirm";
         vo.callBack = function(param1:int):void
         {
            if(param1 == 2)
            {
               serviceModel.requestData("removebuddy",{"avatarID":event.avatarID},null);
            }
         };
         vo.description = Sprintf.format(Sanalika.instance.localizationModel.translate(LanguageKeys.BUDDY_REMOVE_CONFIRM),[avatarName]);
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function removeBuddyRequest(param1:BuddyEvent) : void
      {
         serviceModel.requestData("removebuddy",{"avatarID":param1.avatarID},null);
      }
      
      private function sendMessageRequest(param1:BuddyEvent) : void
      {
      }
      
      public function dispose() : void
      {
         var _loc1_:* = Sanalika.instance.buddyModel;
         _loc1_.clear();
         Dispatcher.removeEventListener("MyBuddyEvent.CHANGE_RELATION",changeRelationRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.SEND_DIAMOND",sendDiamondRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.SEND_MESSAGE",sendMessageRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.BUDDY_LOCATE",buddyLocateRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.INVITE_LOCATION",buddyInviteLocationRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.REMOVE_FRIEND_CONFIRM",removeBuddyConfirm);
         Dispatcher.removeEventListener("MyBuddyEvent.REMOVE_FRIEND",removeBuddyRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.ADD_FRIEND",addFriendRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.CHANGE_MOOD",moodChangeRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.CHANGE_STATUS_MESSAGE",statusMessageChangeRequest);
         Dispatcher.removeEventListener("MyBuddyEvent.ACCEPT_FRIEND_REQUEST",friendRequestAccept);
         Dispatcher.removeEventListener("MyBuddyEvent.REJECT_FRIEND_REQUEST",friendRequestRejected);
         serviceModel.removeExtension("buddyAdded",newBuddyAdded);
         serviceModel.removeExtension("buddyRemoved",buddyRemoved);
         serviceModel.removeExtension("buddyRelationUpdated",buddyRelationChanged);
         serviceModel.removeExtension("respondBuddyRequest",newRequestAdded);
         serviceModel.removeExtension("buddy.moodchanged",buddyMoodChanged);
         serviceModel.removeExtension("buddyOnlineStatus",buddyOnlineStatusChanged);
         serviceModel.removeExtension("buddy.changestatusmessage",buddyStatusMessageChanged);
         serviceModel.removeExtension("buddyrequestfulladded",buddyRequestFullResponse);
         serviceModel.removeExtension("buddyInviteLocation",buddyInviteResponse);
         serviceModel.removeExtension("buddyInviteLocationRespond",buddyInviteRespondResponse);
         serviceModel.removeExtension("buddyInviteGame",buddyInviteGameResponse);
         serviceModel.removeExtension("respondDiamondTransferRequest",transferReceiveRequest);
         serviceModel.removeExtension("diamondTransferResult",transferResult);
         serviceModel.removeExtension("diamondTransferCancelled",diamondTransferCancelled);
         serviceModel.removeExtension("diamondTransferDailyLimitExceeded",diamondTransferDailyLimitExceeded);
         serviceModel.removeRequestData("buddylist",friendListResponse);
         serviceModel = null;
      }
   }
}

