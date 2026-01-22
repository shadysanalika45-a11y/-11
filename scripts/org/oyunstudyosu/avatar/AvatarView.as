package org.oyunstudyosu.avatar
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.cloth.ICharPreview;
   import com.oyunstudyosu.enums.ModuleType;
   import com.oyunstudyosu.enums.RequestDataKey;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import com.oyunstudyosu.events.OrderEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1013")]
   public class AvatarView extends CoreMovieClip
   {
      
      private var fbRoot:String = "https://graph.facebook.com";
      
      public var currentDisplay:MovieClip;
      
      public var avatarContainer:MovieClip;
      
      public var todoContainer:MovieClip;
      
      private var charPreview:ICharPreview;
      
      public function AvatarView()
      {
         super();
      }
      
      override public function added() : void
      {
         var _loc1_:AssetRequest = null;
         var _loc2_:String = null;
         this.charPreview = Connectr.instance.clothModel.getNewCharPreview(this.avatarContainer,null,true);
         this.charPreview.rotate(3);
         this.avatarContainer.x = 20;
         this.avatarContainer.y = 54;
         this.avatarContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         this.avatarContainer.buttonMode = true;
         Connectr.instance.serviceModel.listenExtension(RequestDataKey.CHANGE_CLOTHES,this.onChangeClothes);
         TweenMax.to(this.todoContainer,0,{"alpha":0});
         if(Boolean(Connectr.instance.orderModel.orderRequest) && !Connectr.instance.avatarModel.isTutorialMode)
         {
            if(Connectr.instance.orderModel.orderRequest.status == "NEW" || Connectr.instance.orderModel.orderRequest.status == "PREPARING" || Connectr.instance.orderModel.orderRequest.status == "ORDERED")
            {
               _loc1_ = new AssetRequest();
               _loc1_.context = Connectr.instance.domainModel.assetContext;
               _loc2_ = "/static/items/inventory/" + Connectr.instance.orderModel.orderRequest.clip + ".png";
               _loc1_.type = ModuleType.PNG;
               _loc1_.assetId = _loc2_;
               _loc1_.loadedFunction = this.onTodo;
               Connectr.instance.assetModel.request(_loc1_);
               Dispatcher.addEventListener(OrderEvent.DELIVERED,this.removeTodo);
            }
         }
      }
      
      private function onChangeClothes(param1:Object) : void
      {
         if(param1.errorCode)
         {
            return;
         }
         this.avatarContainer.removeChildren();
         if(this.charPreview)
         {
            this.charPreview.terminate();
         }
         this.charPreview = Connectr.instance.clothModel.getNewCharPreview(this.avatarContainer,null,true);
         this.charPreview.rotate(3);
         this.avatarContainer.x = 20;
         this.avatarContainer.y = 54;
      }
      
      private function removeTodo(param1:OrderEvent) : void
      {
         Dispatcher.removeEventListener(OrderEvent.DELIVERED,this.removeTodo);
         while(this.todoContainer.numChildren > 0)
         {
            this.todoContainer.removeChildAt(0);
         }
         this.todoContainer = null;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new HudEvent(HudEvent.OPEN_AVATARSWITCH_PANEL));
      }
      
      public function onTodo(param1:IAssetRequest) : void
      {
         var _loc2_:Bitmap = new Bitmap((param1.display as Bitmap).bitmapData);
         if(_loc2_)
         {
            if(_loc2_.width > 36)
            {
               _loc2_.width = 36;
               _loc2_.height = 36;
            }
            _loc2_.x = -_loc2_.width / 2;
            _loc2_.y = -_loc2_.height / 2;
            _loc2_.name = "order";
            this.todoContainer.addChild(_loc2_);
            TweenMax.to(this.todoContainer,5,{"alpha":1});
            this.todoContainer.addEventListener(MouseEvent.CLICK,this.onTodoClick);
            TweenMax.killTweensOf(this.todoContainer);
            TweenMax.to(this.todoContainer,4,{"alpha":1});
            TweenMax.to(this.todoContainer,0.5,{
               "glowFilter":{
                  "color":13491257,
                  "alpha":1,
                  "blurX":6,
                  "blurY":6,
                  "strength":2
               },
               "repeat":40,
               "yoyo":true
            });
            Connectr.instance.toolTipModel.addTip(this.todoContainer,$("orderHUNGRY") + " (" + $("pro_" + Connectr.instance.orderModel.orderRequest.clip) + ")");
         }
      }
      
      private function onTodoClick(param1:MouseEvent) : void
      {
      }
      
      public function reset() : void
      {
      }
   }
}

