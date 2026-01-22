package org.oyunstudyosu.assets.clips
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.oyunstudyosu.balance.CoreBalanceClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol914")]
   public class QuestIndicator extends CoreBalanceClip
   {
      
      public var icon:MovieClip;
      
      public var bg:MovieClip;
      
      public var balanceBtn:SimpleButton;
      
      public var balanceTxt:TextField;
      
      public var currentBalance:int;
      
      public var newBalance:int;
      
      public function QuestIndicator()
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
      }
      
      protected function diamondButtonClicked(param1:MouseEvent) : void
      {
      }
   }
}

