package org.osflash.signals.natives.base
{
   import flash.display.Shape;
   import org.osflash.signals.natives.sets.DisplayObjectSignalSet;
   
   public class SignalShape extends Shape
   {
      
      private var _signals:DisplayObjectSignalSet;
      
      public function SignalShape()
      {
         super();
      }
      
      public function get signals() : DisplayObjectSignalSet
      {
         return this._signals = this._signals || new DisplayObjectSignalSet(this);
      }
   }
}

