package com.oyunstudyosu.panel
{
   import flash.events.Event;
   
   public class PanelEvent extends Event
   {
      
      public static const CLOSE:String = "PanelEvent.CLOSE";
      
      public var panel:IPanel;
      
      public function PanelEvent(param1:String, param2:IPanel)
      {
         this.panel = param2;
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new PanelEvent(type,this.panel);
      }
      
      override public function toString() : String
      {
         return formatToString("PanelEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}

