package org.oyunstudyosu.balance
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.enums.BalanceType;
   import com.oyunstudyosu.events.BalanceEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import org.oyunstudyosu.components.CoreMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1014")]
   public class BalanceView extends CoreMovieClip
   {
      
      public var sanilBalance:SanilBalanceClip;
      
      public var diamondBalance:DiamondBalanceClip;
      
      public function BalanceView()
      {
         super();
      }
      
      override public function added() : void
      {
         this.diamondBalance = new DiamondBalanceClip();
         this.diamondBalance.name = "diamondBalance";
         TweenMax.to(this.diamondBalance,0,{"glowFilter":{
            "color":0,
            "alpha":0.4,
            "blurX":6,
            "blurY":6,
            "strength":1
         }});
         addChild(this.diamondBalance);
         this.sanilBalance = new SanilBalanceClip();
         this.sanilBalance.name = "sanilBalance";
         TweenMax.to(this.sanilBalance,0,{"glowFilter":{
            "color":0,
            "alpha":0.4,
            "blurX":6,
            "blurY":6,
            "strength":1
         }});
         addChild(this.sanilBalance);
         this.sanilBalance.x = this.diamondBalance.x + this.diamondBalance.width + 10;
         this.sanilBalance.balanceUpdate(Connectr.instance.avatarModel.balance(BalanceType.SANIL));
         this.diamondBalance.balanceUpdate(Connectr.instance.avatarModel.balance(BalanceType.DIAMOND));
         Dispatcher.addEventListener(BalanceEvent.BALANCE_UPDATE,this.balanceUpdated);
      }
      
      private function balanceUpdated(param1:BalanceEvent) : void
      {
         if(param1.balanceType == BalanceType.SANIL)
         {
            this.sanilBalance.balanceUpdate(param1.balance);
         }
         if(param1.balanceType == BalanceType.DIAMOND)
         {
            this.diamondBalance.balanceUpdate(param1.balance);
         }
      }
      
      override public function removed() : void
      {
         Dispatcher.removeEventListener(BalanceEvent.BALANCE_UPDATE,this.balanceUpdated);
      }
   }
}

