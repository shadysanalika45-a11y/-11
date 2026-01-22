package de.polygonal.ds
{
   public class CircularDLLIterator implements Itr
   {
      
      public var _walker:DLLNode;
      
      public var _s:int;
      
      public var _i:int = 0;
      
      public var _hook:DLLNode = null;
      
      public var _f:DLL;
      
      public function CircularDLLIterator(param1:DLL)
      {
         _f = param1;
         _walker = _f.head;
         _s = _f._size;
         this;
      }
      
      public function reset() : Itr
      {
         _walker = _f.head;
         _s = _f._size;
         _i = 0;
         _hook = null;
         return this;
      }
      
      public function remove() : void
      {
         _f.unlink(_hook);
         --_i;
         --_s;
      }
      
      public function next() : Object
      {
         var _loc1_:Object = _walker.val;
         _hook = _walker;
         _walker = _walker.next;
         ++_i;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         return _i < _s;
      }
   }
}

