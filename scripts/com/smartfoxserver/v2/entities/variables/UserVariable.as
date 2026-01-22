package com.smartfoxserver.v2.entities.variables
{
   public interface UserVariable extends Variable
   {
      
      function get isPrivate() : Boolean;
      
      function set isPrivate(param1:Boolean) : void;
   }
}

