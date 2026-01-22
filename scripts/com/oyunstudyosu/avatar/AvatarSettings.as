package com.oyunstudyosu.avatar
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarSettings;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class AvatarSettings implements IAvatarSettings
   {
      
      private var _verifySession:Boolean = false;
      
      private var _showInvitations:Boolean = true;
      
      private var _visibility:Boolean = true;
      
      private var _wideScreenMode:Boolean;
      
      private var _hideRequests:Boolean = true;
      
      private var _muteSound:Boolean = false;
      
      private var _flatNotifications:Boolean;
      
      private var _onlyBuddyWhisper:Boolean;
      
      private var _incomingMessages:Boolean = true;
      
      private var _transferRequests:Boolean = true;
      
      private var _tradeRequests:Boolean = true;
      
      private var _whisperMessage:Boolean;
      
      private var _rainOn:Boolean = true;
      
      private var _performanceMode:Boolean = false;
      
      public function AvatarSettings()
      {
         super();
      }
      
      public function get verifySession() : Boolean
      {
         return _verifySession;
      }
      
      public function set verifySession(param1:Boolean) : void
      {
         if(_verifySession == param1)
         {
            return;
         }
         _verifySession = param1;
      }
      
      public function get showInvitations() : Boolean
      {
         return _showInvitations;
      }
      
      public function set showInvitations(param1:Boolean) : void
      {
         if(_showInvitations == param1)
         {
            return;
         }
         _showInvitations = param1;
      }
      
      public function get visibility() : Boolean
      {
         return _visibility;
      }
      
      public function set visibility(param1:Boolean) : void
      {
         if(_visibility == param1)
         {
            return;
         }
         _visibility = param1;
      }
      
      public function get wideScreenMode() : Boolean
      {
         return _wideScreenMode;
      }
      
      public function set wideScreenMode(param1:Boolean) : void
      {
         if(_wideScreenMode == param1)
         {
            return;
         }
         _wideScreenMode = param1;
         Sanalika.instance.layerModel.wideScreenMode = param1;
      }
      
      public function get hideRequests() : Boolean
      {
         return _hideRequests;
      }
      
      public function set hideRequests(param1:Boolean) : void
      {
         if(_hideRequests == param1)
         {
            return;
         }
         _hideRequests = param1;
      }
      
      public function get muteSound() : Boolean
      {
         return _muteSound;
      }
      
      public function set muteSound(param1:Boolean) : void
      {
         _muteSound = param1;
         if(param1)
         {
            Sanalika.instance.soundModel.muteAll();
         }
         else
         {
            Sanalika.instance.soundModel.muteAll(false);
         }
         isSoundMuted(param1);
      }
      
      private function isSoundMuted(param1:Boolean) : void
      {
         var _loc2_:SoundTransform = new SoundTransform();
         if(param1 == true)
         {
            _loc2_.volume = 0;
            SoundMixer.soundTransform = _loc2_;
         }
         else
         {
            _loc2_.volume = 1;
            SoundMixer.soundTransform = _loc2_;
         }
      }
      
      public function get flatNotifications() : Boolean
      {
         return _flatNotifications;
      }
      
      public function set flatNotifications(param1:Boolean) : void
      {
         if(_flatNotifications == param1)
         {
            return;
         }
         _flatNotifications = param1;
      }
      
      public function get onlyBuddyWhisper() : Boolean
      {
         return _onlyBuddyWhisper;
      }
      
      public function set onlyBuddyWhisper(param1:Boolean) : void
      {
         _onlyBuddyWhisper = param1;
      }
      
      public function get incomingMessages() : Boolean
      {
         return _incomingMessages;
      }
      
      public function set incomingMessages(param1:Boolean) : void
      {
         if(_incomingMessages == param1)
         {
            return;
         }
         _incomingMessages = param1;
         _whisperMessage = param1;
      }
      
      public function get transferRequests() : Boolean
      {
         return _transferRequests;
      }
      
      public function set transferRequests(param1:Boolean) : void
      {
         if(_transferRequests == param1)
         {
            return;
         }
         _transferRequests = param1;
      }
      
      public function get tradeRequests() : Boolean
      {
         return _tradeRequests;
      }
      
      public function set tradeRequests(param1:Boolean) : void
      {
         if(_tradeRequests == param1)
         {
            return;
         }
         _tradeRequests = param1;
      }
      
      public function get whisperMessage() : Boolean
      {
         return _whisperMessage;
      }
      
      public function set whisperMessage(param1:Boolean) : void
      {
         if(_whisperMessage == param1)
         {
            return;
         }
         _whisperMessage = param1;
      }
      
      public function get rainOn() : Boolean
      {
         return _rainOn;
      }
      
      public function set rainOn(param1:Boolean) : void
      {
         if(_rainOn == param1)
         {
            return;
         }
         _rainOn = param1;
         if(!param1)
         {
            Dispatcher.dispatchEvent(new GameEvent("STOP_RAIN"));
         }
      }
      
      public function get performanceMode() : Boolean
      {
         return _performanceMode;
      }
      
      public function set performanceMode(param1:Boolean) : void
      {
         if(_performanceMode == param1)
         {
            return;
         }
         _performanceMode = param1;
         if(param1)
         {
            Sanalika.instance.stage.quality = "low";
         }
         else
         {
            Sanalika.instance.stage.quality = "high";
         }
      }
      
      public function getData() : Array
      {
         var _loc2_:Object = {};
         var _loc3_:Array = [];
         _loc2_.showInvitations = int(_showInvitations);
         _loc2_.wideMode = int(_wideScreenMode);
         _loc2_.hideRequests = 1;
         _loc2_.muteSound = int(_muteSound);
         _loc2_.incomingMessages = int(_incomingMessages);
         _loc2_.whisperMessage = int(_whisperMessage);
         _loc2_.transferRequests = int(_transferRequests);
         _loc2_.tradeRequests = int(_tradeRequests);
         _loc2_.flatNotifications = int(_flatNotifications);
         _loc2_.onlyBuddyWhisper = int(_onlyBuddyWhisper);
         _loc2_.verifySession = int(_verifySession);
         for(var _loc1_ in _loc2_)
         {
            _loc3_.push({
               "key":_loc1_,
               "value":_loc2_[_loc1_]
            });
         }
         return _loc3_;
      }
   }
}

