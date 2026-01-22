package com.oyunstudyosu.auth
{
   import flash.utils.ByteArray;
   
   public interface IPermission
   {
      
      function get value() : String;
      
      function set value(param1:String) : void;
      
      function get data() : ByteArray;
      
      function check(param1:uint) : Boolean;
      
      function grantedIndexes() : Array;
      
      function checkAny(param1:Array) : Boolean;
      
      function checkAll(param1:Array) : Boolean;
   }
}

