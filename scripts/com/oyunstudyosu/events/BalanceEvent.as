package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class BalanceEvent extends Event
   {
      
      public static const BALANCE_UPDATE:String = "balanceUpdate";
      
      public var balance:String;
      
      public var balanceType:String;
      
      public function BalanceEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new BalanceEvent(type);
      }
   }
}

