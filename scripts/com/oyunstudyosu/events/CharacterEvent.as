package com.oyunstudyosu.events
{
   import com.oyunstudyosu.engine.ICharacter;
   import flash.events.Event;
   
   public class CharacterEvent extends Event
   {
      
      public static const CHAR_SIT:String = "CharacterEvent.CHAR_SIT";
      
      public static const CHAR_STOPPED:String = "CharacterEvent.CHAR_STOPPED";
      
      public static const CHAR_CURRENT_POSITION_UPDATED:String = "CharacterEvent.CHAR_CURRENT_POSITION_UPDATED";
      
      public var char:ICharacter;
      
      public function CharacterEvent(param1:String, param2:ICharacter)
      {
         this.char = param2;
         super(param1,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new CharacterEvent(type,this.char);
      }
      
      override public function toString() : String
      {
         return formatToString("CharacterActionEvent","type","bubbles","cancelable");
      }
   }
}

