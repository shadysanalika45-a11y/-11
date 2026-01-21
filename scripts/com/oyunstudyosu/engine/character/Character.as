package com.oyunstudyosu.engine.character
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.auth.Permission;
   import com.oyunstudyosu.chat.SpeechBalloon;
   import com.oyunstudyosu.cloth.ClothData;
   import com.oyunstudyosu.cloth.ClothType;
   import com.oyunstudyosu.cloth.InventoryItemData;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.CellType;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.engine.core.objects.EntryObject;
   import com.oyunstudyosu.engine.path.AStar;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.pool.model.GamePoolModel;
   import com.oyunstudyosu.enums.CharacterState;
   import com.oyunstudyosu.enums.ItemType;
   import com.oyunstudyosu.events.CellEvent;
   import com.oyunstudyosu.events.CharacterEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.PackItemEvent;
   import com.oyunstudyosu.events.PoolEvent;
   import com.oyunstudyosu.events.WalkEvent;
   import com.oyunstudyosu.debug.ContractLogger;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   import com.oyunstudyosu.utils.StringUtil;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import org.oyunstudyosu.assets.clips.Ghost;
   import org.oyunstudyosu.assets.clips.Typing;
   
   public class Character extends EntryObject implements ICharacter, ISpeechable
   {
      
      private static var HEIGHT:int = -60;
      
      public static const STOPPED:String = "stopped";
      
      public static const STATUS_CHANGED:String = "status_changed";
      
      private var UPDATE_INTERVAL:Number = 0.040160642570281124;
      
      private var MAX_UPDATES_PER_TICK:int = 10;
      
      private var lastTime:Number = -1;
      
      public var _permission:Permission = new Permission();
      
      private var _isSpectator:Boolean;
      
      private var _path:Vector.<IntPoint>;
      
      private var start:int = 0;
      
      private var pathIndis:int;
      
      private var stepX:Number;
      
      private var stepZ:Number;
      
      private var sceneTarget:Vector3d;
      
      private var _lastX:int;
      
      private var _lastY:int;
      
      public var char_TargetDir:int;
      
      public var targetStatus:String;
      
      public var targetChairHeight:Number;
      
      public var targetChairMaskHeight:Number;
      
      public var targetChairAtPoint:IntPoint;
      
      public var speechBalloonContainer:Sprite;
      
      public var targetReachPoint:IntPoint;
      
      public var targetArrivableTile:IntPoint;
      
      public var _action:String;
      
      private var _direction:int;
      
      private var _directionPrev:int;
      
      private var _directionCount:int;
      
      private var _directionLast:int;
      
      public var holdedItemKey:String;
      
      private var _type:int;
      
      private var _gender:String;
      
      public var currentTargetX:int = -1;
      
      public var currentTargetY:int = -1;
      
      private var baseTargetX:int = -1;
      
      private var baseTargetY:int = -1;
      
      private var goingToX:int = -1;
      
      private var goingToY:int = -1;
      
      public var startTileWhileSitting:IntPoint;
      
      private var _isMe:Boolean;
      
      private var lastChat:String;
      
      public var cellBeingUsed:IntPoint;
      
      public var smiley:Smiley;
      
      private var pathLength:int;
      
      private var smileyContainer:MovieClip;
      
      private var typing:MovieClip;
      
      private var targetChairMask:MovieClip;
      
      private var tmpTargetDoor:MovieClip;
      
      private var currentMask:MovieClip;
      
      private var adBotMC:MovieClip;
      
      private var _cachingCompatible:Array;
      
      private var animArray:Array;
      
      private var _invisibleMovieClipList:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var clothWaitingList:Array = [];
      
      private var inventoryWaitingList:Array = [];
      
      private var targetSceneTitle:String;
      
      private var targetScenePrefix:String;
      
      private var targetSceneSrc:String;
      
      private var name:String;
      
      private var speechBalloon:SpeechBalloon;
      
      private var idleData:Array;
      
      private var cacheInitialized:Boolean = false;
      
      private var speechBalloons:Array;
      
      private var exit:Boolean;
      
      private var heightA:String = "|06h36hb2_6|06h36hb2_7|g7yu68yh_9|t6rvecre_10|CzpUZxhf_9|CzpUZxhfm_9|dyk7s52u_9|bwaz4889_9|mh2vigh5_9|uGp8nzkH_9|zDydWmia_9|5r797c48_9|JFxT6Xy3_3|upFUn98T_7|d22VsArn_4|";
      
      private var _platform:String;
      
      private var _forceMove:Boolean;
      
      private var _isDisabled:Boolean;
      
      private var _isNPC:Boolean = false;
      
      private var _status:String;
      
      private var _bodyParts:Array;
      
      private var _gameZoneId:String = "";
      
      private var _targetDoor:MovieClip;
      
      private var _bit:int = 1;
      
      private var _tp:int;
      
      private var problemState:Boolean;
      
      private var _avatarSize:Number = 1;
      
      private var _avatarName:String;
      
      private var nextTargetTile:IntPoint;
      
      private var _speed:Number = 1;
      
      private var _hide:Boolean;
      
      private var isMoving:Boolean;
      
      public function Character()
      {
         super();
      }
      
      public function get permission() : Permission
      {
         return _permission;
      }
      
      public function get isSpectator() : Boolean
      {
         return _isSpectator;
      }
      
      public function set isSpectator(param1:Boolean) : void
      {
         _isSpectator = param1;
      }
      
      public function get path() : Vector.<IntPoint>
      {
         return _path;
      }
      
      public function set path(param1:Vector.<IntPoint>) : void
      {
         _path = param1;
         if(param1 == null)
         {
            container.removeEventListener("enterFrame",onUpdateEvent);
         }
         else
         {
            if(container.hasEventListener("enterFrame"))
            {
               return;
            }
            start = getTimer();
            lastTime = -1;
            container.addEventListener("enterFrame",onUpdateEvent);
         }
      }
      
      public function addCachingCompatibleItem(param1:String, param2:Boolean) : void
      {
         _cachingCompatible[param1] = param2;
      }
      
      public function isCachingCompatible(param1:String) : *
      {
         return _cachingCompatible[param1];
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function set action(param1:String) : void
      {
         _action = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get height() : int
      {
         return HEIGHT;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function init(param1:String, param2:IScene, param3:int, param4:String, param5:Array) : void
      {
         create(null,null,param2 as IsoScene);
         super.initEntry(param1,param2);
         this.type = param3;
         this.sex = param4;
         this.setAccesory(param5);
         speechBalloons = [];
         speechBalloonContainer = new Sprite();
         param2.speechContainer.addChild(speechBalloonContainer);
         idleData = [];
         fill(container);
         add2Scene();
         update();
      }
      
      public function get platform() : String
      {
         return _platform;
      }
      
      public function set platform(param1:String) : void
      {
         if(_platform == param1)
         {
            return;
         }
         _platform = param1;
      }
      
      public function get forceMove() : Boolean
      {
         return _forceMove;
      }
      
      public function set forceMove(param1:Boolean) : void
      {
         if(_forceMove == param1)
         {
            return;
         }
         _forceMove = param1;
      }
      
      public function get isDisabled() : Boolean
      {
         return _isDisabled;
      }
      
      public function set isDisabled(param1:Boolean) : void
      {
         if(_isDisabled == param1)
         {
            return;
         }
         _isDisabled = param1;
      }
      
      public function get isNPC() : Boolean
      {
         return _isNPC;
      }
      
      public function set isNPC(param1:Boolean) : void
      {
         if(_isNPC == param1)
         {
            return;
         }
         _isNPC = param1;
      }
      
      public function get status() : String
      {
         return _status;
      }
      
      public function set status(param1:String) : void
      {
         if(_status == param1)
         {
            return;
         }
         _status = param1;
      }
      
      public function get bodyParts() : Array
      {
         return _bodyParts;
      }
      
      public function set bodyParts(param1:Array) : void
      {
         if(_bodyParts == param1)
         {
            return;
         }
         _bodyParts = param1;
      }
      
      public function get gameZoneId() : String
      {
         return _gameZoneId;
      }
      
      public function set gameZoneId(param1:String) : void
      {
         if(_gameZoneId == param1)
         {
            return;
         }
         _gameZoneId = param1;
      }
      
      public function get targetDoor() : MovieClip
      {
         return _targetDoor;
      }
      
      public function set targetDoor(param1:MovieClip) : void
      {
         if(_targetDoor == param1)
         {
            return;
         }
         _targetDoor = param1;
      }
      
      public function get bit() : int
      {
         return _bit;
      }
      
      public function set bit(param1:int) : void
      {
         if(_bit == param1)
         {
            return;
         }
         _bit = param1;
      }
      
      public function get tp() : int
      {
         return _tp;
      }
      
      public function set tp(param1:int) : void
      {
         if(_tp == param1)
         {
            return;
         }
         _tp = param1;
         if(typing && container.contains(typing) && param1 == 0)
         {
            typing.gotoAndPlay("explode");
            return;
         }
         if(!typing)
         {
            typing = new Typing();
            typing.y = HEIGHT;
            container.addChild(typing);
         }
         else
         {
            typing.gotoAndPlay("start");
         }
         if(smileyContainer)
         {
            typing.y = HEIGHT - 20;
         }
      }
      
      public function get sex() : String
      {
         return _gender;
      }
      
      public function set sex(param1:String) : void
      {
         _gender = param1;
      }
      
      public function get last_y() : int
      {
         return _lastY;
      }
      
      public function set last_y(param1:int) : void
      {
         _lastY = param1;
      }
      
      public function get last_x() : int
      {
         return _lastX;
      }
      
      public function set last_x(param1:int) : void
      {
         _lastX = param1;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(param1 < 1 || param1 > 8)
         {
            param1 = 1;
         }
         _direction = param1;
      }
      
      public function get isMe() : Boolean
      {
         return _isMe;
      }
      
      public function set isMe(param1:Boolean) : void
      {
         _isMe = param1;
      }
      
      public function get visible() : Boolean
      {
         return container.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(speechBalloonContainer != null)
         {
            speechBalloonContainer.visible = param1;
         }
         container.visible = param1;
      }
      
      public function get avatarSize() : Number
      {
         return _avatarSize;
      }
      
      public function set avatarSize(param1:Number) : void
      {
         if(_avatarSize == param1)
         {
            return;
         }
         _avatarSize = param1;
         avatarScale();
      }
      
      public function avatarScale() : void
      {
         if(container)
         {
            container.scaleX = avatarSize;
            container.scaleY = avatarSize;
         }
      }
      
      public function glooo() : void
      {
      }
      
      public function get avatarName() : String
      {
         return _avatarName;
      }
      
      public function set avatarName(param1:String) : void
      {
         if(_avatarName == param1)
         {
            return;
         }
         param1 = StringUtil.wrapHtmlTags(param1);
         _avatarName = param1;
      }
      
      override public function add2Scene() : void
      {
         super.add2Scene();
         pathIndis = 0;
         if(type == 0)
         {
            status = "i";
            setStatus(_status,3);
         }
      }
      
      public function setSmileyHeight() : void
      {
         HEIGHT = -60;
         if(heightA.indexOf("|" + bodyParts[0] + "|") > -1)
         {
            HEIGHT = -120;
         }
         if(smileyContainer)
         {
            smileyContainer.y = HEIGHT;
         }
      }
      
      public function setAccesory(param1:Array) : void
      {
         var _loc2_:ClothData = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         if(param1 == null)
         {
            return;
         }
         this.bodyParts = [];
         var _loc4_:Array = [];
         _loc5_ = [];
         _loc6_ = [];
         for each(var _loc3_ in param1)
         {
            _loc2_ = Sanalika.instance.itemModel.getCloth(sex + "_" + _loc3_);
            if(_loc2_ == null || _loc4_.indexOf(_loc2_.placeBit) != -1)
            {
               trace("PlaceBit values override");
               if(_loc2_ == null)
               {
                  _loc6_.push(_loc3_);
               }
            }
            else
            {
               _loc4_.push(_loc2_.placeBit);
               this.bodyParts.push(_loc3_);
               _loc5_.push({
                  "key":_loc3_,
                  "placeBit":_loc2_.placeBit,
                  "placeBitIndexes":_loc2_.placeBitIndexes,
                  "maxPlaceBitIndex":_loc2_.maxPlaceBitIndex
               });
            }
         }
         try
         {
            ContractLogger.log("clothes_apply",{
               "avatarId":this.id,
               "gender":sex,
               "clothes":param1,
               "resolved":_loc5_,
               "missing":_loc6_
            });
         }
         catch(eC:Error)
         {
         }
         fill(container);
         patchClothSystem4HandItem();
         setStatus(_status,_direction);
         setSmileyHeight();
         updateMask();
      }
      
      public function fill(param1:Sprite, param2:Boolean = true) : void
      {
         if(type == 0)
         {
            Sanalika.instance.itemModel.addItemListener(packEventFunction);
            drawCharNormal(param1);
         }
      }
      
      private function clearContainer(param1:Sprite) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
         if(speechBalloon)
         {
            container.addChild(speechBalloon);
         }
      }
      
      private function addElement2ClothWaitingList(param1:String) : void
      {
         var _loc2_:int = int(clothWaitingList.indexOf(param1));
         if(_loc2_ < 0)
         {
            clothWaitingList.push(param1);
         }
      }
      
      private function removeElement2ClothWaitingList(param1:String) : void
      {
         var _loc2_:int = int(clothWaitingList.indexOf(param1));
         if(_loc2_ >= 0)
         {
            clothWaitingList.splice(_loc2_,1);
         }
      }
      
      public function addElement2InventoryWaitingList(param1:String) : void
      {
         var _loc2_:int = int(inventoryWaitingList.indexOf(param1));
         if(_loc2_ < 0)
         {
            inventoryWaitingList.push(param1);
         }
      }
      
      private function removeElement2InventoryWaitingList(param1:String) : void
      {
         var _loc2_:int = int(inventoryWaitingList.indexOf(param1));
         if(_loc2_ >= 0)
         {
            inventoryWaitingList.splice(_loc2_,1);
         }
      }
      
      private function packEventFunction(param1:PackItemEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.isClothItem)
         {
            _loc2_ = int(clothWaitingList.indexOf(param1.key));
            if(_loc2_ < 0)
            {
               return;
            }
            clothWaitingList.splice(_loc2_,1);
            if(clothWaitingList.length > 0)
            {
               return;
            }
            drawCharNormal(container);
            patchClothSystem4HandItem();
         }
         else
         {
            _loc2_ = int(inventoryWaitingList.indexOf(param1.key));
            if(_loc2_ < 0)
            {
               return;
            }
            inventoryWaitingList.splice(_loc2_,1);
            if(inventoryWaitingList.length > 0)
            {
               return;
            }
            patchClothSystem4HandItem();
         }
         setStatus(_status,_direction);
         updateMask();
      }
      
      public function drawCharWithoutDrawTest(param1:Sprite) : void
      {
         var _loc12_:int = 0;
         var _loc3_:ClothData = null;
         var _loc7_:ClothData = null;
         var _loc9_:ClothData = null;
         var _loc4_:MovieClip = null;
         var _loc11_:Array = [];
         var _loc8_:* = -1;
         var _loc2_:* = -1;
         var _loc6_:int = int(bodyParts.length);
         _loc12_ = 0;
         while(_loc12_ < _loc6_)
         {
            _loc3_ = Sanalika.instance.itemModel.getCloth(sex + "_" + bodyParts[_loc12_]);
            if(_loc3_ != null)
            {
               if(_loc3_.placeBit == ClothType.BIT17_HAIR)
               {
                  _loc2_ = _loc12_;
               }
               if(_loc3_.placeBit == ClothType.BIT20_HAT)
               {
                  _loc8_ = _loc12_;
               }
               _loc11_.push(_loc3_);
            }
            _loc12_++;
         }
         if(_loc8_ != -1 && _loc2_ != -1)
         {
            _loc7_ = _loc11_[_loc2_];
            if(_loc7_)
            {
               _loc9_ = Sanalika.instance.itemModel.getCloth(sex + "_84_" + _loc7_.color);
               if(_loc9_)
               {
                  _loc11_[_loc2_] = _loc9_;
               }
            }
         }
         var _loc5_:int = int(_loc11_.length);
         clearContainer(param1);
         var _loc10_:Array = [];
         _loc12_ = 0;
         while(_loc12_ < _loc5_)
         {
            _loc3_ = _loc11_[_loc12_];
            _loc4_ = Sanalika.instance.itemModel.getClothMovieClip(_loc3_.key);
            _loc4_.clip = _loc3_.key;
            _loc4_.placeBit = _loc3_.placeBit;
            _loc4_.maxPlaceBit = _loc3_.maxPlaceBitIndex;
            _loc4_.frameBit = _loc3_.states;
            if((_loc4_.frameBit & 0x0100) > 0)
            {
               _loc4_.addEventListener("idle",setIdle);
            }
            _loc4_.mouseEnabled = false;
            _loc4_.mouseChildren = false;
            param1.addChild(_loc4_);
            _loc12_++;
         }
      }
      
      private function drawCharNormal(param1:Sprite) : void
      {
         var _loc10_:int = 0;
         var _loc3_:ClothData = null;
         var _loc6_:ClothData = null;
         var _loc8_:ClothData = null;
         var _loc14_:Boolean = false;
         var _loc13_:MovieClip = null;
         var _loc5_:Ghost = null;
         var _loc11_:MovieClip = null;
         var _loc15_:Array = [];
         var _loc7_:* = -1;
         var _loc2_:* = -1;
         var _loc4_:int = int(bodyParts.length);
         _loc10_ = 0;
         while(_loc10_ < _loc4_)
         {
            _loc3_ = Sanalika.instance.itemModel.getCloth(sex + "_" + bodyParts[_loc10_]);
            if(_loc3_ != null)
            {
               if(_loc3_.placeBit == ClothType.BIT17_HAIR)
               {
                  _loc2_ = _loc10_;
               }
               if(_loc3_.placeBit == ClothType.BIT20_HAT)
               {
                  _loc7_ = _loc10_;
               }
               _loc15_.push(_loc3_);
            }
            _loc10_++;
         }
         if(_loc7_ != -1 && _loc2_ != -1)
         {
            _loc6_ = _loc15_[_loc2_];
            if(_loc6_)
            {
               _loc8_ = Sanalika.instance.itemModel.getCloth(sex + "_84_" + _loc6_.color);
               if(_loc8_)
               {
                  _loc15_[_loc2_] = _loc8_;
               }
            }
         }
         var _loc12_:int = int(_loc15_.length);
         _loc10_ = 0;
         while(_loc10_ < _loc12_)
         {
            _loc3_ = _loc15_[_loc10_];
            _loc13_ = Sanalika.instance.itemModel.getClothMovieClip(_loc3_.key);
            if(_loc13_ == null)
            {
               _loc14_ = true;
               addElement2ClothWaitingList(_loc3_.key);
            }
            _loc10_++;
         }
         if(_loc14_)
         {
            if(param1.numChildren == 0)
            {
               _loc5_ = new Ghost();
               _loc5_.placeBit = 134217727;
               _loc5_.maxPlaceBit = 26;
               _loc5_.frameBit = 127;
               param1.addChild(_loc5_);
            }
            return;
         }
         clearContainer(param1);
         var _loc9_:Array = [];
         _loc10_ = 0;
         while(_loc10_ < _loc12_)
         {
            _loc3_ = _loc15_[_loc10_];
            _loc11_ = Sanalika.instance.itemModel.getClothMovieClip(_loc3_.key);
            _loc11_.clip = _loc3_.key;
            _loc11_.placeBit = _loc3_.placeBit;
            _loc11_.maxPlaceBit = _loc3_.maxPlaceBitIndex;
            _loc11_.frameBit = _loc3_.states;
            if((_loc11_.frameBit & 0x0100) > 0)
            {
               _loc11_.addEventListener("idle",setIdle);
            }
            _loc11_.mouseEnabled = false;
            _loc11_.mouseChildren = false;
            param1.addChild(_loc11_);
            _loc10_++;
         }
         if(smileyContainer)
         {
            container.addChild(smileyContainer);
         }
         setSmileyHeight();
         disposeCachedChar();
         cacheInitialized = false;
         _cachingCompatible = [];
         _invisibleMovieClipList = new Vector.<MovieClip>();
         setTimeout(cacheChar,2000,true);
      }
      
      private function disposeCachedChar() : void
      {
         for each(var _loc1_ in idleData)
         {
            try
            {
               _loc1_.bitmapData.dispose();
            }
            catch(e:Error)
            {
            }
         }
         idleData = [];
      }
      
      private function cacheChar(param1:Boolean = false) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = undefined;
         var _loc10_:int = 0;
         _loc3_ = null;
         var _loc8_:String = null;
         var _loc2_:* = false;
         var _loc4_:String = null;
         var _loc9_:Bitmap = null;
         var _loc5_:* = undefined;
         _loc10_ = 0;
         _loc3_ = undefined;
         var _loc6_:SimpleCachedCharacterClip = null;
         if(container == null)
         {
            return;
         }
         _loc7_ = 0;
         while(_loc7_ < container.numChildren)
         {
            _loc3_ = container.getChildAt(_loc7_);
            if(_loc3_ is SimpleCachedCharacterClip)
            {
               _loc6_ = _loc3_ as SimpleCachedCharacterClip;
            }
            _loc7_++;
         }
         if(_loc6_)
         {
            container.removeChild(_loc6_);
         }
         _loc10_ = 0;
         while(_loc10_ < _invisibleMovieClipList.length)
         {
            _loc3_ = _invisibleMovieClipList[_loc10_];
            container.addChildAt(_loc3_,_loc10_);
            _loc10_++;
         }
         _invisibleMovieClipList = new Vector.<MovieClip>();
         if(param1 == false && cacheInitialized == false)
         {
            return;
         }
         cacheInitialized = true;
         if(status != "i" && status != "s")
         {
            return;
         }
         try
         {
            _loc8_ = status + direction;
            _loc2_ = getHandItem() != null;
            _loc4_ = _loc8_ + (_loc2_ ? "1" : "0");
            if(!IdleCacher.check(this,_loc8_))
            {
               trace("Clothes incompatible!");
               throw new Error("Clothes incompatible!");
            }
            _loc9_ = idleData[_loc4_];
            if(_loc9_ == null)
            {
               _loc9_ = IdleCacher.cache(this,_loc8_,_loc2_);
               idleData[_loc4_] = _loc9_;
            }
            if(_loc9_ != null)
            {
               container.addChildAt(_loc9_,0);
               _loc5_ = new Vector.<MovieClip>();
               _loc10_ = 0;
               while(_loc10_ < container.numChildren)
               {
                  _loc3_ = container.getChildAt(_loc10_);
                  if(_loc3_.hasOwnProperty("placeBit") && _loc3_.placeBit != ClothType.BIT22_HANDITEM)
                  {
                     _loc5_.push(_loc3_);
                  }
                  _loc10_++;
               }
               for each(_loc3_ in _loc5_)
               {
                  _invisibleMovieClipList.push(_loc3_);
                  container.removeChild(_loc3_);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function setIdle(param1:Event) : void
      {
         setAction("i");
      }
      
      public function hasActionFrame() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:ClothData = null;
         var _loc2_:int = int(bodyParts.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = Sanalika.instance.itemModel.getCloth(sex + "_" + bodyParts[_loc3_]);
            if(_loc1_ == null)
            {
               return false;
            }
            if((_loc1_.states & 0x0100) > 0)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function hasDanceFrame() : Boolean
      {
         var _loc3_:int = 0;
         var _loc1_:ClothData = null;
         var _loc2_:int = int(bodyParts.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = Sanalika.instance.itemModel.getCloth(sex + "_" + bodyParts[_loc3_]);
            if(_loc1_ == null)
            {
               return false;
            }
            if((_loc1_.states & 0x40) == 0)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function terminate(param1:Boolean = true) : void
      {
         var _loc2_:SpeechBalloon = null;
         var _loc4_:int = 0;
         var _loc3_:DisplayObject = null;
         if(type == 0)
         {
            Sanalika.instance.itemModel.removeItemListener(packEventFunction);
         }
         scene.gridManager.removeCharFromNumberedCharArray(numberedCharArrayIndex,this);
         scene.elementsContainer.removeChild(container);
         _loc4_ = 0;
         while(_loc4_ < speechBalloons.length)
         {
            _loc2_ = speechBalloons[_loc4_];
            if(_loc2_ && scene.speechBalloons.indexOf(_loc2_) > -1)
            {
               _loc2_.removeEventListener("disappeared",speechBalloonDisappeared);
               scene.speechBalloons.splice(Sanalika.instance.engine.scene.speechBalloons.indexOf(_loc2_),1);
               _loc2_.dispose();
               _loc2_ = null;
            }
            _loc4_++;
         }
         speechBalloonContainer.removeChildren();
         if(scene.speechContainer.contains(speechBalloonContainer))
         {
            scene.speechContainer.removeChild(speechBalloonContainer);
         }
         speechBalloons = [];
         inventoryWaitingList = [];
         animArray = [];
         clothWaitingList = [];
         action = status = holdedItemKey = targetStatus = null;
         if(adBotMC)
         {
            adBotMC.removeChildren();
         }
         adBotMC = null;
         targetDoor = null;
         if(smileyContainer)
         {
            smileyContainer.removeChildren();
         }
         tmpTargetDoor = null;
         if(currentMask)
         {
            currentMask.removeChildren();
         }
         currentMask = null;
         if(targetChairMask)
         {
            targetChairMask.removeChildren();
         }
         targetChairMask = null;
         currentTargetX = -1;
         currentTargetY = -1;
         baseTargetX = -1;
         baseTargetY = -1;
         goingToX = -1;
         goingToY = -1;
         disposeCachedChar();
         if(cell != null)
         {
            cell.isObjectInUse = false;
         }
         if(cellBeingUsed != null && scene.getCellAtPoint(cellBeingUsed) != null)
         {
            scene.getCellAtPoint(cellBeingUsed).isObjectInUse = false;
         }
         path = null;
         _loc4_ = 0;
         while(_loc4_ < container.numChildren)
         {
            _loc3_ = container.getChildAt(_loc4_);
            if(_loc3_ is MovieClip)
            {
               (_loc3_ as MovieClip).stop();
            }
            _loc4_++;
         }
         container.removeChildren();
         bodyParts.splice(0);
         bodyParts = null;
         this.dispose();
      }
      
      public function talk(param1:String, param2:int = 1, param3:Number = 1, param4:Boolean = true) : void
      {
         var _loc7_:* = null;
         var _loc6_:GamePool = null;
         if(!scene.speechBalloonsEnabled)
         {
            return;
         }
         lastChat = param1;
         var _loc5_:int = 0;
         var _loc8_:int = HEIGHT;
         if(uncheckedSpeechBalloonLength() > 2)
         {
            for each(speechBalloon in speechBalloons)
            {
               if(!speechBalloon.isChecked)
               {
                  speechBalloon.completeDelay();
                  break;
               }
            }
         }
         speechBalloon = new SpeechBalloon();
         speechBalloon.setType(param2,this,param4);
         speechBalloon.initUI(_loc5_,_loc8_,canvasPosition,avatarName.length > 12 ? avatarName.substr(0,9) + ".." : avatarName,param1,param3);
         speechBalloon.addEventListener("disappeared",speechBalloonDisappeared);
         if(status == "gm")
         {
            if(gameZoneId != "")
            {
               try
               {
                  _loc6_ = Sanalika.instance.engine.scene.elementsContainer.getChildByName(gameZoneId) as GamePool;
                  _loc6_.getItemByName(this.id).addChild(speechBalloon);
               }
               catch(error:Error)
               {
                  trace("speach balloon error");
               }
            }
         }
         else
         {
            speechBalloonContainer.addChild(speechBalloon);
            calculateSpeechBalloonContainerPosition();
         }
         SpeechBalloon.updateIntersectingSpeechBalloons(speechBalloon.getRect(scene.container));
         scene.speechBalloons.push(speechBalloon);
         speechBalloons.push(speechBalloon);
      }
      
      private function uncheckedSpeechBalloonLength() : int
      {
         var _loc1_:int = 0;
         for each(speechBalloon in speechBalloons)
         {
            if(!speechBalloon.isChecked)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function speechBalloonDisappeared(param1:Event) : void
      {
         if(scene == null)
         {
            return;
         }
         var _loc2_:SpeechBalloon = SpeechBalloon(param1.target);
         if(_loc2_ && scene.speechBalloons.indexOf(_loc2_) > -1)
         {
            _loc2_.removeEventListener("disappeared",speechBalloonDisappeared);
            scene.speechBalloons.splice(scene.speechBalloons.indexOf(_loc2_),1);
            speechBalloons.splice(speechBalloons.indexOf(_loc2_),1);
            _loc2_ = null;
         }
      }
      
      private function resetTargetPointSettings() : void
      {
         targetDoor = null;
         tmpTargetDoor = null;
         char_TargetDir = 0;
         targetChairAtPoint = null;
         targetStatus = null;
         targetChairMask = null;
         targetArrivableTile = null;
      }
      
      public function walk(param1:int, param2:int, param3:MovieClip = null, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:MapEntry = null;
         var _loc10_:IntPoint = null;
         var _loc14_:MapEntry = null;
         var _loc8_:Boolean = false;
         var _loc7_:Array = null;
         var _loc12_:int = 0;
         var _loc13_:Object = null;
         var _loc11_:int = 0;
         if(currentTile == null)
         {
            return;
         }
         var _loc9_:Cell = scene.getCellAt(param1,0,param2);
         if(_loc9_ == null || !_loc9_.isWalkable(this) && !((_loc9_.sittable || _loc9_.swimmable || _loc9_.usable) && !_loc9_.isObjectInUse))
         {
            return;
         }
         if(speed >= 100)
         {
            if(!reachable(param1,param2))
            {
               return;
            }
            if(param3)
            {
               Sanalika.instance.roomModel.doorModel.useDoorByKey(param3.name);
            }
            defineSteps(new IntPoint(param1,param2));
            reLocate(param1,param2,direction);
            if(isMe)
            {
               screenShifting();
               Sanalika.instance.serviceModel.setUserVariable(["direction"],[direction]);
            }
            return;
         }
         if(_loc9_.parentMapEntry && _loc9_.parentMapEntry.targetCellPoint)
         {
            _loc6_ = _loc9_.parentMapEntry;
            _loc9_ = scene.getCellAt(_loc9_.parentMapEntry.targetCellPoint.x,0,_loc9_.parentMapEntry.targetCellPoint.y);
            _loc9_.cellType = CellType.TYPE_TARGET;
            _loc9_.parentMapEntry = _loc6_;
         }
         baseTargetX = param1;
         baseTargetY = param2;
         goingToX = param1;
         goingToY = param2;
         forceMove = false;
         if(isMe && !isDisabled)
         {
            targetScenePrefix = null;
            targetSceneTitle = null;
            if(this.targetDoor != null)
            {
               this.targetDoor = null;
            }
         }
         if(_loc9_.sittable || _loc9_.swimmable || _loc9_.usable)
         {
            _loc10_ = null;
            if(_loc9_.parentMapEntry.hasReservedGrids)
            {
               _loc14_ = _loc9_.parentMapEntry;
               _loc8_ = false;
               _loc7_ = _loc14_.chairs;
               _loc12_ = int(_loc7_.length);
               _loc11_ = 0;
               while(_loc11_ < _loc12_)
               {
                  _loc13_ = _loc7_[_loc11_];
                  if(currentTile.equals(_loc13_.grid))
                  {
                     return;
                  }
                  if(!scene.getCellAtPoint(_loc13_.grid).isObjectInUse)
                  {
                     _loc8_ = true;
                     _loc9_ = scene.getCellAtPoint(_loc13_.grid);
                     _loc10_ = _loc9_.getFrontPos(scene);
                     trace("HHHHHHHHHHHHHHH");
                     if(_loc10_ == null)
                     {
                        trace("NULLLNULLL");
                        return;
                     }
                     if(!reachable(_loc10_.x,_loc10_.y))
                     {
                        return;
                     }
                     resetTargetPointSettings();
                     action = null;
                     if(isMe)
                     {
                        if(param4)
                        {
                           Sanalika.instance.serviceModel.setUserVariable(["status"],["d"]);
                        }
                        else if(action == "d" || action == "a1")
                        {
                           Sanalika.instance.serviceModel.setUserVariable(["status"],[null]);
                        }
                        action = null;
                     }
                     if(_loc13_.type == "grid")
                     {
                        param1 = int(_loc13_.grid.x);
                        param2 = int(_loc13_.grid.y);
                        goingToX = param1;
                        goingToY = param2;
                        targetArrivableTile = _loc13_.grid.clone();
                     }
                     break;
                  }
                  _loc11_++;
               }
               if(!_loc8_)
               {
                  return;
               }
            }
            else
            {
               _loc10_ = _loc9_.getFrontPos(scene);
               if(_loc10_ == null)
               {
                  return;
               }
               if(!reachable(_loc10_.x,_loc10_.y))
               {
                  return;
               }
            }
            resetTargetPointSettings();
            if(isMe)
            {
               if(param4)
               {
                  Sanalika.instance.serviceModel.setUserVariable(["status"],["d"]);
               }
               else if(param5)
               {
                  Sanalika.instance.serviceModel.setUserVariable(["status"],["a1"]);
               }
               else if(action == "d" || action == "a1")
               {
                  Sanalika.instance.serviceModel.setUserVariable(["status"],[null]);
               }
               action = null;
            }
            param1 = _loc10_.x;
            param2 = _loc10_.y;
            targetArrivableTile = _loc10_.clone();
         }
         else
         {
            if(!reachable(param1,param2))
            {
               return;
            }
            if(isMe)
            {
               if(param4)
               {
                  Sanalika.instance.serviceModel.setUserVariable(["status"],["d"]);
               }
               else if(param5)
               {
                  Sanalika.instance.serviceModel.setUserVariable(["status"],["a1"]);
               }
            }
         }
         targetReachPoint = new IntPoint(param1,param2);
         updateTargetCellSettings(_loc9_);
         tmpTargetDoor = param3;
         currentTargetX = targetReachPoint.x;
         currentTargetY = targetReachPoint.y;
         calculatePath();
         _loc9_ = null;
      }
      
      public function walkRequest(param1:int, param2:int, param3:MovieClip = null) : void
      {
         var _loc4_:* = param3 != null;
         if(_loc4_)
         {
            tmpTargetDoor = param3;
            targetDoor = param3;
         }
         else
         {
            tmpTargetDoor = null;
            targetDoor = null;
         }
         Sanalika.instance.serviceModel.requestData("walkrequest",{
            "x":param1,
            "y":param2,
            "door":_loc4_
         },fakeListener);
      }
      
      private function fakeListener(param1:Object) : void
      {
      }
      
      public function reachable(param1:int, param2:int) : Boolean
      {
         var _loc3_:AStar = new AStar(scene.grid,scene.columnsCount,scene.rowsCount,startTileWhileSitting != null ? startTileWhileSitting : currentTile,new IntPoint(param1,param2),bit);
         return _loc3_.solve(this) != null;
      }
      
      public function updateTargetCellSettings(param1:Cell) : Boolean
      {
         var _loc3_:AlertVo = null;
         var _loc2_:AlertVo = null;
         if(param1.sittable || param1.swimmable || param1.usable)
         {
            if(param1.objectType == 1)
            {
               char_TargetDir = param1.parentMapEntry.dir;
               targetChairAtPoint = new IntPoint(param1.x,param1.y);
               targetStatus = "s";
               targetChairMaskHeight = param1.parentMapEntry.heighInPx - 10;
               targetChairHeight = param1.parentMapEntry.heighInPx - 10;
               targetChairMask = param1.objectMask;
               return true;
            }
            if(param1.objectType == 3)
            {
               char_TargetDir = param1.parentMapEntry.dir;
               targetChairAtPoint = new IntPoint(param1.x,param1.y);
               targetStatus = param1.charAction;
               targetChairMaskHeight = param1.parentMapEntry.heighInPx - 10;
               targetChairHeight = param1.parentMapEntry.heighInPx - 10;
               targetChairMask = param1.objectMask;
               trace("cell.parentMapEntry.objectMask",param1.parentMapEntry.objectMask);
               trace("cell.objectMask",param1.objectMask);
               return true;
            }
            if(param1.objectType == 5)
            {
               char_TargetDir = param1.parentMapEntry.dir;
               targetChairAtPoint = new IntPoint(param1.x,param1.y);
               gameZoneId = param1.parentMapEntry.gameZoneId;
               if(isMe)
               {
                  if(gameZoneId == "iceRink")
                  {
                     if(!GamePoolModel.canskateByCloth())
                     {
                        _loc3_ = new AlertVo();
                        _loc3_.alertType = "Info";
                        _loc3_.description = Sanalika.instance.localizationModel.translate("requiredIceScateCloth");
                        Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
                        return false;
                     }
                  }
                  if(gameZoneId.indexOf("swimPool") > -1)
                  {
                     if(!GamePoolModel.canSwimByCloth())
                     {
                        _loc2_ = new AlertVo();
                        _loc2_.alertType = "Info";
                        _loc2_.description = Sanalika.instance.localizationModel.translate("requiredSwimCloth");
                        Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
                        return false;
                     }
                  }
               }
               targetStatus = "gm";
               return true;
            }
         }
         return false;
      }
      
      public function calculatePath() : void
      {
         targetReachPoint = null;
         scenePosition.y = 0;
         var _loc2_:Boolean = path == null ? true : false;
         var _loc1_:AStar = new AStar(scene.grid,scene.columnsCount,scene.rowsCount,startTileWhileSitting != null ? startTileWhileSitting : currentTile,new IntPoint(currentTargetX,currentTargetY),bit);
         path = _loc1_.solve(this);
         if(path != null)
         {
            if(startTileWhileSitting != null)
            {
               path.push(startTileWhileSitting);
               startTileWhileSitting = null;
            }
            pathIndis = path.length - 1;
            pathLength = pathIndis;
            if(_loc2_ && path.length > 0)
            {
               defineSteps(path[pathIndis]);
            }
         }
         else
         {
            reLocate(currentTargetX,currentTargetY,direction);
         }
         targetDoor = tmpTargetDoor;
      }
      
      private function calculateSpeechBalloonContainerPosition() : void
      {
         var _loc2_:Rectangle = speechBalloonContainer.getBounds(speechBalloonContainer);
         var _loc1_:Number = _loc2_.width / 2;
         if(container.x - _loc1_ <= 0)
         {
            speechBalloonContainer.x = _loc1_;
            speechBalloonContainer.y = container.y;
         }
         else if(Sanalika.instance.roomModel.width < container.x + _loc1_)
         {
            speechBalloonContainer.x = Sanalika.instance.roomModel.width - _loc1_;
            speechBalloonContainer.y = container.y;
         }
         else
         {
            speechBalloonContainer.x = container.x;
            speechBalloonContainer.y = container.y;
         }
      }
      
      private function onUpdateEvent(param1:Event) : void
      {
         var _loc3_:Number = getTimer() / 1000;
         if(lastTime < 0)
         {
            lastTime = _loc3_;
            update();
         }
         var _loc2_:int = 0;
         while(_loc3_ - lastTime > UPDATE_INTERVAL)
         {
            if(_loc2_ >= MAX_UPDATES_PER_TICK)
            {
               lastTime = _loc3_;
               break;
            }
            update();
            lastTime += UPDATE_INTERVAL;
            _loc2_++;
         }
      }
      
      override public function update() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector3d = null;
         var _loc1_:WalkEvent = null;
         if(path == null)
         {
            return;
         }
         if(scenePosition.equals(sceneTarget))
         {
            if(pathIndis <= 0)
            {
               _loc2_ = currentTile.equals(targetArrivableTile);
               if(_loc2_ && targetChairAtPoint != null)
               {
                  if(scene.getCellAtPoint(targetChairAtPoint).isObjectInUse)
                  {
                     targetChairMask = null;
                     targetStatus = null;
                     char_TargetDir = 0;
                  }
                  else
                  {
                     startTileWhileSitting = new IntPoint(currentTile.x,currentTile.y);
                     if(targetStatus != null)
                     {
                        status = targetStatus;
                     }
                     _loc3_ = scene.getScenePositionFromTile(targetChairAtPoint.x,targetChairAtPoint.y);
                     locate(_loc3_.x,_loc3_.y,_loc3_.z);
                  }
               }
               if(_loc2_)
               {
                  updateMaskAndStatus();
                  if(cell.parentMapEntry && cell.parentMapEntry.targetCellPoint)
                  {
                     try
                     {
                        cell.parentMapEntry.clip.gotoAndStop("action");
                     }
                     catch(e:Error)
                     {
                     }
                  }
                  if(CharacterState.FITNESS.indexOf(status) > -1)
                  {
                  }
               }
               else
               {
                  if(char_TargetDir > 0)
                  {
                     _direction = char_TargetDir;
                     char_TargetDir = 0;
                  }
                  setStatus("i",_direction);
               }
               if(isMe)
               {
                  _loc1_ = new WalkEvent("updateWalk");
                  _loc1_.stepCount = pathLength;
                  Dispatcher.dispatchEvent(_loc1_);
                  screenShifting();
                  Sanalika.instance.serviceModel.setUserVariable(["direction"],[this.direction]);
                  if(targetDoor != null)
                  {
                     Sanalika.instance.roomModel.doorModel.useDoorByKey(targetDoor.name);
                  }
               }
               fireStoppedEvents();
               return;
            }
            pathIndis = pathIndis - 1;
            defineSteps(IntPoint(path[pathIndis]));
         }
         locate(scenePosition.x + stepX,scenePosition.y,scenePosition.z + stepZ);
      }
      
      public function get speed() : Number
      {
         return _speed;
      }
      
      public function set speed(param1:Number) : void
      {
         _speed = param1;
      }
      
      public function defineSteps(param1:IntPoint) : void
      {
         if(param1.x < currentTile.x && param1.y > currentTile.y || param1.x > currentTile.x && param1.y < currentTile.y)
         {
            stepX = (param1.x - currentTile.x) * 18.07 / (int(11 / _speed));
            stepZ = (param1.y - currentTile.y) * 18.07 / (int(11 / _speed));
         }
         else
         {
            stepX = (param1.x - currentTile.x) * 18.07 / (int(7 / _speed));
            stepZ = (param1.y - currentTile.y) * 18.07 / (int(7 / _speed));
         }
         if(param1.x > currentTile.x && param1.y == currentTile.y)
         {
            _direction = 1;
         }
         else if(param1.x > currentTile.x && param1.y < currentTile.y)
         {
            _direction = 2;
         }
         else if(param1.x == currentTile.x && param1.y < currentTile.y)
         {
            _direction = 3;
         }
         else if(param1.x < currentTile.x && param1.y < currentTile.y)
         {
            _direction = 4;
         }
         else if(param1.x < currentTile.x && param1.y == currentTile.y)
         {
            _direction = 5;
         }
         else if(param1.x < currentTile.x && param1.y > currentTile.y)
         {
            _direction = 6;
         }
         else if(param1.x == currentTile.x && param1.y > currentTile.y)
         {
            _direction = 7;
         }
         else if(param1.x > currentTile.x && param1.y > currentTile.y)
         {
            _direction = 8;
         }
         setStatus("w",_direction);
         sceneTarget = scene.getScenePositionFromTile(param1.x,param1.y);
      }
      
      public function locate(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:int = 0;
         this.scenePosition = new Vector3d(param1,param2,param3);
         var _loc4_:Cell = this.scene.translateToCell(scenePosition);
         if(_loc4_ == null)
         {
            return;
         }
         if(cell == null || _loc4_ != cell)
         {
            if(currentMask != null)
            {
               if(container.contains(currentMask))
               {
                  container.removeChild(currentMask);
               }
               currentMask = null;
            }
            if(cell != null)
            {
               cell.isObjectInUse = false;
               if(cell.parentMapEntry && cell.parentMapEntry.targetCellPoint)
               {
                  cell.parentMapEntry.clip.gotoAndStop(1);
               }
               if(last_x != _loc4_.posMatrix.x || last_y != _loc4_.posMatrix.y)
               {
                  if(cell.hasEventListener("ON_EXIT"))
                  {
                     cell.dispatchEvent(new CellEvent("ON_EXIT",id));
                  }
               }
            }
            cell = _loc4_;
            if(_loc4_.sittable || _loc4_.usable)
            {
               _loc4_.isObjectInUse = true;
            }
            _loc5_ = scene.gridManager.getAreaNoFromGrid(cell.x,cell.y);
            if(_loc5_ == -1)
            {
               trace(this.avatarName + "\'s newNumberedCharArrayIndex is -1");
            }
            if(status == "s" || _loc4_.isObjectInUse)
            {
               _loc5_++;
            }
            if(numberedCharArrayIndex != _loc5_)
            {
               scene.gridManager.removeCharFromNumberedCharArray(numberedCharArrayIndex,this);
               movedFromBackAreas = _loc5_ > numberedCharArrayIndex;
               numberedCharArrayIndex = _loc5_;
               scene.gridManager.addCharToNumberedCharArray(numberedCharArrayIndex,this);
            }
            this.depth = (scene.rowsCount - cell.y) * scene.columnsCount - cell.x - 1;
            scene.gridManager.setMustBeSortedToNumberedCharArray(numberedCharArrayIndex);
            this.currentTile = _loc4_.posMatrix.clone();
            if(targetReachPoint != null)
            {
               calculatePath();
            }
         }
         this.canvasPosition = scene.get2dPoint(param1,param2,param3);
         if(container != null)
         {
            container.x = canvasPosition.x;
            container.y = canvasPosition.y;
         }
         calculateSpeechBalloonContainerPosition();
         if(currentMask != null && cell != null && cell.parentMapEntry != null)
         {
            if(!cell.parentMapEntry.targetCellPoint)
            {
               currentMask.x = cell.parentMapEntry.center.x - container.x;
               currentMask.y = cell.parentMapEntry.center.y - container.y;
            }
         }
         if(last_x != this.currentTile.x || last_y != this.currentTile.y)
         {
            if(cell.hasEventListener("WALK_OVER"))
            {
               cell.dispatchEvent(new CellEvent("WALK_OVER",id));
            }
            reCalcLastXY();
         }
      }
      
      private function fireStoppedEvents() : void
      {
         baseTargetX = -1;
         baseTargetY = -1;
         currentTargetX = -1;
         currentTargetY = -1;
         goingToX = -1;
         goingToY = -1;
         char_TargetDir = 0;
         targetArrivableTile = null;
         targetChairAtPoint = null;
         targetChairMask = null;
         targetStatus = null;
         nextTargetTile = null;
         path = null;
         if(cell != null)
         {
            if(cell.hasEventListener("ON_ENTER"))
            {
               cell.dispatchEvent(new CellEvent("ON_ENTER",id));
            }
         }
         if(isMe && status == "s")
         {
            Dispatcher.dispatchEvent(new CharacterEvent("CharacterEvent.CHAR_SIT",this));
         }
         Dispatcher.dispatchEvent(new CharacterEvent("CharacterEvent.CHAR_STOPPED",this));
         if(action != null)
         {
            setAction(action);
         }
      }
      
      public function reLocate(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         isMoving = false;
         if(path != null)
         {
            path = null;
            isMoving = true;
         }
         if(goingToX < 0 && goingToY < 0 || goingToX == param1 && goingToY == param2)
         {
            isMoving = false;
         }
         resetTargetPointSettings();
         var _loc6_:Vector3d = scene.getScenePositionFromTile(param1,param2);
         var _loc5_:Cell = scene.getCellAt(param1,0,param2);
         if(_loc5_ != null && _loc5_.parentMapEntry != null && _loc5_.parentMapEntry.heighInPx != 18.07)
         {
            _loc6_.y += _loc5_.parentMapEntry.heighInPx - 10;
         }
         if(_loc5_ == null || _loc5_.parentMapEntry == null && _loc5_.cellType != CellType.TYPE_EMPTY && !_loc5_.isWalkable(this))
         {
            trace("HACK : CELL NULL OR DISABLE: " + this.id + " X[" + param1 + "] Y[" + param2 + "]");
            return;
         }
         locate(_loc6_.x,_loc6_.y,_loc6_.z);
         this.reCalcLastXY();
         if(_loc5_.sittable || _loc5_.usable)
         {
            _loc5_.isObjectInUse = true;
         }
         if(updateTargetCellSettings(_loc5_))
         {
            updateMaskAndStatus();
         }
         else if(!isMoving)
         {
            setStatus("i",param3);
         }
         var _loc7_:int = scene.gridManager.getAreaNoFromGrid(_loc5_.x,_loc5_.y);
         if(status == "s")
         {
            _loc7_++;
         }
         if(numberedCharArrayIndex != _loc7_)
         {
            scene.gridManager.removeCharFromNumberedCharArray(numberedCharArrayIndex,this);
            movedFromBackAreas = _loc7_ > numberedCharArrayIndex;
            numberedCharArrayIndex = _loc7_;
            scene.gridManager.addCharToNumberedCharArray(numberedCharArrayIndex,this);
         }
         this.depth = (scene.rowsCount - _loc5_.y) * scene.columnsCount - _loc5_.x - 1;
         scene.gridManager.setMustBeSortedToNumberedCharArray(numberedCharArrayIndex);
         if(isMoving)
         {
            currentTargetX = -1;
            currentTargetY = -1;
            walk(baseTargetX,baseTargetY,targetDoor);
         }
         else
         {
            fireStoppedEvents();
         }
      }
      
      public function updateMask() : void
      {
         var _loc1_:Cell = null;
         if(status != null)
         {
            if(status != null && (status == "s" || CharacterState.FITNESS.indexOf(status)))
            {
               _loc1_ = scene.getCellAt(last_x,0,last_y);
               if(_loc1_ == null || _loc1_.objectMask == null && (_loc1_.parentMapEntry == null || _loc1_.parentMapEntry.objectMask == null))
               {
                  return;
               }
               targetChairMask = createClip(_loc1_,-10);
               container.addChild(targetChairMask);
               currentMask = targetChairMask;
               targetChairMask = null;
            }
         }
      }
      
      public function createClip(param1:Cell, param2:* = null) : MovieClip
      {
         var _loc3_:MovieClip = null;
         if(currentMask)
         {
            if(container.contains(currentMask))
            {
               container.removeChild(currentMask);
            }
         }
         if(param1.parentMapEntry.objectMask)
         {
            _loc3_ = new param1.parentMapEntry.objectMask.constructor();
         }
         else
         {
            _loc3_ = new param1.objectMask.constructor();
         }
         var _loc4_:MovieClip = new param1.parentMapEntry.clip.constructor();
         var _loc5_:MovieClip = new MovieClip();
         _loc5_.addChild(_loc4_);
         _loc5_.addChild(_loc3_);
         if(param2)
         {
            _loc3_.y = param1.parentMapEntry.heighInPx + param2;
            _loc4_.y = param1.parentMapEntry.heighInPx + param2;
         }
         _loc4_.mask = _loc3_;
         return _loc5_;
      }
      
      public function updateMaskAndStatus() : void
      {
         if(char_TargetDir > 0)
         {
            _direction = char_TargetDir;
            char_TargetDir = 0;
         }
         if(targetChairMask != null)
         {
            targetChairMask = createClip(cell);
            container.addChild(targetChairMask);
            currentMask = targetChairMask;
            targetChairMask = null;
         }
         if(targetStatus != null)
         {
            setStatus(targetStatus,_direction);
            if(targetChairHeight != 0)
            {
               locate(scenePosition.x,targetChairHeight,scenePosition.z);
               targetChairHeight = 0;
            }
            targetStatus = null;
         }
         else
         {
            setStatus("i",_direction);
         }
      }
      
      public function reCalcLastXY() : void
      {
         last_x = this.currentTile.x;
         last_y = this.currentTile.y;
         if(!isMe)
         {
            return;
         }
         if(scene.hasEventListener("myCharMoved"))
         {
            scene.dispatchEvent(new Event("myCharMoved"));
         }
      }
      
      public function getLastXY() : IntPoint
      {
         return new IntPoint(last_x,last_y);
      }
      
      public function getSmiley() : String
      {
         if(smiley)
         {
            return smiley.key;
         }
         return "";
      }
      
      public function setSmiley(param1:String) : void
      {
         var _loc2_:Smiley = null;
         if(param1 == null || param1 == "")
         {
            return;
         }
         if(param1 != "empty")
         {
            _loc2_ = new Smiley(param1);
         }
         if(smileyContainer != null && container.contains(smileyContainer))
         {
            container.removeChild(smileyContainer);
            smileyContainer = null;
         }
         if(_loc2_ == null)
         {
            return;
         }
         smileyContainer = new MovieClip();
         smileyContainer.addChild(_loc2_);
         this.smiley = _loc2_;
         smileyContainer.y = HEIGHT;
         container.addChild(smileyContainer);
      }
      
      public function setAction(param1:String) : void
      {
         var _loc2_:int = 0;
         trace("setAction():newAction[" + param1 + "]:ME[" + Sanalika.instance.avatarModel.avatarName + "] ID[" + id + "]");
         if(gameZoneId != "")
         {
            removeFromPool();
         }
         if(param1 == "d")
         {
            if(status == "s")
            {
               if(startTileWhileSitting != null)
               {
                  walk(startTileWhileSitting.x,startTileWhileSitting.y,null,true);
               }
            }
            else if(status != "w")
            {
               _loc2_ = _direction <= 4 ? 3 : 5;
               setStatus("d",_loc2_);
               if(isMe)
               {
                  Sanalika.instance.serviceModel.setUserVariable(["direction"],[_loc2_]);
               }
            }
            this.action = param1;
         }
         else if(param1 == "a1")
         {
            if(status == "s")
            {
               if(isMe)
               {
                  walk(startTileWhileSitting.x,startTileWhileSitting.y,null,false,true);
               }
            }
            else if(status != "w")
            {
               setStatus("a1",_direction <= 4 ? 3 : 5);
            }
            this.action = param1;
         }
         else if(param1 == "gm")
         {
            if(!isMe)
            {
               setStatus("gm",_direction);
            }
         }
         else if(status != "w")
         {
            setStatus(param1,_direction);
         }
      }
      
      public function getAction() : String
      {
         return this.action;
      }
      
      public function urgentUpdate4Item(param1:PackItemEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc2_:Class = null;
         var _loc4_:MovieClip = null;
         _loc5_ = 0;
         while(_loc5_ < container.numChildren)
         {
            try
            {
               _loc3_ = MovieClip(container.getChildAt(_loc5_));
               if(_loc3_.clip != null)
               {
                  if(_loc3_.clip == param1.key)
                  {
                     container.removeChildAt(_loc5_);
                     _loc2_ = Sanalika.instance.itemModel.getClass(param1.key);
                     _loc4_ = new _loc2_();
                     _loc4_.clip = _loc3_.clip;
                     _loc4_.placeBit = _loc3_.placeBit;
                     _loc4_.maxPlaceBit = _loc3_.maxPlaceBit;
                     _loc4_.frameBit = _loc3_.frameBit;
                     _loc4_.gotoAndStop(_loc3_.currentFrame);
                     container.addChild(_loc4_);
                     container.setChildIndex(_loc4_,_loc5_);
                     _loc6_ = true;
                     break;
                  }
               }
            }
            catch(error:Error)
            {
               break;
            }
            _loc5_++;
         }
         if(_loc6_ && status == "d")
         {
            setStatus("i",_direction);
            setStatus("d",_direction);
         }
         else if(_loc6_ && status == "a1")
         {
            setStatus("i",_direction);
            setStatus("a1",_direction);
         }
      }
      
      public function getHandItem() : MovieClip
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(!container)
         {
            return null;
         }
         _loc2_ = 0;
         while(_loc2_ < container.numChildren)
         {
            _loc1_ = container.getChildAt(_loc2_);
            if(_loc1_.hasOwnProperty("placeBit"))
            {
               if(_loc1_.placeBit == ClothType.BIT22_HANDITEM && _loc1_.maxPlaceBit == 22)
               {
                  return _loc1_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      private function patchClothSystem4HandItem() : void
      {
         var _loc7_:int = 0;
         var _loc1_:String = null;
         var _loc3_:String = null;
         if(isMe)
         {
            _loc3_ = Sanalika.instance.avatarModel.holdedItem;
         }
         else
         {
            _loc3_ = holdedItemKey;
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc8_:InventoryItemData = Sanalika.instance.itemModel.getItem(sex + "_" + _loc3_);
         if(_loc8_ == null)
         {
            return;
         }
         var _loc4_:MovieClip = Sanalika.instance.itemModel.getItemMovieClip(_loc8_.clip);
         if(_loc4_ == null)
         {
            addElement2InventoryWaitingList(_loc8_.clip);
            return;
         }
         _loc4_.clip = _loc8_.clip;
         _loc4_.placeBit = ClothType.BIT22_HANDITEM;
         _loc4_.maxPlaceBit = 22;
         _loc4_.frameBit = 127;
         container.addChild(_loc4_);
         var _loc2_:* = null;
         var _loc5_:* = 0;
         _loc7_ = 0;
         while(_loc7_ < container.numChildren)
         {
            _loc2_ = container.getChildAt(_loc7_);
            if(_loc2_.hasOwnProperty("placeBit"))
            {
               if(_loc2_.maxPlaceBit < 22)
               {
                  _loc5_ = _loc7_;
               }
            }
            _loc7_++;
         }
         if(_loc5_ != 0)
         {
            container.setChildIndex(_loc4_,_loc5_ + 1);
         }
         var _loc6_:int = _loc8_.itemType;
         if(status == "d" && ItemType.isItemVisibleDance(_loc6_))
         {
            _loc1_ = status;
            setStatus("i",_direction);
            status = _loc1_;
         }
      }
      
      public function canIUseHandItem() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = null;
         _loc2_ = 0;
         _loc1_ = null;
         _loc2_ = 0;
         while(_loc2_ < container.numChildren)
         {
            if(!(!container.getChildAt(_loc2_) is MovieClip || container.getChildAt(_loc2_) is SimpleCachedCharacterClip))
            {
               _loc1_ = MovieClip(container.getChildAt(_loc2_));
               if(_loc1_.hasOwnProperty("placeBit"))
               {
                  if((_loc1_.placeBit & ClothType.BIT22_HANDITEM) > 0 && _loc1_.placeBit != ClothType.BIT22_HANDITEM)
                  {
                     return false;
                  }
               }
            }
            _loc2_++;
         }
         if(_invisibleMovieClipList != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _invisibleMovieClipList.length)
            {
               if(!(!_invisibleMovieClipList[_loc2_] is MovieClip || _invisibleMovieClipList[_loc2_] is SimpleCachedCharacterClip))
               {
                  _loc1_ = MovieClip(_invisibleMovieClipList[_loc2_]);
                  if(_loc1_.hasOwnProperty("placeBit"))
                  {
                     if((_loc1_.placeBit & ClothType.BIT22_HANDITEM) > 0 && _loc1_.placeBit != ClothType.BIT22_HANDITEM)
                     {
                        return false;
                     }
                  }
               }
               _loc2_++;
            }
         }
         return true;
      }
      
      public function removeHandItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = undefined;
         var _loc2_:String = null;
         _loc2_ = holdedItemKey;
         if(_loc2_ != null)
         {
            removeElement2InventoryWaitingList(_loc2_);
         }
         _loc3_ = 0;
         while(_loc3_ < container.numChildren)
         {
            _loc1_ = container.getChildAt(_loc3_);
            if(!(!_loc1_ is MovieClip))
            {
               if(_loc1_.hasOwnProperty("placeBit"))
               {
                  if(_loc1_.placeBit == ClothType.BIT22_HANDITEM)
                  {
                     try
                     {
                        container[_loc3_].dispose();
                     }
                     catch(e:Error)
                     {
                     }
                     try
                     {
                        container[_loc3_] = null;
                     }
                     catch(e:Error)
                     {
                     }
                     container.removeChildAt(_loc3_);
                     break;
                  }
               }
            }
            _loc3_++;
         }
      }
      
      public function useHandItem(param1:String, param2:Boolean = true) : void
      {
         if(holdedItemKey == param1)
         {
            return;
         }
         var _loc3_:String = null;
         if(isMe)
         {
            _loc3_ = Sanalika.instance.avatarModel.holdedItem;
         }
         else
         {
            _loc3_ = holdedItemKey;
         }
         if(_loc3_)
         {
            removeHandItem();
         }
         holdedItemKey = param1;
         if(isMe)
         {
            Sanalika.instance.avatarModel.holdedItem = param1;
         }
         else
         {
            holdedItemKey = param1;
         }
         if(param1 != null)
         {
            patchClothSystem4HandItem();
         }
         else
         {
            removeHandItem();
         }
         setStatus(_status,_direction);
      }
      
      public function getHeadPart(param1:int) : MovieClip
      {
         var _loc5_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = new MovieClip();
         _loc5_ = 0;
         while(_loc5_ < container.numChildren)
         {
            _loc2_ = MovieClip(container.getChildAt(_loc5_));
            if(_loc2_.hasOwnProperty("placeBit"))
            {
               if(_loc2_.placeBit >= ClothType.BIT16_FACIAL_HAIR && _loc2_.placeBit <= ClothType.BIT20_HAT || _loc2_.placeBit == ClothType.BIT02_BODY_TOP)
               {
                  _loc3_ = duplicateDisplayObject(_loc2_) as MovieClip;
                  _loc3_.gotoAndStop("i" + param1.toString());
                  _loc4_.addChild(_loc3_);
               }
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function duplicateDisplayObject(param1:DisplayObject, param2:Boolean = false) : DisplayObject
      {
         var _loc5_:Rectangle = null;
         var _loc4_:Class = Object(param1).constructor as Class;
         var _loc3_:DisplayObject = new _loc4_();
         _loc3_.transform = param1.transform;
         _loc3_.filters = param1.filters;
         _loc3_.cacheAsBitmap = param1.cacheAsBitmap;
         if(Sanalika.instance.airModel.isMobile())
         {
            _loc3_.cacheAsBitmap = true;
            (_loc3_ as MovieClip).cacheAsBitmapMatrix = new Matrix();
         }
         _loc3_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc5_ = param1.scale9Grid;
            _loc3_.scale9Grid = _loc5_;
         }
         if(param2 && param1.parent)
         {
            param1.parent.addChild(_loc3_);
         }
         return _loc3_;
      }
      
      public function get hide() : Boolean
      {
         return _hide;
      }
      
      public function set hide(param1:Boolean) : void
      {
         if(_hide == param1)
         {
            return;
         }
         _hide = param1;
         visible = !param1;
      }
      
      private function hideAndAddToPool() : void
      {
         var _loc1_:GamePool = scene.elementsContainer.getChildByName(gameZoneId) as GamePool;
         if(_loc1_ != null)
         {
            if(isMe)
            {
               Dispatcher.dispatchEvent(new PoolEvent("PoolEvent.SHOW_EXIT_BUTTON"));
            }
            _loc1_.addItem(this,scene);
            visible = false;
         }
         else
         {
            trace("pool is null");
         }
      }
      
      private function removeFromPool() : void
      {
         var _loc1_:GamePool = scene.elementsContainer.getChildByName(gameZoneId) as GamePool;
         if(_loc1_ != null)
         {
            if(isMe)
            {
               Dispatcher.dispatchEvent(new PoolEvent("PoolEvent.HIDE_EXIT_BUTTON"));
            }
            _loc1_.removeItem(this.id);
            visible = true;
            gameZoneId = "";
         }
      }
      
      public function rotateCharLeft() : void
      {
         if(this.status == "i" || this.status == "d")
         {
            if(this.status == "d")
            {
               if(this.direction == 5)
               {
                  this.direction = 3;
               }
            }
            if(this.status == "i")
            {
               if(this.direction == 1)
               {
                  this.direction = 8;
               }
               else
               {
                  this.direction--;
               }
            }
            if(isNPC)
            {
               trace("isNPC");
               setStatus(_status,_direction);
            }
            if(isMe)
            {
               Sanalika.instance.serviceModel.setUserVariable(["status","direction"],[_status,_direction]);
            }
         }
      }
      
      public function rotateCharRight() : void
      {
         if(this.status == "i" || this.status == "d")
         {
            if(this.status == "d")
            {
               if(this.direction == 3)
               {
                  this.direction = 5;
               }
            }
            if(this.status == "i")
            {
               if(this.direction == 8)
               {
                  this.direction = 1;
               }
               else
               {
                  this.direction++;
               }
            }
            if(isNPC)
            {
               trace("isNPC");
               setStatus(_status,_direction);
            }
            if(isMe)
            {
               trace("isMe",_direction);
               Sanalika.instance.serviceModel.setUserVariable(["status","direction"],[_status,_direction]);
            }
         }
      }
      
      public function setFilters(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         _loc3_ = 0;
         while(_loc3_ < container.numChildren)
         {
            _loc2_ = container.getChildAt(_loc3_);
            if(!(_loc2_ as SpeechBalloon))
            {
               _loc2_.filters = param1;
            }
            _loc3_++;
         }
      }
      
      public function setRoles(param1:String) : void
      {
         this._permission.value = param1;
      }
      
      public function setStatus(param1:String, param2:int) : void
      {
         var _loc7_:* = undefined;
         _loc7_ = 0;
         var _loc4_:int = 0;
         if(_directionPrev != param2)
         {
            _directionCount = _directionCount + 1;
            if(_directionCount > 10)
            {
               if(_directionLast + 2000 > getTimer())
               {
                  return;
               }
               _directionCount = 0;
               _directionLast = getTimer();
            }
         }
         _directionPrev = param2;
         _direction = param2;
         _status = param1;
         if(hasEventListener("status_changed"))
         {
            dispatchEvent(new Event("status_changed"));
         }
         if(param1 == "gm" && gameZoneId != "")
         {
            hideAndAddToPool();
         }
         else if(gameZoneId != "")
         {
            removeFromPool();
         }
         if(container == null)
         {
            return;
         }
         var _loc6_:* = -1;
         _loc7_ = 0;
         while(_loc7_ < container.numChildren)
         {
            if(container.getChildAt(_loc7_) instanceof SimpleCachedCharacterClip)
            {
               _loc6_ = _loc7_;
               break;
            }
            _loc7_++;
         }
         if(_loc6_ != -1)
         {
            container.removeChildAt(_loc6_);
            _loc7_ = 0;
            while(_loc7_ < _invisibleMovieClipList.length)
            {
               container.addChild(_invisibleMovieClipList[_loc7_]);
               _loc7_++;
            }
         }
         var _loc3_:* = null;
         var _loc5_:MovieClip = null;
         _loc7_ = 0;
         while(_loc7_ < container.numChildren)
         {
            _loc3_ = container.getChildAt(_loc7_);
            if(_loc3_.hasOwnProperty("placeBit"))
            {
               if(_loc3_.placeBit == ClothType.BIT22_HANDITEM)
               {
                  _loc5_ = _loc3_;
                  break;
               }
            }
            _loc7_++;
         }
         if(_loc5_ == null)
         {
            _loc7_ = 0;
            while(_loc7_ < container.numChildren)
            {
               _loc3_ = container.getChildAt(_loc7_);
               if(_loc3_.hasOwnProperty("placeBit"))
               {
                  if(_loc3_.placeBit != ClothType.BIT22_HANDITEM)
                  {
                     updateMcStatus(_loc3_,"",param1,param2);
                  }
               }
               _loc7_++;
            }
         }
         else
         {
            _loc4_ = int(Sanalika.instance.itemModel.getItemType(sex + "_" + (isMe ? Sanalika.instance.avatarModel.holdedItem : holdedItemKey)));
            _loc7_ = 0;
            while(_loc7_ < container.numChildren)
            {
               _loc3_ = container.getChildAt(_loc7_);
               if(_loc3_.hasOwnProperty("placeBit"))
               {
                  if(_loc3_.placeBit != ClothType.BIT22_HANDITEM)
                  {
                     if(param1 == "i" && ItemType.isHandVisibleIdle(_loc4_))
                     {
                        updateMcStatus(_loc3_,"k",param1,param2);
                     }
                     else if(param1 == "w" && ItemType.isHandVisibleWalking(_loc4_))
                     {
                        if(Sanalika.instance.itemModel.getItemStay(sex + "_" + (isMe ? Sanalika.instance.avatarModel.holdedItem : holdedItemKey)) == 1)
                        {
                           updateMcStatus(_loc3_,"k","i",param2);
                        }
                        else
                        {
                           updateMcStatus(_loc3_,"k",param1,param2);
                        }
                     }
                     else if(param1 == "s" && ItemType.isHandVisibleSitting(_loc4_))
                     {
                        updateMcStatus(_loc3_,"k",param1,param2);
                     }
                     else
                     {
                        updateMcStatus(_loc3_,"",param1,param2);
                     }
                  }
               }
               _loc7_++;
            }
            if(_loc5_ != null)
            {
            }
            if(param1 == "i")
            {
               if(ItemType.isItemVisibleIdle(_loc4_))
               {
                  _loc5_.visible = true;
                  if(ItemType.isHandVisibleIdle(_loc4_))
                  {
                     updateMcStatus(_loc5_,"k",param1,param2);
                  }
                  else
                  {
                     updateMcStatus(_loc5_,"",param1,param2);
                  }
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            else if(param1 == "w")
            {
               if(ItemType.isItemVisibleWalking(_loc4_))
               {
                  _loc5_.visible = true;
                  if(ItemType.isHandVisibleWalking(_loc4_))
                  {
                     updateMcStatus(_loc5_,"k",param1,param2);
                  }
                  else
                  {
                     updateMcStatus(_loc5_,"",param1,param2);
                  }
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            else if(param1 == "s")
            {
               if(ItemType.isItemVisibleSitting(_loc4_))
               {
                  _loc5_.visible = true;
                  if(ItemType.isHandVisibleSitting(_loc4_))
                  {
                     updateMcStatus(_loc5_,"k",param1,param2);
                  }
                  else
                  {
                     updateMcStatus(_loc5_,"",param1,param2);
                  }
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            else if(param1 == "d")
            {
               if(ItemType.isItemVisibleDance(_loc4_))
               {
                  _loc5_.visible = true;
                  updateMcStatus(_loc5_,"",param1,param2);
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            else if(param1 == "a1")
            {
               _loc5_.visible = false;
            }
            else if(CharacterState.FITNESS.indexOf(param1) > -1)
            {
               _loc5_.visible = false;
            }
         }
         cacheChar();
      }
      
      public function getClip() : Sprite
      {
         return container;
      }
      
      private function updateMcStatus(param1:*, param2:String, param3:String, param4:int) : void
      {
         exit = false;
         while(!exit)
         {
            if(param2 == "k")
            {
               if(param3 == "w")
               {
                  if((param1.frameBit & 8) == 0)
                  {
                     param2 = "";
                  }
                  else
                  {
                     exit = true;
                  }
               }
               else if(param3 == "i")
               {
                  if((param1.frameBit & 0x10) == 0)
                  {
                     param2 = "";
                  }
                  else
                  {
                     exit = true;
                  }
               }
               else if((param1.frameBit & 0x20) == 0)
               {
                  param2 = "";
               }
               else
               {
                  exit = true;
               }
            }
            else if(param3 == "w")
            {
               if((param1.frameBit & 1) == 0)
               {
                  param3 = "i";
               }
               else
               {
                  exit = true;
               }
            }
            else if(param3 == "s")
            {
               if((param1.frameBit & 4) == 0)
               {
                  param3 = "i";
               }
               else
               {
                  exit = true;
               }
            }
            else if(param3 == "d")
            {
               if((param1.frameBit & 0x40) == 0)
               {
                  param3 = "i";
               }
               else
               {
                  exit = true;
               }
            }
            else if(param3 == "a1")
            {
               if((param1.frameBit & 0x0100) == 0)
               {
                  param3 = "i";
               }
               else
               {
                  exit = true;
               }
            }
            else if(param3 == "x")
            {
               if((param1.frameBit & 0x80) == 0)
               {
                  param3 = "i";
               }
               else
               {
                  exit = true;
               }
            }
            else
            {
               exit = true;
            }
         }
         try
         {
            param1.gotoAndStop(param2 + param3 + param4);
         }
         catch(error:Error)
         {
            try
            {
               param1.gotoAndStop("i" + param4);
            }
            catch(error:Error)
            {
            }
         }
      }
   }
}

