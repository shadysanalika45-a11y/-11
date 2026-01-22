package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.buddy.BuddyVo;
   import com.oyunstudyosu.buddy.RequestVo;
   
   public interface IBuddyModel
   {
      
      function get buddies() : Vector.<BuddyVo>;
      
      function get requests() : Vector.<RequestVo>;
      
      function get isActived() : Boolean;
      
      function set isActived(param1:Boolean) : void;
      
      function get reqLen() : int;
      
      function get buddyLen() : int;
      
      function get moods() : Array;
      
      function set moods(param1:Array) : void;
      
      function buddyReqTipClicked() : void;
      
      function add(param1:Object) : void;
      
      function addNewBuddy(param1:Object) : void;
      
      function changeRelation(param1:Object) : void;
      
      function changeOnlineStatus(param1:Object) : void;
      
      function changeMood(param1:Object) : void;
      
      function changeStatusMessage(param1:Object) : void;
      
      function removeFromFriend(param1:Object) : void;
      
      function getBuddyVoById(param1:String) : BuddyVo;
      
      function addNewRequest(param1:Object, param2:Boolean = true) : void;
      
      function removeRequest(param1:Object) : void;
      
      function getRequestVoById(param1:String) : RequestVo;
      
      function isBuddy(param1:String) : Boolean;
      
      function isRequest(param1:String) : Boolean;
   }
}

