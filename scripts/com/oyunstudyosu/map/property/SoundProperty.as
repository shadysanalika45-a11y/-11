package com.oyunstudyosu.map.property
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class SoundProperty extends MapProperty
   {
      
      private var sound:Sound;
      
      private var channel:SoundChannel;
      
      private var timeoutId:int = -1;
      
      private var url:String;
      
      private var delay:int;
      
      private var repeatCount:int;
      
      private var playCount:int = 0;
      
      public function SoundProperty()
      {
         super();
      }
      
      override public function execute() : void
      {
         url = data.url;
         delay = parseInt(data.timeout == null ? "0" : data.timeout);
         repeatCount = parseInt(data.repeat == null ? "0" : data.repeat);
         sound = new Sound();
         sound.load(new URLRequest(url));
         playNext();
      }
      
      private function playNext() : void
      {
         channel = sound.play();
         if(channel != null)
         {
            channel.addEventListener("soundComplete",onComplete);
         }
         playCount = playCount + 1;
      }
      
      private function onComplete(param1:Event) : void
      {
         cleanupChannel();
         if(playCount > repeatCount)
         {
            return;
         }
         if(delay > 0)
         {
            timeoutId = setTimeout(playNext,delay * 1000);
         }
         else
         {
            playNext();
         }
      }
      
      private function cleanupChannel() : void
      {
         if(channel == null)
         {
            return;
         }
         channel.removeEventListener("soundComplete",onComplete);
         channel.stop();
         channel = null;
      }
      
      override public function dispose() : void
      {
         if(timeoutId != -1)
         {
            clearTimeout(timeoutId);
            timeoutId = -1;
         }
         cleanupChannel();
         if(sound != null)
         {
            try
            {
               sound.close();
            }
            catch(_:*)
            {
            }
            sound = null;
         }
         super.dispose();
      }
   }
}

