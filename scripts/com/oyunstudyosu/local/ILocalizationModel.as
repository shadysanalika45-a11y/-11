package com.oyunstudyosu.local
{
   public interface ILocalizationModel
   {
      
      function init(param1:Object) : void;
      
      function translate(param1:String) : String;
      
      function translate2(param1:String = "") : String;
   }
}

