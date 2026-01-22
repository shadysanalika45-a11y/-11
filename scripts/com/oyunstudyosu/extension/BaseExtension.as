package com.oyunstudyosu.extension
{
   import flash.display.MovieClip;
   
   public class BaseExtension extends MovieClip implements IExtension
   {
      
      public var property:Object;
      
      public var type:int;
      
      public function BaseExtension()
      {
         super();
      }
      
      public function init(param1:Object = null) : void
      {
      }
      
      public function reload() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}

