package com.oyunstudyosu.property
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.interactive.IEntryVo;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.service.IServiceModel;
   import com.oyunstudyosu.timer.SyncTimer;
   import com.oyunstudyosu.utils.StringUtil;
   import de.polygonal.core.fmt.Sprintf;
   import flash.events.Event;
   
   public class FarmProperty extends Property
   {
      
      private var serviceModel:IServiceModel;
      
      private var obj:IEntryVo;
      
      private var isStarted:int = 0;
      
      private var alertvo:AlertVo;
      
      private var localState:String;
      
      public function FarmProperty()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc3_:Object = null;
         Sanalika.instance.stage.removeEventListener("enterFrame",update);
         Sanalika.instance.stage.addEventListener("enterFrame",update);
         super.data = param1;
         this.localState = "IDLE";
         trace("SETDATA");
         for(var _loc2_ in super.data)
         {
            _loc3_ = super.data[_loc2_];
            trace(_loc2_ + " = " + _loc3_);
         }
      }
      
      private function update(param1:Event) : void
      {
         if(data == null || data.status == null)
         {
            return;
         }
         var _loc2_:int = Math.floor(data.status.expireTime - SyncTimer.timestamp);
         var _loc4_:int = int(data.status.productionTime);
         var _loc3_:String = "IDLE";
         if(data.item != null)
         {
            if(_loc2_ <= _loc4_ / 4 * -1)
            {
               _loc3_ = "DRY";
            }
            else if(_loc2_ <= 0)
            {
               _loc3_ = "PRODUCT";
            }
            else if(_loc2_ <= _loc4_ / 2)
            {
               _loc3_ = "SEEDLING";
            }
            else if(_loc2_ <= _loc4_)
            {
               _loc3_ = "PLANTED";
            }
         }
         if(_loc3_ != localState)
         {
            if(!obj)
            {
               obj = Sanalika.instance.entryModel.getObjectById(data.metaKey);
            }
            trace("client FrameChanged!!!!!!!!!!!!!!!!!!!!!!!!",data.item.clip + _loc3_);
            localState = _loc3_;
            try
            {
               obj.gotoFrameLabel(data.item.clip + _loc3_);
               if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId && _loc3_ == "PRODUCT")
               {
                  alertvo = new AlertVo();
                  alertvo.alertType = "tooltip";
                  alertvo.description = $("farmHARVESTREADY") + " | " + $("pro_" + data.item.clip);
                  Dispatcher.dispatchEvent(new AlertEvent(alertvo));
               }
            }
            catch(e:Error)
            {
               trace(e.message);
               trace(e.getStackTrace());
            }
         }
      }
      
      override public function execute(param1:String = "") : void
      {
         trace("FarmPropertyExecute");
         trace("isStarted",isStarted);
         if(isStarted == 1)
         {
            return;
         }
         obj = Sanalika.instance.entryModel.getObjectById(data.metaKey);
         if(Sanalika.instance.roomModel.ownerId == Sanalika.instance.avatarModel.avatarId)
         {
            if(localState == "PRODUCT")
            {
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = Sanalika.instance.localizationModel.translate("farmHARVEST");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
               Sanalika.instance.serviceModel.requestData("farmgather",{"id":data.metaKey},onHarvestStart);
            }
            else if(localState == "DRY")
            {
               Sanalika.instance.serviceModel.requestData("farmclean",{"id":data.metaKey},onCleanStart);
            }
            else if(localState == "IDLE")
            {
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = Sanalika.instance.localizationModel.translate("farm" + localState);
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            else if(localState == "PLANTED" || localState == "SEEDLING")
            {
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = Sanalika.instance.localizationModel.translate("farm" + localState) + " | " + Sanalika.instance.localizationModel.translate("pro_" + data.item.clip) + " | " + Sprintf.format(Sanalika.instance.localizationModel.translate("leftTime"),[StringUtil.secondToString(Math.floor(data.status.expireTime - SyncTimer.timestamp))]);
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
            else
            {
               alertvo = new AlertVo();
               alertvo.alertType = "tooltip";
               alertvo.description = Sanalika.instance.localizationModel.translate("farmState???");
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
         }
         else if(localState == "PLANTED" || localState == "SEEDLING")
         {
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = Sanalika.instance.localizationModel.translate("farm" + localState) + " | " + Sanalika.instance.localizationModel.translate("pro_" + data.item.clip) + " | " + Sprintf.format(Sanalika.instance.localizationModel.translate("leftTime"),[StringUtil.secondToString(Math.floor(data.status.expireTime - SyncTimer.timestamp))]);
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
         }
         else
         {
            alertvo = new AlertVo();
            alertvo.alertType = "tooltip";
            alertvo.description = Sanalika.instance.localizationModel.translate("FarmNA");
            Dispatcher.dispatchEvent(new AlertEvent(alertvo));
         }
      }
      
      private function onCleanStart(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         Sanalika.instance.serviceModel.removeRequestData("farmclean",onCleanStart);
         if(param1.errorCode)
         {
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $(param1.errorCode);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         isStarted = 0;
      }
      
      private function onHarvestStart(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("farmgather",onHarvestStart);
         isStarted = 0;
      }
      
      override public function dispose() : void
      {
         Sanalika.instance.stage.removeEventListener("enterFrame",update);
         super.dispose();
      }
   }
}

