package org.osflash.signals.natives.sets
{
   import flash.events.Event;
   import flash.net.FileReference;
   import org.osflash.signals.natives.NativeSignal;
   
   public class FileReferenceListSignalSet extends EventDispatcherSignalSet
   {
      
      public function FileReferenceListSignalSet(param1:FileReference)
      {
         super(param1);
      }
      
      public function get cancel() : NativeSignal
      {
         return getNativeSignal(Event.CANCEL);
      }
      
      public function get select() : NativeSignal
      {
         return getNativeSignal(Event.SELECT);
      }
   }
}

