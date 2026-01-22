package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.sanalika.interfaces.IGameModel;
   
   public class GameModel implements IGameModel
   {
      
      private var _exchangeratio:uint = 30;
      
      private var _farmCleaningCost:int;
      
      private var _farmMaxPlantedItemSize:int;
      
      private var _avatarOrderLifeTime:int;
      
      private var _orderLifeTime:int;
      
      private var _prepareLifeTime:int;
      
      private var _roomTheme:Array;
      
      private var _isSecurityKeyViewOpened:Boolean;
      
      public function GameModel()
      {
         super();
      }
      
      public function get languageFileVersion() : String
      {
         return "/static/locale/" + this.language + ".mo";
      }
      
      public function set languageFileVersion(param1:String) : void
      {
      }
      
      public function get itemInfoFileVersion() : String
      {
         return null;
      }
      
      public function get diamondRatio() : Number
      {
         return 0;
      }
      
      public function get ropeServer() : String
      {
         return null;
      }
      
      public function get serverName() : String
      {
         return null;
      }
      
      public function get locale() : String
      {
         return null;
      }
      
      public function get language() : String
      {
         return "tr";
      }
      
      public function get worldPrefix() : String
      {
         return null;
      }
      
      public function get serverDate() : Date
      {
         return null;
      }
      
      public function set serverDate(param1:Date) : void
      {
      }
      
      public function get weather() : String
      {
         return "";
      }
      
      public function set weather(param1:String) : void
      {
      }
      
      public function get fileServer() : String
      {
         return "../../sanalika-debug";
      }
      
      public function get canvasHeight() : int
      {
         return 0;
      }
      
      public function get canvasWidth() : int
      {
         return 0;
      }
      
      public function get quality() : String
      {
         return "sd";
      }
      
      public function set quality(param1:String) : void
      {
      }
      
      public function set canvasHeight(param1:int) : void
      {
      }
      
      public function set canvasWidth(param1:int) : void
      {
      }
      
      public function get minimumCanvasHeight() : int
      {
         return 0;
      }
      
      public function get minimumCanvasWidth() : int
      {
         return 0;
      }
      
      public function get itemInfoFile() : String
      {
         return null;
      }
      
      public function set itemInfoFile(param1:String) : void
      {
      }
      
      public function get exchangeratio() : uint
      {
         return this._exchangeratio;
      }
      
      public function set exchangeratio(param1:uint) : void
      {
         if(this._exchangeratio == param1)
         {
            return;
         }
         this._exchangeratio = param1;
      }
      
      public function get farmCleaningCost() : uint
      {
         return this._farmCleaningCost;
      }
      
      public function set farmCleaningCost(param1:uint) : void
      {
         if(this._farmCleaningCost == param1)
         {
            return;
         }
         this._farmCleaningCost = param1;
      }
      
      public function get farmMaxPlantedItemSize() : uint
      {
         return this._farmMaxPlantedItemSize;
      }
      
      public function set farmMaxPlantedItemSize(param1:uint) : void
      {
         if(this._farmMaxPlantedItemSize == param1)
         {
            return;
         }
         this._farmMaxPlantedItemSize = param1;
      }
      
      public function get avatarOrderLifeTime() : uint
      {
         return this._avatarOrderLifeTime;
      }
      
      public function set avatarOrderLifeTime(param1:uint) : void
      {
         if(this._avatarOrderLifeTime == param1)
         {
            return;
         }
         this._avatarOrderLifeTime = param1;
      }
      
      public function get orderLifeTime() : uint
      {
         return this._orderLifeTime;
      }
      
      public function set orderLifeTime(param1:uint) : void
      {
         if(this._orderLifeTime == param1)
         {
            return;
         }
         this._orderLifeTime = param1;
      }
      
      public function get prepareLifeTime() : uint
      {
         return this._prepareLifeTime;
      }
      
      public function set prepareLifeTime(param1:uint) : void
      {
         if(this._prepareLifeTime == param1)
         {
            return;
         }
         this._prepareLifeTime = param1;
      }
      
      public function get webServer() : String
      {
         return "http://www.sanalika.com";
      }
      
      public function set webServer(param1:String) : void
      {
      }
      
      public function get agentData() : String
      {
         return null;
      }
      
      public function set agentData(param1:String) : void
      {
      }
      
      public function get roomTheme() : Array
      {
         return new Array("aaa","bbb");
      }
      
      public function set roomTheme(param1:Array) : void
      {
         if(this._roomTheme == param1)
         {
            return;
         }
         this._roomTheme = param1;
      }
      
      public function get isSecurityKeyViewOpened() : Boolean
      {
         return this._isSecurityKeyViewOpened;
      }
      
      public function set isSecurityKeyViewOpened(param1:Boolean) : void
      {
         if(this._isSecurityKeyViewOpened == param1)
         {
            return;
         }
         this._isSecurityKeyViewOpened = param1;
      }
   }
}

