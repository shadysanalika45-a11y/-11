package com.oyunstudyosu.layer
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.commands.SceneResolutionCommand;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.SettingsEvent;
   import com.oyunstudyosu.progress.ProgressView;
   import com.oyunstudyosu.sanalika.interfaces.ILayerModel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class LayerModel implements ILayerModel
   {
      
      protected var _stage:Stage;
      
      protected var _panelLayer:Sprite;
      
      protected var _botMessageLayer:Sprite;
      
      protected var _hudLayer:Sprite;
      
      protected var _gameLayer:Sprite;
      
      protected var _effectLayer:Sprite;
      
      protected var _businessMessageLayer:Sprite;
      
      protected var _notificationMessageLayer:Sprite;
      
      protected var _backgroundLayer:Sprite;
      
      protected var _youtubeLayer:Sprite;
      
      protected var _pageLayer:Sprite;
      
      public var masterLayer:Sprite;
      
      public var gameLayerMask:Sprite;
      
      public var progressView:ProgressView;
      
      protected var backgroundBitmapData:BitmapData;
      
      protected var zoomStep:Number = 0.2;
      
      public var hudHeight:int = 35;
      
      public var padding:int = 110;
      
      public var _gameWidth:int;
      
      public var sceneResolititonCommand:SceneResolutionCommand;
      
      private var d:Date = new Date();
      
      private var _gameHeight:int;
      
      private var _gameScale:Number = 1;
      
      private var _wideScreenMode:Boolean;
      
      private var _canvasWidth:int;
      
      private var _canvasHeight:int;
      
      public function LayerModel(param1:Stage)
      {
         super();
         _stage = param1;
         _backgroundLayer = new Sprite();
         _stage.addChild(_backgroundLayer);
         _youtubeLayer = new Sprite();
         _stage.addChild(_youtubeLayer);
         masterLayer = new Sprite();
         gameLayerMask = new Sprite();
         masterLayer.addChild(gameLayerMask);
         drawCanvasMask();
         _gameLayer = new Sprite();
         masterLayer.addChild(_gameLayer);
         _gameLayer.mask = gameLayerMask;
         _gameLayer.addEventListener("mouseOver",onCanvasOver);
         _effectLayer = new Sprite();
         masterLayer.addChild(_effectLayer);
         _pageLayer = new Sprite();
         masterLayer.addChild(_pageLayer);
         _hudLayer = new Sprite();
         masterLayer.addChild(_hudLayer);
         _panelLayer = new Sprite();
         masterLayer.addChild(_panelLayer);
         _botMessageLayer = new Sprite();
         _gameLayer.addChild(_botMessageLayer);
         _businessMessageLayer = new Sprite();
         masterLayer.addChild(_businessMessageLayer);
         _notificationMessageLayer = new Sprite();
         masterLayer.addChild(_notificationMessageLayer);
         _stage.addChild(masterLayer);
         progressView = new ProgressView();
         _panelLayer.addChild(progressView);
         sceneResolititonCommand = new SceneResolutionCommand(this,_stage);
         _stage.addEventListener("resize",onResize);
         _stage.addEventListener("rightClick",onRightClick);
         Dispatcher.addEventListener("SettingsEvent.FULLSCREEN",fullScreenClicked);
         Dispatcher.addEventListener("SettingsEvent.SOUND_ON",soundOnClicked);
         Dispatcher.addEventListener("SettingsEvent.SOUND_OFF",soundOffClicked);
         Dispatcher.addEventListener("SCENE_LOADED",onSceneLoaded);
         onResize(null);
      }
      
      public function get botMessageLayer() : Sprite
      {
         return _botMessageLayer;
      }
      
      public function get gameWidth() : int
      {
         return _gameWidth;
      }
      
      public function set gameWidth(param1:int) : void
      {
         if(_gameWidth == param1)
         {
            return;
         }
         _gameWidth = param1;
      }
      
      public function get gameHeight() : int
      {
         return _gameHeight;
      }
      
      public function set gameHeight(param1:int) : void
      {
         if(_gameHeight == param1)
         {
            return;
         }
         _gameHeight = param1;
      }
      
      public function get gameScale() : Number
      {
         return _gameScale;
      }
      
      public function set gameScale(param1:Number) : void
      {
         if(_gameScale == param1)
         {
            return;
         }
         _gameScale = param1;
      }
      
      protected function onSceneLoaded(param1:GameEvent) : void
      {
      }
      
      private function soundOnClicked(param1:SettingsEvent) : void
      {
         Sanalika.instance.avatarModel.settings.muteSound = true;
      }
      
      private function soundOffClicked(param1:SettingsEvent) : void
      {
         Sanalika.instance.avatarModel.settings.muteSound = false;
      }
      
      private function fullScreenClicked(param1:SettingsEvent) : void
      {
         trace("fullScreenClicked:" + stage.displayState);
         if(stage.displayState == "normal")
         {
            stage.displayState = "fullScreenInteractive";
         }
         else
         {
            stage.displayState = "normal";
         }
      }
      
      public function drawCanvasMask() : void
      {
         var _loc1_:int = 0;
         if(Sanalika.instance.engine && Sanalika.instance.engine.scene && Sanalika.instance.engine.scene.bg)
         {
            trace("bgHeight: ",Sanalika.instance.engine.scene.bg.height);
            trace("canvasHeigt: ",canvasHeight);
            trace("Diff:",Sanalika.instance.engine.scene.bg.height - canvasHeight);
         }
         trace("canvasHeigt",canvasHeight);
         gameLayerMask.graphics.clear();
         gameLayerMask.graphics.beginFill(0);
         gameLayerMask.graphics.drawRoundRectComplex(0,0 - _loc1_,canvasWidth,canvasHeight + _loc1_,12,12,0,0);
         gameLayerMask.graphics.endFill();
      }
      
      protected function onCanvasOver(param1:MouseEvent) : void
      {
         _gameLayer.addEventListener("mouseOut",onCanvasOut);
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
         gameWidth = param1;
         gameHeight = param2;
         onResize(null);
      }
      
      protected function onCanvasOut(param1:MouseEvent) : void
      {
         _gameLayer.removeEventListener("mouseOut",onCanvasOut);
      }
      
      public function get stage() : Stage
      {
         return _stage;
      }
      
      protected function onRightClick(param1:MouseEvent) : void
      {
         trace("Right click not allowed.");
      }
      
      public function onResize(param1:Event = null) : void
      {
         var _loc2_:SceneCharacterComponent = null;
         if(sceneResolititonCommand)
         {
            sceneResolititonCommand.execute();
         }
         drawBG();
         drawCanvasMask();
         if(Sanalika.instance.engine != null && Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            if(_loc2_.myChar != null)
            {
               _loc2_.myChar.screenShifting(0);
            }
         }
         Dispatcher.dispatchEvent(new GameEvent("RESIZE"));
      }
      
      public function get wideScreenMode() : Boolean
      {
         if(Sanalika.instance.airModel.isAir())
         {
            return true;
         }
         return _wideScreenMode;
      }
      
      public function set wideScreenMode(param1:Boolean) : void
      {
         _wideScreenMode = param1;
         onResize();
      }
      
      public function get backgroundLayer() : Sprite
      {
         return _backgroundLayer;
      }
      
      public function get youtubeLayer() : Sprite
      {
         return _youtubeLayer;
      }
      
      public function get pageLayer() : Sprite
      {
         return _pageLayer;
      }
      
      public function get panelLayer() : Sprite
      {
         return _panelLayer;
      }
      
      public function get hudLayer() : Sprite
      {
         return _hudLayer;
      }
      
      public function get gameLayer() : Sprite
      {
         return _gameLayer;
      }
      
      public function get effectLayer() : Sprite
      {
         return _effectLayer;
      }
      
      public function get canvasWidth() : int
      {
         return Sanalika.instance.gameModel.canvasWidth;
      }
      
      public function set canvasWidth(param1:int) : void
      {
         Sanalika.instance.gameModel.canvasWidth = param1;
      }
      
      public function get canvasHeight() : int
      {
         return Sanalika.instance.gameModel.canvasHeight;
      }
      
      public function set canvasHeight(param1:int) : void
      {
         Sanalika.instance.gameModel.canvasHeight = param1;
      }
      
      public function get businessMessageLayer() : Sprite
      {
         return _businessMessageLayer;
      }
      
      public function get notificationMessageLayer() : Sprite
      {
         return _notificationMessageLayer;
      }
      
      public function loadBackground() : void
      {
         if(Sanalika.instance.airModel.isMobile())
         {
            this.stage.color = 4342338;
            return;
         }
         var _loc2_:IAssetRequest = new AssetRequest();
         var _loc1_:String = "";
         if(d.month > 10 || d.month < 2)
         {
            _loc1_ = "Winter";
         }
         if(d.hours < 18)
         {
            _loc2_.assetId = "/static/assets/mainBackGround" + _loc1_ + ".png?v=3";
         }
         else
         {
            _loc2_.assetId = "/static/assets/mainBackGround" + _loc1_ + "N.png?v=3";
         }
         _loc2_.type = "BG";
         _loc2_.loadedFunction = onLoaded;
         _loc2_.context = Sanalika.instance.domainModel.assetContext;
         Sanalika.instance.assetModel.request(_loc2_);
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         backgroundBitmapData = (param1.display as Bitmap).bitmapData;
         drawBG();
      }
      
      public function drawBG() : void
      {
         if(backgroundBitmapData == null)
         {
            return;
         }
         backgroundLayer.removeChildren();
         var _loc1_:Bitmap = new Bitmap(backgroundBitmapData);
         var _loc2_:* = stage.stageWidth / _loc1_.width;
         var _loc3_:* = stage.stageHeight / _loc1_.height;
         if(_loc2_ > _loc3_)
         {
            _loc3_ = _loc2_;
         }
         else if(_loc3_ > _loc2_)
         {
            _loc2_ = _loc3_;
         }
         _loc1_.scaleX = _loc2_;
         _loc1_.scaleY = _loc3_;
         backgroundLayer.addChild(_loc1_);
      }
   }
}

