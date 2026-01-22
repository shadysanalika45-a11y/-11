package com.oyunstudyosu.barter
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.BarterEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.service.IServiceModel;
   import de.polygonal.core.fmt.Sprintf;
   
   public class BarterController
   {
      
      private var serviceModel:IServiceModel;
      
      private var vo:AlertVo;
      
      private var barterID:String;
      
      private var senderID:String;
      
      private var barterReqWaiting:Boolean;
      
      public function BarterController()
      {
         super();
         serviceModel = Sanalika.instance.serviceModel;
         Dispatcher.addEventListener("BarterEvent.BARTER_START_REQUEST",startBarterRequest);
         Dispatcher.addEventListener("BarterEvent.BARTER_CANCEL",cancelBarterRequest);
         serviceModel.listenExtension("respondBarterRequest",respondBarterRequest);
         serviceModel.listenExtension("barterStarted",newBarterStarted);
      }
      
      private function newBarterStarted(param1:Object) : void
      {
         senderID = param1.avatarID;
         barterID = param1.barterID;
         var _loc2_:PanelVO = new PanelVO("BarterPanel");
         _loc2_.type = "static";
         _loc2_.params = param1;
         Sanalika.instance.panelModel.openPanel(_loc2_);
      }
      
      private function respondBarterRequest(param1:Object) : void
      {
         if(barterReqWaiting || !Sanalika.instance.avatarModel.settings.tradeRequests || !Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            return;
         }
         barterID = param1.barterID;
         senderID = param1.senderID;
         barterReqWaiting = true;
         var _loc2_:SceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
         var _loc3_:ICharacter = _loc2_.getAvatarById(senderID);
         vo = new AlertVo();
         vo.alertType = "Confirm";
         vo.callBack = barterRequestAnswer;
         vo.description = Sprintf.format(LanguageKeys.BARTER_START_REQUEST,_loc3_ != null ? [_loc3_.avatarName] : [senderID]);
         Dispatcher.dispatchEvent(new AlertEvent(vo));
      }
      
      private function barterRequestAnswer(param1:int) : void
      {
         if(param1 == 2)
         {
            serviceModel.requestData("barterresponse",{
               "barterID":barterID,
               "response":"ACCEPTED"
            },null);
         }
         else
         {
            serviceModel.requestData("barterresponse",{
               "barterID":barterID,
               "response":"REJECTED"
            },null);
         }
         barterReqWaiting = false;
      }
      
      private function startBarterRequest(param1:BarterEvent) : void
      {
         serviceModel.requestData("barterrequest",{"avatarID":param1.avatarID},null);
      }
      
      private function cancelBarterRequest(param1:BarterEvent) : void
      {
         if(barterID != null && param1.avatarID == senderID)
         {
            serviceModel.requestData("bartercancel",{"barterID":barterID},null);
         }
         barterReqWaiting = false;
      }
   }
}

