package com.oyunstudyosu.property
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.HudEvent;
   
   public class ThrowProperty extends Property
   {
      
      public function ThrowProperty()
      {
         super();
         trace("ThrowPropertyLoad");
      }
      
      override public function execute(param1:String = "") : void
      {
         trace("ThrowPropertyExecute");
         Dispatcher.dispatchEvent(new HudEvent("HudEvent.SHOW_JOYSTICK"));
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         trace("ThrowProperty",data.type);
      }
      
      override public function dispose() : void
      {
         Dispatcher.dispatchEvent(new HudEvent("HudEvent.HIDE_JOYSTICK"));
         super.dispose();
      }
   }
}

