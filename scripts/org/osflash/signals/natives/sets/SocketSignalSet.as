package org.osflash.signals.natives.sets
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import org.osflash.signals.natives.NativeSignal;
   
   public class SocketSignalSet extends EventDispatcherSignalSet
   {
      
      public function SocketSignalSet(param1:Socket)
      {
         super(param1);
      }
      
      public function get close() : NativeSignal
      {
         return getNativeSignal(Event.CLOSE);
      }
      
      public function get connect() : NativeSignal
      {
         return getNativeSignal(Event.CONNECT);
      }
      
      public function get ioError() : NativeSignal
      {
         return getNativeSignal(IOErrorEvent.IO_ERROR,IOErrorEvent);
      }
      
      public function get securityError() : NativeSignal
      {
         return getNativeSignal(SecurityErrorEvent.SECURITY_ERROR,SecurityErrorEvent);
      }
      
      public function get socketData() : NativeSignal
      {
         return getNativeSignal(ProgressEvent.SOCKET_DATA,ProgressEvent);
      }
   }
}

