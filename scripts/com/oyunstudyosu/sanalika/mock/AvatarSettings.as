package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.sanalika.interfaces.IAvatarSettings;
   
   public class AvatarSettings implements IAvatarSettings
   {
      
      private var _verifySession:Boolean = true;
      
      private var _showInvitations:Boolean = true;
      
      private var _wideScreenMode:Boolean;
      
      private var _visibility:Boolean = true;
      
      private var _hideRequests:Boolean = true;
      
      private var _muteSound:Boolean = false;
      
      private var _incomingMessages:Boolean = true;
      
      private var _transferRequests:Boolean = true;
      
      private var _tradeRequests:Boolean = true;
      
      private var _whisperMessage:Boolean = true;
      
      private var _onlyBuddyWhisper:Boolean;
      
      private var _rainOn:Boolean = true;
      
      public function AvatarSettings()
      {
         super();
      }
      
      public function get verifySession() : Boolean
      {
         return this._verifySession;
      }
      
      public function set verifySession(param1:Boolean) : void
      {
         if(this._verifySession == param1)
         {
            return;
         }
         this._verifySession = param1;
      }
      
      public function get showInvitations() : Boolean
      {
         return this._showInvitations;
      }
      
      public function set showInvitations(param1:Boolean) : void
      {
         if(this._showInvitations == param1)
         {
            return;
         }
         this._showInvitations = param1;
      }
      
      public function get wideScreenMode() : Boolean
      {
         return this._wideScreenMode;
      }
      
      public function set wideScreenMode(param1:Boolean) : void
      {
         if(this._wideScreenMode == param1)
         {
            return;
         }
         this._wideScreenMode = param1;
      }
      
      public function get visibility() : Boolean
      {
         return this._visibility;
      }
      
      public function set visibility(param1:Boolean) : void
      {
         if(this._visibility == param1)
         {
            return;
         }
         this._visibility = param1;
      }
      
      public function get hideRequests() : Boolean
      {
         return this._hideRequests;
      }
      
      public function set hideRequests(param1:Boolean) : void
      {
         if(this._hideRequests == param1)
         {
            return;
         }
         this._hideRequests = param1;
      }
      
      public function get muteSound() : Boolean
      {
         return this._muteSound;
      }
      
      public function set muteSound(param1:Boolean) : void
      {
         if(this._muteSound == param1)
         {
            return;
         }
         this._muteSound = param1;
      }
      
      public function get incomingMessages() : Boolean
      {
         return this._incomingMessages;
      }
      
      public function set incomingMessages(param1:Boolean) : void
      {
         if(this._incomingMessages == param1)
         {
            return;
         }
         this._incomingMessages = param1;
      }
      
      public function get transferRequests() : Boolean
      {
         return this._transferRequests;
      }
      
      public function set transferRequests(param1:Boolean) : void
      {
         if(this._transferRequests == param1)
         {
            return;
         }
         this._transferRequests = param1;
      }
      
      public function get tradeRequests() : Boolean
      {
         return this._tradeRequests;
      }
      
      public function set tradeRequests(param1:Boolean) : void
      {
         if(this._tradeRequests == param1)
         {
            return;
         }
         this._tradeRequests = param1;
      }
      
      public function get whisperMessage() : Boolean
      {
         return this._whisperMessage;
      }
      
      public function set whisperMessage(param1:Boolean) : void
      {
         if(this._whisperMessage == param1)
         {
            return;
         }
         this._whisperMessage = param1;
      }
      
      public function getData() : Array
      {
         return null;
      }
      
      public function set flatNotifications(param1:Boolean) : void
      {
      }
      
      public function get flatNotifications() : Boolean
      {
         return false;
      }
      
      public function get onlyBuddyWhisper() : Boolean
      {
         return this._onlyBuddyWhisper;
      }
      
      public function set onlyBuddyWhisper(param1:Boolean) : void
      {
         this._onlyBuddyWhisper = param1;
      }
      
      public function get rainOn() : Boolean
      {
         return this._rainOn;
      }
      
      public function set rainOn(param1:Boolean) : void
      {
         if(this._rainOn == param1)
         {
            return;
         }
         this._rainOn = param1;
      }
   }
}

