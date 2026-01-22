package org.osflash.signals.natives.base
{
   import flash.display.MovieClip;
   import org.osflash.signals.natives.sets.InteractiveObjectSignalSet;
   
   public class SignalMovieClip extends MovieClip
   {
      
      private var _signals:InteractiveObjectSignalSet;
      
      public function SignalMovieClip()
      {
         super();
      }
      
      public function get signals() : InteractiveObjectSignalSet
      {
         return this._signals = this._signals || new InteractiveObjectSignalSet(this);
      }
   }
}

