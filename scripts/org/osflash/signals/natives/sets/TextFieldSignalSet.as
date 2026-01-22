package org.osflash.signals.natives.sets
{
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import org.osflash.signals.natives.NativeSignal;
   
   public class TextFieldSignalSet extends InteractiveObjectSignalSet
   {
      
      public function TextFieldSignalSet(param1:TextField)
      {
         super(param1);
      }
      
      public function get change() : NativeSignal
      {
         return getNativeSignal(Event.CHANGE);
      }
      
      public function get link() : NativeSignal
      {
         return getNativeSignal(TextEvent.LINK,TextEvent);
      }
   }
}

