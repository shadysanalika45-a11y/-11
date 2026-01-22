package org.osflash.signals
{
   public class PrioritySignal extends Signal implements IPrioritySignal
   {
      
      public function PrioritySignal(... rest)
      {
         rest = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
         super(rest);
      }
      
      public function addWithPriority(param1:Function, param2:int = 0) : ISlot
      {
         return this.registerListenerWithPriority(param1,false,param2);
      }
      
      public function addOnceWithPriority(param1:Function, param2:int = 0) : ISlot
      {
         return this.registerListenerWithPriority(param1,true,param2);
      }
      
      override protected function registerListener(param1:Function, param2:Boolean = false) : ISlot
      {
         return this.registerListenerWithPriority(param1,param2);
      }
      
      protected function registerListenerWithPriority(param1:Function, param2:Boolean = false, param3:int = 0) : ISlot
      {
         var _loc4_:ISlot = null;
         if(registrationPossible(param1,param2))
         {
            _loc4_ = new Slot(param1,this,param2,param3);
            slots = slots.insertWithPriority(_loc4_);
            return _loc4_;
         }
         return slots.find(param1);
      }
   }
}

