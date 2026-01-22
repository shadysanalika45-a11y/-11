package com.oyunstudyosu.sanalika.interfaces
{
   public interface IHistorySpeechBubble
   {
      
      function speech(param1:String, param2:String, param3:String = "") : void;
      
      function get avatarName() : String;
      
      function get avatarId() : String;
      
      function get message() : String;
   }
}

