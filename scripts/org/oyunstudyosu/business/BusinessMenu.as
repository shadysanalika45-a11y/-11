package org.oyunstudyosu.business
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.OrderEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.oyunstudyosu.commands.OpenRoomChangePasswordCommand;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1075")]
   public class BusinessMenu extends CoreMovieClip
   {
      
      public var cafeListTab:SimpleButton;
      
      public var modifyTab:SimpleButton;
      
      public var passwordTab:SimpleButton;
      
      public var messageTab:SimpleButton;
      
      public var restrictedListTab:SimpleButton;
      
      public var infoTab:SimpleButton;
      
      public var orderTab:SimpleButton;
      
      public var bgOrder:MovieClip;
      
      public var txtOrder:TextField;
      
      private var outEvent:HudEvent;
      
      public function BusinessMenu()
      {
         super();
      }
      
      override public function added() : void
      {
         Connectr.instance.toolTipModel.addTip(this.cafeListTab,$("Room List"));
         Connectr.instance.toolTipModel.addTip(this.modifyTab,$("Design"));
         Connectr.instance.toolTipModel.addTip(this.messageTab,$("Send Message"));
         Connectr.instance.toolTipModel.addTip(this.infoTab,$("Room Info"));
         Connectr.instance.toolTipModel.addTip(this.passwordTab,$("Room Password"));
         Connectr.instance.toolTipModel.addTip(this.restrictedListTab,$("Restricted List"));
         Connectr.instance.toolTipModel.addTip(this.orderTab,$("orderLIST"));
         this.cafeListTab.addEventListener(MouseEvent.CLICK,this.cafeListTabClicked);
         this.modifyTab.addEventListener(MouseEvent.CLICK,this.modifyTabClicked);
         this.messageTab.addEventListener(MouseEvent.CLICK,this.messageTabClicked);
         this.restrictedListTab.addEventListener(MouseEvent.CLICK,this.restrictedListTabClicked);
         this.infoTab.addEventListener(MouseEvent.CLICK,this.infoTabClicked);
         this.passwordTab.addEventListener(MouseEvent.CLICK,this.passwordTabClicked);
         this.orderTab.addEventListener(MouseEvent.CLICK,this.orderTabClicked);
      }
      
      protected function updateOrderCount(param1:OrderEvent = null) : void
      {
         this.bgOrder.visible = true;
         this.txtOrder.visible = true;
         this.txtOrder.text = Connectr.instance.orderModel.orderList.length + "";
      }
      
      protected function passwordTabClicked(param1:MouseEvent) : void
      {
         var _loc2_:OpenRoomChangePasswordCommand = new OpenRoomChangePasswordCommand();
         _loc2_.execute();
      }
      
      protected function infoTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_ROOM_INFO);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      protected function orderTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_ORDER_PANEL);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      public function init() : void
      {
         this.bgOrder.visible = false;
         this.txtOrder.visible = false;
         if(Connectr.instance.roomModel.ownerId == Connectr.instance.avatarModel.avatarId)
         {
            Dispatcher.addEventListener(OrderEvent.NEW_ORDER,this.updateOrderCount);
            Dispatcher.addEventListener(OrderEvent.TIMEDOUT,this.updateOrderCount);
            Dispatcher.addEventListener(OrderEvent.DELIVERED,this.updateOrderCount);
            Dispatcher.addEventListener(OrderEvent.CANCELLED,this.updateOrderCount);
            Connectr.instance.serviceModel.requestData("orderlist",{},this.onListResponse);
            this.cafeListTab.visible = this.restrictedListTab.visible = this.modifyTab.visible = this.messageTab.visible = this.infoTab.visible = this.passwordTab.visible = this.orderTab.visible = true;
         }
         else
         {
            this.cafeListTab.visible = this.infoTab.visible = true;
            this.restrictedListTab.visible = this.modifyTab.visible = this.messageTab.visible = this.passwordTab.visible = this.orderTab.visible = false;
         }
      }
      
      private function onListResponse(param1:Object) : void
      {
         trace("orderListUpdated");
         Connectr.instance.serviceModel.removeRequestData("orderlist",this.onListResponse);
         Connectr.instance.orderModel.orderList = param1.orders;
         this.updateOrderCount();
      }
      
      protected function messageTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.SEND_BUSINESS_MESSAGE);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      protected function restrictedListTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_RESTRICTED_LIST_PANEL);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      protected function modifyTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_ROOM_DESIGN);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      protected function roomInfoTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_ROOM_INFO);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      protected function cafeListTabClicked(param1:MouseEvent) : void
      {
         this.outEvent = new HudEvent(HudEvent.OPEN_ROOM_LIST_PANEL);
         Dispatcher.dispatchEvent(this.outEvent);
      }
      
      override public function removed() : void
      {
         Connectr.instance.toolTipModel.removeTip(this.cafeListTab);
         Connectr.instance.toolTipModel.removeTip(this.modifyTab);
         Connectr.instance.toolTipModel.removeTip(this.messageTab);
         Connectr.instance.toolTipModel.removeTip(this.restrictedListTab);
         Connectr.instance.toolTipModel.removeTip(this.infoTab);
         Connectr.instance.toolTipModel.removeTip(this.passwordTab);
         Connectr.instance.toolTipModel.removeTip(this.orderTab);
         Dispatcher.removeEventListener(OrderEvent.NEW_ORDER,this.updateOrderCount);
         Dispatcher.removeEventListener(OrderEvent.TIMEDOUT,this.updateOrderCount);
         Dispatcher.removeEventListener(OrderEvent.DELIVERED,this.updateOrderCount);
         Dispatcher.removeEventListener(OrderEvent.CANCELLED,this.updateOrderCount);
         this.cafeListTab.removeEventListener(MouseEvent.CLICK,this.cafeListTabClicked);
         this.modifyTab.removeEventListener(MouseEvent.CLICK,this.modifyTabClicked);
         this.messageTab.removeEventListener(MouseEvent.CLICK,this.messageTabClicked);
         this.infoTab.removeEventListener(MouseEvent.CLICK,this.infoTabClicked);
         this.passwordTab.removeEventListener(MouseEvent.CLICK,this.passwordTabClicked);
         this.restrictedListTab.removeEventListener(MouseEvent.CLICK,this.restrictedListTabClicked);
         this.orderTab.removeEventListener(MouseEvent.CLICK,this.orderTabClicked);
      }
   }
}

