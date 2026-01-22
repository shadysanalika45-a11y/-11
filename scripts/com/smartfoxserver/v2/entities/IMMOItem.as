package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.entities.variables.IMMOItemVariable;
   
   public interface IMMOItem
   {
      
      function get id() : int;
      
      function getVariables() : Array;
      
      function getVariable(param1:String) : IMMOItemVariable;
      
      function setVariable(param1:IMMOItemVariable) : void;
      
      function setVariables(param1:Array) : void;
      
      function containsVariable(param1:String) : Boolean;
      
      function get aoiEntryPoint() : Vec3D;
   }
}

