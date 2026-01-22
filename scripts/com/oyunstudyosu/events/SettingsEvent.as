package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class SettingsEvent extends Event
   {
      
      public static const ZOOM_IN:String = "SettingsEvent.ZOOM_IN";
      
      public static const ZOOM_OUT:String = "SettingsEvent.ZOOM_OUT";
      
      public static const FULLSCREEN:String = "SettingsEvent.FULLSCREEN";
      
      public static const SOUND_ON:String = "SettingsEvent.SOUND_ON";
      
      public static const SOUND_OFF:String = "SettingsEvent.SOUND_OFF";
      
      public function SettingsEvent(param1:String)
      {
         super(param1);
      }
   }
}

