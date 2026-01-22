package org.osflash.signals.natives.base
{
   import flash.net.URLLoader;
   import org.osflash.signals.natives.sets.URLLoaderSignalSet;
   
   public class SignalURLLoader extends URLLoader
   {
      
      private var _signals:URLLoaderSignalSet;
      
      public function SignalURLLoader()
      {
         super();
      }
      
      public function get signals() : URLLoaderSignalSet
      {
         return this._signals = this._signals || new URLLoaderSignalSet(this);
      }
   }
}

