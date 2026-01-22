package com.oyunstudyosu.engine.core.objects
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IsoScene;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.engine.scene.components.ISceneCameraComponent;
   import flash.display.MovieClip;
   
   public class EntryObject extends IsoElement
   {
      
      public var numberedCharArrayIndex:int;
      
      public function EntryObject()
      {
         super();
      }
      
      public function initEntry(param1:String, param2:IScene) : void
      {
         create(null,null,param2 as IsoScene);
         this.id = param1;
         this.container = new MovieClip();
      }
      
      public function add2Scene() : void
      {
         numberedCharArrayIndex = scene.gridManager.maxAreaNo + 1;
         scene.elementsContainer.addChild(container);
      }
      
      public function setObjectPosition(param1:int, param2:int) : void
      {
         var _loc4_:Vector3d = scene.getScenePositionFromTile(param1,param2);
         var _loc3_:Cell = scene.getCellAt(param1,0,param2);
         move(_loc4_.x,_loc4_.y,_loc4_.z);
      }
      
      private function move(param1:Number, param2:Number, param3:Number) : void
      {
         this.scenePosition = new Vector3d(param1,param2,param3);
         var _loc4_:Cell = this.scene.translateToCell(scenePosition);
         if(_loc4_ == null)
         {
            return;
         }
         cell = _loc4_;
         var _loc5_:int = scene.gridManager.getAreaNoFromGrid(cell.x,cell.y);
         if(numberedCharArrayIndex != _loc5_)
         {
            scene.gridManager.removeCharFromNumberedCharArray(numberedCharArrayIndex,this);
            movedFromBackAreas = _loc5_ > numberedCharArrayIndex;
            numberedCharArrayIndex = _loc5_;
            scene.gridManager.addCharToNumberedCharArray(numberedCharArrayIndex,this);
         }
         this.depth = (scene.rowsCount - cell.y) * scene.columnsCount - cell.x - 1;
         scene.gridManager.setMustBeSortedToNumberedCharArray(numberedCharArrayIndex);
         this.currentTile = _loc4_.posMatrix.clone();
         this.canvasPosition = scene.get2dPoint(param1,param2,param3);
         if(container != null)
         {
            container.x = canvasPosition.x;
            container.y = canvasPosition.y;
         }
      }
      
      public function screenShifting(param1:Number = 0.8) : void
      {
         var _loc2_:ISceneCameraComponent = scene.getComponent(ISceneCameraComponent) as ISceneCameraComponent;
         if(_loc2_ != null)
         {
            _loc2_.screenShiftTo(container.x,container.y,param1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

