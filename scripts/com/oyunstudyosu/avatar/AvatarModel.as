package com.oyunstudyosu.avatar
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.auth.IPermission;
   import com.oyunstudyosu.auth.Permission;
   import com.oyunstudyosu.commands.notification.UserFlatEnteredCommand;
   import com.oyunstudyosu.commands.security.OpenSecurityCaptchaCommand;
   import com.oyunstudyosu.commands.security.OpenSecurityKeyCommand;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.scene.components.SceneCharacterComponent;
   import com.oyunstudyosu.events.BalanceEvent;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.ProfileEvent;
   import com.oyunstudyosu.inventory.Item;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.local.LocalInstanceConfig;
   import com.oyunstudyosu.local.LocalTranslation;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarModel;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarSettings;
   import com.oyunstudyosu.utils.Tracker;
   import de.polygonal.core.fmt.Sprintf;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class AvatarModel implements IAvatarModel
   {
      
      public var email:String;
      
      public var stepCount:int = 0;
      
      public var giftCount:int = 0;
      
      private var _data:Object;
      
      private var _accessToken:String;
      
      private var _playerId:String;
      
      private var _avatarId:String;
      
      private var _avatarSize:Number = 1;
      
      private var _avatarName:String;
      
      private var _settings:IAvatarSettings;
      
      private var _age:int;
      
      private var _gender:String = "f";
      
      private var _guest:Boolean = false;
      
      private var _birthYear:int;
      
      private var _universe:String;
      
      private var _isTarget:Boolean;
      
      private var _tp:int;
      
      private var _platform:String;
      
      private var _fbPermission:String;
      
      private var _location:String;
      
      private var _userAgent:String;
      
      private var _baseClothes:Array;
      
      private var _tutorialStep:int;
      
      private var _isTutorialMode:Boolean;
      
      private var _isHideMode:Boolean;
      
      private var _isBaseClothSelected:Boolean;
      
      private var _isAvatarCreated:Boolean;
      
      private var _isUserActivated:Boolean = true;
      
      private var _permission:IPermission;
      
      private var _balance:Dictionary;
      
      private var _clothesOn:Array;
      
      private var _allClothes:String;
      
      private var _items:Array;
      
      private var _holdedItem:String;
      
      private var _lastHoldedItem:String;
      
      private var _usingItem:Item;
      
      private var _isDiamondClub:Boolean;
      
      private var _vipType:int;
      
      private var _hasCafeCard:Boolean;
      
      private var _smileyKey:String;
      
      private var _chatBalloonColor:int;
      
      private var _mood:String;
      
      private var _comment:String;
      
      private var _position:String;
      
      private var _direction:int;
      
      private var _ip:String;
      
      private var _fbToken:String;
      
      private var _blockList:Array = [];
      
      private var _pero:Boolean = true;
      
      public function AvatarModel()
      {
         super();
         _settings = new AvatarSettings();
         _balance = new Dictionary(true);
         _permission = new Permission();
         _data = {};
         Sanalika.instance.serviceModel.listenExtension("securitycaptcha",controlSecurityCaptcha);
         Sanalika.instance.serviceModel.listenExtension("securitykey",controlSecurityKey);
         Sanalika.instance.serviceModel.listenExtension("userFlatEntered",userFlatEntered);
         Sanalika.instance.serviceModel.listenExtension("publicMessageLimitExceeded",publicMessageLimitExceeded);
         Sanalika.instance.serviceModel.listenExtension("infoMessage",infoMessage);
         Sanalika.instance.serviceModel.listenExtension("externalAuthComplete",onExternalAuthComplete);
      }
      
      private function onExternalAuthComplete(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         if(Sanalika.instance.stage["nativeWindow"] != null)
         {
            _loc2_ = Sanalika.instance.stage["nativeWindow"];
            _loc2_.activate();
            _loc2_.alwaysInFront = true;
            _loc2_.alwaysInFront = false;
         }
         var _loc4_:String = param1.token;
         LocalInstanceConfig.setInstance(Sanalika.instance.gameModel.serverName);
         LocalTranslation.setLanguage(LocalInstanceConfig._SafeStr_2("LANGUAGE"));
         if(Sanalika.instance.stage.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.air.controller.DataStorageController"))
         {
            _loc3_ = Sanalika.instance.stage.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.air.controller.DataStorageController") as Class;
            _loc3_._SafeStr_1("instance",Sanalika.instance.gameModel.serverName);
            _loc3_._SafeStr_1("token",_loc4_);
            Sanalika.instance.panelModel.clearPanel("GuestPanel");
         }
         Sanalika.instance.avatarModel.accessToken = _loc4_;
         Sanalika.instance.reset();
      }
      
      private function userFlatEntered(param1:Object) : void
      {
         var _loc2_:UserFlatEnteredCommand = new UserFlatEnteredCommand(param1);
         _loc2_.execute();
      }
      
      private function controlSecurityCaptcha(param1:Object) : void
      {
         var _loc2_:OpenSecurityCaptchaCommand = null;
         if(param1.id != null)
         {
            _loc2_ = new OpenSecurityCaptchaCommand(param1);
            _loc2_.execute();
         }
      }
      
      private function controlSecurityKey(param1:Object) : void
      {
         var _loc2_:OpenSecurityKeyCommand = null;
         if(param1.id)
         {
            _loc2_ = new OpenSecurityKeyCommand(param1.id,param1.sn,param1.requestId);
            _loc2_.execute();
         }
      }
      
      private function infoMessage(param1:Object) : void
      {
         var _loc2_:AlertVo = null;
         if(param1.message)
         {
            if(param1.type == "packageExpire")
            {
               _loc2_ = new AlertVo();
               _loc2_.alertType = "tooltip";
               _loc2_.description = $(param1.message);
               Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
            }
         }
      }
      
      private function publicMessageLimitExceeded(param1:Object) : void
      {
         var _loc3_:PanelVO = null;
         _loc3_ = null;
         var _loc2_:AlertVo = null;
         if(param1.message)
         {
            if(param1.type == "emailActivation")
            {
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("Sanalika.openEmailActivationPanel");
               }
               else if(!Sanalika.instance.panelModel.isOpen("EmailPanel"))
               {
                  _loc3_ = new PanelVO();
                  _loc3_.name = "EmailPanel";
                  _loc3_.params = {"email":Sanalika.instance.avatarModel.email};
                  Sanalika.instance.panelModel.openPanel(_loc3_);
               }
            }
            else
            {
               _loc3_ = new PanelVO();
               _loc3_.name = "ProvisionPanel";
               _loc3_.type = "hud";
               Sanalika.instance.panelModel.openPanel(_loc3_);
            }
            _loc2_ = new AlertVo();
            _loc2_.alertType = "tooltip";
            _loc2_.description = $(param1.message);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
      }
      
      public function get atHome() : Boolean
      {
         return Sanalika.instance.roomModel.ownerId == avatarId;
      }
      
      public function get accessToken() : String
      {
         return _accessToken;
      }
      
      public function set accessToken(param1:String) : void
      {
         if(_accessToken == param1)
         {
            return;
         }
         _accessToken = param1;
      }
      
      public function get playerId() : String
      {
         return _playerId;
      }
      
      public function set playerId(param1:String) : void
      {
         if(_playerId == param1)
         {
            return;
         }
         _playerId = param1;
         Tracker.playerId = param1;
         Tracker.instance = Sanalika.instance.gameModel.serverName;
      }
      
      public function get avatarId() : String
      {
         return _avatarId;
      }
      
      public function set avatarId(param1:String) : void
      {
         if(_avatarId == param1)
         {
            return;
         }
         _avatarId = param1;
         Tracker.avatarId = param1;
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
         _avatarName = param1;
      }
      
      public function get settings() : IAvatarSettings
      {
         return _settings;
      }
      
      public function set settings(param1:IAvatarSettings) : void
      {
         if(_settings == param1)
         {
            return;
         }
         _settings = param1;
      }
      
      public function get age() : int
      {
         return _age;
      }
      
      public function set age(param1:int) : void
      {
         if(_age == param1)
         {
            return;
         }
         _age = param1;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function set gender(param1:String) : void
      {
         if(_gender == param1)
         {
            return;
         }
         _gender = param1;
         Tracker.gender = param1;
      }
      
      public function get guest() : Boolean
      {
         return _guest;
      }
      
      public function set guest(param1:Boolean) : void
      {
         if(_guest == param1)
         {
            return;
         }
         _guest = param1;
      }
      
      public function get birthYear() : int
      {
         return _birthYear;
      }
      
      public function set birthYear(param1:int) : void
      {
         if(_birthYear == param1)
         {
            return;
         }
         _birthYear = param1;
      }
      
      public function get universe() : String
      {
         return _universe;
      }
      
      public function set universe(param1:String) : void
      {
         _universe = param1;
      }
      
      public function get isTarget() : Boolean
      {
         return _isTarget;
      }
      
      public function set isTarget(param1:Boolean) : void
      {
         _isTarget = param1;
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
         Tracker.platform = param1;
      }
      
      public function get fbPermission() : String
      {
         return _fbPermission;
      }
      
      public function set fbPermission(param1:String) : void
      {
         if(_fbPermission == param1)
         {
            return;
         }
         _fbPermission = param1;
      }
      
      public function get location() : String
      {
         return _location;
      }
      
      public function set location(param1:String) : void
      {
         if(_location == param1)
         {
            return;
         }
         _location = param1;
      }
      
      public function get userAgent() : String
      {
         if(_userAgent == null || _userAgent == "")
         {
            if(ExternalInterface.available)
            {
               _userAgent = ExternalInterface.call("window.navigator.userAgent.toString");
            }
            else
            {
               _userAgent = "";
            }
         }
         return _userAgent;
      }
      
      public function get baseClothes() : Array
      {
         return _baseClothes;
      }
      
      public function set baseClothes(param1:Array) : void
      {
         if(_baseClothes == param1)
         {
            return;
         }
         _baseClothes = param1;
      }
      
      public function get tutorialStep() : int
      {
         return _tutorialStep;
      }
      
      public function set tutorialStep(param1:int) : void
      {
         if(_tutorialStep == param1)
         {
            return;
         }
         _tutorialStep = param1;
      }
      
      public function get isTutorialMode() : Boolean
      {
         return _isTutorialMode;
      }
      
      public function set isTutorialMode(param1:Boolean) : void
      {
         if(_isTutorialMode == param1)
         {
            return;
         }
         _isTutorialMode = param1;
      }
      
      public function get isHideMode() : Boolean
      {
         return _isHideMode;
      }
      
      public function set isHideMode(param1:Boolean) : void
      {
         if(_isHideMode == param1)
         {
            return;
         }
         _isHideMode = param1;
      }
      
      public function get isBaseClothSelected() : Boolean
      {
         return _isBaseClothSelected;
      }
      
      public function set isBaseClothSelected(param1:Boolean) : void
      {
         if(_isBaseClothSelected == param1)
         {
            return;
         }
         _isBaseClothSelected = param1;
      }
      
      public function get isAvatarCreated() : Boolean
      {
         return _isAvatarCreated;
      }
      
      public function set isAvatarCreated(param1:Boolean) : void
      {
         if(_isAvatarCreated == param1)
         {
            return;
         }
         _isAvatarCreated = param1;
      }
      
      public function get isUserActivated() : Boolean
      {
         return _isUserActivated;
      }
      
      public function set isUserActivated(param1:Boolean) : void
      {
         if(_isUserActivated == param1)
         {
            return;
         }
         _isUserActivated = param1;
      }
      
      public function get permission() : IPermission
      {
         return _permission;
      }
      
      public function set permission(param1:IPermission) : void
      {
         if(_permission == param1)
         {
            return;
         }
         _permission = param1;
      }
      
      public function balance(param1:String) : String
      {
         if(_balance[param1] == null)
         {
            return "0";
         }
         return _balance[param1];
      }
      
      public function updateWallet(param1:Array) : void
      {
         var _loc2_:int = 0;
         Sanalika.instance.soundModel.playSound("SoundKey.SANIL",1,1);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].currency == "SANIL")
            {
               setBalance("SANIL",param1[_loc2_].balance);
            }
            if(param1[_loc2_].currency == "DIAMOND")
            {
               setBalance("DIAMOND",param1[_loc2_].balance);
            }
            if(param1[_loc2_].currency == "PEPSICOIN")
            {
               setBalance("PEPSICOIN",param1[_loc2_].balance);
            }
            _loc2_++;
         }
      }
      
      public function reasonWallet(param1:String) : void
      {
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = $(param1);
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      public function setBalance(param1:String, param2:String) : void
      {
         _balance[param1] = param2;
         var _loc3_:BalanceEvent = new BalanceEvent("balanceUpdate");
         _loc3_.balance = param2;
         _loc3_.balanceType = param1;
         Dispatcher.dispatchEvent(_loc3_);
      }
      
      public function get clothesOn() : Array
      {
         return _clothesOn;
      }
      
      public function set clothesOn(param1:Array) : void
      {
         if(_clothesOn == param1)
         {
            return;
         }
         _clothesOn = param1;
      }
      
      public function get allClothes() : String
      {
         return _allClothes;
      }
      
      public function set allClothes(param1:String) : void
      {
         if(_allClothes == param1)
         {
            return;
         }
         _allClothes = param1;
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      public function set items(param1:Array) : void
      {
         if(_items == param1)
         {
            return;
         }
         _items = param1;
      }
      
      public function get holdedItem() : String
      {
         return _holdedItem;
      }
      
      public function set holdedItem(param1:String) : void
      {
         if(_holdedItem == param1)
         {
            return;
         }
         _holdedItem = param1;
         lastHoldedItem = param1;
      }
      
      private function onAvatarSizeChange(param1:Object) : void
      {
      }
      
      public function get lastHoldedItem() : String
      {
         return _lastHoldedItem;
      }
      
      public function set lastHoldedItem(param1:String) : void
      {
         if(_holdedItem != null)
         {
            _lastHoldedItem = param1;
         }
      }
      
      public function get usingItem() : Item
      {
         return _usingItem;
      }
      
      public function set usingItem(param1:Item) : void
      {
         if(_usingItem == param1)
         {
            return;
         }
         _usingItem = param1;
      }
      
      public function get isDiamondClub() : Boolean
      {
         return _isDiamondClub;
      }
      
      public function set isDiamondClub(param1:Boolean) : void
      {
         if(_isDiamondClub == param1)
         {
            return;
         }
         _isDiamondClub = param1;
      }
      
      public function get vipType() : int
      {
         return _vipType;
      }
      
      public function set vipType(param1:int) : void
      {
         if(_vipType == param1)
         {
            return;
         }
         _vipType = param1;
      }
      
      public function get hasCafeCard() : Boolean
      {
         return _hasCafeCard;
      }
      
      public function set hasCafeCard(param1:Boolean) : void
      {
         if(_hasCafeCard == param1)
         {
            return;
         }
         _hasCafeCard = param1;
      }
      
      public function get smileyKey() : String
      {
         return _smileyKey;
      }
      
      public function set smileyKey(param1:String) : void
      {
         _smileyKey = param1;
      }
      
      public function get chatBalloonColor() : int
      {
         return _chatBalloonColor;
      }
      
      public function set chatBalloonColor(param1:int) : void
      {
         if(_chatBalloonColor == param1)
         {
            return;
         }
         _chatBalloonColor = param1;
      }
      
      public function get mood() : String
      {
         return _mood;
      }
      
      public function set mood(param1:String) : void
      {
         if(_mood == param1)
         {
            return;
         }
         _mood = param1;
      }
      
      public function get comment() : String
      {
         return _comment;
      }
      
      public function set comment(param1:String) : void
      {
         if(_comment == param1)
         {
            return;
         }
         _comment = param1;
      }
      
      public function get position() : String
      {
         return _position;
      }
      
      public function set position(param1:String) : void
      {
         if(_position == param1)
         {
            return;
         }
         _position = param1;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
      }
      
      public function get ip() : String
      {
         return _ip;
      }
      
      public function set ip(param1:String) : void
      {
         if(_ip == param1)
         {
            return;
         }
         _ip = param1;
      }
      
      public function get fbToken() : String
      {
         return _fbToken;
      }
      
      public function set fbToken(param1:String) : void
      {
         if(_fbToken == param1)
         {
            return;
         }
         _fbToken = param1;
      }
      
      public function isBlocked(param1:String) : Boolean
      {
         if(_blockList.indexOf(param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function removeBlock(param1:String) : void
      {
         var _loc2_:SceneCharacterComponent = null;
         var _loc4_:ICharacter = null;
         var _loc3_:AlertVo = null;
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc4_ = _loc2_.getAvatarById(param1);
            if(_blockList.indexOf(param1) != -1 && _loc4_ != null && _loc4_.avatarName != null)
            {
               _blockList.splice(_blockList.indexOf(param1),1);
               _loc3_ = new AlertVo();
               _loc3_.alertType = "tooltip";
               _loc3_.description = Sprintf.format($("silenceOff"),[_loc4_.avatarName]);
               Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
            }
         }
      }
      
      public function likeUser(param1:String) : void
      {
         var sceneCharacterComponent:SceneCharacterComponent;
         var character:ICharacter;
         var alertvo:AlertVo;
         var id:String = param1;
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            sceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            character = sceneCharacterComponent.getAvatarById(id);
            if(_blockList.indexOf(id) == -1 && character != null && character.avatarName != null)
            {
               alertvo = new AlertVo();
               alertvo.callBack = function():*
               {
                  openProfileCallback(id);
               };
               alertvo.alertType = "tooltip";
               alertvo.description = Sprintf.format($("liked by"),[character.avatarName]);
               Dispatcher.dispatchEvent(new AlertEvent(alertvo));
            }
         }
      }
      
      private function openProfileCallback(param1:String) : void
      {
         var _loc2_:ProfileEvent = new ProfileEvent("AvatarProfileEvent.SHOW_PROFILE");
         _loc2_.avatarID = param1;
         Dispatcher.dispatchEvent(_loc2_);
      }
      
      public function dislikeUser(param1:String) : void
      {
         var _loc2_:SceneCharacterComponent = null;
         var _loc4_:ICharacter = null;
         var _loc3_:AlertVo = null;
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            _loc2_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc4_ = _loc2_.getAvatarById(param1);
            if(_blockList.indexOf(param1) == -1 && _loc4_ != null && _loc4_.avatarName != null)
            {
               _loc3_ = new AlertVo();
               _loc3_.alertType = "tooltip";
               _loc3_.description = Sprintf.format($("disliked by"),[_loc4_.avatarName]);
               Dispatcher.dispatchEvent(new AlertEvent(_loc3_));
            }
         }
      }
      
      public function likeremovedUser(param1:String) : void
      {
         var sceneCharacterComponent:SceneCharacterComponent;
         var character:ICharacter;
         var alertvo:AlertVo;
         var id:String = param1;
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent))
         {
            sceneCharacterComponent = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            character = sceneCharacterComponent.getAvatarById(id);
            if(_blockList.indexOf(id) == -1 && character != null)
            {
               if(character.avatarName != null)
               {
                  alertvo = new AlertVo();
                  alertvo.callBack = function():*
                  {
                     openProfileCallback(id);
                  };
                  alertvo.alertType = "tooltip";
                  alertvo.description = Sprintf.format($("like/dislike removed by"),[character.avatarName]);
                  Dispatcher.dispatchEvent(new AlertEvent(alertvo));
               }
            }
         }
      }
      
      public function blockUser(param1:String) : void
      {
         var _loc3_:SceneCharacterComponent = null;
         var _loc5_:ICharacter = null;
         var _loc2_:String = null;
         var _loc4_:AlertVo = null;
         if(Sanalika.instance.engine.scene != null && Sanalika.instance.engine.scene.existsComponent(SceneCharacterComponent) && !isBlocked(param1))
         {
            _blockList.push(param1);
            _loc3_ = Sanalika.instance.engine.scene.getComponent(SceneCharacterComponent) as SceneCharacterComponent;
            _loc5_ = _loc3_.getAvatarById(param1);
            _loc2_ = _loc5_ != null ? _loc5_.avatarName : param1;
            _loc4_ = new AlertVo();
            _loc4_.alertType = "tooltip";
            _loc4_.description = Sprintf.format($("silenceOn"),[_loc2_]);
            Dispatcher.dispatchEvent(new AlertEvent(_loc4_));
         }
      }
      
      public function get pero() : Boolean
      {
         return _pero;
      }
      
      public function set pero(param1:Boolean) : void
      {
         if(_pero == param1)
         {
            return;
         }
         _pero = param1;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_1 = "set"
 * @identifier _SafeStr_2 = "get"
 */
