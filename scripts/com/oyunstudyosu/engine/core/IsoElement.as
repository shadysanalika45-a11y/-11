package com.oyunstudyosu.engine.core
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.scene.components.ISceneCameraComponent;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class IsoElement extends EventDispatcher
   {
      
      private var _id:String;
      
      public var scenePosition:Vector3d;
      
      public var canvasPosition:Point;
      
      public var scene:IScene;
      
      private var _container:Sprite;
      
      public var containerMask:MovieClip;
      
      public var depth:int;
      
      public var movedFromBackAreas:Boolean;
      
      private var _cell:Cell;
      
      private var p:Vector3d;
      
      private var _currentTile:IntPoint;
      
      public function IsoElement()
      {
         super();
      }
      
      public function get cell() : Cell
      {
         return this._cell;
      }
      
      public function set cell(param1:Cell) : void
      {
         this._cell = param1;
      }
      
      public function create(param1:Vector3d, param2:MovieClip, param3:IScene) : void
      {
         var _loc4_:Matrix = null;
         this.scene = param3;
         this.container = param2;
         if(param2 != null)
         {
            if(Connectr.instance.airModel.isAir())
            {
               _loc4_ = new Matrix();
               _loc4_.scale(1.75,1.75);
               param2["cacheAsBitmapMatrix"] = _loc4_;
               param2.cacheAsBitmap = true;
            }
         }
         if(param1 != null)
         {
            this.scenePosition = param1.clone();
         }
         else
         {
            this.scenePosition = new Vector3d();
         }
      }
      
      public function get currentTile() : IntPoint
      {
         return this._currentTile;
      }
      
      public function set currentTile(param1:IntPoint) : void
      {
         if(this._currentTile == param1)
         {
            return;
         }
         this._currentTile = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get container() : Sprite
      {
         return this._container;
      }
      
      public function set container(param1:Sprite) : void
      {
         this._container = param1;
      }
      
      public function moveToCell(param1:int, param2:int, param3:int) : void
      {
         this.p = this.scene.getScenePositionFromTile(param1,param3);
         this.moveTo(this.p.x,this.p.y,this.p.z);
      }
      
      public function moveTo(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:ISceneCameraComponent = null;
         this.scenePosition = new Vector3d(param1,param2,param3);
         var _loc4_:Cell = this.scene.translateToCell(this.scenePosition);
         if(_loc4_ == null)
         {
            return;
         }
         if(this.cell == null || _loc4_ != this.cell)
         {
            this.cell = _loc4_;
         }
         this.canvasPosition = this.scene.getPosFromGrid(this.cell.posMatrix.x,this.cell.posMatrix.y);
         this.currentTile = this.cell.posMatrix.clone();
         this.container.x = this.canvasPosition.x;
         this.container.y = this.canvasPosition.y;
         if(Connectr.instance.avatarModel.avatarId == this.id && this.scene.existsComponent(ISceneCameraComponent))
         {
            _loc5_ = this.scene.getComponent(ISceneCameraComponent) as ISceneCameraComponent;
            _loc5_.screenShiftTo(this.container.x,this.container.y);
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         this.containerMask = null;
         this.scenePosition = null;
         this.canvasPosition = null;
         this.currentTile = null;
         this.scene = null;
         if(this.container != null)
         {
            this.container.removeChildren();
         }
         this.container = null;
      }
   }
}

