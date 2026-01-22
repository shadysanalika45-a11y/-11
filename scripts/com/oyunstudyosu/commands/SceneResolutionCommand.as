package com.oyunstudyosu.commands
{
   import com.oyunstudyosu.layer.LayerModel;
   import flash.display.Stage;
   import flash.system.Capabilities;
   
   public class SceneResolutionCommand extends Command
   {
      
      private var _layerModel:LayerModel;
      
      private var _stage:Stage;
      
      public function SceneResolutionCommand(param1:LayerModel, param2:Stage)
      {
         super();
         _layerModel = param1;
         _stage = param2;
      }
      
      override public function execute() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = 1;
         try
         {
            _loc1_ = Sanalika.instance.scaleModel.uiScale;
            if(Capabilities.version.substr(0,3) == "AND")
            {
               _layerModel.padding = 20 * _loc1_;
            }
         }
         catch(e:Error)
         {
         }
         if(_layerModel.gameHeight > Sanalika.instance.gameModel.minimumCanvasHeight)
         {
            _layerModel.canvasHeight = _layerModel.gameHeight;
            if(_layerModel.wideScreenMode)
            {
               if(_layerModel.canvasHeight > _stage.stageHeight - _layerModel.hudHeight * _loc1_ - _layerModel.padding)
               {
                  _layerModel.canvasHeight = _stage.stageHeight - _layerModel.hudHeight * _loc1_ - _layerModel.padding;
               }
               if(_layerModel.canvasHeight < Sanalika.instance.gameModel.minimumCanvasHeight)
               {
                  _layerModel.canvasHeight = Sanalika.instance.gameModel.minimumCanvasHeight;
               }
            }
            else
            {
               if(_layerModel.canvasHeight > _stage.stageHeight - _layerModel.padding)
               {
                  _layerModel.canvasHeight = _stage.stageHeight - _layerModel.padding;
               }
               if(_layerModel.canvasHeight > 520)
               {
                  _layerModel.canvasHeight = 520;
               }
               if(_layerModel.canvasHeight < Sanalika.instance.gameModel.minimumCanvasHeight)
               {
                  _layerModel.canvasHeight = Sanalika.instance.gameModel.minimumCanvasHeight;
               }
            }
         }
         else
         {
            _layerModel.canvasHeight = Sanalika.instance.gameModel.minimumCanvasHeight;
         }
         if(_layerModel.gameWidth > Sanalika.instance.gameModel.minimumCanvasWidth)
         {
            _layerModel.canvasWidth = _layerModel.gameWidth;
            if(_layerModel.wideScreenMode)
            {
               if(_layerModel.canvasWidth > _stage.stageWidth - _layerModel.padding)
               {
                  _layerModel.canvasWidth = _stage.stageWidth - _layerModel.padding;
               }
               if(_layerModel.canvasWidth < Sanalika.instance.gameModel.minimumCanvasWidth)
               {
                  _layerModel.canvasWidth = Sanalika.instance.gameModel.minimumCanvasWidth;
               }
            }
            else
            {
               if(_layerModel.canvasWidth > _stage.stageWidth - _layerModel.padding)
               {
                  _layerModel.canvasWidth = _stage.stageWidth - _layerModel.padding;
               }
               if(_layerModel.canvasWidth >= 920)
               {
                  _layerModel.canvasWidth = 920;
               }
               if(_layerModel.canvasWidth < Sanalika.instance.gameModel.minimumCanvasWidth)
               {
                  _layerModel.canvasWidth = Sanalika.instance.gameModel.minimumCanvasWidth;
               }
            }
         }
         else
         {
            _layerModel.canvasWidth = Sanalika.instance.gameModel.minimumCanvasWidth;
         }
         _layerModel.progressView.x = int(_stage.stageWidth / 2);
         _layerModel.progressView.y = int(_stage.stageHeight / 2);
         _layerModel.gameLayer.x = (_stage.stageWidth - _layerModel.canvasWidth) / 2;
         _layerModel.gameLayerMask.x = _layerModel.hudLayer.x = _layerModel.effectLayer.x = _layerModel.gameLayer.x;
         _layerModel.gameLayer.y = (_stage.stageHeight - _layerModel.canvasHeight - _layerModel.hudHeight * _loc1_) / 2;
         if(Capabilities.version.substr(0,3) == "AND")
         {
            _layerModel.gameLayer.y = 5 * _loc1_;
         }
         _layerModel.gameLayerMask.y = _layerModel.hudLayer.y = _layerModel.effectLayer.y = _layerModel.gameLayer.y;
         _layerModel.botMessageLayer.scaleX = _loc1_;
         _layerModel.botMessageLayer.scaleY = _loc1_;
         _layerModel.botMessageLayer.x = _layerModel.canvasWidth - 40 * _loc1_;
         _layerModel.botMessageLayer.y = 100 * _loc1_;
         _layerModel.businessMessageLayer.x = int(_stage.stageWidth / 2);
         _layerModel.businessMessageLayer.y = int(_stage.stageHeight / 2);
         _layerModel.notificationMessageLayer.x = int(_stage.stageWidth / 2);
         _layerModel.notificationMessageLayer.y = int(_stage.stageHeight / 2);
      }
   }
}

