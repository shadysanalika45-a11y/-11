package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class BotEvent extends Event
   {
      
      public static const SPEECH:String = "speech";
      
      public var speechType:String;
      
      public var botKey:String;
      
      public function BotEvent(param1:String, param2:String, param3:String = null, param4:Boolean = false, param5:Boolean = false)
      {
         this.speechType = param2;
         this.botKey = param3;
         super(param1,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new PlayGameEvent(type,this.speechType,bubbles,cancelable);
      }
   }
}

