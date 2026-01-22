package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   
   public class MapLimits
   {
      
      private var _lowerLimit:Vec3D;
      
      private var _higherLimit:Vec3D;
      
      public function MapLimits(param1:Vec3D, param2:Vec3D)
      {
         super();
         if(param1 == null || param2 == null)
         {
            throw new ArgumentError("Map limits arguments must be both non null!");
         }
         this._lowerLimit = param1;
         this._higherLimit = param2;
      }
      
      public function get lowerLimit() : Vec3D
      {
         return this._lowerLimit;
      }
      
      public function get higherLimit() : Vec3D
      {
         return this._higherLimit;
      }
   }
}

