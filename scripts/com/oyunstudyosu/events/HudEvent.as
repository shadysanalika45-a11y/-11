package com.oyunstudyosu.events
{
   import flash.events.Event;
   import flash.text.TextField;
   
   public class HudEvent extends Event
   {
      
      public static const TEXT_FIELD_FOCUS_IN:String = "tf_focus_in";
      
      public static const TEXT_FIELD_FOCUS_OUT:String = "tf_focus_out";
      
      public static const SEND_MESSAGE:String = "sendMessage";
      
      public static const CHAT_COLOR_CHANGE_REQUEST:String = "chatColorChangeRequest";
      
      public static const CHAT_COLOR_CHANGED:String = "chatColorChanged";
      
      public static const OPEN_CHAT_HISTORY:String = "openChatHistory";
      
      public static const OPEN_BUDDY_PANEL:String = "openBuddyPanel";
      
      public static const OPEN_ACHIEVEMENT_PANEL:String = "openAchievementsPanel";
      
      public static const OPEN_ROOM_DESIGN:String = "openRoomDesign";
      
      public static const OPEN_DIAMOND_PURCHASE_PANEL:String = "openDiamondPurchasePanel";
      
      public static const OPEN_QUEST_LIST_PANEL:String = "openQuestListPanel";
      
      public static const OPEN_PRODUCT_PURCHASE_PANEL:String = "openProductPurchasePanel";
      
      public static const OPEN_SANIL_PURCHASE_PANEL:String = "openSanilPurchasePanel";
      
      public static const OPEN_PEPSI_PIN_PANEL:String = "openPepsiPinPanel";
      
      public static const OPEN_CLOTH_PANEL:String = "openClothPanel";
      
      public static const OPEN_QUEST_INVENTORY_PANEL:String = "openQuestInventoryPanel";
      
      public static const OPEN_SCREEN_SHOOT_PANEL:String = "openScreenShotPanel";
      
      public static const OPEN_CELL_PHONE:String = "openCellPhone";
      
      public static const DANCE_FRAME:String = "danceFrame";
      
      public static const ACTION_FRAME:String = "actionFrame";
      
      public static const IDLE_FRAME:String = "idleFrame";
      
      public static const OPEN_SMILEY_PANEL:String = "openSmileyPanel";
      
      public static const OPEN_INVENTORY_PANEL:String = "openInventoryPanel";
      
      public static const OPEN_SHARE_PANEL:String = "openSharePanel";
      
      public static const OPEN_INVITE_PANEL:String = "openInvitePanel";
      
      public static const OPEN_AVATARSWITCH_PANEL:String = "openAvatarSwitchPanel";
      
      public static const OPEN_MAP_PANEL:String = "openMapPanel";
      
      public static const OPEN_ISLANDS_PANEL:String = "openIslandsPanel";
      
      public static const OPEN_SETTINGS_PANEL:String = "openSettingsPanel";
      
      public static const SHARE_BUSINESS_ROOM:String = "HudEvent.SHARE_BUSINESS_ROOM";
      
      public static const OPEN_ROOM_LIST_PANEL:String = "HudEvent.OPEN_ROOM_LIST_PANEL";
      
      public static const OPEN_ROOM_INFO:String = "HudEvent.OPEN_ROOM_INFO";
      
      public static const SEND_BUSINESS_MESSAGE:String = "HudEvent.SEND_BUSINESS_MESSAGE";
      
      public static const OPEN_RESTRICTED_LIST_PANEL:String = "HudEvent.OPEN_RESTRICTED_LIST_PANEL";
      
      public static const SHOW_BALANCE_VIEW:String = "HudEvent.SHOW_BALANCE_VIEW";
      
      public static const HIDE_BALANCE_VIEW:String = "HudEvent.HIDE_BALANCE_VIEW";
      
      public static const OPEN_ORDER_PANEL:String = "HudEvent.OPEN_ORDER_PANEL";
      
      public static const SHOW_STEP_INDICATOR:String = "HudEvent.SHOW_STEP_INDICATOR";
      
      public static const HIDE_STEP_INDICATOR:String = "HudEvent.HIDE_STEP_INDICATOR";
      
      public static const SHOW_FUNBID:String = "HudEvent.SHOW_FUNBID";
      
      public static const HIDE_FUNBID:String = "HudEvent.HIDE_FUNBID";
      
      public static const SHOW_FUNWIN:String = "HudEvent.SHOW_FUNWIN";
      
      public static const HIDE_FUNWIN:String = "HudEvent.HIDE_FUNWIN";
      
      public static const SHOW_RADIO:String = "HudEvent.SHOW_RADIO";
      
      public static const HIDE_RADIO:String = "HudEvent.HIDE_RADIO";
      
      public static const SHOW_NEWYEAR:String = "HudEvent.SHOW_NEWYEAR";
      
      public static const HIDE_NEWYEAR:String = "HudEvent.HIDE_NEWYEAR";
      
      public static const ZOOM_IN:String = "HudEvent.ZOOM_IN";
      
      public static const ZOOM_OUT:String = "HudEvent.ZOOM_OUT";
      
      public static const SHOW_SNOWBALL:String = "HudEvent.SHOW_SNOWBALL";
      
      public static const HIDE_SNOWBALL:String = "HudEvent.HIDE_SNOWBALL";
      
      public static const SHOW_JOYSTICK:String = "HudEvent.SHOW_JOYSTICK";
      
      public static const HIDE_JOYSTICK:String = "HudEvent.HIDE_JOYSTICK";
      
      public static const SHOW_MATCHMAKING:String = "HudEvent.SHOW_MATCHMAKING";
      
      public static const HIDE_MATCHMAKING:String = "HudEvent.HIDE_MATCHMAKING";
      
      public static const THROW:String = "HudEvent.THROW";
      
      public var tf:TextField;
      
      public var chatMessage:String;
      
      public var colorId:int;
      
      public var xTarget:int;
      
      public var yTarget:int;
      
      public var clipTarget:String;
      
      public function HudEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new HudEvent(type,bubbles,cancelable);
      }
   }
}

