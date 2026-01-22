package com.oyunstudyosu.controller
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.purchase.VipPurchaseDiscountCommand;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PurchaseEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.purchase.PurchaseVo;
   import com.oyunstudyosu.service.IServiceModel;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   
   public class PurchaseController
   {
      
      private var purchaseList:Vector.<PurchaseVo>;
      
      private var purchaseItem:Object;
      
      private var purchaseEvent:PurchaseEvent;
      
      private var alertvo:AlertVo;
      
      private var serviceModel:IServiceModel;
      
      private var currentSanil:int;
      
      private var currentDiamond:int;
      
      public function PurchaseController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         Dispatcher.addEventListener("PurchaseEvent.PURCHASE",purchase);
         Dispatcher.addEventListener("PurchaseEvent.FLAT_PURCHASE",purchase);
      }
      
      public function dispose() : void
      {
         serviceModel.removeRequestData("purchase",itemPurchaseResponse);
         serviceModel = null;
      }
      
      private function checkPurchaseBalance(param1:PurchaseEvent) : Boolean
      {
         currentSanil = parseInt(Sanalika.instance.avatarModel.balance("SANIL"));
         currentDiamond = parseInt(Sanalika.instance.avatarModel.balance("DIAMOND"));
         if(currentSanil < param1.sanil && param1.sanil > 0)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("Sanalika.openSanilPurchasePanel");
            }
            else if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
            {
               navigateToURL(new URLRequest(Sanalika.instance.gameModel.webServer + "/payment"));
            }
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = $("Not enough sanil.");
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            return false;
         }
         if(currentDiamond < param1.diamond && param1.diamond > 0)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("Sanalika.openDiamondPurchasePanel");
            }
            else if(Capabilities.playerType == "Desktop" || Capabilities.manufacturer == "Android Linux")
            {
               navigateToURL(new URLRequest(Sanalika.instance.gameModel.webServer + "/payment"));
            }
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = $("Not enough diamond.");
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            return false;
         }
         return true;
      }
      
      private function purchase(param1:PurchaseEvent) : void
      {
         var _loc3_:Object = null;
         var _loc5_:int = 0;
         purchaseList = param1.purchaseList;
         if(!checkPurchaseBalance(param1))
         {
            return;
         }
         if(purchaseList == null || purchaseList.length == 0)
         {
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = $("You must select item.");
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            return;
         }
         var _loc4_:int = int(purchaseList.length);
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = {};
            _loc3_.shopProductID = purchaseList[_loc5_].pid;
            _loc3_.quantity = purchaseList[_loc5_].quantity;
            if(purchaseList[_loc5_].color && parseInt(purchaseList[_loc5_].color) > 0)
            {
               _loc3_.color = purchaseList[_loc5_].color;
            }
            _loc2_.push(_loc3_);
            _loc5_++;
         }
         if(param1.type == "PurchaseEvent.FLAT_PURCHASE")
         {
            serviceModel.requestData("flatpurchase",{
               "shopID":param1.shopID,
               "objectID":param1.objectID,
               "items":_loc2_
            },itemPurchaseResponse);
         }
         else
         {
            serviceModel.requestData("purchase",{
               "shopID":param1.shopID,
               "objectID":param1.objectID,
               "items":_loc2_
            },itemPurchaseResponse);
         }
      }
      
      private function itemPurchaseResponse(param1:Object) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:String = null;
         serviceModel.removeRequestData("purchase",itemPurchaseResponse);
         if(param1.errorCode)
         {
            if(param1.errorCode == "ALREADY_HAS_ITEM")
            {
               purchaseEvent = new PurchaseEvent("PurchaseEvent.FLAT_PURCHASE_FAIL");
               Dispatcher.dispatchEvent(purchaseEvent);
            }
            return;
         }
         var _loc5_:Array = param1.items;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc6_].items;
            _loc3_ = _loc5_[_loc6_].type;
            if(_loc3_ == "CLOTH")
            {
               if(_loc2_[0].subType == "HAIR")
               {
                  purchaseEvent = new PurchaseEvent("PurchaseEvent.HAIR_PURCHASE_COMPLETED");
                  purchaseEvent.hairObject = {};
                  purchaseEvent.hairObject.key = _loc2_[0].clip;
                  purchaseEvent.hairObject.color = _loc2_[0].color;
                  Dispatcher.dispatchEvent(purchaseEvent);
                  alertvo = new AlertVo();
                  alertvo.alertType = "tooltip";
                  alertvo.description = $("New hair added to your account.");
                  Dispatcher.dispatchEvent(new AlertEvent(alertvo));
               }
               else
               {
                  purchaseEvent = new PurchaseEvent("PurchaseEvent.CLOTH_PURCHASE_COMPLETED");
                  Dispatcher.dispatchEvent(purchaseEvent);
                  alertvo = new AlertVo();
                  alertvo.alertType = "tooltip";
                  alertvo.description = $("New clothes added to your bag");
                  Dispatcher.dispatchEvent(new AlertEvent(alertvo));
               }
            }
            if(_loc3_ == "OBJECT")
            {
               purchaseEvent = new PurchaseEvent("PurchaseEvent.FURNITURE_PURCHASE_COMPLETED");
               Dispatcher.dispatchEvent(purchaseEvent);
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = $("New furnitures will ship them to your home.");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            if(_loc3_ == "HAND")
            {
               purchaseEvent = new PurchaseEvent("PurchaseEvent.HAND_ITEM_PURCHASE_COMPLETED");
               purchaseEvent.succesfullHandList = _loc2_;
               Dispatcher.dispatchEvent(purchaseEvent);
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = $("New items added to your bag");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            if(_loc3_ == "CARD")
            {
               purchaseEvent = new PurchaseEvent("PurchaseEvent.CARD_PURCHASE_COMPLETED");
               purchaseEvent.succesfullHandList = _loc2_;
               Dispatcher.dispatchEvent(purchaseEvent);
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = $("Vip card purchase completed.");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            if(_loc3_ == "FLAT")
            {
               purchaseEvent = new PurchaseEvent("PurchaseEvent.FLAT_PURCHASE_COMPLETED");
               purchaseEvent.succesfullFlatList = _loc2_;
               Dispatcher.dispatchEvent(purchaseEvent);
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = $("New flat purchase completed.");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            _loc6_++;
         }
         var _loc4_:VipPurchaseDiscountCommand = new VipPurchaseDiscountCommand(param1.cost);
         _loc4_.execute();
         purchaseEvent = new PurchaseEvent("PurchaseEvent.ITEM_PURCHASE_SUCCESSFULL");
         Dispatcher.dispatchEvent(purchaseEvent);
      }
   }
}

