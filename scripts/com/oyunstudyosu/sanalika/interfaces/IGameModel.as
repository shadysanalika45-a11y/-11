package com.oyunstudyosu.sanalika.interfaces
{
   public interface IGameModel
   {
      
      function get itemInfoFile() : String;
      
      function set itemInfoFile(param1:String) : void;
      
      function get diamondRatio() : Number;
      
      function get ropeServer() : String;
      
      function get serverName() : String;
      
      function get locale() : String;
      
      function get language() : String;
      
      function get worldPrefix() : String;
      
      function get serverDate() : Date;
      
      function set serverDate(param1:Date) : void;
      
      function get webServer() : String;
      
      function set webServer(param1:String) : void;
      
      function get weather() : String;
      
      function set weather(param1:String) : void;
      
      function get fileServer() : String;
      
      function get canvasWidth() : int;
      
      function set canvasWidth(param1:int) : void;
      
      function get canvasHeight() : int;
      
      function set canvasHeight(param1:int) : void;
      
      function get minimumCanvasWidth() : int;
      
      function get minimumCanvasHeight() : int;
      
      function get quality() : String;
      
      function set quality(param1:String) : void;
      
      function get agentData() : String;
      
      function set agentData(param1:String) : void;
      
      function get languageFileVersion() : String;
      
      function set languageFileVersion(param1:String) : void;
      
      function get exchangeratio() : uint;
      
      function set exchangeratio(param1:uint) : void;
      
      function get farmCleaningCost() : uint;
      
      function set farmCleaningCost(param1:uint) : void;
      
      function get farmMaxPlantedItemSize() : uint;
      
      function set farmMaxPlantedItemSize(param1:uint) : void;
      
      function get avatarOrderLifeTime() : uint;
      
      function set avatarOrderLifeTime(param1:uint) : void;
      
      function get orderLifeTime() : uint;
      
      function set orderLifeTime(param1:uint) : void;
      
      function get prepareLifeTime() : uint;
      
      function set prepareLifeTime(param1:uint) : void;
      
      function get roomTheme() : Array;
      
      function get isSecurityKeyViewOpened() : Boolean;
      
      function set isSecurityKeyViewOpened(param1:Boolean) : void;
   }
}

