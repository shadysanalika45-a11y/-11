package com.oyunstudyosu.engine.core
{
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.grid.GridTileSize;
   import com.oyunstudyosu.debug.ContractLogger;
   import com.oyunstudyosu.sanalika.extension.Connectr;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.xml.XMLNode;
   
   public class MapEntry
   {
      
      public var x:int;
      
      public var y:int;
      
      public var z:int;
      
      public var f:int;
      
      public var s:int;
      
      public var fx:int;
      
      public var lc:int;
      
      public var st:int;
      
      public var sv:int;
      
      public var ext:int = 0;
      
      public var version:int = 0;
      
      public var width:Number;
      
      public var height:Number;
      
      public var depth:Number;
      
      public var type:String;
      
      public var entryType:int;
      
      public var definition:String;
      
      public var gameZoneId:String;
      
      public var id:String;
      
      public var gameType:int;
      
      public var dir:int;
      
      public var arg:String;
      
      public var maskDefinition:String;
      
      public var objectMask:MovieClip;
      
      public var center:Point;
      
      public var heighInPx:Number;
      
      public var chairs:Array;
      
      public var hasReservedGrids:Boolean;
      
      public var enabled:Boolean;
      
      public var element:IsoElement;
      
      public var interactiveName:String;
      
      private var _clip:MovieClip;
      
      public var count:int = 1;
      
      public var currentCount:int = 0;
      
      public var targetCellPoint:Point;
      
      public var action:String;
      
      public var stuffType:int;
      
      public var room:String;
      
      public var interactive:Boolean;
      
      public var property:String;
      
      private var cell:Cell;
      
      private var multiCell:Cell;
      
      private var dirs:Array;
      
      private var node:XMLNode;
      
      public function MapEntry(param1:XMLNode = null)
      {
         var _loc2_:XMLNode = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         super();
         if(param1 == null)
         {
            return;
         }
         this.node = param1;
         this.type = param1.nodeName;
         switch(this.type)
         {
            case "box":
               this.entryType = MapEntryType.NORMAL;
               break;
            case "billboard":
               this.entryType = MapEntryType.NORMAL;
               break;
            case "chair":
               this.entryType = MapEntryType.CHAIR;
               break;
            case "poolEntry":
               this.entryType = MapEntryType.POOL_ENTRY;
               break;
            case "pool":
               this.entryType = MapEntryType.POOL;
               break;
            case "farm":
               this.entryType = MapEntryType.FARM;
               break;
            case "floor":
               this.entryType = MapEntryType.FLOOR_OBJECT;
               break;
            case "stuff":
               this.entryType = MapEntryType.USABLE;
               this.action = param1.attributes["a"];
               if(param1.attributes["tc"])
               {
                  _loc3_ = JSON.parse(param1.attributes["tc"]) as Array;
                  this.targetCellPoint = new Point(_loc3_[0],_loc3_[1]);
               }
               break;
            case "cencor":
               this.entryType = MapEntryType.CENCORED_OBJECT;
               this.count = parseInt(param1.attributes["count"]);
               break;
            case "cinema":
               this.entryType = MapEntryType.CINEMA_SCREEN;
               break;
            case "exhibition":
               this.entryType = MapEntryType.EXHIBITION;
               break;
            case "youtube":
               this.entryType = MapEntryType.YOUTUBE_SCREEN;
               break;
            case "sound":
               this.entryType = MapEntryType.SOUND;
               break;
            default:
               this.entryType = MapEntryType.NORMAL;
         }
         this.x = parseInt(param1.attributes["x"]);
         this.y = parseInt(param1.attributes["y"]);
         this.z = parseInt(param1.attributes["z"]);
         this.f = parseInt(param1.attributes["f"]);
         this.s = parseInt(param1.attributes["s"]);
         this.fx = parseInt(param1.attributes["fx"]);
         this.lc = parseInt(param1.attributes["lc"]);
         this.st = parseInt(param1.attributes["st"]);
         this.sv = parseInt(param1.attributes["sv"]);
         this.width = parseInt(param1.attributes["w"]);
         this.height = parseFloat(param1.attributes["h"]);
         this.enabled = param1.attributes["enabled"] != null ? param1.attributes["enabled"] == "1" : true;
         this.depth = parseInt(param1.attributes["d"]);
         this.definition = param1.attributes["def"];
         this.id = param1.attributes["id"] == null ? "0" : param1.attributes["id"];
         this.gameZoneId = param1.attributes["gamezoneid"] == undefined ? "" : param1.attributes["gamezoneid"];
         this.gameType = param1.attributes["type"] == undefined ? -1 : int(param1.attributes["type"]);
         if(param1.attributes["ext"] != null)
         {
            this.ext = parseInt(param1.attributes["ext"]);
         }
         if(param1.attributes["v"] != null)
         {
            this.version = parseInt(param1.attributes["v"]);
         }
         if(param1.attributes["interactive"] == "true")
         {
            this.interactive = true;
         }
         if(this.interactive)
         {
            this.property = param1.lastChild.nodeValue;
         }
         if(this.gameType != -1)
         {
         }
         this.dir = param1.attributes["dir"] != null ? int(parseInt(param1.attributes["dir"])) : 0;
         this.arg = param1.attributes["arg"];
         this.maskDefinition = param1.attributes["mask"];
         for each(_loc2_ in param1.childNodes)
         {
            switch(_loc2_.nodeName)
            {
               case "chairs":
                  this.processChairs(_loc2_);
            }
         }
         try
         {
            _loc4_ = this.node.attributes;
            ContractLogger.log("map_entry",{
               "node":this.type,
               "entryType":this.entryType,
               "definition":this.definition,
               "id":this.id,
               "x":this.x,
               "y":this.y,
               "z":this.z,
               "w":this.width,
               "h":this.height,
               "d":this.depth,
               "dir":this.dir,
               "enabled":this.enabled,
               "attributes":_loc4_
            });
         }
         catch(e1:Error)
         {
         }
      }
      
      public function toString() : String
      {
         return "MapEntry : type[" + this.type + "] entryType[" + this.entryType + "] def[" + this.definition + "] stuffType[" + this.stuffType + "] mask[" + this.maskDefinition + "] action[" + this.action + "] id[" + this.id + "] dir[" + this.dir + "] x[" + this.x + "] y[" + this.y + "] z[" + this.z + "] w[" + this.width + "] h[" + this.height + "] d[" + this.depth + "] arg[" + this.arg + "] enabled[" + this.enabled + "] room[" + this.room + "]";
      }
      
      public function get clip() : MovieClip
      {
         return this._clip;
      }
      
      public function set clip(param1:MovieClip) : void
      {
         this._clip = param1;
      }
      
      public function getEntryData() : Object
      {
         var _loc3_:String = null;
         var _loc1_:Object = {};
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.z = this.z;
         _loc1_.f = this.f;
         _loc1_.s = this.s;
         _loc1_.fx = this.fx;
         _loc1_.lc = this.lc;
         _loc1_.st = this.st;
         _loc1_.sv = this.sv;
         _loc1_.id = this.id;
         _loc1_.width = this.width;
         _loc1_.height = this.height;
         _loc1_.depth = this.depth;
         _loc1_.definition = this.definition;
         _loc1_.clip = this.clip;
         var _loc2_:Object = this.node.attributes;
         for(_loc3_ in _loc2_)
         {
            if(!_loc1_.hasOwnProperty(_loc3_))
            {
               _loc1_[_loc3_] = _loc2_[_loc3_];
            }
         }
         return _loc1_;
      }
      
      public function check4Errors() : Boolean
      {
         if(this.definition == null || this.width == 0 || this.depth == 0)
         {
            return true;
         }
         return false;
      }
      
      public function createStaticItem() : void
      {
      }
      
      public function init(param1:IScene) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.width == 1 && this.depth == 1)
         {
            this.center = param1.getPosFromGrid(this.x,this.z);
            this.cell = param1.getCellAt(this.x,this.y,this.z);
            if(this.cell == null)
            {
               return;
            }
            this.cell.setMapEntry(this);
            if(this.entryType != MapEntryType.FLOOR_OBJECT)
            {
               this.cell.cellType = CellType.TYPE_DISABLED;
            }
            if(this.maskDefinition != null)
            {
               this.cell.objectMask = param1.getMovieClip(this.maskDefinition);
            }
         }
         else
         {
            this.center = param1.get2dPoint((this.x + this.width - 1) * GridTileSize.tileWidth,0,(this.z + this.depth - 1) * GridTileSize.tileWidth);
            if(this.maskDefinition != null)
            {
               this.objectMask = param1.getMovieClip(this.maskDefinition);
            }
            _loc2_ = 0;
            while(_loc2_ < this.width)
            {
               _loc3_ = 0;
               while(_loc3_ < this.depth)
               {
                  this.multiCell = param1.getCellAt(this.x + _loc2_,this.y,this.z + _loc3_);
                  if(this.multiCell != null)
                  {
                     this.multiCell.setMapEntry(this);
                     if(this.entryType != MapEntryType.FLOOR_OBJECT)
                     {
                        this.multiCell.cellType = CellType.TYPE_DISABLED;
                     }
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         this.heighInPx = this.height * GridTileSize.tileWidth;
      }
      
      public function getDirOfChair(param1:IntPoint) : int
      {
         var _loc2_:Object = null;
         if(param1 == null)
         {
            throw new Error("Null grid");
         }
         if(this.hasReservedGrids)
         {
            for each(_loc2_ in this.chairs)
            {
               if(_loc2_.grid.equals(param1))
               {
                  return _loc2_.dir;
               }
            }
            return 4;
         }
         return (this.dir + 4) % 8;
      }
      
      private function processChairs(param1:XMLNode) : void
      {
         var _loc2_:XMLNode = null;
         this.chairs = new Array();
         for each(_loc2_ in param1.childNodes)
         {
            if(Boolean(_loc2_) && _loc2_.nodeType != 3)
            {
               this.hasReservedGrids = true;
               this.chairs.push({
                  "type":_loc2_.nodeName,
                  "grid":new IntPoint(parseInt(_loc2_.attributes["x"]),parseInt(_loc2_.attributes["z"])),
                  "dir":parseInt(_loc2_.attributes["dir"]),
                  "inUse":false,
                  "h":(_loc2_.attributes["h"] ? parseFloat(_loc2_.attributes["h"]) : 0),
                  "maskDefinition":_loc2_.attributes["mask"]
               });
            }
         }
         try
         {
            ContractLogger.log("map_entry_chairs",{
               "definition":this.definition,
               "id":this.id,
               "chairs":this.chairs
            });
         }
         catch(e2:Error)
         {
         }
      }
      
      public function getFrontPos(param1:IScene, param2:Cell = null) : IntPoint
      {
         var _loc3_:IntPoint = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         if(this.entryType == MapEntryType.NORMAL)
         {
            throw new Error("Not an interactive object!");
         }
         var _loc4_:int = this.dir;
         var _loc5_:int = this.x;
         var _loc6_:int = this.y;
         var _loc7_:int = this.z;
         if(param2)
         {
            for each(_loc9_ in this.chairs)
            {
               if(param2.posMatrix.equals(_loc9_.grid))
               {
                  _loc4_ = int(_loc9_.dir);
                  _loc5_ = int(_loc9_.grid.x);
                  _loc7_ = int(_loc9_.grid.y);
                  break;
               }
            }
         }
         _loc3_ = param1.getPointAtDir(_loc4_,_loc5_,_loc6_,_loc7_);
         var _loc8_:IntPoint = _loc3_;
         this.cell = param1.getCellAtPoint(_loc8_);
         if(this.cell != null && this.cell.cellType == CellType.TYPE_DISABLED)
         {
            _loc8_ = null;
            this.dirs = [2,1,3];
            _loc10_ = 0;
            while(_loc10_ < 3)
            {
               _loc8_ = param1.getPointAtDir(_loc4_ + this.dirs[_loc10_],_loc5_,_loc6_,_loc7_);
               if(param1.getCellAtPoint(_loc8_).cellType != CellType.TYPE_DISABLED)
               {
                  break;
               }
               _loc8_ = param1.getPointAtDir(_loc4_ - this.dirs[_loc10_],_loc5_,_loc6_,_loc7_);
               if(param1.getCellAtPoint(_loc8_).cellType != CellType.TYPE_DISABLED)
               {
                  break;
               }
               _loc10_++;
            }
            if(_loc8_ == null)
            {
               _loc8_ = param1.getPointAtDir(_loc4_ - 4,_loc5_,_loc6_,_loc7_);
            }
         }
         this.cell = null;
         return _loc8_;
      }
      
      public function dispose() : void
      {
         if(this.element)
         {
            this.element.dispose();
         }
         this.element = null;
         if(this.cell)
         {
            this.cell.dispose();
         }
         this.cell = null;
         if(this.multiCell)
         {
            this.multiCell.dispose();
         }
         this.multiCell = null;
         if(this.objectMask)
         {
            this.objectMask.removeChildren();
         }
         this.objectMask = null;
         if(this.clip)
         {
            Connectr.instance.toolTipModel.removeTip(this.clip);
            this.clip.removeChildren();
         }
         this.clip = null;
         this.dirs = null;
         this.chairs = null;
      }
   }
}

