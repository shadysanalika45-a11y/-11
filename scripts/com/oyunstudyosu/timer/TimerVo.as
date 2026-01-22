package com.oyunstudyosu.timer
{
   public class TimerVo
   {
      
      public var createTimestamp:int;
      
      public var second:int = 0;
      
      public var repeatCount:int = 0;
      
      public var callback:Vector.<Function> = null;
      
      public var started:Boolean = false;
      
      public function TimerVo()
      {
         super();
      }
   }
}

