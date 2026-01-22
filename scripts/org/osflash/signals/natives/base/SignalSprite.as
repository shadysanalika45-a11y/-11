package org.osflash.signals.natives.base
{
   import flash.display.Sprite;
   import org.osflash.signals.natives.sets.InteractiveObjectSignalSet;
   
   public class SignalSprite extends Sprite
   {
      
      private var _signals:InteractiveObjectSignalSet;
      
      public function SignalSprite()
      {
         super();
      }
      
      public function get signals() : InteractiveObjectSignalSet
      {
         return this._signals = this._signals || new InteractiveObjectSignalSet(this);
      }
   }
}

