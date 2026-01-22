package com.oyunstudyosu.engine.core
{
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.enums.AvatarPermission;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class Cell extends EventDispatcher implements ICell
   {
      
      public var pos3d:Vector3d;
      
      public var pos2d:Point;
      
      public var posMatrix:IntPoint;
      
      public var parent:Cell;
      
      public var g:Number = 0;
      
      public var h:Number = 0;
      
      public var cost:Number = 1;
      
      public var zIndex:uint;
      
      public var baseZIndex:uint;
      
      public var objectMask:MovieClip;
      
      public var parentMapEntry:MapEntry;
      
      private var _bit:int;
      
      private var _cellType:int;
      
      public var eventDispatcherCharNick:String;
      
      private var _isObjectInUse:Boolean;
      
      public function Cell(param1:int, param2:int)
      {
         super();
         this.posMatrix = new IntPoint(param1,param2);
      }
      
      public function get isObjectInUse() : Boolean
      {
         return this._isObjectInUse;
      }
      
      public function set isObjectInUse(param1:Boolean) : void
      {
         if(this._isObjectInUse == param1)
         {
            return;
         }
         this._isObjectInUse = param1;
      }
      
      public function get bit() : int
      {
         return this._bit;
      }
      
      public function set bit(param1:int) : void
      {
         this._bit = param1;
      }
      
      public function get cellType() : int
      {
         return this._cellType;
      }
      
      public function set cellType(param1:int) : void
      {
         this._cellType = param1;
      }
      
      public function terminate() : void
      {
         this.pos3d = null;
         this.pos2d = null;
         this.posMatrix = null;
         this.parent = null;
         this.objectMask = null;
         this.dispose();
      }
      
      public function get x() : Number
      {
         return this.posMatrix.x;
      }
      
      public function get y() : Number
      {
         return this.posMatrix.y;
      }
      
      public function get f() : Number
      {
         return this.g + this.h;
      }
      
      public function get sittable() : Boolean
      {
         return this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.CHAIR;
      }
      
      public function get usable() : Boolean
      {
         if(this.cellType == CellType.TYPE_TARGET)
         {
            return true;
         }
         return this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.USABLE;
      }
      
      public function get swimmable() : Boolean
      {
         return this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.POOL_ENTRY;
      }
      
      public function get isPool() : Boolean
      {
         return this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.POOL;
      }
      
      public function isCencored() : Boolean
      {
         var _loc1_:Object = null;
         if(this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.CENCORED_OBJECT)
         {
            for each(_loc1_ in this.parentMapEntry.chairs)
            {
               if(this.posMatrix.equals(_loc1_.grid))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get playable() : Boolean
      {
         return this.parentMapEntry != null && this.parentMapEntry.entryType == MapEntryType.ATARI;
      }
      
      public function isSelectable(param1:ICharacter) : Boolean
      {
         return this.isWalkable(param1);
      }
      
      public function isWalkableBit(param1:int) : Boolean
      {
         return ((this.bit | param1) == param1 || param1 == 1 && this.bit < 0) && (this.cellType == CellType.TYPE_EMPTY || this.cellType == CellType.TYPE_WALK_ONLY);
      }
      
      public function isWalkable(param1:ICharacter) : Boolean
      {
         return ((this.bit | param1.bit) == param1.bit || param1.bit == 1 && this.bit < 0) && (this.cellType == CellType.TYPE_EMPTY || this.cellType == CellType.TYPE_WALK_ONLY) || this.cellType == CellType.TYPE_SANALIKAX && param1.permission.check(AvatarPermission.CARD_SANALIKAX) || this.cellType == CellType.TYPE_DIAMOND && param1.permission.check(AvatarPermission.DIAMOND_CLUB) || this.cellType == CellType.TYPE_ADMIN && param1.permission.check(AvatarPermission.MODERATOR) || this.cellType == CellType.TYPE_SHORTCUT && param1.permission.check(AvatarPermission.GAME_SHORTCUT) || this.cellType == CellType.TYPE_NPC && param1.permission.check(AvatarPermission.NPC) || this.cellType == CellType.TYPE_STAGE && param1.permission.check(AvatarPermission.STAGE);
      }
      
      override public function toString() : String
      {
         return "[CELL:" + this.posMatrix.x + "/" + this.posMatrix.y + " | cellType:" + this.cellType + "]";
      }
      
      public function equals(param1:ICell) : Boolean
      {
         return param1.x == this.x && param1.y == this.y;
      }
      
      public function get objectType() : int
      {
         if(this.parentMapEntry != null)
         {
            return this.parentMapEntry.entryType;
         }
         return MapEntryType.NORMAL;
      }
      
      public function get charAction() : String
      {
         if(this.parentMapEntry != null)
         {
            return this.parentMapEntry.action;
         }
         return null;
      }
      
      public function setMapEntry(param1:MapEntry) : void
      {
         this.parentMapEntry = param1;
      }
      
      public function getFrontPos(param1:IScene) : IntPoint
      {
         if(this.parentMapEntry != null)
         {
            return this.parentMapEntry.getFrontPos(param1,this);
         }
         return this.posMatrix.clone();
      }
      
      public function dispose() : void
      {
         if(this.parent)
         {
            this.parent.dispose();
         }
         this.parent = null;
         this.parentMapEntry = null;
      }
   }
}

