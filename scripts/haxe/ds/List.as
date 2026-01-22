package haxe.ds
{
   import flash.Boot;
   import haxe.ds._List.ListNode;
   
   public class List
   {
      
      public var q:ListNode;
      
      public var length:int;
      
      public var h:ListNode;
      
      public function List()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         length = 0;
      }
      
      public function remove(param1:Object) : Boolean
      {
         var _loc2_:ListNode = null;
         var _loc3_:ListNode = h;
         while(_loc3_ != null)
         {
            if(_loc3_.item == param1)
            {
               if(_loc2_ == null)
               {
                  h = _loc3_.next;
               }
               else
               {
                  _loc2_.next = _loc3_.next;
               }
               if(q == _loc3_)
               {
                  q = _loc2_;
               }
               --length;
               return true;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         return false;
      }
      
      public function push(param1:Object) : void
      {
         var _loc2_:ListNode = new ListNode(param1,h);
         h = _loc2_;
         if(q == null)
         {
            q = _loc2_;
         }
         ++length;
      }
      
      public function pop() : Object
      {
         if(h == null)
         {
            return null;
         }
         var _loc1_:Object = h.item;
         h = h.next;
         if(h == null)
         {
            q = null;
         }
         --length;
         return _loc1_;
      }
      
      public function clear() : void
      {
         h = null;
         q = null;
         length = 0;
      }
      
      public function add(param1:Object) : void
      {
         var _loc2_:ListNode = null;
         var _loc3_:ListNode = new ListNode(param1,_loc2_);
         if(h == null)
         {
            h = _loc3_;
         }
         else
         {
            q.next = _loc3_;
         }
         q = _loc3_;
         ++length;
      }
   }
}

