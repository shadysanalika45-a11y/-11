package com.oyunstudyosu.model
{
   import com.oyunstudyosu.assets.AssetRequest;
   import com.oyunstudyosu.assets.IAssetRequest;
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.panel.IPanel;
   import com.oyunstudyosu.panel.Panel;
   import com.oyunstudyosu.panel.PanelEvent;
   import com.oyunstudyosu.panel.PanelVO;
   import com.oyunstudyosu.sanalika.interfaces.IPanelModel;
   import com.oyunstudyosu.utils.DefinitionUtils;
   import com.oyunstudyosu.utils.DrawUtils;
   import com.oyunstudyosu.utils.Tracker;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.system.ApplicationDomain;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   
   public class PanelModel implements IPanelModel
   {
      
      private var panelList:Dictionary;
      
      private var panelContainer:DisplayObjectContainer;
      
      public var panelBg:Sprite;
      
      public function PanelModel()
      {
         super();
         Dispatcher.addEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.addEventListener("TERMINATE_SCENE",onTerminateScene);
         Dispatcher.addEventListener("RESIZE",onSceneResize);
         Dispatcher.addEventListener("PanelEvent.CLOSE",onPanelClose);
         Sanalika.instance.stage.addEventListener("gestureRotate",onRotate);
         panelContainer = Sanalika.instance.layerModel.panelLayer;
         Sanalika.instance.layerModel.stage.addEventListener("keyUp",onKeyUp);
         panelList = new Dictionary(true);
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:IPanel = null;
         if(param1.keyCode == 27)
         {
            _loc2_ = getLatestPanel();
            if(_loc2_.data != null && _loc2_.data.isPermanent == true)
            {
               return;
            }
            if(_loc2_)
            {
               if(_loc2_.data.type == "static")
               {
                  if(panelBg && panelContainer.contains(panelContainer))
                  {
                     panelContainer.removeChild(panelBg);
                     panelBg = null;
                  }
               }
               _loc2_.dispose();
               panelContainer.removeChild(_loc2_ as DisplayObject);
            }
         }
      }
      
      private function onSceneResize(param1:GameEvent = null) : void
      {
         if(panelBg && panelContainer.contains(panelBg))
         {
            panelBg.width = Sanalika.instance.layerModel.stage.stageWidth;
            panelBg.height = Sanalika.instance.layerModel.stage.stageHeight;
         }
         for each(var _loc2_ in panelList)
         {
            _loc2_.scaleX = Sanalika.instance.scaleModel.uiScale;
            _loc2_.scaleY = Sanalika.instance.scaleModel.uiScale;
         }
      }
      
      private function onTerminateGame(param1:GameEvent) : void
      {
         clearPanelsByType("hud",true);
         clearPanelsByType("room",true);
      }
      
      private function onRotate(param1:GameEvent) : void
      {
         clearPanelsByType("hud",true);
         clearPanelsByType("room",true);
      }
      
      private function onTerminateScene(param1:GameEvent) : void
      {
         clearPanelsByType("room",true);
      }
      
      public function getPanelList() : Dictionary
      {
         return panelList;
      }
      
      public function dispose() : void
      {
         panelContainer = null;
         panelList = null;
         Dispatcher.removeEventListener("TERMINATE_GAME",onTerminateGame);
         Dispatcher.removeEventListener("TERMINATE_SCENE",onTerminateScene);
         Dispatcher.removeEventListener("RESIZE",onSceneResize);
      }
      
      public function clearPanel(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = Sanalika.instance.layerModel.panelLayer;
         for each(var _loc2_ in panelList)
         {
            if(_loc2_.data.name == param1)
            {
               if(_loc3_.contains(_loc2_ as DisplayObject))
               {
                  _loc3_.removeChild(_loc2_ as DisplayObject);
               }
               if(Boolean(dispose))
               {
                  try
                  {
                     panelList[_loc2_.data.name].dispose();
                  }
                  catch(e:Error)
                  {
                  }
                  delete panelList[_loc2_.data.name];
               }
            }
         }
         _loc3_ = null;
      }
      
      public function clearPanelsByType(param1:String, param2:Boolean = false) : void
      {
         var _loc4_:DisplayObjectContainer = Sanalika.instance.layerModel.panelLayer;
         for each(var _loc3_ in panelList)
         {
            if(_loc3_.data.type == param1)
            {
               if(_loc4_.contains(_loc3_ as DisplayObject))
               {
                  _loc4_.removeChild(_loc3_ as DisplayObject);
               }
               if(param2)
               {
                  try
                  {
                     panelList[_loc3_.data.name].dispose();
                  }
                  catch(e:Error)
                  {
                  }
                  delete panelList[_loc3_.data.name];
               }
            }
         }
         _loc4_ = null;
      }
      
      public function isOpen(param1:String) : Boolean
      {
         var _loc2_:IPanel = panelList[param1];
         if(_loc2_)
         {
            return !_loc2_.isDisposed;
         }
         return false;
      }
      
      public function showBg(param1:PanelVO, param2:IPanel) : void
      {
         if((param1.type == "static" || param1.type == "alert") && panelBg == null)
         {
            panelBg = DrawUtils.getRectangleSprite(Sanalika.instance.layerModel.stage.stageWidth,Sanalika.instance.layerModel.stage.stageHeight,0,0.3);
            panelContainer.addChildAt(panelBg,0);
         }
      }
      
      public function showPanel(param1:String) : void
      {
         var _loc2_:Panel = panelList[param1];
         _loc2_.scaleX = Sanalika.instance.scaleModel.uiScale;
         _loc2_.scaleY = Sanalika.instance.scaleModel.uiScale;
         _loc2_.show();
      }
      
      public function openPanel(param1:PanelVO) : void
      {
         var _loc2_:Panel = panelList[param1.name];
         Tracker.track("panel","open",param1.name);
         if(_loc2_)
         {
            _loc2_.data = param1;
            if(!panelContainer.contains(_loc2_ as DisplayObject))
            {
               panelContainer.addChild(_loc2_ as DisplayObject);
               _loc2_.scaleX = Sanalika.instance.scaleModel.uiScale;
               _loc2_.scaleY = Sanalika.instance.scaleModel.uiScale;
               _loc2_.init();
               onSceneResize();
            }
            else if(param1.name != "ProfilePanel")
            {
               _loc2_.dispose();
               panelContainer.removeChild(_loc2_ as DisplayObject);
            }
            return;
         }
         try
         {
            Mouse.cursor = "loading";
         }
         catch(error:Error)
         {
            Mouse.cursor = "auto";
         }
         var _loc3_:IAssetRequest = new AssetRequest();
         _loc3_.name = param1.name + ".swf";
         _loc3_.data = param1;
         _loc3_.context = Sanalika.instance.domainModel.subContext;
         _loc3_.assetId = Sanalika.instance.moduleModel.getPath(param1.name,"ModuleType.PANEL");
         _loc3_.loadedFunction = onLoaded;
         _loc3_.errorFunction = onError;
         _loc3_.type = "ModuleType.PANEL";
         _loc3_.priority = 98;
         Sanalika.instance.assetModel.request(_loc3_);
      }
      
      public function getLatestPanel() : IPanel
      {
         var _loc1_:int = panelContainer.numChildren;
         if(_loc1_ == 0)
         {
            return null;
         }
         return panelContainer.getChildAt(_loc1_ - 1) as IPanel;
      }
      
      private function onError(param1:IAssetRequest) : void
      {
         param1.dispose();
      }
      
      private function onLoaded(param1:IAssetRequest) : void
      {
         var _loc3_:Panel = null;
         var _loc2_:LoaderInfo = param1.loader.contentLoaderInfo;
         var _loc6_:ApplicationDomain = param1.context.applicationDomain;
         var _loc5_:PanelVO = param1.data as PanelVO;
         param1.dispose();
         var _loc4_:Class = DefinitionUtils.getClass(_loc6_,_loc5_.name);
         if(_loc4_ != null)
         {
            _loc3_ = new _loc4_();
            _loc3_.data = _loc5_;
            panelContainer.addChild(_loc3_ as DisplayObject);
            _loc3_.scaleX = Sanalika.instance.scaleModel.uiScale;
            _loc3_.scaleY = Sanalika.instance.scaleModel.uiScale;
            _loc3_.init();
            onSceneResize();
            register(_loc3_);
            _loc4_ = null;
         }
         else
         {
            Mouse.cursor = "auto";
            Tracker.track("runtime","main","panel",_loc5_.name + " NOT FOUND !!!");
            trace(_loc5_.name + " NOT FOUND !!!");
         }
      }
      
      private function register(param1:IPanel) : void
      {
         panelList[param1.data.name] = param1;
      }
      
      private function onPanelClose(param1:PanelEvent) : void
      {
         var _loc2_:IPanel = param1.panel;
         Tracker.track("panel","close",_loc2_.data.name);
         if((_loc2_.data.type == "static" || _loc2_.data.type == "alert") && panelBg)
         {
            panelContainer.removeChild(panelBg);
            panelBg = null;
         }
         if(Sanalika.instance.layerModel.panelLayer.contains(_loc2_ as DisplayObject))
         {
            Sanalika.instance.layerModel.panelLayer.removeChild(_loc2_ as DisplayObject);
         }
      }
   }
}

