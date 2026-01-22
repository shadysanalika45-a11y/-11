package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertType;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.auth.IPermission;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.inventory.Item;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarModel;
   import com.oyunstudyosu.sanalika.interfaces.IAvatarSettings;
   import com.printfas3.printf;
   
   public class AvatarModel implements IAvatarModel
   {
      
      private var _settings:IAvatarSettings;
      
      private var _items:Array;
      
      private var _permission:IPermission;
      
      private var _blockList:Array = new Array();
      
      private var _orderRequest:Object;
      
      private var _pero:Boolean;
      
      public function AvatarModel()
      {
         super();
         this._settings = new AvatarSettings();
      }
      
      public function get baseClothes() : Array
      {
         return null;
      }
      
      public function set baseClothes(param1:Array) : void
      {
      }
      
      public function get avatarId() : String
      {
         return "584";
      }
      
      public function set avatarId(param1:String) : void
      {
      }
      
      public function get avatarName() : String
      {
         return "Tayfun";
      }
      
      public function get settings() : IAvatarSettings
      {
         return this._settings;
      }
      
      public function set settings(param1:IAvatarSettings) : void
      {
         if(this._settings == param1)
         {
            return;
         }
         this._settings = param1;
      }
      
      public function get age() : int
      {
         return 0;
      }
      
      public function get birthYear() : int
      {
         return 0;
      }
      
      public function get tp() : int
      {
         return 0;
      }
      
      public function set tp(param1:int) : void
      {
      }
      
      public function get fbPermission() : String
      {
         return "";
      }
      
      public function set fbPermission(param1:String) : void
      {
      }
      
      public function get isBaseClothSelected() : Boolean
      {
         return false;
      }
      
      public function set isBaseClothSelected(param1:Boolean) : void
      {
      }
      
      public function get isAvatarCreated() : Boolean
      {
         return false;
      }
      
      public function set isAvatarCreated(param1:Boolean) : void
      {
      }
      
      public function get isUserActivated() : Boolean
      {
         return false;
      }
      
      public function get banEndTime() : int
      {
         return 0;
      }
      
      public function balance(param1:String) : String
      {
         return "0";
      }
      
      public function setBalance(param1:String, param2:String) : void
      {
      }
      
      public function addBalance(param1:String, param2:int) : void
      {
      }
      
      public function get clothesOn() : Array
      {
         return null;
      }
      
      public function set clothesOn(param1:Array) : void
      {
      }
      
      public function get allClothes() : String
      {
         return null;
      }
      
      public function set allClothes(param1:String) : void
      {
      }
      
      public function get items() : Array
      {
         return this._items;
      }
      
      public function set items(param1:Array) : void
      {
         this._items = param1;
      }
      
      public function get holdedItem() : String
      {
         return null;
      }
      
      public function set holdedItem(param1:String) : void
      {
      }
      
      public function get usingItem() : Item
      {
         return null;
      }
      
      public function set usingItem(param1:Item) : void
      {
      }
      
      public function get direction() : int
      {
         return 0;
      }
      
      public function set direction(param1:int) : void
      {
      }
      
      public function get position() : String
      {
         return null;
      }
      
      public function set position(param1:String) : void
      {
      }
      
      public function get ip() : String
      {
         return null;
      }
      
      public function set ip(param1:String) : void
      {
      }
      
      public function hasRole(param1:int) : Boolean
      {
         return false;
      }
      
      public function set role(param1:int) : void
      {
      }
      
      public function get gender() : String
      {
         return "m";
      }
      
      public function get permission() : IPermission
      {
         return this._permission;
      }
      
      public function set permission(param1:IPermission) : void
      {
         if(this._permission == param1)
         {
            return;
         }
         this._permission = param1;
      }
      
      public function get whisperMode() : Boolean
      {
         return false;
      }
      
      public function set whisperMode(param1:Boolean) : void
      {
      }
      
      public function get atHome() : Boolean
      {
         return false;
      }
      
      public function isBlocked(param1:String) : Boolean
      {
         if(this._blockList.indexOf(param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function removeBlock(param1:String) : void
      {
      }
      
      public function blockUser(param1:String) : void
      {
         var _loc2_:AlertVo = null;
         if(this.isBlocked(param1))
         {
            this._blockList.push(param1);
            _loc2_ = new AlertVo();
            _loc2_.alertType = AlertType.TOOLTIP;
            _loc2_.description = printf($("silence"),param1);
            Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
         }
         else
         {
            trace("zaten engelli");
         }
      }
      
      public function get universe() : String
      {
         return null;
      }
      
      public function get data() : Object
      {
         return {};
      }
      
      public function set data(param1:Object) : void
      {
      }
      
      public function get platform() : String
      {
         return null;
      }
      
      public function set platform(param1:String) : void
      {
      }
      
      public function get userAgent() : String
      {
         return null;
      }
      
      public function get location() : String
      {
         return null;
      }
      
      public function updateWallet(param1:Array) : void
      {
      }
      
      public function get tutorialStep() : int
      {
         return 0;
      }
      
      public function set tutorialStep(param1:int) : void
      {
      }
      
      public function get isTutorialMode() : Boolean
      {
         return false;
      }
      
      public function set isTutorialMode(param1:Boolean) : void
      {
      }
      
      public function get isHideMode() : Boolean
      {
         return false;
      }
      
      public function set isHideMode(param1:Boolean) : void
      {
      }
      
      public function get playerId() : String
      {
         return null;
      }
      
      public function set playerId(param1:String) : void
      {
      }
      
      public function get orderRequest() : Object
      {
         return null;
      }
      
      public function set orderRequest(param1:Object) : void
      {
      }
      
      public function get pero() : Boolean
      {
         return this._pero;
      }
      
      public function set pero(param1:Boolean) : void
      {
         if(this._pero == param1)
         {
            return;
         }
         this._pero = param1;
      }
      
      public function get guest() : Boolean
      {
         return false;
      }
   }
}

