package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.auth.Permission;
   import com.oyunstudyosu.engine.ICharacter;
   import com.oyunstudyosu.engine.IScene;
   import com.oyunstudyosu.engine.IntPoint;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.events.PackItemEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class DummyCharacter implements ICharacter
   {
      
      public function DummyCharacter()
      {
         super();
      }
      
      public function init(param1:String, param2:IScene, param3:int, param4:String, param5:Array) : void
      {
      }
      
      public function get permission() : Permission
      {
         return null;
      }
      
      public function get platform() : String
      {
         return null;
      }
      
      public function set platform(param1:String) : void
      {
      }
      
      public function get action() : String
      {
         return null;
      }
      
      public function set action(param1:String) : void
      {
      }
      
      public function get type() : int
      {
         return 0;
      }
      
      public function set type(param1:int) : void
      {
      }
      
      public function get forceMove() : Boolean
      {
         return false;
      }
      
      public function set forceMove(param1:Boolean) : void
      {
      }
      
      public function get isDisabled() : Boolean
      {
         return false;
      }
      
      public function set isDisabled(param1:Boolean) : void
      {
      }
      
      public function get isNPC() : Boolean
      {
         return false;
      }
      
      public function set isNPC(param1:Boolean) : void
      {
      }
      
      public function get isMe() : Boolean
      {
         return false;
      }
      
      public function set isMe(param1:Boolean) : void
      {
      }
      
      public function get direction() : int
      {
         return 0;
      }
      
      public function set direction(param1:int) : void
      {
      }
      
      public function get last_x() : int
      {
         return 0;
      }
      
      public function set last_x(param1:int) : void
      {
      }
      
      public function get last_y() : int
      {
         return 0;
      }
      
      public function set last_y(param1:int) : void
      {
      }
      
      public function get sex() : String
      {
         return null;
      }
      
      public function set sex(param1:String) : void
      {
      }
      
      public function get hide() : Boolean
      {
         return false;
      }
      
      public function set hide(param1:Boolean) : void
      {
      }
      
      public function get avatarName() : String
      {
         return null;
      }
      
      public function set avatarName(param1:String) : void
      {
      }
      
      public function get avatarSize() : Number
      {
         return 0;
      }
      
      public function set avatarSize(param1:Number) : void
      {
      }
      
      public function getHandItem() : MovieClip
      {
         return null;
      }
      
      public function urgentUpdate4Item(param1:PackItemEvent) : void
      {
      }
      
      public function setAccesory(param1:Array) : void
      {
      }
      
      public function getSmiley() : String
      {
         return null;
      }
      
      public function setSmiley(param1:String) : void
      {
      }
      
      public function canIUseHandItem() : Boolean
      {
         return false;
      }
      
      public function drawCharWithoutDrawTest(param1:Sprite) : void
      {
      }
      
      public function walk(param1:int, param2:int, param3:MovieClip = null, param4:Boolean = false, param5:Boolean = false) : void
      {
      }
      
      public function walkRequest(param1:int, param2:int, param3:MovieClip = null) : void
      {
      }
      
      public function setAction(param1:String) : void
      {
      }
      
      public function getAction() : String
      {
         return null;
      }
      
      public function useHandItem(param1:String, param2:Boolean = true) : void
      {
      }
      
      public function reLocate(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
      }
      
      public function rotateCharLeft() : void
      {
      }
      
      public function rotateCharRight() : void
      {
      }
      
      public function locate(param1:Number, param2:Number, param3:Number) : void
      {
      }
      
      public function get tp() : int
      {
         return 0;
      }
      
      public function set tp(param1:int) : void
      {
      }
      
      public function get bit() : int
      {
         return 0;
      }
      
      public function set bit(param1:int) : void
      {
      }
      
      public function get targetDoor() : MovieClip
      {
         return null;
      }
      
      public function set targetDoor(param1:MovieClip) : void
      {
      }
      
      public function get gameZoneId() : String
      {
         return null;
      }
      
      public function set gameZoneId(param1:String) : void
      {
      }
      
      public function terminate(param1:Boolean = true) : void
      {
      }
      
      public function talk(param1:String, param2:int = 0, param3:Number = 1, param4:Boolean = true) : void
      {
         trace(param1);
      }
      
      public function get bodyParts() : Array
      {
         return null;
      }
      
      public function set bodyParts(param1:Array) : void
      {
      }
      
      public function disableChar() : void
      {
      }
      
      public function setRoles(param1:String) : void
      {
      }
      
      public function setStatus(param1:String, param2:int) : void
      {
      }
      
      public function setFilters(param1:Array) : void
      {
      }
      
      public function get status() : String
      {
         return null;
      }
      
      public function set status(param1:String) : void
      {
      }
      
      public function hasActionFrame() : Boolean
      {
         return false;
      }
      
      public function hasDanceFrame() : Boolean
      {
         return false;
      }
      
      public function removeHandItem() : void
      {
      }
      
      public function set speed(param1:Number) : void
      {
      }
      
      public function get height() : int
      {
         return 0;
      }
      
      public function get container() : Sprite
      {
         return null;
      }
      
      public function set container(param1:Sprite) : void
      {
      }
      
      public function get id() : String
      {
         return null;
      }
      
      public function set id(param1:String) : void
      {
      }
      
      public function get currentTile() : IntPoint
      {
         return null;
      }
      
      public function set currentTile(param1:IntPoint) : void
      {
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function reachable(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function screenShifting(param1:Number = 0.8) : void
      {
      }
      
      public function get cell() : Cell
      {
         return undefined;
      }
      
      public function set cell(param1:Cell) : void
      {
      }
      
      public function get isSpectator() : Boolean
      {
         return false;
      }
      
      public function set isSpectator(param1:Boolean) : void
      {
      }
   }
}

