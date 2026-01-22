package com.oyunstudyosu.property
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.service.IServiceModel;
   import org.oyunstudyosu.assets.clips.Breaking;
   import org.oyunstudyosu.assets.clips.Cutting;
   import org.oyunstudyosu.assets.clips.MeatGathering;
   import org.oyunstudyosu.assets.clips.Mining;
   
   public class GatheringProperty extends Property
   {
      
      private var serviceModel:IServiceModel;
      
      private var obj:IEntryVo;
      
      private var isStarted:int = 0;
      
      private var alertvo:AlertVo;
      
      public function GatheringProperty()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
      }
      
      override public function execute(param1:String = "") : void
      {
         var _loc6_:AlertVo = null;
         var _loc5_:Cutting = null;
         var _loc2_:Mining = null;
         var _loc3_:Breaking = null;
         var _loc4_:MeatGathering = null;
         trace("GatheringPropertyExecute");
         if(isStarted == 1)
         {
            _loc6_ = new AlertVo();
            _loc6_.alertType = "tooltip";
            _loc6_.description = $("GatheringAlreadyStarted");
            Dispatcher.dispatchEvent(new AlertEvent(_loc6_));
            return;
         }
         obj = Sanalika.instance.entryModel.getObjectById(param1);
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId || obj.lc == 2 || obj.lc == 0)
         {
            _loc6_ = new AlertVo();
            _loc6_.alertType = "tooltip";
            _loc6_.description = $("GatheringStarted");
            Dispatcher.dispatchEvent(new AlertEvent(_loc6_));
            Sanalika.instance.serviceModel.requestData("gatheritemsearch",{"id":data.metaKey},onSearchStart);
            isStarted = 1;
            if(data.item.clip == "ZUyDYQ0C")
            {
               _loc5_ = new Cutting();
               _loc5_.y = -50;
               _loc5_.x = 0;
               _loc5_.name = "animation";
               obj.clip.addChild(_loc5_);
            }
            if(data.item.clip == "pip6OHRT")
            {
               _loc2_ = new Mining();
               _loc2_.y = -40;
               _loc2_.x = 0;
               _loc2_.name = "animation";
               obj.clip.addChild(_loc2_);
            }
            if(data.item.clip == "n81ejfo4" || data.item.clip == "4xgqfl9f")
            {
               _loc3_ = new Breaking();
               _loc3_.y = -40;
               _loc3_.x = 0;
               _loc3_.name = "animation";
               obj.clip.addChild(_loc3_);
            }
            if(data.item.clip == "meat")
            {
               _loc4_ = new MeatGathering();
               _loc4_.scaleX = 0.5;
               _loc4_.scaleY = 0.5;
               _loc4_.y = 20;
               _loc4_.x = -10;
               _loc4_.name = "animation";
               obj.clip.addChild(_loc4_);
            }
         }
         else
         {
            _loc6_ = new AlertVo();
            _loc6_.alertType = "tooltip";
            _loc6_.description = $("GatheringItemLocked");
            Dispatcher.dispatchEvent(new AlertEvent(_loc6_));
         }
      }
      
      private function onSearchStart(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("gatheritemsearch",onSearchStart);
         if(param1.errorCode == undefined)
         {
            TweenMax.delayedCall(12,itemCollect);
         }
      }
      
      private function itemCollect() : void
      {
         trace("itemCollect.Init");
         TweenMax.delayedCall(2,animationRemove);
         Sanalika.instance.serviceModel.requestData("gatheritemcollect",{},onItemCollect);
      }
      
      private function animationRemove() : void
      {
         if(obj.clip.getChildByName("animation"))
         {
            obj.clip.removeChild(obj.clip.getChildByName("animation"));
         }
      }
      
      private function onItemCollect(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("gatheritemcollect",onItemCollect);
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         if(param1.quantity)
         {
            _loc2_.description = $("GatheredItem") + " " + $("pro_" + param1.clip) + " " + $("Quantity") + ": " + param1.quantity;
         }
         else
         {
            _loc2_.description = $("GatheredNothing");
         }
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         isStarted = 0;
      }
      
      private function onChange(param1:Object) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

