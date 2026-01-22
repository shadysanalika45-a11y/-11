package com.oyunstudyosu.sanalika.interfaces
{
   import flash.utils.Dictionary;
   
   public interface IBotEntry extends ISpeechable
   {
      
      function get questIcons() : Dictionary;
      
      function get questCount() : int;
      
      function set questCount(param1:int) : void;
   }
}

