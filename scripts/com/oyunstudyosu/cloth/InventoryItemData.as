package com.oyunstudyosu.cloth
{
   public class InventoryItemData extends ItemFileData
   {
      
      public var clip:String;
      
      public var itemType:int;
      
      public var stayIdle:int;
      
      public function InventoryItemData(param1:String, param2:int, param3:int, param4:int)
      {
         super();
         this.clip = param1;
         this.forceUpdate(param2,param3,param4);
      }
      
      public function update(param1:int, param2:int, param3:int) : Boolean
      {
         if(this.itemType == param1 && this.stayIdle == param2 && this.version == param3)
         {
            return false;
         }
         this.forceUpdate(param1,param2,param3);
         return true;
      }
      
      public function forceUpdate(param1:int, param2:int, param3:int) : void
      {
         this.itemType = param1;
         this.stayIdle = param2;
         this.version = param3;
      }
   }
}

