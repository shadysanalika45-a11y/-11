package com.oyunstudyosu.alert
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.panel.IPanel;
   import com.oyunstudyosu.panel.Panel;
   import com.oyunstudyosu.panel.PanelEvent;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.utils.StringUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.oyunstudyosu.alert.SanalikaAlert;
   
   public class AlertModel implements IAlertModel
   {
      
      private var alertTipContainer:Sprite;
      
      private var timeoutIdMap:Dictionary;
      
      private var visibleTipCount:int = 5;
      
      private var tipHeight:int = 27;
      
      private var tipDuration:int = 8;
      
      private var tipSlideTime:Number = 0.3;
      
      private var alert:Panel;
      
      public var newAlertTip:AlertTooltip;
      
      public var repeat:int = 1;
      
      public function AlertModel()
      {
         super();
         timeoutIdMap = new Dictionary();
         alertTipContainer = new Sprite();
         alertTipContainer.visible = false;
         alertTipContainer.addEventListener("removed",onRemoved,false,0,true);
         Sanalika.instance.layerModel.hudLayer.addChild(alertTipContainer);
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminateGame,true);
         Dispatcher.addEventListener("AlertEvent.SEND",onAlertSend,true);
         Dispatcher.addEventListener("RESIZE",onResize,true);
         onResize();
      }
      
      private function onTerminateGame(param1:GameEvent) : void
      {
         dispose();
      }
      
      private function onResize(param1:GameEvent = null) : void
      {
         try
         {
            if(alertTipContainer)
            {
               alertTipContainer.x = Sanalika.instance.gameModel.canvasWidth - 5;
               alertTipContainer.y = Sanalika.instance.gameModel.canvasHeight - tipHeight * Sanalika.instance.scaleModel.uiScale - 25;
               alertTipContainer.visible = true;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onAlertSend(param1:AlertEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:PanelVO = null;
         if(!Sanalika.instance.avatarModel.settings.hideRequests)
         {
            if(param1.vo.alertType == "tooltip")
            {
               return;
            }
         }
         if(param1.vo.alertType == "tooltip" || !Sanalika.instance.avatarModel.settings.showInvitations && param1.vo.alertType == "Info")
         {
            if(param1.vo.description == "" || param1.vo.description == null)
            {
               return;
            }
            if(!Sanalika.instance.avatarModel.isTutorialMode)
            {
               param1.vo.description = StringUtil.replaceCarriageReturnsToSpace(param1.vo.description);
               if(param1.vo.title != "" && param1.vo.title != null)
               {
                  param1.vo.description = param1.vo.title + ": " + param1.vo.description;
               }
               showTooltip(param1.vo.description,param1.vo.callBack,param1.vo.sound);
            }
         }
         else
         {
            _loc2_ = param1.vo.panelType == null ? "core" : param1.vo.panelType;
            _loc3_ = new PanelVO("AlertPanel",_loc2_,toObject(param1.vo));
            alert = new SanalikaAlert();
            alert.data = _loc3_;
            Sanalika.instance.layerModel.notificationMessageLayer.addChild(alert as Panel);
            alert.init();
            if(param1.vo.alertType == "Info")
            {
               setTimeout(Dispatcher.dispatchEvent,88000,new PanelEvent("PanelEvent.CLOSE",alert));
               setTimeout(alert.dispose,90000);
            }
            Dispatcher.addEventListener("PanelEvent.CLOSE",closeAlert);
            setNotificationMessagesIndex();
         }
      }
      
      protected function closeAlert(param1:PanelEvent) : void
      {
         var _loc2_:IPanel = param1.panel;
         if(_loc2_ is SanalikaAlert && Sanalika.instance.layerModel.notificationMessageLayer.contains(_loc2_ as SanalikaAlert))
         {
            Sanalika.instance.layerModel.notificationMessageLayer.removeChild(_loc2_ as Panel);
         }
      }
      
      private function setNotificationMessagesIndex() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc2_:int = Sanalika.instance.layerModel.notificationMessageLayer.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = Sanalika.instance.layerModel.notificationMessageLayer.getChildAt(_loc3_);
            if(_loc1_ is SanalikaAlert)
            {
               _loc1_.x = -(_loc1_.width / 2) + _loc3_ * 10;
               _loc1_.y = -(_loc1_.height / 2) + _loc3_ * 10;
            }
            _loc3_++;
         }
      }
      
      private function showTooltip(param1:String, param2:Function = null, param3:* = false) : void
      {
         var _loc4_:AlertTooltip = null;
         var _loc6_:int = 0;
         if(newAlertTip)
         {
            if(newAlertTip.messageKey == param1)
            {
               if(alertTipContainer.numChildren > 0)
               {
                  alertTipContainer.removeChildAt(alertTipContainer.numChildren - 1);
               }
               repeat += 1;
            }
            else
            {
               repeat = 1;
            }
         }
         var _loc5_:int = alertTipContainer.numChildren;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(repeat > 1)
            {
               break;
            }
            _loc4_ = alertTipContainer.getChildAt(_loc6_) as AlertTooltip;
            if(_loc4_.alpha < 0.01 || _loc5_ > 10)
            {
               TweenLite.killTweensOf(_loc4_,true);
               alertTipContainer.removeChild(_loc4_);
               _loc5_--;
            }
            else
            {
               TweenLite.killTweensOf(_loc4_,true);
               TweenLite.to(_loc4_,tipSlideTime,{
                  "y":_loc4_.y - tipHeight * Sanalika.instance.scaleModel.uiScale - 5,
                  "ease":Quad.easeOut
               });
            }
            _loc6_++;
         }
         newAlertTip = new AlertTooltip(param1,param2,repeat);
         newAlertTip.x = -newAlertTip.width;
         TweenLite.from(newAlertTip,tipSlideTime,{
            "y":tipHeight * Sanalika.instance.scaleModel.uiScale,
            "ease":Quad.easeOut
         });
         alertTipContainer.addChild(newAlertTip);
         if(param3)
         {
            Sanalika.instance.soundModel.playSound("SoundKey.ALERT",1,1);
         }
         timeoutIdMap[newAlertTip] = setTimeout(onTimeout,tipDuration * 1000,newAlertTip);
      }
      
      private function onTimeout(param1:DisplayObject) : void
      {
         alertTipContainer.removeChild(param1);
      }
      
      protected function onRemoved(param1:Event) : void
      {
         var _loc2_:AlertTooltip = param1.target as AlertTooltip;
         clearTimeout(timeoutIdMap[_loc2_]);
         delete timeoutIdMap[_loc2_];
      }
      
      public function toObject(param1:IAlertVo) : Object
      {
         var _loc2_:Object = {};
         _loc2_.title = param1.title;
         _loc2_.description = param1.description;
         _loc2_.stepperComment = param1.stepperComment;
         _loc2_.alertType = param1.alertType;
         _loc2_.callBack = param1.callBack;
         _loc2_.minQuantity = param1.minQuantity;
         _loc2_.maxQuantity = param1.maxQuantity;
         _loc2_.stepSize = param1.stepSize;
         _loc2_.isTransfer = param1.isTransfer;
         _loc2_.defaultInputMessage = param1.defaultInputMessage;
         _loc2_.secretSession = param1.secretSession;
         _loc2_.data = param1.data;
         return _loc2_;
      }
      
      public function toAlertVo(param1:Object) : IAlertVo
      {
         var _loc3_:AlertVo = new AlertVo();
         for(var _loc2_ in param1)
         {
            _loc3_[_loc2_] = param1[_loc2_];
         }
         return _loc3_;
      }
      
      private function dispose() : void
      {
         while(alertTipContainer.numChildren > 0)
         {
            alertTipContainer.removeChildAt(0);
         }
      }
   }
}

