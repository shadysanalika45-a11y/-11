package org.osflash.signals.natives.sets
{
   import flash.events.AsyncErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SyncEvent;
   import flash.net.SharedObject;
   import org.osflash.signals.natives.NativeSignal;
   
   public class SharedObjectSignalSet extends EventDispatcherSignalSet
   {
      
      public function SharedObjectSignalSet(param1:SharedObject)
      {
         super(param1);
      }
      
      public function get asyncError() : NativeSignal
      {
         return getNativeSignal(AsyncErrorEvent.ASYNC_ERROR,AsyncErrorEvent);
      }
      
      public function get netStatus() : NativeSignal
      {
         return getNativeSignal(NetStatusEvent.NET_STATUS,NetStatusEvent);
      }
      
      public function get sync() : NativeSignal
      {
         return getNativeSignal(SyncEvent.SYNC,SyncEvent);
      }
   }
}

