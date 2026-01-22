package com.oyunstudyosu.pooling
{
   import flash.utils.Dictionary;
   
   public class OPM
   {
      
      private static var map:Dictionary;
      
      private static var _resetFunc:String;
      
      private static var _disposeFunc:String;
      
      public function OPM()
      {
         super();
      }
      
      public static function set resetFunc(param1:String) : void
      {
         if(_resetFunc == param1)
         {
            return;
         }
         _resetFunc = param1;
      }
      
      public static function set disposeFunc(param1:String) : void
      {
         if(_disposeFunc == param1)
         {
            return;
         }
         _disposeFunc = param1;
      }
      
      public static function hasType(param1:Class) : Boolean
      {
         var _loc2_:ObjectPool = map[param1] as ObjectPool;
         if(_loc2_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function addType(param1:Class, param2:int = 100) : void
      {
         if(map == null)
         {
            map = new Dictionary(true);
         }
         map[param1] = new ObjectPool(param1,false,param2,0,null,"","");
      }
      
      public static function removeType(param1:Class) : void
      {
         var _loc2_:ObjectPool = map[param1] as ObjectPool;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.dispose();
         delete map[param1];
      }
      
      public static function borrowObjectByType(param1:Class) : *
      {
         var _loc2_:ObjectPool = map[param1];
         if(_loc2_)
         {
            return _loc2_.borrowObject();
         }
         return null;
      }
      
      public static function returnObjectByType(param1:*, param2:Class) : void
      {
         var _loc3_:ObjectPool = map[param2];
         if(_loc3_)
         {
            _loc3_.returnObject(param1);
         }
      }
      
      public static function dispose() : void
      {
         var _loc1_:ObjectPool = null;
         for each(_loc1_ in map)
         {
            _loc1_.dispose();
         }
         map = null;
      }
   }
}

