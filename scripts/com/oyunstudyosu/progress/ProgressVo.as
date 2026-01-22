package com.oyunstudyosu.progress
{
   public class ProgressVo
   {
      
      public static const CONNECTING:ProgressVo = new ProgressVo(0,"CONNECTING");
      
      public static const LANG_FILE_READY:ProgressVo = new ProgressVo(10,"LANG_FILE_READY");
      
      public static const CONNECTED:ProgressVo = new ProgressVo(20,"CONNECTED");
      
      public static const LOGINED:ProgressVo = new ProgressVo(30,"LOGINED");
      
      public static const CONFIG_READY:ProgressVo = new ProgressVo(40,"CONFIG_READY");
      
      public static const INFO_FILE_READY:ProgressVo = new ProgressVo(50,"INFO_FILE_READY");
      
      public static const GAME_EXTENSIONS_LOADED:ProgressVo = new ProgressVo(60,"GAME_EXTENSIONS_LOADED");
      
      public static const INIT_READY:ProgressVo = new ProgressVo(70,"INIT_READY");
      
      public static const GAME_READY:ProgressVo = new ProgressVo(80,"GAME_READY");
      
      public static const PROGRESS_FULL:ProgressVo = new ProgressVo(100,"PROGRESS_FULL");
      
      public static const LOADING:ProgressVo = new ProgressVo(0,"LOADING");
      
      public static const ROOM_FILES:ProgressVo = new ProgressVo(0,"ROOM_FILES");
      
      public static const LOAD_DESIGNER:ProgressVo = new ProgressVo(10,"LOAD_DESIGNER");
      
      public static const DESIGNER_LOADED:ProgressVo = new ProgressVo(100,"DESIGNER_LOADED");
      
      public static const JOINING_USER_ROOM:ProgressVo = new ProgressVo(0,"JOINING_USER_ROOM");
      
      public var percent:int;
      
      public var description:String;
      
      public var args:Array;
      
      public function ProgressVo(param1:int, param2:String, ... rest)
      {
         super();
         this.percent = param1;
         this.description = param2;
         this.args = rest;
      }
   }
}

