package de.polygonal.ds
{
   import hx.Std;
   
   public class LinkedStackNode
   {
      
      public var val:Object;
      
      public var next:LinkedStackNode;
      
      public function LinkedStackNode(param1:Object)
      {
         val = param1;
      }
      
      public function toString() : String
      {
         return Std.string(val);
      }
   }
}

