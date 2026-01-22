package com.oyunstudyosu.sanalika.interfaces
{
   import flash.system.LoaderContext;
   
   public interface IDomainModel
   {
      
      function get mainContext() : LoaderContext;
      
      function clearMainContext() : void;
      
      function get subContext() : LoaderContext;
      
      function clearSubContext() : void;
      
      function get assetContext() : LoaderContext;
      
      function clearAssetContext() : void;
      
      function generateContext(param1:String) : LoaderContext;
      
      function clearContext(param1:String) : void;
   }
}

