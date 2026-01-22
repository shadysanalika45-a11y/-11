package com.oyunstudyosu.model
{
   import flash.display.Stage;
   import flash.utils.Dictionary;
   
   public class BrowserModel
   {
      
      private var stage:Stage;
      
      private var BrowserController:Class = null;
      
      public function BrowserModel(param1:Stage)
      {
         super();
         if(param1.loaderInfo.applicationDomain.hasDefinition("com.oyunstudyosu.air.controller.BrowserController"))
         {
            BrowserController = param1.loaderInfo.applicationDomain.getDefinition("com.oyunstudyosu.air.controller.BrowserController") as Class;
            BrowserController.init(param1);
         }
      }
      
      public function get isAvailable() : Boolean
      {
         if(BrowserController == null)
         {
            return false;
         }
         return true;
      }
      
      public function get browsers() : Dictionary
      {
         if(isAvailable == false)
         {
            return null;
         }
         return BrowserController.browsers;
      }
      
      public function create(param1:String, param2:Object, param3:Boolean = true) : void
      {
         if(isAvailable == false)
         {
            return;
         }
         BrowserController.create(param1,param2,param3);
      }
      
      public function remove(param1:String) : void
      {
         if(isAvailable == false)
         {
            return;
         }
         BrowserController.remove(param1);
      }
      
      public function _SafeStr_2(param1:String) : *
      {
         if(isAvailable == false)
         {
            return null;
         }
         return BrowserController._SafeStr_2(param1);
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
