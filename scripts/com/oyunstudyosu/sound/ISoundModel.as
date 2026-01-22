package com.oyunstudyosu.sound
{
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public interface ISoundModel
   {
      
      function addSound(param1:String, param2:String = "", param3:Class = null) : void;
      
      function removeSound(param1:String) : void;
      
      function hasSound(param1:String) : Boolean;
      
      function playSound(param1:String, param2:Number = 1, param3:int = 999) : void;
      
      function stopSound(param1:String) : void;
      
      function setGlobalVolume(param1:Number) : void;
      
      function muteAll(param1:Boolean = true) : void;
      
      function setVolume(param1:String, param2:Number) : void;
      
      function getSoundChannel(param1:String) : SoundChannel;
      
      function getSoundTransform(param1:String) : SoundTransform;
      
      function getSoundVolume(param1:String) : Number;
   }
}

