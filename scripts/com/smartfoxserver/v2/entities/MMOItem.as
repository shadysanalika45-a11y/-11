package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.entities.variables.IMMOItemVariable;
   import com.smartfoxserver.v2.entities.variables.MMOItemVariable;
   
   public class MMOItem implements IMMOItem
   {
      
      private var _id:int;
      
      private var _variables:Object;
      
      private var _aoiEntryPoint:Vec3D;
      
      public function MMOItem(param1:int)
      {
         super();
         this._id = param1;
         this._variables = {};
      }
      
      public static function fromSFSArray(param1:ISFSArray) : IMMOItem
      {
         var _loc2_:IMMOItem = new MMOItem(param1.getElementAt(0));
         var _loc3_:ISFSArray = param1.getSFSArray(1);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.size())
         {
            _loc2_.setVariable(MMOItemVariable.fromSFSArray(_loc3_.getSFSArray(_loc4_)));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function getVariables() : Array
      {
         var _loc1_:IMMOItemVariable = null;
         var _loc2_:Array = [];
         for each(_loc1_ in this._variables)
         {
         }
         _loc2_.push(_loc1_);
         return _loc2_;
      }
      
      public function getVariable(param1:String) : IMMOItemVariable
      {
         return this._variables[param1];
      }
      
      public function setVariable(param1:IMMOItemVariable) : void
      {
         if(param1 != null)
         {
            if(param1.isNull())
            {
               delete this._variables[param1.name];
            }
            else
            {
               this._variables[param1.name] = param1;
            }
         }
      }
      
      public function setVariables(param1:Array) : void
      {
         var _loc2_:IMMOItemVariable = null;
         for each(var _loc5_ in param1)
         {
            _loc2_ = _loc5_;
            _loc5_;
            this.setVariable(_loc2_);
         }
      }
      
      public function containsVariable(param1:String) : Boolean
      {
         return this._variables[param1] != null;
      }
      
      public function get aoiEntryPoint() : Vec3D
      {
         return this._aoiEntryPoint;
      }
      
      public function set aoiEntryPoint(param1:Vec3D) : void
      {
         this._aoiEntryPoint = param1;
      }
      
      public function toString() : String
      {
         return "[Item: " + this._id + "]";
      }
   }
}

