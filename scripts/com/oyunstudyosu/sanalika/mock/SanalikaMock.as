package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.alert.IAlertModel;
   import com.oyunstudyosu.assets.AssetModel;
   import com.oyunstudyosu.assets.IAssetModel;
   import com.oyunstudyosu.chat.IChatModel;
   import com.oyunstudyosu.cloth.IClothModel;
   import com.oyunstudyosu.data.DataModel;
   import com.oyunstudyosu.data.IDataModel;
   import com.oyunstudyosu.displayAd.IAdModel;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.local.ILocalizationModel;
   import com.oyunstudyosu.model.AirModel;
   import com.oyunstudyosu.quest.IQuestModel;
   import com.oyunstudyosu.sanalika.interfaces.IAirModel;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarModel;
   import com.oyunstudyosu.sanalika.interfaces.IBuddyModel;
   import com.oyunstudyosu.sanalika.interfaces.ICookieModel;
   import com.oyunstudyosu.sanalika.interfaces.IGameModel;
   import com.oyunstudyosu.sanalika.interfaces.IItemModel;
   import com.oyunstudyosu.sanalika.interfaces.ILayerModel;
   import com.oyunstudyosu.sanalika.interfaces.IModuleModel;
   import com.oyunstudyosu.sanalika.interfaces.IPanelModel;
   import com.oyunstudyosu.sanalika.interfaces.IRoomModel;
   import com.oyunstudyosu.sanalika.interfaces.IToolTipModel;
   import com.oyunstudyosu.sanalika.interfaces.update.IUpdateModel;
   import com.oyunstudyosu.sanalika.sound.SoundKey;
   import com.oyunstudyosu.service.IServiceModel;
   import com.oyunstudyosu.sound.ISoundModel;
   import com.oyunstudyosu.sound.SoundModel;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   
   public class SanalikaMock extends Sprite
   {
      
      public var airModel:IAirModel;
      
      public var configModel:Object;
      
      public var assetModel:IAssetModel;
      
      public var gameModel:IGameModel;
      
      public var roomModel:IRoomModel;
      
      public var avatarModel:IAvatarModel;
      
      public var layerModel:ILayerModel;
      
      public var panelModel:IPanelModel;
      
      public var itemModel:IItemModel;
      
      public var clothModel:IClothModel;
      
      public var serviceModel:IServiceModel;
      
      public var buddyModel:IBuddyModel;
      
      public var chatModel:IChatModel;
      
      public var toolTipModel:IToolTipModel;
      
      public var localizationModel:ILocalizationModel;
      
      public var alertModel:IAlertModel;
      
      public var dataModel:IDataModel;
      
      public var moduleModel:IModuleModel;
      
      public var soundModel:ISoundModel;
      
      public var domainModel:MockDomainModel;
      
      public var updateModel:IUpdateModel;
      
      public var adModel:IAdModel;
      
      public var cookieModel:ICookieModel;
      
      public var questModel:IQuestModel;
      
      public function SanalikaMock()
      {
         super();
         this.stage.scaleMode = StageScaleMode.NO_SCALE;
         this.stage.align = StageAlign.TOP_LEFT;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedStage);
      }
      
      protected function onAddedStage(param1:Event) : void
      {
         this.domainModel = new MockDomainModel();
         this.domainModel.checkPolicyFile = false;
         this.domainModel.securityDomain = null;
         this.domainModel.mainAppDomain = ApplicationDomain.currentDomain;
         this.domainModel.subAppDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
         this.gameModel = new GameModel();
         this.assetModel = new AssetModel(stage);
         this.layerModel = new LayerModel(stage);
         this.itemModel = new ItemModel();
         this.avatarModel = new AvatarModel();
         this.clothModel = new ClothModel();
         this.roomModel = new RoomModel();
         this.chatModel = new ChatModel();
         this.buddyModel = new BuddyModel();
         this.alertModel = new AlertModel();
         this.dataModel = new DataModel();
         this.soundModel = new SoundModel();
         this.moduleModel = new ModuleModel();
         this.adModel = new DummyAdModel();
         this.airModel = new AirModel(stage);
         this.soundModel.addSound(SoundKey.BUTTON_CLICK,"../../sanalika-debug/static/sounds/click.mp3");
         this.localizationModel = new LocalizationModel();
         Dispatcher.addEventListener(LocalizationModel.LOCALIZATION_DATA_READY,this.onComplete);
         var _loc2_:Object = {};
         _loc2_.stage = this.layerModel.stage;
         _loc2_.toolTipModel = this.toolTipModel;
         _loc2_.language = this.gameModel.language;
         _loc2_.fileServer = this.gameModel.fileServer;
         _loc2_.version = this.gameModel.languageFileVersion;
         _loc2_.debugMode = true;
         this.localizationModel.init(_loc2_);
      }
      
      public function onComplete(param1:Event) : void
      {
         trace("translations ok.");
      }
   }
}

