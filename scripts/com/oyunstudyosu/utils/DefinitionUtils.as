package com.oyunstudyosu.utils
{
   import flash.system.ApplicationDomain;
   
   public class DefinitionUtils
   {
      
      public function DefinitionUtils()
      {
         super();
      }
      
      public static function getClass(param1:ApplicationDomain, param2:String, param3:String = "") : Class
      {
         var _loc4_:Class = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(param3.length > 0)
         {
            param2 += "_" + param3;
         }
         if(param1.hasDefinition(param2))
         {
            _loc4_ = param1.getDefinition(param2) as Class;
         }
         else
         {
            _loc5_ = param1.getQualifiedDefinitionNames();
            if(_loc5_ == null)
            {
               return _loc4_;
            }
            _loc6_ = int(_loc5_.length);
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(_loc5_[_loc7_].indexOf("::") > -1)
               {
                  _loc8_ = _loc5_[_loc7_].split("::")[1];
                  if(_loc8_ == param2)
                  {
                     _loc4_ = param1.getDefinition(_loc5_[_loc7_]) as Class;
                  }
               }
               else if(_loc5_[_loc7_] == param2)
               {
                  _loc4_ = param1.getDefinition(_loc5_[_loc7_]) as Class;
               }
               _loc7_++;
            }
         }
         return _loc4_;
      }
   }
}

