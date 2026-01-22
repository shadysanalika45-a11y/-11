package org.osflash.signals.natives.base
{
   import flash.display.Bitmap;
   import org.osflash.signals.natives.sets.DisplayObjectSignalSet;
   
   public class SignalBitmap extends Bitmap
   {
      
      private var _signals:DisplayObjectSignalSet;
      
      public function SignalBitmap()
      {
         super();
      }
      
      public function get signals() : DisplayObjectSignalSet
      {
         return this._signals = this._signals || new DisplayObjectSignalSet(this);
      }
   }
}

