package com.oyunstudyosu.model
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.AssetRequestQueue;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.extension.BaseExtension;
   import com.oyunstudyosu.extension.IExtension;
   import com.oyunstudyosu.sanalika.interfaces.IExtensionModel;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class ExtensionModel implements IExtensionModel
   {
      
      private var extensions:Dictionary;
      
      private var extensionsList:Array;
      
      public function ExtensionModel()
      {
         super();
         extensions = new Dictionary(true);
         extensionsList = [];
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.addEventListener("TERMINATE_SCENE",onTerminateScene);
      }
      
      private function onTerminateGame(param1:GameEvent) : void
      {
         trace("ExtensionModel onTerminateGame");
         dispose();
      }
      
      private function onTerminateScene(param1:GameEvent) : void
      {
         var _loc3_:* = Sanalika.instance.extensionModel.getExtensionsByType(1);
         for each(var _loc2_ in _loc3_)
         {
            Sanalika.instance.extensionModel.removeExtension(_loc2_.name);
         }
      }
      
      public function init(param1:Array) : void
      {
         var _loc3_:int = 0;
         if(param1.length == 0)
         {
            Dispatcher.dispatchEvent(new GameEvent("EXTENSIONS_LOADED"));
         }
         var _loc2_:Dictionary = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_[param1[_loc3_]["name"]] = param1[_loc3_]["property"];
            _loc3_++;
         }
         loadExtensionList(_loc2_,0);
      }
      
      public function loadExtension(param1:String, param2:Object, param3:int) : void
      {
         var _loc4_:Dictionary = new Dictionary();
         _loc4_[param1] = param2;
         loadExtensionList(_loc4_,param3);
      }
      
      public function loadExtensionList(param1:Dictionary, param2:int) : void
      {
         var _loc7_:Object = null;
         var _loc5_:IAssetRequest = null;
         var _loc3_:Array = [];
         for(var _loc6_ in param1)
         {
            _loc7_ = param1[_loc6_];
            _loc5_ = new AssetRequest();
            _loc5_.name = _loc6_;
            _loc5_.assetId = Sanalika.instance.moduleModel.getPath(_loc6_,"ModuleType.EXTENSION");
            _loc5_.type = "ModuleType.EXTENSION";
            _loc5_.context = Sanalika.instance.domainModel.subContext;
            _loc5_.data = {
               "property":_loc7_,
               "type":param2
            };
            _loc5_.priority = 97;
            _loc3_.push(_loc5_);
         }
         var _loc4_:AssetRequestQueue = new AssetRequestQueue(_loc3_);
         _loc4_.callback = onLoaded;
         Sanalika.instance.assetModel.requestQueue(_loc4_);
      }
      
      public function onLoaded(param1:AssetRequestQueue) : void
      {
         var _loc4_:ApplicationDomain = null;
         var _loc3_:Class = null;
         for each(var _loc2_ in param1.queue)
         {
            if(!_loc2_.error)
            {
               _loc4_ = _loc2_.context.applicationDomain;
               _loc3_ = _loc4_.getDefinition("extensions." + _loc2_.name) as Class;
               if(_loc3_ != null)
               {
                  if(_loc2_.data == null)
                  {
                     _loc2_.data = {};
                     _loc2_.data.property = null;
                     _loc2_.data.type = 0;
                  }
                  addExtension(_loc2_.name,_loc3_,_loc2_.data.property,_loc2_.data.type);
                  _loc2_.dispose();
               }
            }
         }
         param1.dispose();
         Dispatcher.dispatchEvent(new GameEvent("EXTENSIONS_LOADED"));
      }
      
      public function addExtension(param1:String, param2:Class, param3:Object, param4:int) : void
      {
         var _loc5_:IExtension = extensions[param1];
         if(_loc5_ == null)
         {
            _loc5_ = new param2();
            _loc5_.name = param1;
            (_loc5_ as BaseExtension).type = param4;
            extensions[param1] = _loc5_;
            extensionsList.push(_loc5_);
            _loc5_.init(param3);
         }
      }
      
      public function removeExtension(param1:String) : void
      {
         var _loc2_:IExtension = null;
         if(extensions)
         {
            _loc2_ = extensions[param1];
            if(_loc2_ != null)
            {
               delete extensions[param1];
               extensionsList.splice(extensionsList.indexOf(_loc2_),1);
               _loc2_.dispose();
               trace("exremoved:" + param1);
            }
         }
      }
      
      public function getExtensionByName(param1:String) : IExtension
      {
         if(extensions[param1])
         {
            return extensions[param1];
         }
         return null;
      }
      
      public function getExtensionsByType(param1:int) : Array
      {
         var type:int = param1;
         return extensionsList.filter(function(param1:BaseExtension, param2:int, param3:Array):Boolean
         {
            return param1.type == type;
         });
      }
      
      public function dispose() : void
      {
         var _loc1_:IExtension = null;
         Dispatcher.removeEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.removeEventListener("TERMINATE_SCENE",onTerminateScene);
         while(extensionsList.length)
         {
            _loc1_ = extensionsList.pop();
            removeExtension(_loc1_.name);
            delete this[[_loc1_.name]];
            _loc1_.dispose();
         }
         extensionsList = null;
         extensions = null;
      }
   }
}

