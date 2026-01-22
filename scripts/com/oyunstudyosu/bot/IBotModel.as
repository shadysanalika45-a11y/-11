package com.oyunstudyosu.bot
{
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   
   public interface IBotModel
   {
      
      function getBotByKey(param1:String) : IBotVO;
      
      function getBotClip(param1:ApplicationDomain, param2:String) : MovieClip;
      
      function load(param1:Array) : void;
      
      function loadJSON(param1:String) : void;
      
      function runBotByKey(param1:String) : void;
      
      function get count() : int;
      
      function get keyList() : Array;
      
      function dispose() : void;
   }
}

