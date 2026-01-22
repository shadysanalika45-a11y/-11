package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class ComboBoxEvent extends Event
   {
      
      public static const ITEM_SELECTED:String = "itemSelected";
      
      public var id:int;
      
      public function ComboBoxEvent(param1:String)
      {
         super(param1);
      }
   }
}

