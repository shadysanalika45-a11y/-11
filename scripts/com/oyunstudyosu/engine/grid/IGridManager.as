package com.oyunstudyosu.engine.grid
{
   import com.oyunstudyosu.engine.core.IsoElement;
   
   public interface IGridManager
   {
      
      function get maxAreaNo() : int;
      
      function set maxAreaNo(param1:int) : void;
      
      function get gridElementLists() : Array;
      
      function set gridElementLists(param1:Array) : void;
      
      function get sortedMapEntries() : Array;
      
      function set sortedMapEntries(param1:Array) : void;
      
      function enterFrameOperations() : void;
      
      function doFixedObjectOperations() : void;
      
      function addCharToNumberedCharArray(param1:int, param2:IsoElement) : void;
      
      function removeCharFromNumberedCharArray(param1:int, param2:IsoElement) : void;
      
      function setMustBeSortedToNumberedCharArray(param1:int) : void;
      
      function getAreaNoFromGrid(param1:int, param2:int) : int;
   }
}

