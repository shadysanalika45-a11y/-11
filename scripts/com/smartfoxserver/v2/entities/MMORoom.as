package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.kernel;
   import com.smartfoxserver.v2.util.ArrayUtil;
   
   use namespace kernel;
   
   public class MMORoom extends SFSRoom
   {
      
      private var _defaultAOI:Vec3D;
      
      private var _lowerMapLimit:Vec3D;
      
      private var _higherMapLimit:Vec3D;
      
      private var _itemsById:Object = {};
      
      public function MMORoom(param1:int, param2:String, param3:String = "default")
      {
         super(param1,param2,param3);
      }
      
      public function get defaultAOI() : Vec3D
      {
         return this._defaultAOI;
      }
      
      public function get lowerMapLimit() : Vec3D
      {
         return this._lowerMapLimit;
      }
      
      public function get higherMapLimit() : Vec3D
      {
         return this._higherMapLimit;
      }
      
      public function set defaultAOI(param1:Vec3D) : void
      {
         if(this._defaultAOI != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._defaultAOI = param1;
      }
      
      public function set lowerMapLimit(param1:Vec3D) : void
      {
         if(this._lowerMapLimit != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._lowerMapLimit = param1;
      }
      
      public function set higherMapLimit(param1:Vec3D) : void
      {
         if(this._higherMapLimit != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._higherMapLimit = param1;
      }
      
      public function getMMOItem(param1:int) : IMMOItem
      {
         return this._itemsById[param1];
      }
      
      public function getMMOItems() : Array
      {
         return ArrayUtil.objToArray(this._itemsById);
      }
      
      kernel function addMMOItem(param1:IMMOItem) : void
      {
         this._itemsById[param1.id] = param1;
      }
      
      kernel function removeItem(param1:int) : void
      {
         delete this._itemsById[param1];
      }
   }
}

