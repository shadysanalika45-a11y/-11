package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.interfaces.IKeyboardModel;
   import flash.events.KeyboardEvent;
   import flash.utils.Dictionary;
   
   public class KeyboardModel implements IKeyboardModel
   {
      
      protected var map:Dictionary;
      
      public function KeyboardModel()
      {
         super();
         Sanalika.instance.layerModel.stage.addEventListener("keyUp",onKeyUp);
         map = new Dictionary(true);
      }
      
      public function addKeyMapping(param1:String, param2:Function) : void
      {
         if(map[param1] != null)
         {
            trace("Override happened on key mapping. " + param1);
         }
         map[param1] = param2;
      }
      
      public function clearKeyMapping(param1:String) : void
      {
         delete map[param1];
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc3_:String = param1.ctrlKey ? "CTRL+" : "";
         _loc3_ += param1.shiftKey ? "SHIFT+" : "";
         _loc3_ += param1.altKey ? "ALT+" : "";
         if(param1.charCode)
         {
            _loc3_ += String.fromCharCode(param1.charCode).toUpperCase();
         }
         else
         {
            _loc3_ += param1.keyCode;
         }
         var _loc2_:Function = map[_loc3_];
         if(Boolean(_loc2_))
         {
            _loc2_();
         }
      }
   }
}

