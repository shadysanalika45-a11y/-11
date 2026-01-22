package com.oyunstudyosu.transfer
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.FarmEvent;
   import com.oyunstudyosu.events.InventoryEvent;
   import com.oyunstudyosu.events.TransferEvent;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.panel.IPanel;
   import com.oyunstudyosu.service.IServiceModel;
   import com.oyunstudyosu.utils.CollideUtils;
   import de.polygonal.core.fmt.Sprintf;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TransferController
   {
      
      private var dragClip:MovieClip;
      
      private var paddingX:int;
      
      private var paddingY:int;
      
      private var vo:AlertVo;
      
      private var avatarID:String;
      
      private var serviceModel:IServiceModel;
      
      private var lastTransferReceiveData:Object;
      
      private var info:String;
      
      public function TransferController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         Dispatcher.addEventListener("TransferEvent.START_DRAGGING",setTransferItem);
         Dispatcher.addEventListener("TransferEvent.STOP_DRAGGING",stopDraggingItem);
         Dispatcher.addEventListener("TransferEvent.TRANSFER_CANCELLED",abort);
         serviceModel.listenExtension("respondTransferRequest",transferReceiveRequest);
         serviceModel.listenExtension("transferResult",transferResult);
         serviceModel.listenExtension("transferCancelled",transferCancelledResponse);
      }
      
      private function stopDraggingItem(param1:TransferEvent) : void
      {
         trace("stopDraggingItem");
         setDragingEvents(false);
         checkAvailability(param1.mouseEvent);
         if(dragClip)
         {
            dragClip.removeChildren();
         }
      }
      
      private function transferCancelledResponse(param1:Object) : void
      {
         trace("transferCancelledResponse");
         if(lastTransferReceiveData != null && lastTransferReceiveData.transferID == param1.transferID)
         {
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.description = LanguageKeys.ITEM_TRANSFER_CANCELLED;
            vo.callBack = transferCancelled;
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function transferResult(param1:Object) : void
      {
         if(param1.status == "ACCEPTED")
         {
            if(param1.isMe)
            {
               if(Sanalika.instance.transferModel.transferItem.clip == "ckt7RFNK")
               {
                  vo = new AlertVo();
                  vo.alertType = "tooltip";
                  vo.description = "Yupo hediye ettin!";
                  Sanalika.instance.avatarModel.giftCount++;
                  Dispatcher.dispatchEvent(new AlertEvent(vo));
               }
               else
               {
                  trace("Sanalika.instance.avatarModel.holdedItem",Sanalika.instance.avatarModel.holdedItem);
                  if(Sanalika.instance.avatarModel.holdedItem == param1.clip)
                  {
                     Sanalika.instance.serviceModel.requestData("usehanditem",{"id":0},useHandItemResponse);
                  }
                  info = Sprintf.format(LanguageKeys.ITEM_TRANSFER_SEND_COMPLETED,[param1.avatarName,param1.quantity,$("pro_" + param1.clip)]);
                  vo = new AlertVo();
                  vo.alertType = "Info";
                  vo.title = LanguageKeys.ITEM_TRANSFER_COMPLETE_TITLE;
                  vo.description = info;
                  Dispatcher.dispatchEvent(new AlertEvent(vo));
               }
            }
            else
            {
               info = Sprintf.format(LanguageKeys.ITEM_TRANSFER_RECEIVED_COMPLETED,[param1.avatarName,param1.quantity,$("pro_" + param1.clip)]);
               vo = new AlertVo();
               vo.alertType = "Info";
               vo.title = LanguageKeys.ITEM_TRANSFER_COMPLETE_TITLE;
               vo.description = info;
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            }
            Dispatcher.dispatchEvent(new TransferEvent("TransferEvent.TRANFER_COMPLETED"));
         }
         if(param1.status == "REJECTED")
         {
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.title = LanguageKeys.ITEM_TRANSFER_COMPLETE_TITLE;
            vo.description = "Transfer Rejected";
            Dispatcher.dispatchEvent(new AlertEvent(vo));
            transferCancelled();
         }
      }
      
      private function useHandItemResponse(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("usehanditem",useHandItemResponse);
      }
      
      private function transferReceiveRequest(param1:Object) : void
      {
         if(lastTransferReceiveData != null || !Sanalika.instance.avatarModel.settings.transferRequests)
         {
            return;
         }
         lastTransferReceiveData = {};
         lastTransferReceiveData.senderID = param1.senderID;
         lastTransferReceiveData.transferID = param1.transferID;
         var _loc2_:String = Sprintf.format(LanguageKeys.ITEM_TRANSFER_REQUEST_RECEIVED_DESCRIPTION,[param1.senderName,param1.quantity,$("pro_" + param1.clip)]);
         vo = new AlertVo();
         vo.alertType = "Confirm";
         vo.isTransfer = true;
         vo.title = LanguageKeys.ITEM_TRANSFER_REQUEST_RECEIVED_TITLE;
         vo.description = _loc2_;
         vo.callBack = transferConfirmResponse;
         Dispatcher.dispatchEvent(new AlertEvent(vo));
         trace("transferReceiveRequest");
      }
      
      private function abort(param1:TransferEvent) : void
      {
         trace("TransferController->abort");
         trace(Sanalika.instance.avatarModel.avatarId,"....lastTransferReceiveData",JSON.stringify(lastTransferReceiveData));
         if(lastTransferReceiveData)
         {
            transferConfirmResponse(4);
         }
      }
      
      private function transferConfirmResponse(param1:int) : void
      {
         if(!lastTransferReceiveData)
         {
            return;
         }
         if(param1 == 2)
         {
            trace("transferConfirmResponse ACCEPTED");
            lastTransferReceiveData.response = "ACCEPTED";
         }
         else
         {
            if(!(param1 == 3 || param1 == 4))
            {
               lastTransferReceiveData = null;
               return;
            }
            trace("transferConfirmResponse REJECTED");
            lastTransferReceiveData.response = "REJECTED";
         }
         Sanalika.instance.serviceModel.requestData("transferresponse",lastTransferReceiveData,null);
         lastTransferReceiveData = null;
      }
      
      private function setDragingEvents(param1:Boolean) : void
      {
         if(param1)
         {
            Sanalika.instance.layerModel.stage.addEventListener("mouseMove",stageMouseMoved);
         }
         else
         {
            Sanalika.instance.layerModel.stage.removeEventListener("mouseMove",stageMouseMoved);
         }
      }
      
      private function setTransferItem(param1:TransferEvent) : void
      {
         Sanalika.instance.transferModel.transferItem = param1.draggingItem;
         setDragingEvents(true);
         if(dragClip == null)
         {
            dragClip = new MovieClip();
            Sanalika.instance.layerModel.panelLayer.addChild(dragClip);
         }
         var _loc2_:MovieClip = Sanalika.instance.itemModel.getItemImage(Sanalika.instance.avatarModel.gender + "_" + param1.draggingItem.clip);
         Sanalika.instance.layerModel.panelLayer.setChildIndex(dragClip,Sanalika.instance.layerModel.panelLayer.numChildren - 1);
         dragClip.removeChildren();
         if(_loc2_ != null)
         {
            dragClip.addChild(_loc2_);
         }
      }
      
      public function stageMouseMoved(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         paddingX = Sanalika.instance.engine.scene.paddingX;
         paddingY = Sanalika.instance.engine.scene.paddingY;
         dragClip.x = Sanalika.instance.layerModel.stage.mouseX;
         dragClip.y = Sanalika.instance.layerModel.stage.mouseY - 10;
         if(dragClip.getChildAt(0).width > 40)
         {
            dragClip.getChildAt(0).height = dragClip.getChildAt(0).height / dragClip.getChildAt(0).width * 40;
            dragClip.getChildAt(0).width = 40;
         }
      }
      
      private function checkAvailability(param1:MouseEvent) : void
      {
         var _loc6_:SceneBotComponent = null;
         var _loc5_:Array = null;
         var _loc8_:int = 0;
         for each(var _loc3_ in Sanalika.instance.panelModel.getPanelList())
         {
            if((_loc3_ as DisplayObject).hitTestPoint(param1.stageX,param1.stageY,true))
            {
               transferCancelled();
               return;
            }
         }
         if(Sanalika.instance.transferModel.transferItem.subType == "CHECK")
         {
            _loc6_ = Sanalika.instance.engine.scene.getComponent(SceneBotComponent) as SceneBotComponent;
            if(_loc6_ != null)
            {
               _loc5_ = Sanalika.instance.roomModel.botModel.keyList;
               _loc8_ = 0;
               while(_loc8_ < Sanalika.instance.roomModel.botModel.count)
               {
                  if((_loc6_.getBotByName(_loc5_[_loc8_]).getClip() as DisplayObject).hitTestPoint(param1.stageX,param1.stageY,true))
                  {
                     if(_loc5_[_loc8_] == "bankers01" || _loc5_[_loc8_] == "bankers03" || _loc5_[_loc8_] == "bankers05" || _loc5_[_loc8_] == "bankers04" || _loc5_[_loc8_] == "cashier")
                     {
                        Dispatcher.dispatchEvent(new TransferEvent("TransferEvent.TRANSFER_CANCELLED"));
                        vo = new AlertVo();
                        vo.alertType = "Confirm";
                        vo.title = $("checkExchangeTitle");
                        vo.description = $("checkExchangeDescription") + "\n" + $("pro_" + Sanalika.instance.transferModel.transferItem.clip);
                        vo.callBack = checkResponse;
                        Dispatcher.dispatchEvent(new AlertEvent(vo));
                        return;
                     }
                  }
                  _loc8_++;
               }
            }
         }
         for each(var _loc4_ in Sanalika.instance.entryModel.entryItems)
         {
            if(_loc4_.clip.hitTestPoint(param1.stageX,param1.stageY,true))
            {
               if(CollideUtils.isColliding(_loc4_.clip,param1.stageX,param1.stageY))
               {
                  trace("transfer.executeItem",_loc4_.id);
                  seedRequest(_loc4_);
                  return;
               }
            }
         }
         var _loc2_:ISceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as ISceneCharacterComponent;
         if(_loc2_ != null)
         {
            for each(var _loc7_ in _loc2_.characterList)
            {
               if(_loc7_.container.hitTestPoint(param1.stageX,param1.stageY,true))
               {
                  if(_loc2_.myChar.id != _loc7_.id)
                  {
                     if(Sanalika.instance.transferModel.transferItem && !Sanalika.instance.transferModel.transferItem.isTransferable)
                     {
                        trace("ITEM_CANNOT_TRANSFER");
                        vo = new AlertVo();
                        vo.alertType = "Error";
                        vo.description = LanguageKeys.ITEM_CANNOT_TRANSFER;
                        vo.callBack = transferCancelled;
                        Dispatcher.dispatchEvent(new AlertEvent(vo));
                        return;
                     }
                     transferRequest(_loc7_);
                     return;
                  }
               }
            }
         }
      }
      
      private function checkResponse(param1:int) : void
      {
         if(param1 == 2)
         {
            Sanalika.instance.serviceModel.requestData("giftcheckexchange",{"id":Sanalika.instance.transferModel.transferItem.id},checkServiceResponse);
         }
      }
      
      private function checkServiceResponse(param1:int) : void
      {
         Sanalika.instance.serviceModel.removeRequestExtension("giftcheckexchange",checkServiceResponse);
         Dispatcher.dispatchEvent(new InventoryEvent("updateInventory"));
      }
      
      private function seedRequest(param1:IEntryVo) : void
      {
         trace("seedRequest");
         var _loc2_:Array = ["tomatoe","strawberry","pepper","wheat","corn","watermelon","melon","rice","sugarcane","onion","potato"];
         if(_loc2_.indexOf(Sanalika.instance.transferModel.transferItem.clip) == -1)
         {
            vo = new AlertVo();
            vo.alertType = "Info";
            vo.title = $("farmingSeedTitle");
            vo.description = $("farmingSeedNotApplicable") + "\n" + $("pro_" + Sanalika.instance.transferModel.transferItem.clip);
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else if(param1.property && param1.property.data.item)
         {
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.description = $("FARM_MUST_BE_EMPTY");
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
         else
         {
            Sanalika.instance.farmModel.farmObjectID = param1.id;
            vo = new AlertVo();
            vo.alertType = "Confirm";
            vo.title = $("farmingSeedTitle");
            vo.description = $("farmingSeedDescription") + "\n" + $("pro_" + Sanalika.instance.transferModel.transferItem.clip);
            vo.callBack = seedResponse;
            Dispatcher.dispatchEvent(new AlertEvent(vo));
         }
      }
      
      private function seedResponse(param1:int) : void
      {
         var _loc2_:FarmEvent = null;
         if(param1 == 2)
         {
            _loc2_ = new FarmEvent("FarmEvent.IMPLANT");
            _loc2_.itemID = Sanalika.instance.transferModel.transferItem.id;
            _loc2_.id = Sanalika.instance.farmModel.farmObjectID;
            Dispatcher.dispatchEvent(_loc2_);
         }
      }
      
      private function transferRequest(param1:ICharacter) : void
      {
         if(!Sanalika.instance.transferModel.transferItem)
         {
            return;
         }
         avatarID = param1.id;
         var _loc2_:String = Sprintf.format(LanguageKeys.ITEM_TRANSFER_REQUEST_DESCRIPTION,[param1.avatarName,$("pro_" + Sanalika.instance.transferModel.transferItem.clip)]);
         vo = new AlertVo();
         vo.alertType = "Quantity";
         vo.title = LanguageKeys.ITEM_TRANSFER_REQUEST_TITLE;
         vo.description = _loc2_;
         vo.callBack = transferQuantityResponse;
         vo.stepperComment = LanguageKeys.ITEM_TRANSFER_REQUEST_STEPPER_DESCRIPTION;
         vo.minQuantity = 1;
         vo.stepSize = 1;
         if(Sanalika.instance.transferModel.transferItem.clip == "ckt7RFNK")
         {
            vo.maxQuantity = 1;
         }
         else
         {
            vo.maxQuantity = Sanalika.instance.transferModel.transferItem.quantity;
         }
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function transferCancelled(param1:int = 1) : void
      {
         trace("TransferController->transferCancelled");
         Dispatcher.dispatchEvent(new TransferEvent("TransferEvent.TRANSFER_CANCELLED"));
         Sanalika.instance.transferModel.transferItem = null;
      }
      
      private function transferQuantityResponse(param1:int, param2:int = -1) : void
      {
         if(param1 == 2)
         {
            Sanalika.instance.serviceModel.requestData("transferrequest",{
               "clip":Sanalika.instance.transferModel.transferItem.clip,
               "id":Sanalika.instance.transferModel.transferItem.id,
               "quantity":param2,
               "avatarID":avatarID
            },null);
         }
         if(param1 == 3 || param1 == 4)
         {
            transferCancelled();
         }
      }
   }
}

