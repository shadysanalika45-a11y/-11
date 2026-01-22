package com.oyunstudyosu.model
{
   import flash.display.Stage;
   
   public class CacheModel
   {
      
      private var CacheController:Class = null;
      
      public function CacheModel(param1:Stage)
      {
         super();
      }
      
      public function get isSupported() : Boolean
      {
         if(CacheController == null)
         {
            return false;
         }
         return CacheController.isSupported;
      }
      
      public function get isAvailable() : Boolean
      {
         if(CacheController == null)
         {
            return false;
         }
         return CacheController.isAvailable;
      }
      
      public function get path() : String
      {
         if(CacheController == null)
         {
            return null;
         }
         return CacheController.path;
      }
      
      public function set path(param1:String) : void
      {
         if(CacheController == null)
         {
            return;
         }
         CacheController.path = param1;
      }
      
      public function disable() : void
      {
         if(CacheController == null)
         {
            return;
         }
         CacheController.disable();
      }
      
      public function enable() : void
      {
         if(CacheController == null)
         {
            return;
         }
         CacheController.enable();
      }
      
      public function checkPermissionByPath(param1:*) : Boolean
      {
         if(CacheController == null)
         {
            return false;
         }
         return CacheController.checkPermissionByPath(param1);
      }
      
      public function checkPermission() : Boolean
      {
         if(CacheController == null)
         {
            return false;
         }
         return CacheController.checkPermission();
      }
      
      public function resolvePath() : *
      {
         if(CacheController == null)
         {
            return null;
         }
         return CacheController.resolvePath();
      }
      
      public function cleanTemporaryFiles() : void
      {
         CacheController.cleanTemporaryFiles();
      }
   }
}

