package org.osflash.signals.natives.base
{
   import flash.text.TextField;
   import org.osflash.signals.natives.sets.TextFieldSignalSet;
   
   public class SignalTextField extends TextField
   {
      
      private var _signals:TextFieldSignalSet;
      
      public function SignalTextField()
      {
         super();
      }
      
      public function get signals() : TextFieldSignalSet
      {
         return this._signals = this._signals || new TextFieldSignalSet(this);
      }
   }
}

