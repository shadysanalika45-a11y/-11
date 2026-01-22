package com.oyunstudyosu.engine.pool.chars
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.pool.GamePool;
   import com.oyunstudyosu.engine.pool.controls.ItemControl;
   import flash.display.Sprite;
   
   public class PoolItem extends Sprite
   {
      
      public var _char:ICharacter;
      
      public var control:ItemControl;
      
      public var _nonIsoX:Number = 0;
      
      public var _nonIsoY:Number = 0;
      
      public var _direction:int = 1;
      
      public var _status:String = "";
      
      private var _bodyclip:String;
      
      protected var scene:IScene;
      
      public function PoolItem(param1:IScene, param2:ICharacter, param3:Number = 0, param4:Number = 0)
      {
         super();
         this.scene = param1;
         _char = param2;
         _nonIsoX = param3;
         _nonIsoY = param4;
      }
      
      public function updateBody() : void
      {
      }
      
      public function updateItem() : void
      {
      }
      
      public function update(param1:String) : void
      {
         visible = true;
         var _loc2_:Array = param1.split(",");
         if(_loc2_[2] == "down")
         {
            control.setKeyDown(_loc2_[1]);
         }
         else if(_loc2_[2] == "up")
         {
            control.setKeyUp(_loc2_[1]);
         }
      }
      
      public function initialize(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         _nonIsoX = parseFloat(_loc2_[3]);
         _nonIsoY = parseFloat(_loc2_[4]);
         control.initRotation = parseFloat(_loc2_[5]);
         control.initAngle = parseFloat(_loc2_[6]);
         control.initX = parseFloat(_loc2_[7]);
         control.initY = parseFloat(_loc2_[8]);
      }
      
      public function kill() : void
      {
         pool.removeChild(this);
         scene = null;
         _char = null;
      }
      
      public function set status(param1:String) : void
      {
         _status = param1;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
      }
      
      public function set nonIsoY(param1:Number) : void
      {
         _nonIsoY = param1;
      }
      
      public function set nonIsoX(param1:Number) : void
      {
         _nonIsoX = param1;
      }
      
      public function get coordinates() : String
      {
         return _nonIsoX + "," + _nonIsoY + "," + control.rotation + "," + control.angle + "," + control.x + "," + control.y;
      }
      
      public function get character() : ICharacter
      {
         return _char;
      }
      
      public function get pool() : GamePool
      {
         return this.parent as GamePool;
      }
      
      public function get bodyclip() : String
      {
         return _bodyclip;
      }
      
      public function set bodyclip(param1:String) : void
      {
         this._bodyclip = param1;
      }
   }
}

