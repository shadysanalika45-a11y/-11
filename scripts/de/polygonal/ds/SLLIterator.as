package de.polygonal.ds
{
   public class SLLIterator implements Itr
   {
      
      public var _walker:SLLNode;
      
      public var _hook:SLLNode = null;
      
      public var _f:SLL;
      
      public function SLLIterator(param1:SLL)
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
         var _loc4_:* = null as SLLNode;
         var _loc5_:* = null as SLLNode;
         var _loc6_:* = null as Object;
         var _loc1_:SLL = _f;
         var _loc2_:SLLNode = _hook;
         var _loc3_:SLLNode = _loc2_.next;
         if(_loc2_ == _loc1_.head)
         {
            _loc4_ = _loc1_.head;
            if(_loc1_._size > 1)
            {
               _loc1_.head = _loc1_.head.next;
               if(_loc1_._circular)
               {
                  _loc1_.tail.next = _loc1_.head;
               }
            }
            else
            {
               _loc1_.head = _loc1_.tail = null;
            }
            --_loc1_._size;
            _loc4_.next = null;
            _loc6_ = _loc4_.val;
            if(_loc1_._reservedSize > 0 && _loc1_._poolSize < _loc1_._reservedSize)
            {
               _loc1_._tailPool = _loc1_._tailPool.next = _loc4_;
               _loc4_.val = null;
               _loc4_.next = null;
               ++_loc1_._poolSize;
            }
            else
            {
               _loc4_._list = null;
            }
            _loc6_;
         }
         else
         {
            _loc5_ = _loc1_.head;
            while(_loc5_.next != _loc2_)
            {
               _loc5_ = _loc5_.next;
            }
            _loc4_ = _loc5_;
            if(_loc4_.next == _loc1_.tail)
            {
               if(_loc1_._circular)
               {
                  _loc1_.tail = _loc4_;
                  _loc4_.next = _loc1_.head;
               }
               else
               {
                  _loc1_.tail = _loc4_;
                  _loc4_.next = null;
               }
            }
            else
            {
               _loc4_.next = _loc3_;
            }
            _loc2_.next = null;
            _loc6_ = _loc2_.val;
            if(_loc1_._reservedSize > 0 && _loc1_._poolSize < _loc1_._reservedSize)
            {
               _loc1_._tailPool = _loc1_._tailPool.next = _loc2_;
               _loc2_.val = null;
               _loc2_.next = null;
               ++_loc1_._poolSize;
            }
            else
            {
               _loc2_._list = null;
            }
            _loc6_;
            --_loc1_._size;
         }
         _loc3_;
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

