package com.oyunstudyosu.model
{
   import com.greensock.TweenLite;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.InventoryEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.utils.NumberUtils;
   import de.polygonal.core.fmt.Sprintf;
   import flash.display.MovieClip;
   import org.oyunstudyosu.gift.DropGift;
   
   public class DropGiftModel
   {
      
      private var myGained:int;
      
      private var myCurrencyType:String;
      
      private var dropGift:DropGift;
      
      private var char:Character;
      
      private var currency:String;
      
      private var amount:int;
      
      private var winner:String;
      
      private var winners:Array;
      
      private var vo:AlertVo;
      
      private var clip:String;
      
      public var containerGift:MovieClip;
      
      public function DropGiftModel()
      {
         super();
         trace("DropGiftModel Loaded");
         Sanalika.instance.serviceModel.listenExtension("giftRain",giftDroppedResponse);
      }
      
      private function giftDroppedResponse(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         containerGift = new MovieClip();
         Sanalika.instance.layerModel.effectLayer.addChild(containerGift);
         winners = param1.winners;
         _loc4_ = 0;
         while(_loc4_ < winners.length)
         {
            winner = winners[_loc4_].avatarID;
            amount = winners[_loc4_].amount;
            currency = winners[_loc4_].currency;
            if(Sanalika.instance.gameModel.extensionInfo.indexOf({"name":"GiftRainExtension"}))
            {
               char = Connectr.instance.engine.scene.getAvatarById(winner) as Character;
            }
            _loc2_ = NumberUtils.randRange(0,5);
            if(char.isMe)
            {
               _loc2_ = 0;
            }
            if(amount > 10)
            {
               amount = 10;
            }
            _loc3_ = 0;
            while(_loc3_ < amount)
            {
               dropGift = new DropGift();
               if(dropGift)
               {
                  dropGift.delay = _loc2_ + _loc3_ * 0.1;
                  dropGift.x = char.container.x;
                  dropGift.y = char.container.y - 50;
                  if(winners[_loc4_].clip == null)
                  {
                     dropGift.currencyType = currency;
                  }
                  else
                  {
                     dropGift.currencyType = "OBJECT";
                  }
                  containerGift.addChild(dropGift);
               }
               _loc3_++;
            }
            if(char.isMe)
            {
               clip = winners[_loc4_].clip;
               myGained = amount;
               myCurrencyType = currency;
               TweenLite.delayedCall(5,showInfo);
            }
            _loc4_++;
         }
         TweenLite.delayedCall(7,removeContainerGift);
      }
      
      private function removeContainerGift() : void
      {
         if(containerGift)
         {
            Sanalika.instance.layerModel.effectLayer.removeChild(containerGift);
            containerGift = null;
         }
      }
      
      private function showInfo() : void
      {
         if(myCurrencyType != "SANIL")
         {
            if(myCurrencyType != "DIAMOND")
            {
               vo = new AlertVo();
               vo.alertType = "tooltip";
               vo.title = $("ObjectRain");
               vo.description = Sprintf.format($("objectgift"),[myGained,$("pro_" + clip)]);
               Dispatcher.dispatchEvent(new AlertEvent(vo));
            }
         }
         Dispatcher.dispatchEvent(new InventoryEvent("updateInventory"));
         myCurrencyType = null;
      }
   }
}

