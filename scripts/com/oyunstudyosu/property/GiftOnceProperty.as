package com.oyunstudyosu.property
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.utils.StringUtil;
   import de.polygonal.core.fmt.Sprintf;
   
   public class GiftOnceProperty extends Property
   {
      
      private var vo:AlertVo;
      
      private var id:String;
      
      private var campaignKey:String;
      
      public function GiftOnceProperty()
      {
         super();
      }
      
      override public function execute(param1:String = "") : void
      {
         id = data.campaignID;
         if(!Sanalika.instance.giftModel.contains(id))
         {
            Sanalika.instance.serviceModel.requestData("campaignquest",{
               "command":"botGift",
               "id":id
            },giftOnceResponse);
         }
      }
      
      private function giftOnceResponse(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("campaignquest",giftOnceResponse);
         if(param1.errorCode == "GIFT_ALREADY_GIVEN")
         {
            Sanalika.instance.giftModel.add(id);
            vo = new AlertVo();
            vo.alertType = "tooltip";
            vo.description = $("giftAlreadyGiven");
            Dispatcher.dispatchEvent(new AlertEvent(vo));
            return;
         }
         if(param1.errorCode)
         {
            return;
         }
         vo = new AlertVo();
         vo.alertType = "Info";
         vo.title = $("giftOnceTitle" + param1.key);
         vo.description = Sprintf.format($("giftOnceDescription" + param1.key),[StringUtil.getInfoByGift(param1)]);
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
   }
}

