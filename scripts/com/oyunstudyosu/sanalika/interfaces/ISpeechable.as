package com.oyunstudyosu.sanalika.interfaces
{
   import flash.display.Sprite;
   
   public interface ISpeechable
   {
      
      function talk(param1:String, param2:int = 1, param3:Number = 1, param4:Boolean = true) : void;
      
      function getClip() : Sprite;
   }
}

