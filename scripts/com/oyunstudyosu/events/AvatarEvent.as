package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class AvatarEvent extends Event
   {
      
      public var avatarID:String;
      
      public function AvatarEvent(param1:String)
      {
         super(param1);
      }
   }
}

