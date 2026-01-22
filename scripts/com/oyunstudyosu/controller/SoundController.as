package com.oyunstudyosu.controller
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.SoundEvent;
   
   public class SoundController
   {
      
      public function SoundController()
      {
         super();
         Dispatcher.addEventListener("SoundEvent.PLAY_SOUND",playSound);
      }
      
      private function playSound(param1:SoundEvent) : void
      {
         Sanalika.instance.soundModel.playSound(param1.soundKey,1,1);
      }
   }
}

