package com.oyunstudyosu.alert
{
   import com.oyunstudyosu.local.$;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.oyunstudyosu.assets.clips.StaticArabicTextField;
   import org.oyunstudyosu.assets.clips.ToolTipClip;
   
   public class AlertTooltip extends Sprite
   {
      
      private var callback:Function;
      
      public var messageKey:String;
      
      public function AlertTooltip(param1:String, param2:Function = null, param3:* = 1)
      {
         super();
         if(param1 == "" || param1 == null)
         {
            param1 = "Unknown Error";
         }
         this.messageKey = param1;
         this.mouseChildren = false;
         var _loc4_:StaticArabicTextField = new StaticArabicTextField();
         _loc4_.sText.wordWrap = false;
         _loc4_.sText.multiline = false;
         _loc4_.sText.autoSize = "none";
         _loc4_.x = 6 * Sanalika.instance.scaleModel.uiScale;
         _loc4_.y = 3 * Sanalika.instance.scaleModel.uiScale;
         if(param3 > 1)
         {
            _loc4_.sText.htmlText = $(param1) + " (" + param3 + ")";
         }
         else
         {
            _loc4_.sText.htmlText = $(param1);
         }
         _loc4_.scaleX = Sanalika.instance.scaleModel.uiScale;
         _loc4_.scaleY = Sanalika.instance.scaleModel.uiScale;
         var _loc5_:ToolTipClip = new ToolTipClip();
         _loc5_.width = _loc4_.width + _loc4_.x * 2;
         _loc5_.height = _loc4_.height + 4;
         addChild(_loc5_);
         addChild(_loc4_);
         if(param2 != null)
         {
            this.callback = param2;
            this.addEventListener("click",onMouseClick);
            this.addEventListener("removedFromStage",onRemoved);
            this.mouseEnabled = true;
            this.buttonMode = true;
         }
      }
      
      protected function onRemoved(param1:Event) : void
      {
         callback = null;
         this.removeEventListener("click",onMouseClick);
         this.removeEventListener("removedFromStage",onRemoved);
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         callback();
         this.parent.removeChild(this);
      }
   }
}

