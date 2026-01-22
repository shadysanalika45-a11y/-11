package com.smartfoxserver.v2.entities.variables
{
   public interface RoomVariable extends Variable
   {
      
      function get isPrivate() : Boolean;
      
      function set isPrivate(param1:Boolean) : void;
      
      function get isPersistent() : Boolean;
      
      function set isPersistent(param1:Boolean) : void;
   }
}

