package com.oyunstudyosu.model
{
   import com.greensock.TweenMax;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.IToolTipModel;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.StaticArabicTextField;
   import org.oyunstudyosu.assets.clips.ToolTipClip;
   
   public class ToolTipModel implements IToolTipModel
   {
      
      private var tfMc:StaticArabicTextField;
      
      private var myTextFormat:TextFormat;
      
      private var tip:Sprite;
      
      private var balloon:ToolTipClip;
      
      private var mc:DisplayObjectContainer;
      
      private var targetItem:DisplayObject;
      
      private var dictionary:Dictionary = new Dictionary(true);
      
      public function ToolTipModel()
      {
         super();
         tfMc = new StaticArabicTextField();
         tfMc.name = "fld";
         tfMc.sText.multiline = true;
         tfMc.sText.width = 200;
         tfMc.sText.y = -2;
         tfMc.x = 4;
         tfMc.y = 4;
         tip = new Sprite();
         balloon = new ToolTipClip();
         TweenMax.to(balloon,0,{"dropShadowFilter":{
            "color":1381653,
            "alpha":0.5,
            "blurX":2,
            "blurY":2,
            "distance":2,
            "angle":45
         }});
         tip.addChild(balloon);
         tip.addChild(tfMc);
         tip.visible = false;
      }
      
      public function showTip(param1:DisplayObject, param2:String, param3:int = 0) : void
      {
         dictionary[param1] = {
            "clip":param1,
            "message":param2,
            "align":param3
         };
         param1.addEventListener("rollOut",outRightClickTip);
         drawTip(param1);
      }
      
      protected function outRightClickTip(param1:MouseEvent) : void
      {
         targetItem = param1.currentTarget as DisplayObject;
         if(targetItem.parent)
         {
            if(targetItem.parent.contains(tip))
            {
               targetItem.removeEventListener("rollOut",outRightClickTip);
               if(!tip.visible)
               {
                  return;
               }
               tip.visible = false;
               try
               {
                  Sanalika.instance.layerModel.stage.removeChild(tip);
               }
               catch(error:Error)
               {
               }
               delete dictionary[targetItem];
            }
         }
      }
      
      public function addTip(param1:DisplayObject, param2:String, param3:int = 0) : void
      {
         dictionary[param1] = {
            "clip":param1,
            "message":param2,
            "align":param3
         };
         param1.addEventListener("rollOver",overItem);
         param1.addEventListener("rollOut",outItem);
         param1.addEventListener("mouseDown",downItem);
      }
      
      public function removeTip(param1:DisplayObject) : void
      {
         param1.removeEventListener("rollOver",overItem);
         param1.removeEventListener("rollOut",outItem);
         param1.removeEventListener("mouseDown",downItem);
         delete dictionary[param1];
      }
      
      protected function overItem(param1:MouseEvent) : void
      {
         targetItem = param1.currentTarget as DisplayObject;
         drawTip(targetItem);
      }
      
      private function drawTip(param1:DisplayObject) : void
      {
         var _loc3_:int = int(dictionary[param1].align);
         tfMc.sText.width = 180;
         tfMc.sText.multiline = true;
         if(Sanalika.instance.localizationModel.hasSecondaryLanguage)
         {
            tfMc.sText.htmlText = $(dictionary[param1].message);
         }
         else
         {
            tfMc.sText.htmlText = $(dictionary[param1].message);
         }
         if(tfMc.sText.textWidth > 180)
         {
            tfMc.sText.multiline = true;
            tfMc.sText.wordWrap = true;
         }
         else
         {
            tfMc.sText.width = tfMc.sText.textWidth + 6;
         }
         tfMc.sText.height = tfMc.sText.textHeight + 4;
         balloon.width = tfMc.width + tfMc.x * 2;
         balloon.height = tfMc.height + tfMc.y * 2;
         if(tip.visible)
         {
            return;
         }
         tip.y = param1.y - tip.height - 5;
         if(_loc3_ == 0)
         {
            tip.x = param1.x + param1.width / 2 - tip.width / 2;
         }
         else if(_loc3_ == 1)
         {
            tip.x = param1.x + param1.width / 2 - tip.width;
         }
         else if(_loc3_ == 2)
         {
            tip.x = param1.x + param1.width / 2;
         }
         else if(_loc3_ == 3)
         {
            tip.y = param1.y + param1.height + 4;
            tip.x = param1.x + param1.width / 2 - tip.width / 2;
         }
         else if(_loc3_ == 4)
         {
            tip.y = param1.y + param1.height + 4;
            tip.x = param1.x - tip.width;
         }
         else if(_loc3_ == 5)
         {
            tip.y = param1.y + (param1.height - tip.height) / 2;
            tip.x = param1.x - tip.width - 4;
         }
         var _loc2_:Point = param1.parent.localToGlobal(new Point(tip.x,tip.y));
         tip.x = _loc2_.x;
         tip.y = _loc2_.y;
         tip.scaleX = tip.scaleY = Sanalika.instance.scaleModel.uiScale;
         tip.mouseChildren = false;
         tip.mouseEnabled = false;
         Sanalika.instance.layerModel.stage.addChild(tip);
         tip.visible = true;
      }
      
      protected function outItem(param1:MouseEvent) : void
      {
         targetItem = param1.currentTarget as DisplayObject;
         if(!tip.visible)
         {
            return;
         }
         tip.visible = false;
         try
         {
            Sanalika.instance.layerModel.stage.removeChild(tip);
         }
         catch(error:Error)
         {
         }
      }
      
      protected function downItem(param1:MouseEvent) : void
      {
         targetItem = param1.currentTarget as DisplayObject;
         if(!tip.visible)
         {
            return;
         }
         tip.visible = false;
         try
         {
            Sanalika.instance.layerModel.stage.removeChild(tip);
         }
         catch(error:Error)
         {
         }
      }
   }
}

