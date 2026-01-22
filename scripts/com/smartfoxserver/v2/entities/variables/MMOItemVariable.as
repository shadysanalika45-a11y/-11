package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class MMOItemVariable extends BaseVariable implements IMMOItemVariable
   {
      
      public function MMOItemVariable(param1:String, param2:*, param3:int = -1)
      {
         super(param1,param2,param3);
      }
      
      public static function fromSFSArray(param1:ISFSArray) : IMMOItemVariable
      {
         return new MMOItemVariable(param1.getUtfString(0),param1.getElementAt(2),param1.getByte(1));
      }
      
      public function toString() : String
      {
         return "[MMOItemVar: " + _name + ", type: " + _type + ", value: " + _value + "]";
      }
   }
}

