package org.osflash.signals.natives.sets
{
   import flash.events.ActivityEvent;
   import flash.events.StatusEvent;
   import flash.media.Microphone;
   import org.osflash.signals.natives.NativeSignal;
   
   public class MicrophoneSignalSet extends EventDispatcherSignalSet
   {
      
      public function MicrophoneSignalSet(param1:Microphone)
      {
         super(param1);
      }
      
      public function get activity() : NativeSignal
      {
         return getNativeSignal(ActivityEvent.ACTIVITY,ActivityEvent);
      }
      
      public function get status() : NativeSignal
      {
         return getNativeSignal(StatusEvent.STATUS,StatusEvent);
      }
   }
}

