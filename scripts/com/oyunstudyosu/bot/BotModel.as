package com.oyunstudyosu.bot
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.local.$;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   
   public class BotModel implements IBotModel
   {
      
      private var _map:Dictionary;
      
      private var i:int = 0;
      
      private var _count:int;
      
      public function BotModel()
      {
         super();
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.addEventListener("TERMINATE_SCENE",onTerminateGame);
      }
      
      private function onTerminateGame(param1:GameEvent) : void
      {
         Dispatcher.removeEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.removeEventListener("TERMINATE_SCENE",onTerminateGame);
         dispose();
      }
      
      public function getBotByKey(param1:String) : IBotVO
      {
         try
         {
            return _map[param1];
         }
         catch(e:Error)
         {
            var _loc4_:* = null;
         }
         return _loc4_;
      }
      
      public function getBotClip(param1:ApplicationDomain, param2:String) : MovieClip
      {
         trace("domain",param1,"definition",param2,"i",i);
         i = i + 1;
         var _loc3_:Class = DefinitionUtils.getClass(param1,param2);
         if(_loc3_)
         {
            return new _loc3_();
         }
         return new MovieClip();
      }
      
      public function runBotByKey(param1:String) : void
      {
         var _loc2_:BotVO = _map[param1];
         if(_loc2_ == null)
         {
            return;
         }
         Mouse.cursor = "auto";
         try
         {
            trace(JSON.stringify(_loc2_.property));
            _loc2_.property.execute(param1);
         }
         catch(error:Error)
         {
         }
      }
      
      public function load(param1:Array) : void
      {
         var _loc2_:BotVO = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         if(_map == null)
         {
            _map = new Dictionary();
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            trace("data",_loc3_);
            _loc2_ = _map[_loc3_.key];
            if(_loc2_ == null)
            {
               _count = _count + 1;
               _loc2_ = new BotVO();
            }
            _loc2_.metaKey = _loc3_.key;
            _loc2_.nick = $(_loc3_.key);
            _loc2_.definition = _loc3_.key;
            _loc2_.x = _loc3_.posX;
            _loc2_.y = _loc3_.posY;
            _loc2_.width = _loc3_.width;
            _loc2_.height = _loc3_.height;
            _loc2_.length = _loc3_.length;
            _loc2_.version = _loc3_.ver;
            if(_loc3_.property)
            {
               _loc2_.setProperty(_loc3_.property);
            }
            _loc2_.setSpeechProperty(_loc3_.speechProperty);
            _map[_loc2_.metaKey] = _loc2_;
            _loc4_++;
         }
      }
      
      public function loadJSON(param1:String) : void
      {
         var _loc2_:Array = JSON.parse(param1) as Array;
         load(_loc2_);
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
            _loc2_.push(_loc1_.metaKey);
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _map)
         {
            delete _map[_loc1_.metaKey];
            _loc1_.dispose();
         }
         _count = 0;
         _map = null;
      }
   }
}

