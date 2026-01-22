package com.oyunstudyosu.engine
{
   import com.oyunstudyosu.auth.Permission;
   import com.oyunstudyosu.engine.core.Cell;
   import com.oyunstudyosu.events.PackItemEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public interface ICharacter extends IIsoElement
   {
      
      function get isSpectator() : Boolean;
      
      function set isSpectator(param1:Boolean) : void;
      
      function get cell() : Cell;
      
      function set cell(param1:Cell) : void;
      
      function get permission() : Permission;
      
      function init(param1:String, param2:IScene, param3:int, param4:String, param5:Array) : void;
      
      function get platform() : String;
      
      function set platform(param1:String) : void;
      
      function get action() : String;
      
      function set action(param1:String) : void;
      
      function get type() : int;
      
      function set type(param1:int) : void;
      
      function get forceMove() : Boolean;
      
      function set forceMove(param1:Boolean) : void;
      
      function drawCharWithoutDrawTest(param1:Sprite) : void;
      
      function get isDisabled() : Boolean;
      
      function set isDisabled(param1:Boolean) : void;
      
      function get isNPC() : Boolean;
      
      function set isNPC(param1:Boolean) : void;
      
      function get isMe() : Boolean;
      
      function set isMe(param1:Boolean) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
      
      function get last_x() : int;
      
      function set last_x(param1:int) : void;
      
      function get last_y() : int;
      
      function set last_y(param1:int) : void;
      
      function get sex() : String;
      
      function set sex(param1:String) : void;
      
      function get hide() : Boolean;
      
      function set hide(param1:Boolean) : void;
      
      function get avatarName() : String;
      
      function set avatarName(param1:String) : void;
      
      function get avatarSize() : Number;
      
      function set avatarSize(param1:Number) : void;
      
      function getHandItem() : MovieClip;
      
      function urgentUpdate4Item(param1:PackItemEvent) : void;
      
      function setAccesory(param1:Array) : void;
      
      function getSmiley() : String;
      
      function setSmiley(param1:String) : void;
      
      function canIUseHandItem() : Boolean;
      
      function reachable(param1:int, param2:int) : Boolean;
      
      function walk(param1:int, param2:int, param3:MovieClip = null, param4:Boolean = false, param5:Boolean = false) : void;
      
      function walkRequest(param1:int, param2:int, param3:MovieClip = null) : void;
      
      function setAction(param1:String) : void;
      
      function getAction() : String;
      
      function useHandItem(param1:String, param2:Boolean = true) : void;
      
      function reLocate(param1:int, param2:int, param3:int, param4:Boolean = true) : void;
      
      function rotateCharLeft() : void;
      
      function rotateCharRight() : void;
      
      function locate(param1:Number, param2:Number, param3:Number) : void;
      
      function get tp() : int;
      
      function set tp(param1:int) : void;
      
      function get bit() : int;
      
      function set bit(param1:int) : void;
      
      function get targetDoor() : MovieClip;
      
      function set targetDoor(param1:MovieClip) : void;
      
      function get gameZoneId() : String;
      
      function set gameZoneId(param1:String) : void;
      
      function terminate(param1:Boolean = true) : void;
      
      function talk(param1:String, param2:int = 0, param3:Number = 1, param4:Boolean = true) : void;
      
      function get bodyParts() : Array;
      
      function set bodyParts(param1:Array) : void;
      
      function setFilters(param1:Array) : void;
      
      function setRoles(param1:String) : void;
      
      function setStatus(param1:String, param2:int) : void;
      
      function get status() : String;
      
      function set status(param1:String) : void;
      
      function hasActionFrame() : Boolean;
      
      function hasDanceFrame() : Boolean;
      
      function removeHandItem() : void;
      
      function set speed(param1:Number) : void;
      
      function get height() : int;
      
      function screenShifting(param1:Number = 0.8) : void;
   }
}

