package org.osflash.signals.natives.base
{
   import flash.utils.Timer;
   import org.osflash.signals.natives.sets.TimerSignalSet;
   
   public class SignalTimer extends Timer
   {
      
      private var _signals:TimerSignalSet;
      
      public function SignalTimer(param1:Number, param2:int = 0)
      {
         super(param1,param2);
      }
      
      public function get signals() : TimerSignalSet
      {
         return this._signals = this._signals || new TimerSignalSet(this);
      }
   }
}

