package com.oyunstudyosu.sound
{
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundLoaderContext;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class SoundModel implements ISoundModel
   {
      
      public var sounds:Dictionary;
      
      public var currPlayingSounds:Dictionary;
      
      private var isMuted:Boolean;
      
      public function SoundModel()
      {
         super();
         this.sounds = new Dictionary();
         this.currPlayingSounds = new Dictionary();
      }
      
      public function addSound(param1:String, param2:String = "", param3:Class = null) : void
      {
         if(param2 != "")
         {
            if(param2.indexOf("http://fs.sanalika.com/") == 0 || param2.indexOf("https://fs.sanalika.com/") == 0)
            {
               this.sounds[param1] = param2;
            }
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
      
      public function playSound(param1:String, param2:Number = 1, param3:int = 1) : void
      {
         var _loc4_:SoundTransform = null;
         var _loc5_:String = null;
         var _loc6_:Sound = null;
         var _loc8_:SoundChannel = null;
         var _loc9_:Sound = null;
         if(this.isMuted)
         {
            param2 = 0;
         }
         for(_loc5_ in this.currPlayingSounds)
         {
            if(_loc5_ == param1)
            {
               _loc8_ = this.currPlayingSounds[param1].channel as SoundChannel;
               _loc9_ = this.currPlayingSounds[param1].sound as Sound;
               _loc4_ = new SoundTransform(param2);
               _loc8_ = _loc9_.play(0,param3);
               if(_loc8_ != null)
               {
                  _loc8_.soundTransform = _loc4_;
                  this.currPlayingSounds[param1] = {
                     "channel":_loc8_,
                     "sound":_loc9_,
                     "volume":param2
                  };
               }
               return;
            }
         }
         if(this.sounds[param1] == null)
         {
            trace("No sound with id " + param1);
            return;
         }
         if(this.sounds[param1] is Class)
         {
            _loc6_ = new this.sounds[param1]() as Sound;
         }
         else
         {
            _loc6_ = new Sound();
            _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.handleLoadError);
            _loc6_.load(new URLRequest(this.sounds[param1]),new SoundLoaderContext(1000,true));
         }
         var _loc7_:SoundChannel = new SoundChannel();
         _loc7_ = _loc6_.play(0,param3);
         if(_loc7_ != null)
         {
            _loc4_ = new SoundTransform(param2);
            _loc7_.soundTransform = _loc4_;
            this.currPlayingSounds[param1] = {
               "channel":_loc7_,
               "sound":_loc6_,
               "volume":param2
            };
         }
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
         trace("setGlobalVolume : ",param1);
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
            this.isMuted = true;
            this.setGlobalVolume(0);
         }
         else
         {
            this.isMuted = false;
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

