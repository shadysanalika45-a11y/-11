package com.oyunstudyosu.cloth
{
   public class SmileyData extends ItemFileData
   {
      
      public var key:String;
      
      public function SmileyData(param1:String, param2:int)
      {
         super();
         this.key = param1;
         this.forceUpdate(param2);
      }
      
      public function update(param1:int) : Boolean
      {
         if(this.version == param1)
         {
            return false;
         }
         this.forceUpdate(param1);
         return true;
      }
      
      public function forceUpdate(param1:int) : void
      {
         this.version = param1;
      }
   }
}

