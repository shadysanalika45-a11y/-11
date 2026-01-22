package org.osflash.signals.natives.sets
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.osflash.signals.natives.NativeSignal;
   
   public class TimerSignalSet extends EventDispatcherSignalSet
   {
      
      public function TimerSignalSet(param1:Timer)
      {
         super(param1);
      }
      
      public function get timer() : NativeSignal
      {
         return getNativeSignal(TimerEvent.TIMER,TimerEvent);
      }
      
      public function get timerComplete() : NativeSignal
      {
         return getNativeSignal(TimerEvent.TIMER_COMPLETE,TimerEvent);
      }
   }
}

