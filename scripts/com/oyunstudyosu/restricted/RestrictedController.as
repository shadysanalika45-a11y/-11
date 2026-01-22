package com.oyunstudyosu.restricted
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.RestrictedEvent;
   import com.oyunstudyosu.service.IServiceModel;
   
   public class RestrictedController
   {
      
      private var serviceModel:IServiceModel;
      
      public function RestrictedController()
      {
         super();
         Dispatcher.addEventListener("MyBuddyEvent.REMOVE_RESTRICTED",removeRestrictedRequest);
         serviceModel = Sanalika.instance.serviceModel;
         serviceModel.listenExtension("avatarRestrictionRemoved",restrictedRemoved);
      }
      
      private function addRestrictedRequest(param1:Object) : void
      {
      }
      
      private function removeRestrictedRequest(param1:RestrictedEvent) : void
      {
         serviceModel.requestData("removeavatarrestriction",{
            "cmd":"remove",
            "avatarID":param1.avatarID
         },null);
      }
      
      private function restrictedRemoved(param1:Object) : void
      {
         Sanalika.instance.restrictedModel.removeFromRestricted(param1);
      }
      
      public function dispose() : void
      {
         Dispatcher.removeEventListener("MyRestrictedEvent.RESTRICTED_REMOVED",restrictedRemoved);
      }
   }
}

