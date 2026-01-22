package com.greensock.loading
{
   public class BinaryDataLoader extends DataLoader
   {
      
      private static var _classActivated:Boolean = _activateClass("BinaryDataLoader",BinaryDataLoader,"zip");
      
      public function BinaryDataLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _loader.dataFormat = "binary";
         _type = "BinaryDataLoader";
      }
   }
}

