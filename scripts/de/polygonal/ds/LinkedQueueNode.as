package de.polygonal.ds
{
   import hx.Std;
   
   public class LinkedQueueNode
   {
      
      public var val:Object;
      
      public var next:LinkedQueueNode;
      
      public function LinkedQueueNode(param1:Object)
      {
         val = param1;
      }
      
      public function toString() : String
      {
         return "" + Std.string(val);
      }
   }
}

