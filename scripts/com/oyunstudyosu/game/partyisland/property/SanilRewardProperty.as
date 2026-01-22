package com.oyunstudyosu.game.partyisland.property
{
   import com.greensock.TweenLite;
   import com.oyunstudyosu.engine.ICharacter;
   import flash.display.MovieClip;
   import org.oyunstudyosu.gift.DropGift;
   
   public class SanilRewardProperty extends EmptyPartyProperty
   {
      
      public function SanilRewardProperty()
      {
         super();
      }
      
      override public function execute(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:DropGift = null;
         setText("Earned %s sanil",[param2.amount]);
         var _loc7_:MovieClip = new MovieClip();
         Sanalika.instance.layerModel.effectLayer.addChild(_loc7_);
         var _loc6_:ICharacter = getAvatarById(param1);
         if(_loc6_ != null)
         {
            _loc3_ = Math.floor(param2.amount / 10);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = new DropGift();
               _loc4_.x = _loc6_.container.x;
               _loc4_.y = _loc6_.container.y - 50;
               _loc4_.delay = 0.1 * _loc5_;
               _loc4_.currencyType = "SANIL";
               _loc7_.addChildAt(_loc4_,0);
               _loc5_++;
            }
         }
         TweenLite.delayedCall(7,removeContainerGift,[_loc7_]);
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

