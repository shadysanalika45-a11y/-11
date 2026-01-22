package com.oyunstudyosu.sanalika.interfaces
{
   import com.oyunstudyosu.restricted.RestrictedVo;
   
   public interface IRestrictedModel
   {
      
      function get restricted() : Vector.<RestrictedVo>;
      
      function get restrictedLen() : int;
      
      function add(param1:Object) : void;
      
      function removeAll() : void;
      
      function getRestrictedVoById(param1:String) : RestrictedVo;
      
      function removeFromRestricted(param1:Object) : void;
      
      function addNewRestriction(param1:Object) : void;
      
      function get isActive() : Boolean;
      
      function set isActive(param1:Boolean) : void;
   }
}

