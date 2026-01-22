package com.oyunstudyosu.chat
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.events.GameEvent;
   
   public interface IChatModel
   {
      
      function onTerminate(param1:GameEvent) : void;
      
      function get list() : Vector.<ChatVO>;
      
      function add(param1:ICharacter, param2:String, param3:int = 0, param4:Boolean = true) : void;
      
      function get whisperId() : String;
      
      function set whisperId(param1:String) : void;
      
      function get whisperMode() : Boolean;
      
      function set whisperMode(param1:Boolean) : void;
   }
}

