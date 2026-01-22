package org.osflash.signals.natives.sets
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import org.osflash.signals.natives.NativeSignal;
   
   public class EventDispatcherSignalSet extends NativeSignalSet
   {
      
      public function EventDispatcherSignalSet(param1:EventDispatcher)
      {
         super(param1);
      }
      
      public function get activate() : NativeSignal
      {
         return getNativeSignal(Event.ACTIVATE);
      }
      
      public function get deactivate() : NativeSignal
      {
         return getNativeSignal(Event.DEACTIVATE);
      }
   }
}

