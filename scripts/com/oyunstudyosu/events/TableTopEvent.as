package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class TableTopEvent extends Event
   {
      
      public static const ELEMENT_UPDATE:String = "ELEMENT_UPDATE";
      
      public static const SCORE_UPDATE:String = "SCORE_UPDATE";
      
      public var data:Object;
      
      public function TableTopEvent(param1:String)
      {
         super(param1,true,false);
      }
      
      override public function clone() : Event
      {
         var _loc1_:TableTopEvent = new TableTopEvent(this.type);
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}

