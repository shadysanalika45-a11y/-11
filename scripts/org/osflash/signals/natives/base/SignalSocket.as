package org.osflash.signals.natives.base
{
   import flash.net.Socket;
   import org.osflash.signals.natives.sets.SocketSignalSet;
   
   public class SignalSocket extends Socket
   {
      
      private var _signals:SocketSignalSet;
      
      public function SignalSocket()
      {
         super();
      }
      
      public function get signals() : SocketSignalSet
      {
         return this._signals = this._signals || new SocketSignalSet(this);
      }
   }
}

