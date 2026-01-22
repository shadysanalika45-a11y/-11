package com.oyunstudyosu.door
{
   public interface IDoorModel
   {
      
      function getDoor(param1:int, param2:int) : IDoorVO;
      
      function getDoorById(param1:String) : IDoorVO;
      
      function useDoorByKey(param1:String) : void;
      
      function useHouseDoor(param1:String, param2:String, param3:String = "", param4:Object = null) : void;
      
      function load(param1:Array) : void;
      
      function loadJSON(param1:String) : void;
      
      function get count() : int;
      
      function get keyList() : Array;
      
      function dispose() : void;
      
      function get busy() : Boolean;
      
      function set busy(param1:Boolean) : void;
   }
}

