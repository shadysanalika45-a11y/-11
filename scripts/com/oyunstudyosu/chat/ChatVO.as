package com.oyunstudyosu.chat
{
   import com.oyunstudyosu.engine.ICharacter;
   
   public class ChatVO
   {
      
      public var sender:ICharacter;
      
      public var message:String;
      
      public var frameNo:int;
      
      public var isPublic:Boolean;
      
      public function ChatVO()
      {
         super();
      }
   }
}

