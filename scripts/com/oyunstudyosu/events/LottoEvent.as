package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class LottoEvent extends Event
   {
      
      public static const JOIN_THE_GAME:String = "LottoEvent::JoinTheGame";
      
      public static const CLOSE_THE_GAME:String = "LottoEvent::CloseTheGame";
      
      public function LottoEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

