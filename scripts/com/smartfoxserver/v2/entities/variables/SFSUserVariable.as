package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class SFSUserVariable extends BaseVariable implements UserVariable
   {
      
      protected var _isPrivate:Boolean;
      
      public function SFSUserVariable(param1:String, param2:*, param3:int = -1)
      {
         super(param1,param2,param3);
      }
      
      public static function fromSFSArray(param1:ISFSArray) : UserVariable
      {
         var _loc2_:UserVariable = new SFSUserVariable(param1.getUtfString(0),param1.getElementAt(2),param1.getByte(1));
         if(param1.size() > 3)
         {
            _loc2_.isPrivate = param1.getBool(3);
         }
         return _loc2_;
      }
      
      public static function newPrivateVariable(param1:String, param2:*) : SFSUserVariable
      {
         var _loc3_:SFSUserVariable = new SFSUserVariable(param1,param2);
         _loc3_.isPrivate = true;
         return _loc3_;
      }
      
      public function get isPrivate() : Boolean
      {
         return this._isPrivate;
      }
      
      public function set isPrivate(param1:Boolean) : void
      {
         this._isPrivate = param1;
      }
      
      override public function toSFSArray() : ISFSArray
      {
         var _loc1_:ISFSArray = super.toSFSArray();
         _loc1_.addBool(this._isPrivate);
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "[UserVar: " + _name + ", type: " + _type + ", value: " + _value + ", private: " + this._isPrivate + "]";
      }
   }
}

