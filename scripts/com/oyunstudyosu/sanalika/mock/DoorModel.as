package com.oyunstudyosu.sanalika.mock
{
   import com.oyunstudyosu.door.IDoorModel;
   import com.oyunstudyosu.door.IDoorVO;
   
   public class DoorModel implements IDoorModel
   {
      
      public function DoorModel()
      {
         super();
      }
      
      public function getDoor(param1:int, param2:int) : IDoorVO
      {
         return null;
      }
      
      public function getDoorById(param1:String) : IDoorVO
      {
         return null;
      }
      
      public function useDoorByKey(param1:String) : void
      {
      }
      
      public function useHouseDoor(param1:String, param2:String, param3:String = "", param4:Object = null) : void
      {
         trace("use door houseID : " + param1,"data : " + JSON.stringify(param4));
      }
      
      public function load(param1:Array) : void
      {
      }
      
      public function loadJSON(param1:String) : void
      {
      }
      
      public function get count() : int
      {
         return 0;
      }
      
      public function get keyList() : Array
      {
         return null;
      }
      
      public function dispose() : void
      {
      }
      
      public function get busy() : Boolean
      {
         return false;
      }
      
      public function set busy(param1:Boolean) : void
      {
      }
   }
}

