package com.oyunstudyosu.commands.purchase
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import de.polygonal.core.fmt.Sprintf;
   
   public class VipPurchaseDiscountCommand extends Command
   {
      
      private var cost:Array;
      
      private var sanilDiscount:int;
      
      private var diamondDiscount:int;
      
      private var desc:String = "";
      
      private var vo:AlertVo;
      
      public function VipPurchaseDiscountCommand(param1:Array)
      {
         super();
         this.cost = param1;
      }
      
      override public function execute() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < cost.length)
         {
            if(cost[_loc1_].discountedPrice != null)
            {
               if(cost[_loc1_].currency == "SANIL")
               {
                  sanilDiscount += cost[_loc1_].price - cost[_loc1_].discountedPrice;
               }
               if(cost[_loc1_].currency == "DIAMOND")
               {
                  diamondDiscount += cost[_loc1_].price - cost[_loc1_].discountedPrice;
               }
            }
            _loc1_++;
         }
         if(sanilDiscount > 0)
         {
            desc += Sprintf.format($("sanilPrice"),[sanilDiscount]);
         }
         if(diamondDiscount > 0)
         {
            if(desc.length > 0)
            {
               desc += ", ";
            }
            desc += Sprintf.format($("diamondPrice"),[diamondDiscount]);
         }
         if(desc.length == 0)
         {
            return;
         }
         vo = new AlertVo();
         vo.alertType = "Info";
         vo.title = $("VIP BENEFITS");
         vo.description = Sprintf.format($("vipProductPurchaseDiscount"),[desc]);
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
   }
}

