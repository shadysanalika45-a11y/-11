package com.oyunstudyosu.engine.scene.components
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.CellType;
   import com.oyunstudyosu.engine.scene.vo.DragVo;
   import flash.events.MouseEvent;
   
   public class SceneCameraComponent extends BaseSceneComponent implements ISceneCameraComponent
   {
      
      private var _dragVo:DragVo;
      
      public function SceneCameraComponent(param1:IScene)
      {
         super(param1);
         dragVo = new DragVo();
         param1.container.addEventListener("mouseDown",bgDown);
      }
      
      public function get dragVo() : DragVo
      {
         return _dragVo;
      }
      
      public function set dragVo(param1:DragVo) : void
      {
         _dragVo = param1;
      }
      
      private function bgDown(param1:MouseEvent) : void
      {
         if(!scene.mouseEnabled)
         {
            return;
         }
         Sanalika.instance.stage.addEventListener("mouseUp",stageMouseUpEvent,false,1);
         Sanalika.instance.stage.addEventListener("mouseMove",stageMouseMoveEvent);
         dragVo.mouseX = param1.stageX - scene.paddingX;
         dragVo.mouseY = param1.stageY - scene.paddingY;
         dragVo.containerX = scene.xBase;
         dragVo.containerY = scene.yBase;
      }
      
      public function stageMouseUpEvent(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         Sanalika.instance.stage.removeEventListener("mouseUp",stageMouseUpEvent);
         Sanalika.instance.stage.removeEventListener("mouseMove",stageMouseMoveEvent);
         scene.cursor.mouseEnabled = true;
      }
      
      public function stageMouseMoveEvent(param1:MouseEvent) : void
      {
         var point:IntPoint;
         var cell:Cell;
         var minimumDragLength:Number;
         var dragMath:*;
         var targetX:Number;
         var targetY:Number;
         var e:MouseEvent = param1;
         if(!dragVo.isEnabled)
         {
            return;
         }
         point = scene.translateToGrid(scene.mouseX,scene.mouseY);
         cell = scene.getCellAt(point.x,0,point.y);
         if(cell != null && cell.cellType == CellType.TYPE_FISH)
         {
            dragVo.containerX = scene.xBase;
            dragVo.containerY = scene.yBase;
            dragVo.isActive = false;
            return;
         }
         if(!dragVo.isActive)
         {
            dragMath = function(param1:Number, param2:Number):Number
            {
               param1 = Math.abs(param1);
               param2 = Math.abs(param2);
               return param1 >= param2 ? param1 - param2 : param2 - param1;
            };
            minimumDragLength = 150;
            if(!Sanalika.instance.scaleModel.isLandscape)
            {
               minimumDragLength = minimumDragLength / 2;
            }
            if(dragVo.lastMouseX == null)
            {
               dragVo.lastMouseX = e.stageX;
               dragVo.lastMouseY = e.stageY;
            }
            if(dragMath(dragVo.lastMouseX as Number,e.stageX) + dragMath(dragVo.lastMouseY as Number,e.stageY) < minimumDragLength)
            {
               trace(Math.abs(e.stageX - (dragVo.lastMouseX as Number)));
               trace(Math.abs(e.stageY - (dragVo.lastMouseY as Number)));
               return;
            }
            dragVo.mouseX = e.stageX - scene.paddingX;
            dragVo.mouseY = e.stageY - scene.paddingY;
            dragVo.isActive = true;
         }
         dragVo.lastMouseX = dragVo.lastMouseY = null;
         targetX = dragVo.containerX + (e.stageX - scene.paddingX) - dragVo.mouseX;
         targetY = dragVo.containerY + (e.stageY - scene.paddingY) - dragVo.mouseY;
         if(targetX > 0)
         {
            targetX = 0;
         }
         else if(targetX < Sanalika.instance.gameModel.canvasWidth - Sanalika.instance.scaleModel.width)
         {
            targetX = Sanalika.instance.gameModel.canvasWidth - Sanalika.instance.scaleModel.width;
         }
         if(targetY > 0)
         {
            targetY = 0;
         }
         else if(targetY < Sanalika.instance.gameModel.canvasHeight - Sanalika.instance.scaleModel.height)
         {
            targetY = Sanalika.instance.gameModel.canvasHeight - Sanalika.instance.scaleModel.height;
         }
         scene.container.x = targetX;
         scene.container.y = targetY;
         scene.xBase = scene.container.x;
         scene.yBase = scene.container.y;
         scene.cursor.mouseEnabled = false;
         Sanalika.instance.stage.addEventListener("mouseUp",onSwipeEnd);
      }
      
      private function onSwipeEnd(param1:MouseEvent) : void
      {
         dragVo.lastMouseX = dragVo.lastMouseY = null;
         dragVo.isActive = false;
         dragVo.timeoutEnabled = true;
         Sanalika.instance.stage.removeEventListener("mouseUp",onSwipeEnd);
      }
      
      public function screenShiftTo(param1:Number, param2:Number, param3:Number = 0.8) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         param1 *= Sanalika.instance.scaleModel.currentScale;
         param2 *= Sanalika.instance.scaleModel.currentScale;
         if(param1 < Sanalika.instance.layerModel.canvasWidth / 2)
         {
            _loc5_ = 0;
         }
         else if(param1 > Sanalika.instance.scaleModel.width - Sanalika.instance.layerModel.canvasWidth / 2)
         {
            _loc5_ = Sanalika.instance.layerModel.canvasWidth - Sanalika.instance.scaleModel.width;
         }
         else
         {
            _loc5_ = Sanalika.instance.layerModel.canvasWidth / 2 - param1;
         }
         if(param2 < Sanalika.instance.layerModel.canvasHeight / 2)
         {
            _loc4_ = 0;
         }
         else if(param2 > Sanalika.instance.scaleModel.height - Sanalika.instance.layerModel.canvasHeight / 2)
         {
            _loc4_ = Sanalika.instance.layerModel.canvasHeight - Sanalika.instance.scaleModel.height;
         }
         else
         {
            _loc4_ = Sanalika.instance.layerModel.canvasHeight / 2 - param2;
         }
         scene.xBase = _loc5_;
         scene.yBase = _loc4_;
         if(param3 == 0)
         {
            scene.container.x = scene.xBase;
            scene.container.y = scene.yBase;
         }
         else
         {
            TweenMax.to(scene.container,param3,{
               "x":scene.xBase,
               "y":scene.yBase,
               "ease":Quad.easeOut
            });
         }
      }
      
      override public function dispose() : void
      {
         isDisposed = true;
         scene.container.removeEventListener("mouseDown",bgDown);
         Sanalika.instance.stage.removeEventListener("mouseUp",stageMouseUpEvent,false);
         Sanalika.instance.stage.removeEventListener("mouseMove",stageMouseMoveEvent);
         Sanalika.instance.stage.removeEventListener("mouseUp",onSwipeEnd);
      }
   }
}

