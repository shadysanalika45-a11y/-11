package com.oyunstudyosu.model
{
   import com.oyunstudyosu.sanalika.interfaces.IModuleModel;
   import flash.utils.Dictionary;
   
   public class ModuleModel implements IModuleModel
   {
      
      private var map:Dictionary;
      
      private var qs:String = "";
      
      private var patternMap:Dictionary;
      
      private var staticList:Array;
      
      public function ModuleModel()
      {
         super();
         staticList = ["ModuleType.CLOTH","ModuleType.INVENTORY","ModuleType.SMILEY","ModuleType.CONCERT_SWF","ModuleType.BOT","ModuleType.FURNITURE","ModuleType.PROFILE_SKIN"];
      }
      
      public function init(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         map = new Dictionary();
         var _loc2_:Array = param1.split("|");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length - 1)
         {
            _loc3_ = _loc2_[_loc4_].split("=");
            map[_loc3_[0]] = "/dynamic/" + _loc3_[1];
            _loc4_++;
         }
         if(Sanalika.instance.gameModel.quality == "hd")
         {
            qs = "-2x";
         }
         patternMap = new Dictionary();
         patternMap["ModuleType.ROOM"] = "/dynamic/rooms" + qs + "/{key}.swf";
         patternMap["ModuleType.PANEL"] = "/dynamic/panels" + qs + "/{key}.swf";
         patternMap["ModuleType.CONCERT_SWF"] = "/static/bots" + qs + "/{key}.swf";
         patternMap["ModuleType.EXTENSION"] = "/{key}.swf";
         patternMap["ModuleType.FURNITURE"] = "/static/items/furnitures" + qs + "/{key}.swf";
         patternMap["ModuleType.INVENTORY"] = "/static/items" + qs + "/inventory/{key}";
         patternMap["ModuleType.CLOTH"] = "/static/items" + qs + "/clothes/{key}";
         patternMap["ModuleType.CLOTH_PNG"] = "/static/items" + qs + "/clothes/r_{key}";
         patternMap["ModuleType.BOT"] = "/static/bots" + qs + "/{key}.swf";
         patternMap["ModuleType.QUEST"] = "/static/items" + qs + "/quests/{key}";
         patternMap["ModuleType.SMILEY"] = "/static/items" + qs + "/smileys/{key}";
         patternMap["ModuleType.PROFILE_SKIN"] = "/static/items/profileskins" + qs + "/{key}";
      }
      
      public function getPath(param1:String, param2:String) : String
      {
         var _loc4_:String = null;
         var _loc3_:RegExp = /^[A-Za-z0-9_.]+$/;
         if(!_loc3_.test(param1))
         {
            return "";
         }
         _loc4_ = map[param1];
         if(param2 == "ModuleType.ROOM" || param2 == "ModuleType.FURNITURE" || param2 == "ModuleType.EXTENSION" || param2 == "ModuleType.PANEL")
         {
            _loc4_ += ".swf";
         }
         if(staticList.indexOf(param2) > -1)
         {
            _loc4_ = patternMap[param2];
            _loc4_ = _loc4_.replace("{key}",param1);
         }
         if(_loc4_ == null)
         {
         }
         return _loc4_;
      }
   }
}

