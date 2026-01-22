package
{
   import com.adobe.crypto.MD5;
   import com.greensock.easing.Strong;
   import com.greensock.plugins.ThrowPropsPlugin;
   import com.greensock.plugins.TransformAroundPointPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.junkbyte.console.Cc;
   import com.oyunstudyosu.achievement.AchievementController;
   import com.oyunstudyosu.achievement.AchievementModel;
   import com.oyunstudyosu.trace.TraceManager;
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertModel;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.alert.IAlertModel;
   import com.oyunstudyosu.assets.IAssetModel;
   import com.oyunstudyosu.avatar.AvatarController;
   import com.oyunstudyosu.avatar.AvatarModel;
   import com.oyunstudyosu.ban.BanModel;
   import com.oyunstudyosu.barter.BarterController;
   import com.oyunstudyosu.barter.BarterModel;
   import com.oyunstudyosu.buddy.BuddyController;
   import com.oyunstudyosu.buddy.BuddyModel;
   import com.oyunstudyosu.chat.ChatController;
   import com.oyunstudyosu.chat.ChatModel;
   import com.oyunstudyosu.cloth.CharPreviewManager;
   import com.oyunstudyosu.cloth.ClothModel;
   import com.oyunstudyosu.commands.Command;
   import com.oyunstudyosu.commands.ConfigCommand;
   import com.oyunstudyosu.commands.ConnectCommand;
   import com.oyunstudyosu.commands.DetectOldClientCommand;
   import com.oyunstudyosu.commands.InitParamsCommand;
   import com.oyunstudyosu.commands.LocalizationCommand;
   import com.oyunstudyosu.commands.LoginCommand;
   import com.oyunstudyosu.commands.SerialCommand;
   import com.oyunstudyosu.commands.SetErrorMessagesCommand;
   import com.oyunstudyosu.commands.daily.CheckDailyGiftCommand;
   import com.oyunstudyosu.concert.ConcertModel;
   import com.oyunstudyosu.controller.ActionController;
   import com.oyunstudyosu.controller.ExtensionController;
   import com.oyunstudyosu.controller.MatchmakingController;
   import com.oyunstudyosu.controller.MobileController;
   import com.oyunstudyosu.controller.PurchaseController;
   import com.oyunstudyosu.controller.ReloadController;
   import com.oyunstudyosu.controller.ScreenShakeController;
   import com.oyunstudyosu.controller.ScreenshotController;
   import com.oyunstudyosu.controller.SoundController;
   import com.oyunstudyosu.controller.UserRoomController;
   import com.oyunstudyosu.debug.DebugModel;
   import com.oyunstudyosu.discord.DiscordModel;
   import com.oyunstudyosu.displayAd.AdModel;
   import com.oyunstudyosu.displayAd.IAdModel;
   import com.oyunstudyosu.drop.DropController;
   import com.oyunstudyosu.engine.GameModel;
   import com.oyunstudyosu.engine.IsoEngine;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.OSProgressEvent;
   import com.oyunstudyosu.game.JoystickController;
   import com.oyunstudyosu.game.partyisland.PartyIslandController;
   import com.oyunstudyosu.interactive.EntryModel;
   import com.oyunstudyosu.interactive.IEntryModel;
   import com.oyunstudyosu.item.ItemModel;
   import com.oyunstudyosu.layer.LayerModel;
   import com.oyunstudyosu.local.LocalTranslation;
   import com.oyunstudyosu.local.LocalizationModel;
   import com.oyunstudyosu.model.AdminMessageModel;
   import com.oyunstudyosu.model.AirModel;
   import com.oyunstudyosu.model.BrowserModel;
   import com.oyunstudyosu.model.CacheModel;
   import com.oyunstudyosu.model.ChatBalloonModel;
   import com.oyunstudyosu.model.ConfigModel;
   import com.oyunstudyosu.model.CookieModel;
   import com.oyunstudyosu.model.DomainModel;
   import com.oyunstudyosu.model.DropGiftModel;
   import com.oyunstudyosu.model.ExtensionModel;
   import com.oyunstudyosu.model.ExternalModel;
   import com.oyunstudyosu.model.FarmModel;
   import com.oyunstudyosu.model.GiftModel;
   import com.oyunstudyosu.model.HudModel;
   import com.oyunstudyosu.model.IMatchmakingModel;
   import com.oyunstudyosu.model.KeyboardModel;
   import com.oyunstudyosu.model.LocalConnectionModel;
   import com.oyunstudyosu.model.MatchmakingModel;
   import com.oyunstudyosu.model.MobileModel;
   import com.oyunstudyosu.model.ModuleModel;
   import com.oyunstudyosu.model.OrderModel;
   import com.oyunstudyosu.model.PanelModel;
   import com.oyunstudyosu.model.ScaleModel;
   import com.oyunstudyosu.model.ShortCutModel;
   import com.oyunstudyosu.model.SmileyModel;
   import com.oyunstudyosu.model.SoftKeyboardModel;
   import com.oyunstudyosu.model.TransitionModel;
   import com.oyunstudyosu.model.VersionModel;
   import com.oyunstudyosu.model.WalkModel;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.pooling.OPM;
   import com.oyunstudyosu.privatechat.IPrivateChatModel;
   import com.oyunstudyosu.privatechat.PrivateChatController;
   import com.oyunstudyosu.privatechat.PrivateChatModel;
   import com.oyunstudyosu.progress.ProgressVo;
   import com.oyunstudyosu.quest.IQuestModel;
   import com.oyunstudyosu.quest.QuestController;
   import com.oyunstudyosu.quest.QuestModel;
   import com.oyunstudyosu.restricted.RestrictedController;
   import com.oyunstudyosu.restricted.RestrictedModel;
   import com.oyunstudyosu.room.RoomController;
   import com.oyunstudyosu.room.RoomModel;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.IAchievementModel;
   import com.oyunstudyosu.sanalika.interfaces.IBanModel;
   import com.oyunstudyosu.sanalika.interfaces.IBuddyModel;
   import com.oyunstudyosu.sanalika.interfaces.IChatBalloonModel;
   import com.oyunstudyosu.sanalika.interfaces.IConcertModel;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.sanalika.interfaces.IGiftModel;
   import com.oyunstudyosu.sanalika.interfaces.IHudModel;
   import com.oyunstudyosu.sanalika.interfaces.IKeyboardModel;
   import com.oyunstudyosu.sanalika.interfaces.ILocalConnectionModel;
   import com.oyunstudyosu.sanalika.interfaces.IOrderModel;
   import com.oyunstudyosu.sanalika.interfaces.ISmileyModel;
   import com.oyunstudyosu.sanalika.interfaces.IToolTipModel;
   import com.oyunstudyosu.sanalika.interfaces.ITransferModel;
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateModel;
   import com.oyunstudyosu.service.ServiceController;
   import com.oyunstudyosu.service.ServiceErrorCode;
   import com.oyunstudyosu.service.ServiceModel;
   import com.oyunstudyosu.sound.ISoundModel;
   import com.oyunstudyosu.sound.SoundModel;
   import com.oyunstudyosu.timer.ServerTimerModel;
   import com.oyunstudyosu.timer.SyncTimer;
   import com.oyunstudyosu.transfer.TransferController;
   import com.oyunstudyosu.transfer.TransferModel;
   import com.oyunstudyosu.update.UpdateModel;
   import com.oyunstudyosu.utils.Logger;
   import com.oyunstudyosu.video.youtube.YoutubeModel;
   import com.smartfoxserver.v2.requests.LogoutRequest;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.UncaughtErrorEvent;
   import flash.globalization.DateTimeFormatter;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.SecurityDomain;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import org.oyunstudyosu.assets.clips.DoorIcon;
   
   public class Sanalika extends Sprite
   {
      
      public static var instance:Sanalika;
      
      public var assetModel:IAssetModel;
      
      public var gameModel:GameModel;
      
      public var roomModel:RoomModel;
      
      public var avatarModel:AvatarModel;
      
      public var layerModel:LayerModel;
      
      public var panelModel:PanelModel;
      
      public var itemModel:ItemModel;
      
      public var versionModel:VersionModel;
      
      public var clothModel:ClothModel;
      
      public var serviceModel:ServiceModel;
      
      public var alertModel:IAlertModel;
      
      public var chatModel:ChatModel;
      
      public var soundModel:ISoundModel;
      
      public var extensionModel:ExtensionModel;
      
      public var buddyModel:IBuddyModel;
      
      public var toolTipModel:IToolTipModel;
      
      public var localizationModel:LocalizationModel;
      
      public var transferModel:ITransferModel;
      
      public var moduleModel:ModuleModel;
      
      public var domainModel:DomainModel;
      
      public var keyboardModel:IKeyboardModel;
      
      public var externalModel:ExternalModel;
      
      public var transitionModel:TransitionModel;
      
      public var barterModel:BarterModel;
      
      public var updateModel:IUpdateModel;
      
      public var banModel:IBanModel;
      
      public var entryModel:IEntryModel;
      
      public var concertModel:IConcertModel;
      
      public var smileyModel:ISmileyModel;
      
      public var cookieModel:ICookieModel;
      
      public var localConnectionModel:ILocalConnectionModel;
      
      public var hudModel:IHudModel;
      
      public var chatBalloonModel:IChatBalloonModel;
      
      public var adminMessageModel:AdminMessageModel;
      
      public var adModel:IAdModel;
      
      public var orderModel:IOrderModel;
      
      public var farmModel:FarmModel;
      
      public var mobileModel:MobileModel;
      
      public var scaleModel:ScaleModel;
      
      public var serverTimerModel:ServerTimerModel;
      
      public var walkModel:WalkModel;
      
      public var youtubeModel:YoutubeModel;
      
      public var airModel:AirModel;
      
      public var browserModel:BrowserModel;
      
      public var softKeyboardModel:SoftKeyboardModel;
      
      public var discordModel:DiscordModel;
      
      public var cacheModel:CacheModel;
      
      public var configModel:ConfigModel;
      
      public var debugModel:DebugModel;
      
      public var shortCutModel:ShortCutModel;
      
      public var dropGiftModel:DropGiftModel;
      
      public var privateChatModel:IPrivateChatModel;
      
      public var giftModel:IGiftModel;
      
      public var achievementModel:IAchievementModel;
      
      public var questModel:IQuestModel;
      
      public var matchmakingModel:IMatchmakingModel;
      
      public var controllerList:Dictionary;
      
      public var engine:IsoEngine;
      
      public var restrictedModel:RestrictedModel;

      public var traceManager:TraceManager;

      public var vo:AlertVo;

      private var data:Object;
      
      private var checkDailyGiftCommand:CheckDailyGiftCommand;
      
      public function Sanalika()
      {
         super();
         if(getLen(Capabilities.playerType) != 730)
         {
            stage.frameRate = 24;
         }
         this.addEventListener("addedToStage",onAddedToStage);
         Dispatcher.addEventListener("initManual",initManual);
      }
      
      public function getHash() : String
      {
         return MD5.hashBytes(this.loaderInfo.bytes);
      }
      
      private function getLen(param1:String) : Number
      {
         var _loc3_:* = undefined;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ += param1.charAt(_loc3_).charCodeAt(0);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function initManual(param1:Event) : void
      {
         trace("Sanalika->initManual");
         var _loc2_:SerialCommand = new SerialCommand();
         _loc2_.addCommand(new LoginCommand(false));
         _loc2_.execute();
      }
      
      public function bypass() : void
      {
         Dispatcher.addEventListener("LOGOUT_COMPLETE",onLogoutBypass);
         this.serviceModel.sfs.send(new LogoutRequest());
      }
      
      private function onLogoutBypass(param1:Event = null) : void
      {
         var _loc2_:SerialCommand = new SerialCommand();
         _loc2_.addCommand(new LoginCommand(false));
         _loc2_.execute();
      }
      
      public function reset() : void
      {
         if(Sanalika.instance.serviceModel.sfs.isConnected)
         {
            Sanalika.instance.serviceModel.sfs.send(new LogoutRequest());
         }
         else
         {
            Dispatcher.dispatchEvent(new Event("initManual"));
         }
      }
      
      private function initMan() : void
      {
         Dispatcher.dispatchEvent(new Event("initManual"));
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         instance = this;
         Connectr.instance = instance;
         gameModel = new GameModel();
         layerModel = new LayerModel(stage);
         alertModel = new AlertModel();
         entryModel = new EntryModel();
         updateModel = new UpdateModel();
         cookieModel = new CookieModel();
         matchmakingModel = new MatchmakingModel();
         cookieModel.open("sanalika-global");
         this.stage.scaleMode = "noScale";
         this.stage.align = "TL";
         this.stage.quality = "best";
         ThrowPropsPlugin;
         TweenPlugin.activate([TransformAroundPointPlugin]);
         Strong;
         OPM.addType(DoorIcon,12);
         domainModel = new DomainModel(stage);
         domainModel.checkPolicyFile = true;
         domainModel.securityDomain = SecurityDomain.currentDomain;
         domainModel.mainAppDomain = ApplicationDomain.currentDomain;
         domainModel.subAppDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.LOADING));
         init();
      }
      
      public function init() : void
      {
         Cc.infoch("CharPreviewManager",CharPreviewManager);

         // Initialize trace system early
         traceManager = TraceManager.instance;

         serviceModel = new ServiceModel();
         serviceModel.listenExtension("initQueue",onInitQueueData);
         avatarModel = new AvatarModel();
         roomModel = new RoomModel();
         soundModel = new SoundModel();
         chatModel = new ChatModel();
         buddyModel = new BuddyModel();
         clothModel = new ClothModel();
         transferModel = new TransferModel();
         moduleModel = new ModuleModel();
         keyboardModel = new KeyboardModel();
         externalModel = new ExternalModel();
         transitionModel = new TransitionModel();
         barterModel = new BarterModel();
         smileyModel = new SmileyModel();
         banModel = new BanModel();
         concertModel = new ConcertModel();
         localConnectionModel = new LocalConnectionModel();
         adminMessageModel = new AdminMessageModel();
         configModel = new ConfigModel();
         debugModel = new DebugModel();
         shortCutModel = new ShortCutModel();
         dropGiftModel = new DropGiftModel();
         giftModel = new GiftModel();
         privateChatModel = new PrivateChatModel();
         achievementModel = new AchievementModel();
         questModel = new QuestModel();
         restrictedModel = new RestrictedModel();
         orderModel = new OrderModel();
         farmModel = new FarmModel();
         mobileModel = new MobileModel();
         airModel = new AirModel(stage);
         browserModel = new BrowserModel(stage);
         discordModel = new DiscordModel(stage);
         cacheModel = new CacheModel(stage);
         serverTimerModel = new ServerTimerModel();
         scaleModel = new ScaleModel(stage);
         youtubeModel = new YoutubeModel();
         chatBalloonModel = new ChatBalloonModel();
         var _loc1_:SerialCommand = new SerialCommand();
         _loc1_.addCommand(new InitParamsCommand(stage,this));
         _loc1_.addCommand(new SetErrorMessagesCommand());
         _loc1_.addCommand(new ConnectCommand());
         _loc1_.addCommand(new LoginCommand());
         _loc1_.addCommand(new ConfigCommand());
         _loc1_.addCommand(new LocalizationCommand());
         _loc1_.addCommand(new DetectOldClientCommand());
         _loc1_.addEventListener("complete",initCommandsCompleted);
         _loc1_.execute();
      }
      
      private function initCommandsCompleted(param1:Event) : void
      {
         controllerList = new Dictionary();
         controllerList[AvatarController] = new AvatarController();
         controllerList[ServiceController] = new ServiceController();
         controllerList[ChatController] = new ChatController();
         controllerList[PurchaseController] = new PurchaseController();
         controllerList[ActionController] = new ActionController();
         controllerList[TransferController] = new TransferController();
         controllerList[BarterController] = new BarterController();
         controllerList[UserRoomController] = new UserRoomController();
         controllerList[SoundController] = new SoundController();
         controllerList[ScreenshotController] = new ScreenshotController();
         controllerList[ExtensionController] = new ExtensionController();
         controllerList[ReloadController] = new ReloadController();
         controllerList[PrivateChatController] = new PrivateChatController();
         controllerList[AchievementController] = new AchievementController();
         controllerList[QuestController] = new QuestController();
         controllerList[DropController] = new DropController();
         controllerList[JoystickController] = new JoystickController();
         controllerList[RestrictedController] = new RestrictedController();
         controllerList[MobileController] = new MobileController();
         controllerList[ScreenShakeController] = new ScreenShakeController();
         controllerList[PartyIslandController] = new PartyIslandController();
         controllerList[MatchmakingController] = new MatchmakingController();
         (param1.target as Command).removeEventListener("complete",initCommandsCompleted);
         layerModel.loadBackground();
         softKeyboardModel = new SoftKeyboardModel(stage);
         if(hudModel != null)
         {
            hudModel.dispose();
         }
         hudModel = new HudModel();
         panelModel = new PanelModel();
         engine = new IsoEngine();
         adModel = new AdModel();
         Dispatcher.addEventListener("ITEM_INFO_FILE_LOADED",onItemInfoFileLoaded);
         itemModel = new ItemModel(gameModel.itemInfoFile);
         walkModel = new WalkModel();

         // Initialize trace system with all dependencies
         if(traceManager && serviceModel && serviceModel.sfs && assetModel)
         {
            traceManager.init(serviceModel.sfs,serviceModel,assetModel as com.oyunstudyosu.assets.AssetModel,layerModel.systemLayer);
            trace("[Sanalika] Trace system initialized successfully");
            trace("[Sanalika] Press Ctrl+Shift+T to open trace console");
            trace("[Sanalika] Logs: " + traceManager.logger.getCurrentLogFile().nativePath);
         }
         else
         {
            trace("[Sanalika] Warning: Trace system not initialized - missing dependencies");
         }

         trace("hello world");
      }
      
      public function getController(param1:Class) : Object
      {
         return controllerList[param1];
      }
      
      public function onItemInfoFileLoaded(param1:Event = null) : void
      {
         Dispatcher.removeEventListener("ITEM_INFO_FILE_LOADED",onItemInfoFileLoaded);
         Dispatcher.addEventListener("VERSION_FILE_LOADED",onVersionFileLoaded);
         versionModel = new VersionModel(gameModel.versionFile);
      }
      
      public function onVersionFileLoaded(param1:Event = null) : void
      {
         var _loc2_:PanelVO = null;
         Dispatcher.removeEventListener("VERSION_FILE_LOADED",onVersionFileLoaded);
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.INFO_FILE_READY));
         controllerList[RoomController] = new RoomController(serviceModel.sfs);
         Dispatcher.addEventListener("INITIALIZE",initialize);
         if(Sanalika.instance.serviceModel.sfs.mySelf.privilegeId == 0 && avatarModel.guest == false)
         {
            Cc.info("fileServer: " + Sanalika.instance.gameModel.fileServer);
            _loc2_ = new PanelVO();
            _loc2_.name = "GuestPanel";
            _loc2_.params = {};
            panelModel.openPanel(_loc2_);
            Cc.info("GuestPanel request: " + Sanalika.instance.moduleModel.getPath("GuestPanel","ModuleType.PANEL"));
         }
         else
         {
            initialize();
         }
      }
      
      public function restartApplication() : void
      {
         var _loc10_:* = undefined;
         var _loc5_:Class = null;
         var _loc1_:Class = null;
         var _loc6_:Class = null;
         var _loc3_:Class = null;
         var _loc11_:XML = null;
         var _loc9_:Namespace = null;
         var _loc4_:String = null;
         var _loc8_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = undefined;
         if(Connectr.instance.airModel.isMobile())
         {
            _loc10_ = stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.restart.RestartApplication") as Class;
            _loc10_.restart();
         }
         else
         {
            _loc5_ = stage.loaderInfo.applicationDomain.getDefinition("flash.filesystem.File") as Class;
            _loc1_ = stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeApplication") as Class;
            _loc6_ = stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeProcessStartupInfo") as Class;
            _loc3_ = stage.loaderInfo.applicationDomain.getDefinition("flash.desktop.NativeProcess") as Class;
            _loc11_ = _loc1_.nativeApplication.applicationDescriptor;
            _loc9_ = new Namespace(_loc11_.namespace());
            _loc4_ = _loc11_._loc9_::filename;
            _loc8_ = new _loc6_();
            _loc7_ = new _loc3_();
            if(Capabilities.os.indexOf("Win") > -1)
            {
               _loc2_ = new _loc5_(_loc5_.applicationDirectory.nativePath + "/" + _loc4_ + ".exe");
            }
            else
            {
               _loc2_ = new _loc5_(_loc5_.applicationDirectory.nativePath.replace("Resources","MacOS/" + _loc4_));
            }
            _loc8_.executable = _loc2_;
            _loc7_.start(_loc8_);
            _loc1_.nativeApplication.exit();
         }
      }
      
      public function testStreet() : void
      {
         serviceModel.requestData("teleport",{"roomKey":"testStreet"},null);
      }
      
      public function initialize(param1:Event = null) : void
      {
         serviceModel.requestData("init",{},onInited);
      }
      
      private function onInited(param1:Object) : void
      {
         var _loc8_:PanelVO = null;
         var _loc5_:AlertVo = null;
         _loc8_ = null;
         var _loc7_:DateTimeFormatter = null;
         _loc5_ = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc2_:Date = null;
         var _loc4_:String = null;
         serviceModel.removeRequestData("init",onInited);
         this.data = param1;
         ServiceErrorCode.setRoles();
         if(param1.ts)
         {
            SyncTimer.setTimestamp(param1.ts);
         }
         if(param1.selectedAvatarID != undefined)
         {
            avatarModel.avatarId = param1.selectedAvatarID;
         }
         if(param1.email != null)
         {
            avatarModel.email = param1.email;
         }
         if(param1.deactivationReason != null)
         {
            Dispatcher.dispatchEvent(new OSProgressEvent("LOADING_PROGRESS",ProgressVo.PROGRESS_FULL));
            _loc8_ = new PanelVO();
            _loc8_.name = "CellPhonePanel";
            _loc8_.type = "hud";
            _loc8_.isPermanent = true;
            _loc8_.params = {"isLoginBanned":true};
            Sanalika.instance.panelModel.openPanel(_loc8_);
            _loc5_ = new AlertVo();
            _loc5_.alertType = "Error";
            _loc5_.title = LocalTranslation.translate("LOGIN_ERROR_TITLE");
            _loc5_.description = Sanalika.instance.localizationModel.translate(param1.deactivationReason);
            Dispatcher.dispatchEvent(new AlertEvent(_loc5_));
            return;
         }
         if(param1.banData != null)
         {
            Dispatcher.dispatchEvent(new OSProgressEvent("LOADING_PROGRESS",ProgressVo.PROGRESS_FULL));
            _loc8_ = new PanelVO();
            _loc8_.name = "CellPhonePanel";
            _loc8_.type = "hud";
            _loc8_.isPermanent = true;
            _loc8_.params = {"isLoginBanned":true};
            Sanalika.instance.panelModel.openPanel(_loc8_);
            _loc7_ = new DateTimeFormatter("en-US");
            _loc7_.setDateTimePattern("yyyy-MM-dd HH:mm:ss");
            _loc5_ = new AlertVo();
            _loc5_.alertType = "Error";
            _loc5_.title = LocalTranslation.translate("LOGIN_ERROR_TITLE");
            _loc3_ = param1.banData.endDate;
            _loc6_ = param1.banData.reason;
            _loc2_ = new Date(parseFloat(_loc3_));
            _loc4_ = _loc7_.format(_loc2_).toString();
            if(_loc6_ == null)
            {
               _loc5_.description = LocalTranslation.translate("LOGIN_BANNED_USER",_loc4_);
            }
            else
            {
               _loc5_.description = LocalTranslation.translate("LOGIN_BANNED_USER",_loc4_);
            }
            Dispatcher.dispatchEvent(new AlertEvent(_loc5_));
            return;
         }
         trace(param1.extensionInfo.length);
         if(param1.extensionInfo != undefined)
         {
            gameModel.extensionInfo = param1.extensionInfo;
         }
         extensionModel = new ExtensionModel();
         if(gameModel.extensionInfo != null)
         {
            extensionModel.init(gameModel.extensionInfo);
         }
         else
         {
            extensionModel.init([]);
         }
         if(param1.settings)
         {
            avatarModel.settings.hideRequests = 1;
            if(param1.settings.wideMode != undefined)
            {
               avatarModel.settings.wideScreenMode = int(param1.settings.wideMode.toString());
            }
            if(param1.settings.showInvitations != undefined)
            {
               avatarModel.settings.showInvitations = int(param1.settings.showInvitations.toString());
            }
            avatarModel.settings.muteSound = 0;
            if(param1.settings.transferRequests != undefined)
            {
               avatarModel.settings.transferRequests = int(param1.settings.transferRequests.toString());
            }
            if(param1.settings.incomingMessages != undefined)
            {
               avatarModel.settings.incomingMessages = int(param1.settings.incomingMessages.toString());
            }
            if(param1.settings.tradeRequests != undefined)
            {
               avatarModel.settings.tradeRequests = int(param1.settings.tradeRequests.toString());
            }
            if(param1.settings.whisperMessage != undefined)
            {
               avatarModel.settings.whisperMessage = int(param1.settings.whisperMessage.toString());
            }
            if(param1.settings.flatNotifications != undefined)
            {
               avatarModel.settings.flatNotifications = int(param1.settings.flatNotifications.toString());
            }
            if(param1.settings.onlyBuddyWhisper != undefined)
            {
               avatarModel.settings.onlyBuddyWhisper = int(param1.settings.onlyBuddyWhisper.toString());
            }
            if(param1.settings.verifySession != undefined)
            {
               avatarModel.settings.verifySession = int(param1.settings.verifySession.toString());
            }
         }
         if(param1.campaigns)
         {
            checkDailyGiftCommand = new CheckDailyGiftCommand(param1.campaigns);
            checkDailyGiftCommand.execute();
         }
         if(param1.bans)
         {
            banModel.configBans(param1.bans);
         }
         if(param1.orderRequest)
         {
            orderModel.orderRequest = param1.orderRequest;
         }
         Dispatcher.addEventListener("EXTENSIONS_LOADED",process);
      }
      
      private function onInitQueueData(param1:Object) : void
      {
         SyncTimer.setTimestamp(param1.timestamp);
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",new ProgressVo(0,"QUEUE",param1.p)));
      }
      
      private function process(param1:GameEvent) : void
      {
         var panelVo:PanelVO;
         var vo:PanelVO;
         var e:GameEvent = param1;
         Dispatcher.removeEventListener("EXTENSIONS_LOADED",process);
         trace("onInited");
         serviceModel.removeRequestData("init",onInited);
         avatarModel.gender = data.gender;
         avatarModel.guest = data.guest;
         achievementModel.rewardCount = data.completedAchievementsCount;
         if(data.checkAvatar == 0)
         {
            Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.PROGRESS_FULL));
            panelVo = new PanelVO();
            panelVo.name = "AvatarCreatePanel";
            panelVo.type = "BaseCloth";
            panelModel.openPanel(panelVo);
            return;
         }
         avatarModel.isBaseClothSelected = true;
         if(data.createAvatar)
         {
            Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.PROGRESS_FULL));
            vo = new PanelVO();
            vo.name = "AvatarCreatePanel";
            vo.params = {};
            panelModel.openPanel(vo);
            return;
         }
         roomModel.checkMap(data);
         avatarModel.updateWallet(data.wallet);
         clothModel.load(data.clothes.items);
         avatarModel.holdedItem = null;
         avatarModel.lastHoldedItem = null;
         hudModel.init();
         if(controllerList[BuddyController] != null)
         {
            controllerList[BuddyController].dispose();
         }
         controllerList[BuddyController] = new BuddyController();
         engine.start();
         Dispatcher.dispatchEvent(new OSProgressEvent("INIT_PROGRESS",ProgressVo.INIT_READY));
         cookieModel.startCheck();
         data = null;
         Dispatcher.addEventListener("ACTIVE_GRID_CHANGED",function(param1:GameEvent):*
         {
         });
      }
      
      private function letsStart(param1:*) : void
      {
      }
      
      protected function onUncaughtErrorHandler(param1:UncaughtErrorEvent) : void
      {
         var _loc3_:Error = null;
         var _loc2_:ErrorEvent = null;
         param1.preventDefault();
         Mouse.cursor = "auto";
         if(param1.error is Error)
         {
            _loc3_ = param1.error as Error;
            Logger.log(_loc3_.getStackTrace(),true);
         }
         else if(param1.error is ErrorEvent)
         {
            _loc2_ = param1.error as ErrorEvent;
            Logger.log(_loc2_.text,true);
         }
         else
         {
            Logger.log(param1.errorID + " error.",true);
         }
      }
   }
}

