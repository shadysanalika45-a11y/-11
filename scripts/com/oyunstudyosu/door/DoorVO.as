package com.oyunstudyosu.door
{
   import com.oyunstudyosu.property.EmptyProperty;
   import com.oyunstudyosu.property.ExchangeProperty;
   import com.oyunstudyosu.property.ExternalLinkProperty;
   import com.oyunstudyosu.property.FlatEnterProperty;
   import com.oyunstudyosu.property.FlatExitProperty;
   import com.oyunstudyosu.property.FlatSponsorPanelProperty;
   import com.oyunstudyosu.property.GameProperty;
   import com.oyunstudyosu.property.GatheringProperty;
   import com.oyunstudyosu.property.GiftOnceProperty;
   import com.oyunstudyosu.property.InviteGiftProperty;
   import com.oyunstudyosu.property.JSFunctionProperty;
   import com.oyunstudyosu.property.NickChangePanelProperty;
   import com.oyunstudyosu.property.PanelProperty;
   import com.oyunstudyosu.property.PassageProperty;
   import com.oyunstudyosu.property.PaymentPanelProperty;
   import com.oyunstudyosu.property.ProfessionPanelProperty;
   import com.oyunstudyosu.property.RoomPanelProperty;
   import com.oyunstudyosu.property.RoomShopPanelProperty;
   import com.oyunstudyosu.property.SaleItemPanelProperty;
   import com.oyunstudyosu.property.SaleProductPanelProperty;
   import com.oyunstudyosu.property.ShopPanelProperty;
   import com.oyunstudyosu.property.SimpleBotMessageProperty;
   import com.oyunstudyosu.property.SolariumPanelProperty;
   import com.oyunstudyosu.property.SpeechProperty;
   import com.oyunstudyosu.property.TableTopGameProperty;
   import com.oyunstudyosu.property.TeleportProperty;
   import com.oyunstudyosu.property.TopListProperty;
   import com.oyunstudyosu.property.VipCardPanelProperty;
   import flash.utils.getDefinitionByName;
   
   public class DoorVO implements IDoorVO
   {
      
      private var _key:String;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _direction:int;
      
      private var _property:IProperty;
      
      public function DoorVO()
      {
         super();
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function set key(param1:String) : void
      {
         if(_key == param1)
         {
            return;
         }
         _key = param1;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function set x(param1:int) : void
      {
         if(_x == param1)
         {
            return;
         }
         _x = param1;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function set y(param1:int) : void
      {
         if(_y == param1)
         {
            return;
         }
         _y = param1;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
      }
      
      public function get property() : IProperty
      {
         return _property;
      }
      
      public function setProperty(param1:Object) : void
      {
         var _loc2_:Class = null;
         if(param1 == null)
         {
            trace("No door property for " + key);
            return;
         }
         RoomPanelProperty;
         PassageProperty;
         TeleportProperty;
         FlatExitProperty;
         FlatEnterProperty;
         GameProperty;
         TopListProperty;
         GatheringProperty;
         PanelProperty;
         SpeechProperty;
         TableTopGameProperty;
         SaleItemPanelProperty;
         ProfessionPanelProperty;
         PaymentPanelProperty;
         SimpleBotMessageProperty;
         ExternalLinkProperty;
         RoomShopPanelProperty;
         ShopPanelProperty;
         SolariumPanelProperty;
         NickChangePanelProperty;
         FlatSponsorPanelProperty;
         JSFunctionProperty;
         VipCardPanelProperty;
         ExchangeProperty;
         GiftOnceProperty;
         InviteGiftProperty;
         EmptyProperty;
         SaleProductPanelProperty;
         try
         {
            _loc2_ = getDefinitionByName("com.oyunstudyosu.property." + param1.cn) as Class;
         }
         catch(error:Error)
         {
            trace("No class found named" + param1.cn);
            return;
         }
         _property = new _loc2_();
         param1.type = "door";
         _property.data = param1;
      }
      
      public function dispose() : void
      {
         _property.dispose();
      }
   }
}

