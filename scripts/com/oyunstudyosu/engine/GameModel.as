package com.oyunstudyosu.engine
{
   import com.oyunstudyosu.sanalika.interfaces.IGameModel;
   
   public class GameModel implements IGameModel
   {
      
      private var _quality:String = "sd";
      
      private var _agentData:String = "";
      
      private var _itemInfoFile:String;
      
      private var _versionFile:String;
      
      private var _languageFileVersion:String;
      
      private var _worldPrefix:String;
      
      private var _diamondRatio:Number;
      
      private var _firewall:String = "PASSIVE";
      
      private var _webServer:String;
      
      private var _fileServer:String;
      
      private var _ropeServer:String;
      
      private var _chatServer:String;
      
      private var _protocol:String = "https://";
      
      private var _serverName:String;
      
      private var _debug:Boolean = false;
      
      private var _language:String;
      
      private var _extensionInfo:Array;
      
      private var _minimumCanvasWidth:int = 400;
      
      private var _minimumCanvasHeight:int = 300;
      
      private var _canvasWidth:int = 800;
      
      private var _canvasHeight:int = 515;
      
      private var _locale:String;
      
      private var _serverDate:Date;
      
      private var _weather:String = "";
      
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
      
      public function get quality() : String
      {
         return _quality;
      }
      
      public function set quality(param1:String) : void
      {
         if(_quality == param1)
         {
            return;
         }
         _quality = param1;
      }
      
      public function get agentData() : String
      {
         return _agentData;
      }
      
      public function set agentData(param1:String) : void
      {
         if(_agentData == param1)
         {
            return;
         }
         _agentData = param1;
      }
      
      public function get itemInfoFile() : String
      {
         return _itemInfoFile;
      }
      
      public function set itemInfoFile(param1:String) : void
      {
         if(_itemInfoFile == param1)
         {
            return;
         }
         _itemInfoFile = param1;
      }
      
      public function get versionFile() : String
      {
         return _versionFile;
      }
      
      public function set versionFile(param1:String) : void
      {
         if(_versionFile == param1)
         {
            return;
         }
         _versionFile = param1;
      }
      
      public function get languageFileVersion() : String
      {
         return _languageFileVersion;
      }
      
      public function set languageFileVersion(param1:String) : void
      {
         if(_languageFileVersion == param1)
         {
            return;
         }
         _languageFileVersion = param1;
      }
      
      public function set worldPrefix(param1:String) : void
      {
         _worldPrefix = param1;
      }
      
      public function get worldPrefix() : String
      {
         return _worldPrefix;
      }
      
      public function get diamondRatio() : Number
      {
         return _diamondRatio;
      }
      
      public function set diamondRatio(param1:Number) : void
      {
         if(_diamondRatio == param1)
         {
            return;
         }
         _diamondRatio = param1;
      }
      
      public function get firewall() : String
      {
         return _firewall;
      }
      
      public function set firewall(param1:String) : void
      {
         if(_firewall == param1)
         {
            return;
         }
         _firewall = param1;
      }
      
      public function get webServer() : String
      {
         return _protocol + _webServer;
      }
      
      public function set webServer(param1:String) : void
      {
         if(_webServer == param1)
         {
            return;
         }
         _webServer = param1;
      }
      
      public function get fileServer() : String
      {
         if(_fileServer == null)
         {
            return "../../sanalika-debug";
         }
         return _protocol + _fileServer;
      }
      
      public function set fileServer(param1:String) : void
      {
         if(_fileServer == param1)
         {
            return;
         }
         _fileServer = param1;
      }
      
      public function get ropeServer() : String
      {
         return _protocol + _ropeServer;
      }
      
      public function set ropeServer(param1:String) : void
      {
         if(_ropeServer == param1)
         {
            return;
         }
         _ropeServer = param1;
      }
      
      public function get chatServer() : String
      {
         return _chatServer;
      }
      
      public function set chatServer(param1:String) : void
      {
         if(_chatServer == param1)
         {
            return;
         }
         _chatServer = param1;
      }
      
      public function get protocol() : String
      {
         return _protocol;
      }
      
      public function set protocol(param1:String) : void
      {
         if(_protocol == param1)
         {
            return;
         }
         _protocol = param1;
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      public function set serverName(param1:String) : void
      {
         if(_serverName == param1)
         {
            return;
         }
         _serverName = param1;
      }
      
      public function get debug() : Boolean
      {
         return _debug;
      }
      
      public function set debug(param1:Boolean) : void
      {
         if(_debug == param1)
         {
            return;
         }
         _debug = param1;
      }
      
      public function get language() : String
      {
         return _language;
      }
      
      public function set language(param1:String) : void
      {
         if(_language == param1)
         {
            return;
         }
         _language = param1;
      }
      
      public function get extensionInfo() : Array
      {
         return _extensionInfo;
      }
      
      public function set extensionInfo(param1:Array) : void
      {
         if(_extensionInfo == param1)
         {
            return;
         }
         _extensionInfo = param1;
      }
      
      public function get minimumCanvasWidth() : int
      {
         return _minimumCanvasWidth;
      }
      
      public function set minimumCanvasWidth(param1:int) : void
      {
         if(_minimumCanvasWidth == param1)
         {
            return;
         }
         _minimumCanvasWidth = param1;
      }
      
      public function get minimumCanvasHeight() : int
      {
         return _minimumCanvasHeight;
      }
      
      public function set minimumCanvasHeight(param1:int) : void
      {
         if(_minimumCanvasHeight == param1)
         {
            return;
         }
         _minimumCanvasHeight = param1;
      }
      
      public function get canvasWidth() : int
      {
         return _canvasWidth;
      }
      
      public function set canvasWidth(param1:int) : void
      {
         if(_canvasWidth == param1)
         {
            return;
         }
         _canvasWidth = param1;
      }
      
      public function get canvasHeight() : int
      {
         return _canvasHeight;
      }
      
      public function set canvasHeight(param1:int) : void
      {
         if(_canvasHeight == param1)
         {
            return;
         }
         _canvasHeight = param1;
      }
      
      public function get locale() : String
      {
         return _locale;
      }
      
      public function set locale(param1:String) : void
      {
         if(_locale == param1)
         {
            return;
         }
         _locale = param1;
      }
      
      public function get serverDate() : Date
      {
         return _serverDate;
      }
      
      public function set serverDate(param1:Date) : void
      {
         if(_serverDate == param1)
         {
            return;
         }
         _serverDate = param1;
      }
      
      public function get weather() : String
      {
         return _weather;
      }
      
      public function set weather(param1:String) : void
      {
         if(_weather == param1)
         {
            return;
         }
         _weather = param1;
      }
      
      public function get exchangeratio() : uint
      {
         return _exchangeratio;
      }
      
      public function set exchangeratio(param1:uint) : void
      {
         if(_exchangeratio == param1)
         {
            return;
         }
         _exchangeratio = param1;
      }
      
      public function get farmCleaningCost() : uint
      {
         return _farmCleaningCost;
      }
      
      public function set farmCleaningCost(param1:uint) : void
      {
         if(_farmCleaningCost == param1)
         {
            return;
         }
         _farmCleaningCost = param1;
      }
      
      public function get farmMaxPlantedItemSize() : uint
      {
         return _farmMaxPlantedItemSize;
      }
      
      public function set farmMaxPlantedItemSize(param1:uint) : void
      {
         if(_farmMaxPlantedItemSize == param1)
         {
            return;
         }
         _farmMaxPlantedItemSize = param1;
      }
      
      public function get avatarOrderLifeTime() : uint
      {
         return _avatarOrderLifeTime;
      }
      
      public function set avatarOrderLifeTime(param1:uint) : void
      {
         if(_avatarOrderLifeTime == param1)
         {
            return;
         }
         _avatarOrderLifeTime = param1;
      }
      
      public function get orderLifeTime() : uint
      {
         return _orderLifeTime;
      }
      
      public function set orderLifeTime(param1:uint) : void
      {
         if(_orderLifeTime == param1)
         {
            return;
         }
         _orderLifeTime = param1;
      }
      
      public function get prepareLifeTime() : uint
      {
         return _prepareLifeTime;
      }
      
      public function set prepareLifeTime(param1:uint) : void
      {
         if(_prepareLifeTime == param1)
         {
            return;
         }
         _prepareLifeTime = param1;
      }
      
      public function get roomTheme() : Array
      {
         return _roomTheme;
      }
      
      public function set roomTheme(param1:Array) : void
      {
         if(_roomTheme == param1)
         {
            return;
         }
         _roomTheme = param1;
      }
      
      public function get isSecurityKeyViewOpened() : Boolean
      {
         return _isSecurityKeyViewOpened;
      }
      
      public function set isSecurityKeyViewOpened(param1:Boolean) : void
      {
         if(_isSecurityKeyViewOpened == param1)
         {
            return;
         }
         _isSecurityKeyViewOpened = param1;
      }
   }
}

