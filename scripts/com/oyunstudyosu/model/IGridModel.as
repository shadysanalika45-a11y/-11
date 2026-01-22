package com.oyunstudyosu.model
{
   public interface IGridModel
   {
      
      function get data() : String;
      
      function get width() : int;
      
      function get height() : int;
      
      function create(param1:int, param2:int, param3:int = 0) : void;
      
      function load(param1:String) : void;
      
      function getCellValue(param1:int, param2:int) : int;
      
      function setCellValue(param1:int, param2:int, param3:int) : void;
      
      function getCoordinatesByValue(param1:int) : Array;
      
      function toString() : String;
      
      function getCellsFromCellToDir(param1:int, param2:int, param3:int, param4:int = 0) : Array;
   }
}

