package com.oyunstudyosu.door
{
   import com.oyunstudyosu.alert.AlertEvent;
   import com.oyunstudyosu.alert.AlertVo;
   import com.oyunstudyosu.enums.LanguageKeys;
   import com.oyunstudyosu.events.Dispatcher;
   import flash.system.System;
   import flash.utils.Dictionary;
   
   public class DoorModel implements IDoorModel
   {
      
      private var _map:Dictionary;
      
      private var dataCount:int;
      
      private var mapData:Array;
      
      private var _count:int;
      
      private var _busy:Boolean;
      
      public function DoorModel()
      {
         super();
         Sanalika.instance.serviceModel.listenExtension("kickedAvatarFromRoom",kickedFromRoom);
      }
      
      private function kickedFromRoom(param1:Object) : void
      {
         if(param1.errorCode)
         {
            return;
         }
         Sanalika.instance.roomModel.checkMap(param1);
         var _loc2_:AlertVo = new AlertVo();
         _loc2_.alertType = "tooltip";
         _loc2_.description = LanguageKeys.KICKED_FROM_HOME_BY_OWNER;
         Dispatcher.dispatchEvent(new AlertEvent(_loc2_));
      }
      
      public function getDoor(param1:int, param2:int) : IDoorVO
      {
         for each(var _loc3_ in _map)
         {
            if(_loc3_.x == param1 && _loc3_.y == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _map)
         {
            delete _map[_loc1_.key];
            _loc1_.dispose();
         }
         busy = false;
         _count = 0;
         _map = null;
         System.gc();
      }
      
      public function useDoorByKey(param1:String) : void
      {
         if(busy)
         {
            return;
         }
         var _loc2_:IDoorVO = _map[param1];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.property.execute(param1);
      }
      
      public function useHouseDoor(param1:String, param2:String, param3:String = "", param4:Object = null) : void
      {
         dataCount = 0;
         mapData = [];
         Sanalika.instance.roomModel.buildingData = param4;
         Sanalika.instance.serviceModel.requestData("usehousedoor",{
            "flatID":param1,
            "password":param3,
            "avatarID":param2
         },onUseHouseDoorResponse);
         Sanalika.instance.roomModel.mapInitalized = false;
         busy = true;
      }
      
      private function onUseHouseDoorResponse(param1:Object) : void
      {
         Sanalika.instance.serviceModel.removeRequestData("usehousedoor",onUseHouseDoorResponse);
         if(param1.errorCode != undefined)
         {
            busy = false;
            return;
         }
         Sanalika.instance.roomModel.checkMap(param1);
      }
      
      public function getDoorById(param1:String) : IDoorVO
      {
         return _map[param1];
      }
      
      public function load(param1:Array) : void
      {
         var _loc3_:IDoorVO = null;
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         if(_map == null)
         {
            _map = new Dictionary();
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = param1[_loc4_];
            _loc3_ = _map[_loc2_.key];
            if(_loc3_ == null)
            {
               _count = _count + 1;
               _loc3_ = new DoorVO();
            }
            _loc3_.key = _loc2_.key;
            _loc3_.x = _loc2_.targetX;
            _loc3_.y = _loc2_.targetY;
            _loc3_.direction = _loc2_.targetDir;
            _loc3_.setProperty(_loc2_.property);
            _map[_loc3_.key] = _loc3_;
            _loc4_++;
         }
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get keyList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in _map)
         {
            _loc2_.push(_loc1_.key);
         }
         return _loc2_;
      }
      
      public function loadJSON(param1:String) : void
      {
         var _loc2_:Array = JSON.parse(param1) as Array;
         load(_loc2_);
      }
      
      public function get busy() : Boolean
      {
         return _busy;
      }
      
      public function set busy(param1:Boolean) : void
      {
         if(_busy == param1)
         {
            return;
         }
         _busy = param1;
      }
   }
}

