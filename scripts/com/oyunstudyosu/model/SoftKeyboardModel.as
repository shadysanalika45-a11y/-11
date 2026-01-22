package com.oyunstudyosu.model
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.SoftKeyboardEvent;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.SoftKeyboardEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SoftKeyboardModel
   {
      
      public var isSupported:Boolean = false;
      
      public var measureKeyboard:* = null;
      
      public var measureKeyboardInstance:* = null;
      
      private var intervalID:uint = 0;
      
      private var isActive:Boolean = false;
      
      public function SoftKeyboardModel(param1:Stage)
      {
         super();
         if(Sanalika.instance.stage.loaderInfo.applicationDomain.hasDefinition("com.freshplanet.ane.KeyboardSize.MeasureKeyboard") && Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.freshplanet.ane.KeyboardSize.MeasureKeyboard").isSupported)
         {
            measureKeyboard = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.freshplanet.ane.KeyboardSize.MeasureKeyboard");
            measureKeyboardInstance = measureKeyboard.getInstance();
         }
         else
         {
            if(!(Sanalika.instance.stage.loaderInfo.applicationDomain.hasDefinition("com.freshplanet.ane.AirKeyboardSize.MeasureKeyboard") && Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.freshplanet.ane.AirKeyboardSize.MeasureKeyboard").isSupported))
            {
               return;
            }
            measureKeyboard = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.freshplanet.ane.AirKeyboardSize.MeasureKeyboard");
            measureKeyboardInstance = measureKeyboard.instance;
         }
         param1.addEventListener("enterFrame",onEnterFrame);
         param1.addEventListener("softKeyboardActivate",onSoftKeyboardActive);
         param1.addEventListener("softKeyboardDeactivate",onSoftKeyboardDeactive);
         isSupported = true;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!isActive)
         {
            return;
         }
         var _loc2_:Number = Number(measureKeyboardInstance.getKeyboardHeight());
         var _loc3_:Number = Number(measureKeyboardInstance.getKeyboardY());
         if(Sanalika.instance.stage.stageHeight - _loc3_ >= 1)
         {
            Dispatcher.dispatchEvent(new com.oyunstudyosu.events.SoftKeyboardEvent("SOFT_KEYBOARD_ACTIVATE",_loc2_,_loc3_));
         }
      }
      
      private function onSoftKeyboardActive(param1:flash.events.SoftKeyboardEvent) : void
      {
         isActive = param1.target == Sanalika.instance.hudModel["hud"].inputText;
         if(isActive)
         {
            clearTimeout(intervalID);
         }
      }
      
      private function onSoftKeyboardDeactive(param1:flash.events.SoftKeyboardEvent) : void
      {
         var e:flash.events.SoftKeyboardEvent = param1;
         isActive = false;
         clearTimeout(intervalID);
         intervalID = setTimeout(function():*
         {
            Dispatcher.dispatchEvent(new com.oyunstudyosu.events.SoftKeyboardEvent("SOFT_KEYBOARD_DEACTIVATE"));
         },2000);
      }
   }
}

