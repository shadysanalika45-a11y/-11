package com.smartfoxserver.v2.entities.data
{
   import flash.utils.getDefinitionByName;
   
   public class Vec3D
   {
      
      public static var useFloatCoordinates:Boolean = false;
      
      private var _px:Number;
      
      private var _py:Number;
      
      private var _pz:Number;
      
      public function Vec3D(param1:Number, param2:Number, param3:Number = 0)
      {
         super();
         this._px = param1;
         this._py = param2;
         this._pz = param3;
      }
      
      public static function fromArray(param1:Array) : Vec3D
      {
         return new Vec3D(param1[0],param1[1],param1[2]);
      }
      
      public function toString() : String
      {
         return "(" + this._px + ", " + this._py + ", " + this._pz + ")";
      }
      
      public function get px() : Number
      {
         return this._px;
      }
      
      public function get py() : Number
      {
         return this._py;
      }
      
      public function get pz() : Number
      {
         return this._pz;
      }
      
      public function isFloat() : Boolean
      {
         return useFloatCoordinates;
      }
      
      public function toArray() : Array
      {
         return [this._px,this._py,this._pz];
      }
   }
}

