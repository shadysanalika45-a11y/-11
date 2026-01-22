package com.oyunstudyosu.property
{
   import com.oyunstudyosu.door.IProperty;
   
   public class Property implements IProperty
   {
      
      private var _data:Object;
      
      public function Property()
      {
         super();
      }
      
      public function execute(param1:String = "") : void
      {
         throw new Error("You have to implement DoorProperty.execute()!!");
      }
      
      public function get owner() : String
      {
         if(_data)
         {
            return _data.type;
         }
         return "";
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
      }
      
      public function dispose() : void
      {
         _data = null;
      }
   }
}

