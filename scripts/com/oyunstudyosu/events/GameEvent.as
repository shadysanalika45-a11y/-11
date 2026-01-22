package com.oyunstudyosu.events
{
   import flash.events.Event;
   
   public class GameEvent extends Event
   {
      
      public static const INITIALIZE:String = "INITIALIZE";
      
      public static const INSTANCE_DETECTED:String = "INSTANCE_DETECTED";
      
      public static const NO_INSTANCE_DETECTED:String = "NO_INSTANCE_DETECTED";
      
      public static const NO_CONTAINER_DETECTED:String = "NO_CONTAINER_DETECTED";
      
      public static const INVALID_DOMAIN_DETECTED:String = "INVALID_DOMAIN_DETECTED";
      
      public static const EXTENSIONS_LOADED:String = "EXTENSIONS_LOADED";
      
      public static const ITEM_INFO_FILE_LOADED:String = "ITEM_INFO_FILE_LOADED";
      
      public static const VERSION_FILE_LOADED:String = "VERSION_FILE_LOADED";
      
      public static const LOGOUT_COMPLETE:String = "LOGOUT_COMPLETE";
      
      public static const INITCOMMAND:String = "INITCOMMAND";
      
      public static const SCENE_READY:String = "SCENE_READY";
      
      public static const SCENE_LOADED:String = "SCENE_LOADED";
      
      public static const SCENE_DATA_LOADED:String = "SCENE_DATA_LOADED";
      
      public static const TERMINATE_PROVISION:String = "TERMINATE_PROVISION";
      
      public static const TERMINATE_SCENE:String = "TERMINATE_SCENE";
      
      public static const TERMINATE_GAME:String = "TERMINATE_GAME";
      
      public static const STOP_RAIN:String = "STOP_RAIN";
      
      public static const RESIZE:String = "RESIZE";
      
      public static const RELOAD:String = "RELOAD";
      
      public static const USER_LEAVE_ROOM:String = "USER_LEAVE_ROOM";
      
      public static const USER_ENTER_ROOM:String = "USER_ENTER_ROOM";
      
      public static const USER_POSITION_UPDATED:String = "USER_POSITION_UPDATED";
      
      public static const USER_DOOR:String = "USER_DOOR";
      
      public static const TRANSITION_IN:String = "TRANSITION_IN";
      
      public static const TRANSITION_IN_COMPLETE:String = "TRANSITION_IN_COMPLETE";
      
      public static const TRANSITION_OUT:String = "TRANSITION_OUT";
      
      public static const TRANSITION_OUT_COMPLETE:String = "TRANSITION_OUT_COMPLETE";
      
      public static const TRANSFER_ITEM:String = "TRANSFER_ITEM";
      
      public static const ACTIVE_GRID_CHANGED:String = "ACTIVE_GRID_CHANGED";
      
      public static const SAVE_AVATAR_IMAGE:String = "SAVE_AVATAR_IMAGE";
      
      public static const SAVE_ROOM_IMAGE:String = "SAVE_ROOM_IMAGE";
      
      public static const SAVE_TEMP_IMAGE:String = "SAVE_TEMP_IMAGE";
      
      public static const SS_IMAGE:String = "SS_IMAGE";
      
      public static const STAGE_IMAGE:String = "STAGE_IMAGE";
      
      public static const ROOM_IMAGE_SAVED:String = "ROOM_IMAGE_SAVED";
      
      public static const ROOM_MAP_INITIALIZED:String = "ROOM_MAP_INITIALIZED";
      
      public static const PREVIOUS_ROOM:String = "PREVIOUS_ROOM";
      
      public var id:String;
      
      public var lang:String;
      
      public var data:Object;
      
      public function GameEvent(param1:String)
      {
         super(param1,true,false);
      }
      
      override public function clone() : Event
      {
         var _loc1_:GameEvent = new GameEvent(this.type);
         _loc1_.id = this.id;
         _loc1_.data = this.data;
         return _loc1_;
      }
   }
}

