package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.alert.IAlertModel;
   import com.oyunstudyosu.alert.IAlertVo;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class AlertModel implements IAlertModel
   {
      
      private var alertTipContainer:Sprite;
      
      private var timeoutIdMap:Dictionary;
      
      private var visibleTipCount:int = 5;
      
      private var tipHeight:int = 28;
      
      private var tipDuration:int = 8;
      
      private var tipSlideTime:Number = 0.4;
      
      public function AlertModel()
      {
         super();
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
         _loc2_.defaultInputMessage = param1.defaultInputMessage;
         return _loc2_;
      }
      
      public function toAlertVo(param1:Object) : IAlertVo
      {
         var _loc3_:String = null;
         var _loc2_:AlertVo = new AlertVo();
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
   }
}

