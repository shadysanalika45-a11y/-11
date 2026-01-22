package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.engine.ICharacter;
   
   public interface ISpeechBubble
   {
      
      function speech(param1:String = "", param2:String = "") : void;
      
      function get sender() : ICharacter;
      
      function set sender(param1:ICharacter) : void;
   }
}

