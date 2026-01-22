package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class SFSBuddyVariable extends BaseVariable implements BuddyVariable
   {
      
      public static const OFFLINE_PREFIX:String = "$";
      
      public function SFSBuddyVariable(param1:String, param2:*, param3:int = -1)
      {
         super(param1,param2,param3);
      }
      
      public static function fromSFSArray(param1:ISFSArray) : BuddyVariable
      {
         return new SFSBuddyVariable(param1.getUtfString(0),param1.getElementAt(2),param1.getByte(1));
      }
      
      public function get isOffline() : Boolean
      {
         return _name.charAt(0) == "$";
      }
      
      public function toString() : String
      {
         return "[BuddyVar: " + _name + ", type: " + _type + ", value: " + _value + "]";
      }
   }
}

