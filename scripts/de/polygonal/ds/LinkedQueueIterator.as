package de.polygonal.ds
{
   public class LinkedQueueIterator implements Itr
   {
      
      public var _walker:LinkedQueueNode;
      
      public var _hook:LinkedQueueNode = null;
      
      public var _f:LinkedQueue;
      
      public function LinkedQueueIterator(param1:LinkedQueue)
      {
         _f = param1;
         _walker = _f._head;
         this;
      }
      
      public function reset() : Itr
      {
         _walker = _f._head;
         _hook = null;
         return this;
      }
      
      public function remove() : void
      {
         _f._removeNode(_hook);
      }
      
      public function next() : Object
      {
         var _loc1_:Object = _walker.val;
         _hook = _walker;
         _walker = _walker.next;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         return _walker != null;
      }
      
      public function __remove(param1:Object, param2:LinkedQueueNode) : void
      {
         return param1._removeNode(param2);
      }
      
      public function __head(param1:Object) : LinkedQueueNode
      {
         return param1._head;
      }
   }
}

