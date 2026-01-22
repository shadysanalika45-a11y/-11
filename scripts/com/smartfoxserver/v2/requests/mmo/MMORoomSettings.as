package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.requests.RoomSettings;
   
   public class MMORoomSettings extends RoomSettings
   {
      
      private var _defaultAOI:Vec3D;
      
      private var _mapLimits:MapLimits;
      
      private var _userMaxLimboSeconds:int = 50;
      
      private var _proximityListUpdateMillis:int = 250;
      
      private var _sendAOIEntryPoint:Boolean = true;
      
      public function MMORoomSettings(param1:String)
      {
         super(param1);
      }
      
      public function get defaultAOI() : Vec3D
      {
         return this._defaultAOI;
      }
      
      public function get mapLimits() : MapLimits
      {
         return this._mapLimits;
      }
      
      public function get userMaxLimboSeconds() : int
      {
         return this._userMaxLimboSeconds;
      }
      
      public function get proximityListUpdateMillis() : int
      {
         return this._proximityListUpdateMillis;
      }
      
      public function get sendAOIEntryPoint() : Boolean
      {
         return this._sendAOIEntryPoint;
      }
      
      public function set defaultAOI(param1:Vec3D) : void
      {
         this._defaultAOI = param1;
      }
      
      public function set mapLimits(param1:MapLimits) : void
      {
         this._mapLimits = param1;
      }
      
      public function set userMaxLimboSeconds(param1:int) : void
      {
         this._userMaxLimboSeconds = param1;
      }
      
      public function set proximityListUpdateMillis(param1:int) : void
      {
         this._proximityListUpdateMillis = param1;
      }
      
      public function set sendAOIEntryPoint(param1:Boolean) : void
      {
         this._sendAOIEntryPoint = param1;
      }
   }
}

