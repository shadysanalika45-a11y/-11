package com.oyunstudyosu.events
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class BusinessMessageEvent extends Event
   {
      
      public static const ADD_BUSINESS_MESSAGE:String = "BusinessMessageEvent.ADD_BUSINESS_MESSAGE";
      
      public static const REMOVE_BUSINESS_MESSAGE:String = "BusinessMessageEvent.REMOVE_BUSINESS_MESSAGE";
      
      public var view:MovieClip;
      
      public function BusinessMessageEvent(param1:String)
      {
         super(param1);
      }
   }
}

