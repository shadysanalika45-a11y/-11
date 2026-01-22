package com.oyunstudyosu.local
{
   import flash.utils.Dictionary;
   
   public class LocalInstanceConfig
   {
      
      private static var config:Dictionary = new Dictionary();
      
      private static var configs:Dictionary = new Dictionary();
      
      public function LocalInstanceConfig()
      {
         super();
      }
      
      private static function init() : *
      {
         addConfigEntry("turkey","LANGUAGE","tr");
         addConfigEntry("turkey","NAME","Türkiye");
         addConfigEntry("spain","LANGUAGE","ca");
         addConfigEntry("spain","NAME","Latino");
         addConfigEntry("russia","LANGUAGE","ru");
         addConfigEntry("russia","NAME","Russia");
         addConfigEntry("marhab","LANGUAGE","ar");
         addConfigEntry("marhab","NAME","Arabic");
         addConfigEntry("global","LANGUAGE","en");
         addConfigEntry("global","NAME","Global");
         addConfigEntry("egypt","LANGUAGE","ar");
         addConfigEntry("egypt","NAME","Egypt");
      }
      
      private static function addConfigEntry(param1:String, param2:String, param3:String) : *
      {
         if(configs[param1] == null)
         {
            configs[param1] = new Dictionary();
         }
         configs[param1][param2] = param3;
      }
      
      public static function setInstance(param1:String) : void
      {
         init();
         if(configs[param1] == null)
         {
            param1 = "global";
         }
         config = configs[param1];
      }
      
      public static function _SafeStr_2(param1:String) : String
      {
         if(!exists(param1))
         {
            return param1;
         }
         return config[param1];
      }
      
      public static function exists(param1:String) : Boolean
      {
         return config[param1] != null;
      }
   }
}


/** 
 * WARNING: The original code has obfuscated identifiers.
 * List of replacements follows:
 * @identifier _SafeStr_2 = "get"
 */
