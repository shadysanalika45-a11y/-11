package com.oyunstudyosu.model
{
   import com.oyunstudyosu.events.Dispatcher;
   import com.oyunstudyosu.events.GameEvent;
   import com.oyunstudyosu.events.ScaleEvent;
   import flash.display.Stage;
   import flash.events.Event;
   
   public class ScaleModel
   {
      
      public var defaultWidth:int = 800;
      
      public var defaultHeight:int = 500;
      
      public var width:int = 800;
      
      public var height:int = 550;
      
      private var stage:Stage;
      
      private var _currentScale:Number = 1;
      
      private var _currentX:Number = 0;
      
      private var _currentY:Number = 0;
      
      private var _uiScale:Number = 1;
      
      private var _enabled:Boolean = false;
      
      public var autoScale:Boolean = true;
      
      public function ScaleModel(param1:Stage)
      {
         super();
         this.stage = param1;
         if(Sanalika.instance.airModel.isDesktop())
         {
            autoScale = false;
         }
         if(Sanalika.instance.airModel.isAir())
         {
            enabled = true;
         }
         init();
      }
      
      public function get isLandscape() : Boolean
      {
         return Sanalika.instance.stage.stageWidth >= Sanalika.instance.stage.stageHeight;
      }
      
      public function get recommendedScaleRate() : Number
      {
         if(!Sanalika.instance.airModel.isMobile())
         {
            return calculateBestScaleRate(defaultWidth,defaultHeight);
         }
         if(!isLandscape)
         {
            return calculateBestScaleRate(defaultHeight,defaultWidth);
         }
         return calculateBestScaleRate(defaultWidth,defaultHeight);
      }
      
      public function get recommendedUIScaleRate() : Number
      {
         if(!Sanalika.instance.airModel.isMobile())
         {
            return calculateBestScaleRate(defaultWidth,defaultHeight);
         }
         if(!isLandscape)
         {
            return calculateBestScaleRate(defaultHeight,defaultWidth);
         }
         return calculateBestScaleRate(defaultWidth,defaultHeight);
      }
      
      public function get currentScale() : Number
      {
         return _currentScale;
      }
      
      public function set currentScale(param1:Number) : void
      {
         if(!enabled)
         {
            param1 = 1;
         }
         _currentScale = param1;
         try
         {
            updateSceneContainer();
         }
         catch(e:Error)
         {
         }
      }
      
      public function setCurrentScaleSlient(param1:Number, param2:Number, param3:Number) : void
      {
         if(!enabled)
         {
            param1 = 1;
         }
         _currentScale = param1;
         _currentX = param2;
         _currentY = param3;
         updateSceneContainer(false);
      }
      
      public function get uiScale() : Number
      {
         return _uiScale;
      }
      
      public function set uiScale(param1:Number) : void
      {
         if(_uiScale == param1)
         {
            return;
         }
         if(!enabled)
         {
            param1 = 1;
         }
         _uiScale = param1;
         Dispatcher.dispatchEvent(new ScaleEvent("UI_SCALE_CHANGED"));
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
         if(param1)
         {
            if(autoScale)
            {
               currentScale = recommendedScaleRate;
               uiScale = recommendedUIScaleRate;
            }
         }
         else
         {
            currentScale = 1;
            uiScale = 1;
         }
      }
      
      public function init() : void
      {
         Dispatcher.addEventListener("SCENE_DATA_LOADED",onSceneDataLoaded);
         Dispatcher.addEventListener("TRANSITION_IN",onSceneRendered);
         stage.addEventListener("resize",onResizeEvent);
      }
      
      private function onSceneRendered(param1:Event) : void
      {
         updateSceneContainer();
      }
      
      private function onResizeEvent(param1:Event) : void
      {
         reCalcScaleRates();
      }
      
      private function onSceneDataLoaded(param1:GameEvent) : void
      {
         if(width == Sanalika.instance.roomModel.width && height == Sanalika.instance.roomModel.height)
         {
            return;
         }
         width = Sanalika.instance.roomModel.width;
         height = Sanalika.instance.roomModel.height;
      }
      
      private function reCalcScaleRates() : void
      {
         if(!enabled)
         {
            return;
         }
         if(autoScale)
         {
            currentScale = recommendedScaleRate;
         }
      }
      
      public function updateSceneContainer(param1:Boolean = false) : void
      {
         if(Sanalika.instance.engine.scene == null)
         {
            return;
         }
         width = Sanalika.instance.roomModel.width * currentScale;
         height = Sanalika.instance.roomModel.height * currentScale;
         if(autoScale)
         {
            uiScale = recommendedUIScaleRate;
         }
         if(Sanalika.instance.engine.scene.container.scaleX != currentScale || Sanalika.instance.engine.scene.container.scaleY != currentScale)
         {
            Sanalika.instance.engine.scene.container.scaleX = currentScale;
            Sanalika.instance.engine.scene.container.scaleY = currentScale;
            trace("_currentX",_currentX);
            trace("_currentY",_currentY);
         }
         if(param1)
         {
            Sanalika.instance.layerModel.gameWidth = width;
            Sanalika.instance.layerModel.gameHeight = height;
            trace("Scale isSlinet");
         }
         else
         {
            Sanalika.instance.layerModel.updateSize(width,height);
            trace("Scale !isSlinet");
         }
      }
      
      private function calculateBestScaleRate(param1:int, param2:int) : Number
      {
         var _loc3_:Number = 1;
         var _loc4_:Number = 0.001;
         if(param1 <= 0 || param2 <= 0)
         {
            return _loc3_;
         }
         try
         {
            if(stage.stageWidth <= 800 || stage.stageHeight - Sanalika.instance.layerModel.hudHeight - Sanalika.instance.layerModel.padding <= 550)
            {
               return _loc3_;
            }
            while(!(param1 * (_loc3_ + _loc4_) > stage.stageWidth || param2 * (_loc3_ + _loc4_) > stage.stageHeight - Sanalika.instance.layerModel.hudHeight - Sanalika.instance.layerModel.padding))
            {
               _loc3_ += _loc4_;
            }
         }
         catch(e:Error)
         {
            _loc3_ = 1;
         }
         return _loc3_;
      }
   }
}

