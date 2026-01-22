package org.osflash.signals.natives.base
{
   import flash.net.XMLSocket;
   import org.osflash.signals.natives.sets.XMLSocketSignalSet;
   
   public class SignalXMLSocket extends XMLSocket
   {
      
      private var _signals:XMLSocketSignalSet;
      
      public function SignalXMLSocket()
      {
         super();
      }
      
      public function get signals() : XMLSocketSignalSet
      {
         return this._signals = this._signals || new XMLSocketSignalSet(this);
      }
   }
}

