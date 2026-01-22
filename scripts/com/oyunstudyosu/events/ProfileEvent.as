package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class ProfileEvent extends Event
   {
      
      public static const ADD_TO_FRIEND:String = "AvatarProfileEvent.ADD_TO_FRIEND";
      
      public static const REMOVE_FROM_FRIEND:String = "AvatarProfileEvent.REMOVE_FROM_FRIEND";
      
      public static const WHISPER:String = "AvatarProfileEvent.WHISPER";
      
      public static const TRADE:String = "AvatarProfileEvent.TRADE";
      
      public static const BLOCK:String = "AvatarProfileEvent.BLOCK";
      
      public static const UNBLOCK:String = "AvatarProfileEvent.UNBLOCK";
      
      public static const SHOW_PROFILE:String = "AvatarProfileEvent.SHOW_PROFILE";
      
      public static const SHOW_ROOMS:String = "AvatarProfileEvent.SHOW_ROOMS";
      
      public static const LIKE:String = "AvatarProfileEvent.LIKED";
      
      public static const DISLIKE:String = "AvatarProfileEvent.DISLIKED";
      
      public static const LIKEREMOVED:String = "AvatarProfileEvent.LIKEREMOVED";
      
      public var avatarID:String;
      
      public var status:int;
      
      public var whisperMode:Boolean;
      
      public function ProfileEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ProfileEvent(type,bubbles,cancelable);
      }
   }
}

