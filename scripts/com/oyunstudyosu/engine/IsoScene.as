package com.oyunstudyosu.engine
{
   import com.oyunstudyosu.engine.character.Character;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.CellType;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.engine.grid.GridManager;
   import com.oyunstudyosu.engine.grid.IGridManager;
   import com.oyunstudyosu.engine.scene.components.ISceneCameraComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneComponent;
   import com.oyunstudyosu.engine.scene.components.ISceneProcessDataComponent;
   import com.oyunstudyosu.engine.scene.components.SceneBotComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCameraComponent;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.engine.scene.components.SceneDoorComponent;
   import com.oyunstudyosu.engine.scene.components.SceneMouseInteractionComponent;
   import com.oyunstudyosu.engine.scene.components.SceneProcessDataComponent;
   import com.oyunstudyosu.engine.scene.components.SceneZoomComponent;
   import com.oyunstudyosu.debug.ContractLogger;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   import com.oyunstudyosu.utils.BooleanEvaluator;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLNode;
   import org.oyunstudyosu.assets.clips.ChairArrow;
   import org.oyunstudyosu.assets.clips.Cursor;
   
   public class IsoScene extends EventDispatcher implements IScene
   {
      
      public static const cos:Number = 0.9483255309738488;
      
      public static const sin:Number = 0.31729905027145594;
      
      public var _mouseEnabled:Boolean = true;
      
      private var _speechBalloonsEnabled:Boolean = true;
      
      private var _speechBalloons:Array;
      
      private var _xBase:int = 0;
      
      private var _yBase:int = 0;
      
      private var _paddingX:Number;
      
      private var _paddingY:Number;
      
      private var _activeGrid:IntPoint;
      
      private var _elementsContainer:Sprite = new Sprite();
      
      private var _speechContainer:Sprite = new Sprite();
      
      public var _floorContainer:Sprite = new Sprite();
      
      private var _ceilingContainer:Sprite = new Sprite();
      
      private var _bgContainer:Sprite = new Sprite();
      
      private var _container:Sprite;
      
      private var _bg:MovieClip;
      
      private var _grid:Vector.<Cell>;
      
      private var _gridManager:IGridManager;
      
      private var _columnsCount:int;
      
      private var _rowsCount:int;
      
      private var soundTransform:SoundTransform;
      
      private var _mapEntries:Vector.<MapEntry>;
      
      private var _sceneElements:Vector.<IsoElement>;
      
      public var yOrigin:Number = 0;
      
      public var xOrigin:Number = 0;
      
      private var _cursor:MovieClip;
      
      private var _arrow:MovieClip;
      
      private var _map:XMLNode;
      
      public var cell:Cell;
      
      public var disposed:Boolean = false;
      
      private var _sceneLoaded:Boolean = false;
      
      public var _initialized:Boolean = false;
      
      private var p:Point;
      
      private var components:Dictionary = new Dictionary();
      
      private var interfaceComponents:Dictionary = new Dictionary();
      
      public function IsoScene()
      {
         super();
         gridManager = new GridManager(this);
         container = new Sprite();
         arrow = new ChairArrow();
         arrow.mouseChildren = arrow.mouseEnabled = false;
         cursor = new Cursor();
         cursor.x = -50;
         cursor.y = -50;
         elementsContainer = new Sprite();
         floorContainer = new Sprite();
         ceilingContainer = new Sprite();
         speechContainer = new Sprite();
         bgContainer = new Sprite();
         container.cacheAsBitmap = false;
         container.addChild(bgContainer);
         container.addChild(floorContainer);
         container.addChild(cursor);
         container.addChild(elementsContainer);
         container.addChild(speechContainer);
         container.addChild(ceilingContainer);
         container.addChild(arrow);
         Mouse.cursor = "auto";
         Dispatcher.addEventListener("RESIZE",onCanvasResize);
         onCanvasResize();
      }
      
      public function get mouseEnabled() : Boolean
      {
         return _mouseEnabled;
      }
      
      public function set mouseEnabled(param1:Boolean) : void
      {
         _mouseEnabled = param1;
      }
      
      public function get speechBalloonsEnabled() : Boolean
      {
         return _speechBalloonsEnabled;
      }
      
      public function set speechBalloonsEnabled(param1:Boolean) : void
      {
         _speechBalloonsEnabled = param1;
      }
      
      public function get speechBalloons() : Array
      {
         return _speechBalloons;
      }
      
      public function set speechBalloons(param1:Array) : void
      {
         _speechBalloons = param1;
      }
      
      public function get xBase() : int
      {
         return _xBase;
      }
      
      public function set xBase(param1:int) : void
      {
         _xBase = param1;
      }
      
      public function get yBase() : int
      {
         return _yBase;
      }
      
      public function set yBase(param1:int) : void
      {
         _yBase = param1;
      }
      
      public function get paddingX() : Number
      {
         return _paddingX;
      }
      
      public function set paddingX(param1:Number) : void
      {
         _paddingX = param1;
      }
      
      public function get paddingY() : Number
      {
         return _paddingY;
      }
      
      public function set paddingY(param1:Number) : void
      {
         _paddingY = param1;
      }
      
      public function get activeGrid() : IntPoint
      {
         return _activeGrid;
      }
      
      public function set activeGrid(param1:IntPoint) : void
      {
         _activeGrid = param1;
      }
      
      public function getBotByName(param1:String) : ISpeechable
      {
         var _loc2_:SceneBotComponent = null;
         if(existsComponent(SceneBotComponent))
         {
            _loc2_ = getComponent(SceneBotComponent) as SceneBotComponent;
            return _loc2_.getBotByName(param1);
         }
         return null;
      }
      
      public function get characterList() : Array
      {
         var _loc1_:Array = [];
         if(existsComponent(SceneCharacterComponent))
         {
            for each(var _loc2_ in (getComponent(SceneCharacterComponent) as SceneCharacterComponent).characterList)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getAvatarById(param1:String) : ICharacter
      {
         if(existsComponent(SceneCharacterComponent))
         {
            return (getComponent(SceneCharacterComponent) as SceneCharacterComponent).getAvatarById(param1);
         }
         return null;
      }
      
      public function get myChar() : ICharacter
      {
         if(existsComponent(SceneCharacterComponent))
         {
            return (getComponent(SceneCharacterComponent) as SceneCharacterComponent).myChar;
         }
         return null;
      }
      
      public function get mouseX() : Number
      {
         return (Sanalika.instance.stage.mouseX - paddingX - xBase) / Sanalika.instance.scaleModel.currentScale;
      }
      
      public function get mouseY() : Number
      {
         return (Sanalika.instance.stage.mouseY - paddingY - yBase) / Sanalika.instance.scaleModel.currentScale;
      }
      
      public function get elementsContainer() : Sprite
      {
         return _elementsContainer;
      }
      
      public function set elementsContainer(param1:Sprite) : void
      {
         _elementsContainer = param1;
      }
      
      public function get speechContainer() : Sprite
      {
         return _speechContainer;
      }
      
      public function set speechContainer(param1:Sprite) : void
      {
         _speechContainer = param1;
      }
      
      public function get floorContainer() : Sprite
      {
         return _floorContainer;
      }
      
      public function set floorContainer(param1:Sprite) : void
      {
         _floorContainer = param1;
      }
      
      public function get ceilingContainer() : Sprite
      {
         return _ceilingContainer;
      }
      
      public function set ceilingContainer(param1:Sprite) : void
      {
         _ceilingContainer = param1;
      }
      
      public function get bgContainer() : Sprite
      {
         return _bgContainer;
      }
      
      public function set bgContainer(param1:Sprite) : void
      {
         _bgContainer = param1;
      }
      
      public function get container() : Sprite
      {
         return _container;
      }
      
      public function set container(param1:Sprite) : void
      {
         _container = param1;
      }
      
      public function get bg() : MovieClip
      {
         return _bg;
      }
      
      public function set bg(param1:MovieClip) : void
      {
         _bg = param1;
      }
      
      public function get grid() : Vector.<Cell>
      {
         return _grid;
      }
      
      public function set grid(param1:Vector.<Cell>) : void
      {
         _grid = param1;
      }
      
      public function get gridManager() : IGridManager
      {
         return _gridManager;
      }
      
      public function set gridManager(param1:IGridManager) : void
      {
         _gridManager = param1;
      }
      
      public function get columnsCount() : int
      {
         return _columnsCount;
      }
      
      public function set columnsCount(param1:int) : void
      {
         _columnsCount = param1;
      }
      
      public function get rowsCount() : int
      {
         return _rowsCount;
      }
      
      public function set rowsCount(param1:int) : void
      {
         _rowsCount = param1;
      }
      
      public function get mapEntries() : Vector.<MapEntry>
      {
         return _mapEntries;
      }
      
      public function set mapEntries(param1:Vector.<MapEntry>) : void
      {
         _mapEntries = param1;
      }
      
      public function get sceneElements() : Vector.<IsoElement>
      {
         return _sceneElements;
      }
      
      public function set sceneElements(param1:Vector.<IsoElement>) : void
      {
         _sceneElements = param1;
      }
      
      public function get cursor() : MovieClip
      {
         return _cursor;
      }
      
      public function set cursor(param1:MovieClip) : void
      {
         _cursor = param1;
      }
      
      public function get arrow() : MovieClip
      {
         return _arrow;
      }
      
      public function set arrow(param1:MovieClip) : void
      {
         _arrow = param1;
      }
      
      public function get map() : XMLNode
      {
         return _map;
      }
      
      public function set map(param1:XMLNode) : void
      {
         _map = param1;
      }
      
      public function get sceneLoaded() : Boolean
      {
         return _sceneLoaded;
      }
      
      public function set sceneLoaded(param1:Boolean) : void
      {
         _sceneLoaded = param1;
      }
      
      public function get initialized() : Boolean
      {
         return _initialized;
      }
      
      public function set initialized(param1:Boolean) : void
      {
         _initialized = param1;
      }
      
      public function addComponent(param1:Class, param2:Class = null) : ISceneComponent
      {
         if(param2 != null && interfaceComponents[getQualifiedClassName(param2)] != null)
         {
            return null;
         }
         var _loc4_:String = getQualifiedClassName(param1);
         var _loc3_:ISceneComponent = new param1(this);
         components[_loc4_] = _loc3_;
         if(param2 != null)
         {
            interfaceComponents[getQualifiedClassName(param2)] = _loc3_;
         }
         return _loc3_;
      }
      
      public function existsComponent(param1:Class) : Boolean
      {
         var _loc2_:String = getQualifiedClassName(param1);
         return components[_loc2_] != null || interfaceComponents[_loc2_] != null;
      }
      
      public function getComponent(param1:Class) : ISceneComponent
      {
         var _loc2_:String = getQualifiedClassName(param1);
         if(components[_loc2_] != null)
         {
            return components[_loc2_];
         }
         if(interfaceComponents[_loc2_] != null)
         {
            return interfaceComponents[_loc2_];
         }
         return null;
      }
      
      protected function enterFrameOperations(param1:Event) : void
      {
         gridManager.enterFrameOperations();
      }
      
      public function init() : void
      {
         trace("init()");
         cursor.visible = true;
         arrow.visible = false;
         if(!Sanalika.instance.avatarModel.settings.muteSound)
         {
            SoundMixer.soundTransform = new SoundTransform(1);
         }
         speechBalloons = [];
         grid = new Vector.<Cell>();
         sceneElements = new Vector.<IsoElement>();
         mapEntries = new Vector.<MapEntry>();
         disposed = false;
         addComponent(SceneDoorComponent);
         addComponent(SceneCameraComponent,ISceneCameraComponent);
         addComponent(SceneMouseInteractionComponent);
         addComponent(SceneZoomComponent);
         addComponent(SceneBotComponent);
         addComponent(SceneCharacterComponent,ISceneCharacterComponent);
         addComponent(SceneProcessDataComponent,ISceneProcessDataComponent);
         Sanalika.instance.stage.addEventListener("enterFrame",enterFrameOperations);
         Sanalika.instance.serviceModel.listenExtension("roomjoincomplete",onRoomJoinComplete);
      }
      
      public function load() : void
      {
         if(!existsComponent(ISceneProcessDataComponent))
         {
            return;
         }
         var _loc1_:ISceneProcessDataComponent = getComponent(ISceneProcessDataComponent) as ISceneProcessDataComponent;
         _loc1_.load();
         initialized = true;
      }
      
      private function onCanvasResize(param1:Event = null) : void
      {
         paddingX = Sanalika.instance.layerModel.gameLayer.x;
         paddingY = Sanalika.instance.layerModel.gameLayer.y;
      }
      
      public function processMap(param1:XMLNode) : void
      {
         var _loc2_:XMLNode = null;
         var _loc4_:MapEntry = null;
         var _loc6_:int = 0;
         var _loc3_:Object = null;
         xOrigin = parseInt(param1.attributes["xOrigin"].toString());
         yOrigin = parseInt(param1.attributes["yOrigin"].toString());
         var _loc5_:int = int(param1.childNodes.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.childNodes[_loc6_];
            _loc3_ = {};
            _loc3_.flash = true;
            _loc3_[Sanalika.instance.gameModel.serverName] = true;
            _loc3_["lang" + Sanalika.instance.gameModel.language] = true;
            if(_loc2_.attributes["if"] != null && BooleanEvaluator.evaluate(_loc2_.attributes["if"].toString(),_loc3_) == false)
            {
               trace("delete map entry: " + _loc2_.attributes["if"].toString());
            }
            else if(_loc2_ && _loc2_.nodeType != 3)
            {
               _loc4_ = new MapEntry(_loc2_);
               if(_loc4_.entryType == 8)
               {
                  mapEntries.unshift(_loc4_);
               }
               else
               {
                  mapEntries.push(_loc4_);
               }
            }
            _loc6_++;
         }
      }
      
      public function processGrid() : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc1_:int = 0;
         var _loc4_:Object = null;
         columnsCount = Sanalika.instance.roomModel.gridModel.width;
         rowsCount = Sanalika.instance.roomModel.gridModel.height;
         _loc4_ = {};
         _loc3_ = 0;
         while(_loc3_ < rowsCount)
         {
            _loc2_ = "";
            _loc1_ = 0;
            while(_loc1_ < columnsCount)
            {
               cell = new Cell(_loc1_,_loc3_);
               cell.bit = Sanalika.instance.roomModel.gridModel.getCellValue(_loc1_,_loc3_);
               if(_loc4_[cell.bit] == null)
               {
                  _loc4_[cell.bit] = 0;
               }
               _loc4_[cell.bit] = _loc4_[cell.bit] + 1;
               switch(cell.bit - -1)
               {
                  case 0:
                     cell.cellType = CellType.TYPE_WALK_ONLY;
                     break;
                  case 1:
                  case 3:
                     cell.cellType = CellType.TYPE_EMPTY;
                     break;
                  case 2:
                     cell.cellType = CellType.TYPE_DISABLED;
                     break;
                  case 5:
                     cell.cellType = CellType.TYPE_DIAMOND;
                     break;
                  case 6:
                     cell.cellType = CellType.TYPE_ADMIN;
                     break;
                  case 8:
                     cell.cellType = CellType.TYPE_FISH;
                     break;
                  case 9:
                     cell.cellType = CellType.TYPE_SANALIKAX;
                     break;
                  case 11:
                     cell.cellType = CellType.TYPE_SHORTCUT;
                     break;
                  case 12:
                     cell.cellType = CellType.TYPE_NPC;
                     break;
                  case 13:
                     cell.cellType = CellType.TYPE_STAGE;
                     break;
                  case 14:
                     cell.cellType = CellType.TYPE_FURNITURE_ONLY;
               }
               grid.push(cell);
               _loc2_ += cell.bit + ",";
               _loc1_++;
            }
            _loc3_++;
         }
         try
         {
            ContractLogger.log("grid_cells",{
               "width":columnsCount,
               "height":rowsCount,
               "cellBits":_loc4_
            });
         }
         catch(eG:Error)
         {
         }
      }
      
      public function processBackground() : void
      {
         this.bg = getMovieClip("bg");
         bg.init();
         bgContainer.addChild(bg);
      }
      
      protected function onRoomJoinComplete(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeExtension("roomjoincomplete",onRoomJoinComplete);
         sceneLoaded = true;
         Dispatcher.dispatchEvent(new GameEvent("SCENE_DATA_LOADED"));
         trace("SCENE_DATA_LOADED");
         if(Sanalika.instance.roomModel.key == "street03")
         {
            Tracker.track("ad","joinRoom","fanta",Sanalika.instance.roomModel.key);
         }
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:ISceneProcessDataComponent = getComponent(ISceneProcessDataComponent) as ISceneProcessDataComponent;
         if(_loc2_ != null)
         {
            return _loc2_.getMovieClip(param1);
         }
         return null;
      }
      
      public function translateToGrid(param1:Number, param2:Number) : IntPoint
      {
         var _loc3_:Point = translateStageCoordsTo3DCoords(param1,param2);
         var _loc4_:IntPoint = new IntPoint();
         _loc4_.x = Math.floor(_loc3_.x / 18.07);
         _loc4_.y = Math.floor(_loc3_.y / 18.07);
         return _loc4_;
      }
      
      public function getPosFromGrid(param1:Number, param2:Number) : Point
      {
         return get2dPoint((param1 + 1) * 18.07 - 18.07 / 2,0,(param2 + 1) * 18.07 - 18.07 / 2);
      }
      
      public function get3DPosFromGrid(param1:int, param2:int) : Vector3d
      {
         return new Vector3d((param1 + 1) * 18.07 - 18.07 / 2,0,(param2 + 1) * 18.07 - 18.07 / 2);
      }
      
      public function getScenePositionFromTile(param1:int, param2:int) : Vector3d
      {
         return new Vector3d((param1 + 1) * 18.07 - 18.07 / 2,0,(param2 + 1) * 18.07 - 18.07 / 2);
      }
      
      public function get2dPoint(param1:Number, param2:Number, param3:Number) : Point
      {
         var _loc4_:Point = new Point();
         _loc4_.x = (param1 - param3) * 0.9483255309738488 + xOrigin;
         _loc4_.y = -(param2 + (param1 + param3) * 0.31729905027145594) + yOrigin;
         return _loc4_;
      }
      
      public function screenToCharacter(param1:Number, param2:Number, param3:Boolean = false) : Character
      {
         for each(var _loc4_ in Connectr.instance.engine.scene.characterList)
         {
            if(param1 < _loc4_.container.x && param1 > _loc4_.container.x + _loc4_.container.width && (param2 < _loc4_.container.y && param2 > _loc4_.container.y + _loc4_.container.height))
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getCellTypeByGrid(param1:Number, param2:Number, param3:Number) : int
      {
         var _loc4_:Cell = null;
         if(param1 < 0 || param3 < 0 || param1 >= columnsCount || param3 >= rowsCount)
         {
            return -1;
         }
         _loc4_ = this.grid[param3 * columnsCount + param1];
         return _loc4_.cellType;
      }
      
      public function indicateGrid(param1:int, param2:int, param3:Function) : void
      {
         var point:Point;
         var onCursorClick:*;
         var gridX:int = param1;
         var girdY:int = param2;
         var onClick:Function = param3;
         cell = getCellAt(gridX,0,girdY);
         if(cell != null)
         {
            onCursorClick = function(param1:MouseEvent):void
            {
               cursor.removeEventListener("click",onCursorClick);
               arrow.removeEventListener("click",onCursorClick);
               arrow.visible = false;
               cursor.visible = false;
               onClick();
            };
            point = getPosFromGrid(gridX,girdY);
            arrow.x = point.x;
            arrow.y = point.y - 10;
            arrow.visible = true;
            cursor.visible = true;
            cursor.x = point.x;
            cursor.y = point.y;
            cursor.buttonMode = true;
            cursor.useHandCursor = true;
            cursor.addEventListener("click",onCursorClick);
            arrow.addEventListener("click",onCursorClick);
         }
      }
      
      public function hideCursors() : void
      {
         arrow.visible = false;
         cursor.visible = false;
      }
      
      public function setCellStatus(param1:int, param2:int, param3:Boolean) : void
      {
         cell = getCellAt(param1,0,param2);
         if(cell == null)
         {
            trace("CELL NULL");
         }
         else if(param3)
         {
            cell.cellType = CellType.TYPE_EMPTY;
         }
         else
         {
            cell.cellType = CellType.TYPE_DISABLED;
         }
      }
      
      public function enable() : void
      {
         cursor.visible = arrow.visible = mouseEnabled = true;
         for each(var _loc1_ in components)
         {
            _loc1_.enable();
         }
      }
      
      protected function mouseOut(param1:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      public function disable() : void
      {
         cursor.visible = arrow.visible = mouseEnabled = false;
         for each(var _loc1_ in components)
         {
            _loc1_.disable();
         }
      }
      
      public function translateStageCoordsTo3DCoords(param1:Number, param2:Number) : Point
      {
         var _loc3_:Point = new Point();
         var _loc7_:Number = xOrigin - param1;
         var _loc6_:Number = yOrigin - param2;
         var _loc4_:Number = (_loc7_ / 0.9483255309738488 + _loc6_ / 0.31729905027145594) / 2;
         var _loc5_:Number = (-1 * _loc6_ / 0.31729905027145594 + _loc7_ / 0.9483255309738488) / -2;
         _loc3_.x = _loc5_;
         _loc3_.y = _loc4_;
         return _loc3_;
      }
      
      public function translateToCell(param1:Vector3d) : Cell
      {
         return this.getCellAt(Math.floor(param1.x / 18.07),Math.floor(param1.y / 18.07),Math.floor(param1.z / 18.07));
      }
      
      public function getCellAt(param1:Number, param2:Number, param3:Number) : Cell
      {
         if(param1 < 0 || param3 < 0 || isNaN(param1) || isNaN(param2) || isNaN(param3) || param1 >= columnsCount || param3 >= rowsCount)
         {
            return null;
         }
         return this.grid[param3 * columnsCount + param1];
      }
      
      public function getCellAtPoint(param1:IntPoint) : Cell
      {
         if(grid == null || param1.x >= columnsCount || param1.y >= rowsCount || param1.x < 0 || param1.y < 0)
         {
            return null;
         }
         return this.grid[param1.y * columnsCount + param1.x];
      }
      
      public function getCellAtIsUsing(param1:Number, param2:Number, param3:Number) : Boolean
      {
         if(param1 < 0 || param3 < 0 || param1 >= columnsCount || param3 >= rowsCount)
         {
            return false;
         }
         var _loc4_:Cell = this.grid[param3 * columnsCount + param1];
         return _loc4_.isObjectInUse;
      }
      
      public function getPointAtDir(param1:int, param2:int, param3:int, param4:int) : IntPoint
      {
         var _loc5_:IntPoint = null;
         if(param1 < 0)
         {
            param1 = 8 + param1;
         }
         if(param1 != 8)
         {
            param1 %= 8;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc5_ = new IntPoint(param2 + 1,param4);
               break;
            case 1:
               _loc5_ = new IntPoint(param2 + 1,param4 - 1);
               break;
            case 2:
               _loc5_ = new IntPoint(param2,param4 - 1);
               break;
            case 3:
               _loc5_ = new IntPoint(param2 - 1,param4 - 1);
               break;
            case 4:
               _loc5_ = new IntPoint(param2 - 1,param4);
               break;
            case 5:
               _loc5_ = new IntPoint(param2 - 1,param4 + 1);
               break;
            case 6:
               _loc5_ = new IntPoint(param2,param4 + 1);
               break;
            case 7:
               _loc5_ = new IntPoint(param2 + 1,param4 + 1);
         }
         return _loc5_;
      }
      
      public function dispose() : void
      {
         if(!initialized)
         {
            throw "terminate error";
         }
         initialized = false;
         sceneLoaded = false;
         disposed = true;
         Dispatcher.dispatchEvent(new GameEvent("TERMINATE_PROVISION"));
         for each(var _loc1_ in components)
         {
            _loc1_.dispose();
         }
         components = new Dictionary();
         Sanalika.instance.serviceModel.removeExtension("roomjoincomplete",onRoomJoinComplete);
         Sanalika.instance.stage.removeEventListener("enterFrame",enterFrameOperations);
         Dispatcher.removeEventListener("RESIZE",onCanvasResize);
         disable();
         columnsCount = 0;
         rowsCount = 0;
         for each(cell in grid)
         {
            cell.dispose();
         }
         for each(var _loc2_ in mapEntries)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
         for each(var _loc3_ in sceneElements)
         {
            _loc3_.dispose();
         }
         if(bg)
         {
            bg.dispose();
            bg = null;
         }
         xBase = 0;
         yBase = 0;
         bgContainer.x = xBase;
         bgContainer.y = yBase;
         speechContainer.x = xBase;
         speechContainer.y = yBase;
         bgContainer.removeChildren();
         trace("GameEvent.TERMINATE_SCENE");
         Dispatcher.dispatchEvent(new GameEvent("TERMINATE_SCENE"));
      }
   }
}

