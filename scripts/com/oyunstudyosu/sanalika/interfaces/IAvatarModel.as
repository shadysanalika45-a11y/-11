package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.auth.IPermission;
   import com.oyunstudyosu.inventory.Item;
   
   public interface IAvatarModel
   {
      
      function get playerId() : String;
      
      function set playerId(param1:String) : void;
      
      function get avatarId() : String;
      
      function set avatarId(param1:String) : void;
      
      function get avatarName() : String;
      
      function get settings() : IAvatarSettings;
      
      function set settings(param1:IAvatarSettings) : void;
      
      function get age() : int;
      
      function get gender() : String;
      
      function get birthYear() : int;
      
      function get tp() : int;
      
      function set tp(param1:int) : void;
      
      function get fbPermission() : String;
      
      function set fbPermission(param1:String) : void;
      
      function get universe() : String;
      
      function get tutorialStep() : int;
      
      function set tutorialStep(param1:int) : void;
      
      function get isTutorialMode() : Boolean;
      
      function set isTutorialMode(param1:Boolean) : void;
      
      function get isHideMode() : Boolean;
      
      function set isHideMode(param1:Boolean) : void;
      
      function get isBaseClothSelected() : Boolean;
      
      function set isBaseClothSelected(param1:Boolean) : void;
      
      function get baseClothes() : Array;
      
      function set baseClothes(param1:Array) : void;
      
      function get isAvatarCreated() : Boolean;
      
      function set isAvatarCreated(param1:Boolean) : void;
      
      function get isUserActivated() : Boolean;
      
      function balance(param1:String) : String;
      
      function updateWallet(param1:Array) : void;
      
      function setBalance(param1:String, param2:String) : void;
      
      function get clothesOn() : Array;
      
      function set clothesOn(param1:Array) : void;
      
      function get allClothes() : String;
      
      function set allClothes(param1:String) : void;
      
      function get items() : Array;
      
      function set items(param1:Array) : void;
      
      function get holdedItem() : String;
      
      function set holdedItem(param1:String) : void;
      
      function get usingItem() : Item;
      
      function set usingItem(param1:Item) : void;
      
      function get position() : String;
      
      function set position(param1:String) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
      
      function get ip() : String;
      
      function set ip(param1:String) : void;
      
      function get userAgent() : String;
      
      function get platform() : String;
      
      function set platform(param1:String) : void;
      
      function get permission() : IPermission;
      
      function set permission(param1:IPermission) : void;
      
      function get atHome() : Boolean;
      
      function get data() : Object;
      
      function set data(param1:Object) : void;
      
      function isBlocked(param1:String) : Boolean;
      
      function removeBlock(param1:String) : void;
      
      function blockUser(param1:String) : void;
      
      function get pero() : Boolean;
      
      function set pero(param1:Boolean) : void;
      
      function get guest() : Boolean;
   }
}

