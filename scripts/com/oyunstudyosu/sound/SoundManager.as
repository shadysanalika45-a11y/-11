package com.oyunstudyosu.sound
{
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class SoundManager
   {
      
      private static var _instance:SoundManager;
      
      public var sounds:Dictionary;
      
      public var currPlayingSounds:Dictionary;
      
      public function SoundManager(param1:PrivateClass)
      {
         super();
         this.sounds = new Dictionary();
         this.currPlayingSounds = new Dictionary();
      }
      
      public static function getInstance() : SoundManager
      {
         if(!_instance)
         {
            _instance = new SoundManager(new PrivateClass());
         }
         return _instance;
      }
      
      public function addSound(param1:String, param2:String = "", param3:Class = null) : void
      {
         trace("addSound");
         if(param2 != "")
         {
            this.sounds[param1] = param2;
         }
         else
         {
            this.sounds[param1] = param3;
         }
      }
      
      public function removeSound(param1:String) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            if(_loc2_ == param1)
            {
               delete this.currPlayingSounds[param1];
               break;
            }
         }
         for(_loc2_ in this.sounds)
         {
            if(_loc2_ == param1)
            {
               delete this.sounds[param1];
               break;
            }
         }
      }
      
      public function hasSound(param1:String) : Boolean
      {
         return Boolean(this.sounds[param1]);
      }
      
      public function playSound(param1:String, param2:Number = 1, param3:int = 999) : void
      {
         var _loc4_:SoundTransform = null;
         var _loc5_:String = null;
         var _loc6_:Sound = null;
         var _loc8_:SoundChannel = null;
         var _loc9_:Sound = null;
         trace("playSound");
         for(_loc5_ in this.currPlayingSounds)
         {
            if(_loc5_ == param1)
            {
               _loc8_ = this.currPlayingSounds[param1].channel as SoundChannel;
               _loc9_ = this.currPlayingSounds[param1].sound as Sound;
               return;
            }
         }
         if(this.sounds[param1] is Class)
         {
            _loc6_ = new this.sounds[param1]() as Sound;
         }
         else
         {
            _loc6_ = new Sound();
            _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadError);
         }
         var _loc7_:SoundChannel = new SoundChannel();
         _loc4_ = new SoundTransform(param2);
         _loc7_.soundTransform = _loc4_;
         this.currPlayingSounds[param1] = {
            "channel":_loc7_,
            "sound":_loc6_,
            "volume":param2
         };
      }
      
      public function stopSound(param1:String) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            if(_loc2_ == param1)
            {
               SoundChannel(this.currPlayingSounds[param1].channel).stop();
            }
         }
      }
      
      public function setGlobalVolume(param1:Number) : void
      {
         var _loc2_:String = null;
         var _loc3_:SoundTransform = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            _loc3_ = new SoundTransform(param1);
            SoundChannel(this.currPlayingSounds[_loc2_].channel).soundTransform = _loc3_;
            this.currPlayingSounds[_loc2_].volume = param1;
         }
      }
      
      public function muteAll(param1:Boolean = true) : void
      {
         var _loc2_:String = null;
         var _loc3_:SoundTransform = null;
         if(param1)
         {
            this.setGlobalVolume(0);
         }
         else
         {
            for(_loc2_ in this.currPlayingSounds)
            {
               _loc3_ = new SoundTransform(this.currPlayingSounds[_loc2_].volume);
               SoundChannel(this.currPlayingSounds[_loc2_].channel).soundTransform = _loc3_;
            }
         }
      }
      
      public function setVolume(param1:String, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:SoundTransform = null;
         for(_loc3_ in this.currPlayingSounds)
         {
            if(_loc3_ == param1)
            {
               _loc4_ = new SoundTransform(param2);
               SoundChannel(this.currPlayingSounds[param1].channel).soundTransform = _loc4_;
               this.currPlayingSounds[param1].volume = param2;
            }
         }
      }
      
      public function getSoundChannel(param1:String) : SoundChannel
      {
         var _loc2_:String = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            if(_loc2_ == param1)
            {
               return SoundChannel(this.currPlayingSounds[param1].channel);
            }
         }
         throw Error("You are trying to get a non-existent soundChannel. Play it first in order to assign a channel");
      }
      
      public function getSoundTransform(param1:String) : SoundTransform
      {
         var _loc2_:String = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            if(_loc2_ == param1)
            {
               return SoundChannel(this.currPlayingSounds[param1].channel).soundTransform;
            }
         }
         throw Error("You are trying to get a non-existent soundTransform. Play it first in order to assign a transform");
      }
      
      public function getSoundVolume(param1:String) : Number
      {
         var _loc2_:String = null;
         for(_loc2_ in this.currPlayingSounds)
         {
            if(_loc2_ == param1)
            {
               return this.currPlayingSounds[param1].volume;
            }
         }
         throw Error("You are trying to get a non-existent volume. Play it first in order to assign a volume.");
      }
      
      private function handleLoadError(param1:IOErrorEvent) : void
      {
         trace("Sound manager failed to load a sound: " + param1.text);
      }
   }
}

class PrivateClass
{
   
   public function PrivateClass()
   {
      super();
   }
}
