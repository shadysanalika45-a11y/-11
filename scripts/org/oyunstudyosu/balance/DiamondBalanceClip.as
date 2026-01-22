package org.oyunstudyosu.balance
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1021")]
   public class DiamondBalanceClip extends CoreBalanceClip
   {
      
      public var icon:MovieClip;
      
      public var bg:MovieClip;
      
      public var balanceBtn:SimpleButton;
      
      public var balanceTxt:TextField;
      
      public var currentBalance:int;
      
      public var newBalance:int;
      
      public function DiamondBalanceClip()
      {
         super();
      }
      
      override public function balanceUpdate(param1:String) : void
      {
         if(this.balanceTxt.text)
         {
            this.currentBalance = parseInt(this.balanceTxt.text);
         }
         this.newBalance = parseInt(param1);
         if(Math.abs(this.newBalance - this.currentBalance) < 10)
         {
            this.balanceTxt.text = param1;
         }
         else
         {
            TweenMax.to(this,2,{
               "currentBalance":this.newBalance,
               "onUpdate":this.changeBalance,
               "ease":Quad.easeOut
            });
         }
         super.balanceUpdate(param1);
      }
      
      protected function changeBalance() : void
      {
         this.balanceTxt.text = this.currentBalance.toString();
      }
      
      override public function added() : void
      {
         this.balanceBtn.addEventListener(MouseEvent.CLICK,this.diamondButtonClicked);
      }
      
      protected function diamondButtonClicked(param1:MouseEvent) : void
      {
         Dispatcher.dispatchEvent(new HudEvent(HudEvent.OPEN_DIAMOND_PURCHASE_PANEL));
      }
   }
}

