package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.chat.ChatColorTemplate;
   
   public interface IChatBalloonModel
   {
      
      function add(param1:ChatColorTemplate, param2:Class) : void;
      
      function getTemplateByID(param1:int) : ChatColorTemplate;
      
      function getBubbleByID(param1:int) : ISpeechBubble;
      
      function get activeBalloons() : Array;
      
      function set activeBalloons(param1:Array) : void;
   }
}

