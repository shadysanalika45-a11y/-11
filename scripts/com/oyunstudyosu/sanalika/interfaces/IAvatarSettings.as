package com.oyunstudyosu.sanalika.interfaces
{
   public interface IAvatarSettings
   {
      
      function get verifySession() : Boolean;
      
      function set verifySession(param1:Boolean) : void;
      
      function get showInvitations() : Boolean;
      
      function set showInvitations(param1:Boolean) : void;
      
      function get wideScreenMode() : Boolean;
      
      function set wideScreenMode(param1:Boolean) : void;
      
      function get visibility() : Boolean;
      
      function set visibility(param1:Boolean) : void;
      
      function get hideRequests() : Boolean;
      
      function set hideRequests(param1:Boolean) : void;
      
      function get muteSound() : Boolean;
      
      function set muteSound(param1:Boolean) : void;
      
      function get incomingMessages() : Boolean;
      
      function set incomingMessages(param1:Boolean) : void;
      
      function get transferRequests() : Boolean;
      
      function set transferRequests(param1:Boolean) : void;
      
      function get tradeRequests() : Boolean;
      
      function set tradeRequests(param1:Boolean) : void;
      
      function get whisperMessage() : Boolean;
      
      function set whisperMessage(param1:Boolean) : void;
      
      function set flatNotifications(param1:Boolean) : void;
      
      function get flatNotifications() : Boolean;
      
      function set onlyBuddyWhisper(param1:Boolean) : void;
      
      function get onlyBuddyWhisper() : Boolean;
      
      function set rainOn(param1:Boolean) : void;
      
      function get rainOn() : Boolean;
      
      function getData() : Array;
   }
}

