package com.oyunstudyosu.engine
{
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.engine.core.IsoElement;
   import com.oyunstudyosu.engine.core.MapEntry;
   import com.oyunstudyosu.engine.core.Vector3d;
   import com.oyunstudyosu.engine.grid.IGridManager;
   import com.oyunstudyosu.engine.scene.components.ISceneComponent;
   import com.oyunstudyosu.sanalika.interfaces.ISpeechable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.xml.XMLNode;
   
   public interface IScene extends IEventDispatcher
   {
      
      function getBotByName(param1:String) : ISpeechable;
      
      function get characterList() : Array;
      
      function getAvatarById(param1:String) : ICharacter;
      
      function get myChar() : ICharacter;
      
      function get mouseEnabled() : Boolean;
      
      function set mouseEnabled(param1:Boolean) : void;
      
      function get mouseX() : Number;
      
      function get mouseY() : Number;
      
      function get sceneLoaded() : Boolean;
      
      function get initialized() : Boolean;
      
      function get map() : XMLNode;
      
      function set map(param1:XMLNode) : void;
      
      function processMap(param1:XMLNode) : void;
      
      function processGrid() : void;
      
      function processBackground() : void;
      
      function get mapEntries() : Vector.<MapEntry>;
      
      function set mapEntries(param1:Vector.<MapEntry>) : void;
      
      function get sceneElements() : Vector.<IsoElement>;
      
      function get cursor() : MovieClip;
      
      function get arrow() : MovieClip;
      
      function addComponent(param1:Class, param2:Class = null) : ISceneComponent;
      
      function existsComponent(param1:Class) : Boolean;
      
      function getComponent(param1:Class) : ISceneComponent;
      
      function get grid() : Vector.<Cell>;
      
      function set grid(param1:Vector.<Cell>) : void;
      
      function get gridManager() : IGridManager;
      
      function set gridManager(param1:IGridManager) : void;
      
      function get columnsCount() : int;
      
      function set columnsCount(param1:int) : void;
      
      function get rowsCount() : int;
      
      function set rowsCount(param1:int) : void;
      
      function translateToGrid(param1:Number, param2:Number) : IntPoint;
      
      function indicateGrid(param1:int, param2:int, param3:Function) : void;
      
      function init() : void;
      
      function load() : void;
      
      function enable() : void;
      
      function disable() : void;
      
      function get container() : Sprite;
      
      function set container(param1:Sprite) : void;
      
      function get ceilingContainer() : Sprite;
      
      function set ceilingContainer(param1:Sprite) : void;
      
      function get speechContainer() : Sprite;
      
      function set speechContainer(param1:Sprite) : void;
      
      function get elementsContainer() : Sprite;
      
      function set elementsContainer(param1:Sprite) : void;
      
      function get floorContainer() : Sprite;
      
      function set floorContainer(param1:Sprite) : void;
      
      function get bgContainer() : Sprite;
      
      function set bgContainer(param1:Sprite) : void;
      
      function get bg() : MovieClip;
      
      function set bg(param1:MovieClip) : void;
      
      function get speechBalloonsEnabled() : Boolean;
      
      function set speechBalloonsEnabled(param1:Boolean) : void;
      
      function get speechBalloons() : Array;
      
      function set speechBalloons(param1:Array) : void;
      
      function get paddingX() : Number;
      
      function get paddingY() : Number;
      
      function get yBase() : int;
      
      function get xBase() : int;
      
      function getMovieClip(param1:String) : MovieClip;
      
      function set yBase(param1:int) : void;
      
      function set xBase(param1:int) : void;
      
      function hideCursors() : void;
      
      function getPosFromGrid(param1:Number, param2:Number) : Point;
      
      function get3DPosFromGrid(param1:int, param2:int) : Vector3d;
      
      function get2dPoint(param1:Number, param2:Number, param3:Number) : Point;
      
      function getPointAtDir(param1:int, param2:int, param3:int, param4:int) : IntPoint;
      
      function getCellAtPoint(param1:IntPoint) : Cell;
      
      function getScenePositionFromTile(param1:int, param2:int) : Vector3d;
      
      function getCellTypeByGrid(param1:Number, param2:Number, param3:Number) : int;
      
      function get activeGrid() : IntPoint;
      
      function set activeGrid(param1:IntPoint) : void;
      
      function getCellAtIsUsing(param1:Number, param2:Number, param3:Number) : Boolean;
      
      function setCellStatus(param1:int, param2:int, param3:Boolean) : void;
      
      function getCellAt(param1:Number, param2:Number, param3:Number) : Cell;
      
      function translateToCell(param1:Vector3d) : Cell;
      
      function dispose() : void;
   }
}

