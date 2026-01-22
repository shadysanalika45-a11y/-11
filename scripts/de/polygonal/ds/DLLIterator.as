package de.polygonal.ds
{
   public class DLLIterator implements Itr
   {
      
      public var _walker:DLLNode;
      
      public var _hook:DLLNode = null;
      
      public var _f:DLL;
      
      public function DLLIterator(param1:DLL)
      {
         _f = param1;
         _walker = _f.head;
         this;
      }
      
      public function reset() : Itr
      {
         _walker = _f.head;
         _hook = null;
         return this;
      }
      
      public function remove() : void
      {
         _f.unlink(_hook);
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
   }
}

