package com.oyunstudyosu.game.partyisland.property
{
   import com.greensock.TweenLite;
   import com.oyunstudyosu.engine.ICharacter;
   import flash.display.MovieClip;
   import org.oyunstudyosu.gift.DropGift;
   
   public class InventoryItemRewardProperty extends EmptyPartyProperty
   {
      
      public function InventoryItemRewardProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:DropGift = null;
         var _loc3_:Object = param2.reward;
         var _loc6_:String = Sanalika.instance.localizationModel.translate("pro_" + _loc3_.clip);
         setText("%s item earned",[_loc6_]);
         var _loc9_:MovieClip = new MovieClip();
         Sanalika.instance.layerModel.effectLayer.addChild(_loc9_);
         var _loc8_:ICharacter = getAvatarById(param1);
         if(_loc8_ != null)
         {
            _loc4_ = int(_loc3_.quantity);
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc5_ = new DropGift();
               _loc5_.x = _loc8_.container.x;
               _loc5_.y = _loc8_.container.y - 50;
               _loc5_.delay = 0.1 * _loc7_;
               _loc5_.currencyType = "OBJECT";
               _loc9_.addChildAt(_loc5_,0);
               _loc7_++;
            }
         }
         TweenLite.delayedCall(7,removeContainerGift,[_loc9_]);
      }
      
      private function removeContainerGift(param1:MovieClip) : void
      {
         if(Sanalika.instance.layerModel.effectLayer.contains(param1))
         {
            Sanalika.instance.layerModel.effectLayer.removeChild(param1);
         }
      }
   }
}

