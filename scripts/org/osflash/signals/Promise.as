package org.osflash.signals
{
   import flash.errors.IllegalOperationError;
   
   public class Promise extends OnceSignal
   {
      
      private var isDispatched:Boolean;
      
      private var valueObjects:Array;
      
      public function Promise()
      {
         super();
      }
      
      override public function addOnce(param1:Function) : ISlot
      {
         var _loc2_:ISlot = super.addOnce(param1);
         if(this.isDispatched)
         {
            _loc2_.execute(this.valueObjects);
            _loc2_.remove();
         }
         return _loc2_;
      }
      
      override public function dispatch(... rest) : void
      {
         if(this.isDispatched)
         {
            throw new IllegalOperationError("You cannot dispatch() a Promise more than once");
         }
         this.isDispatched = true;
         this.valueObjects = rest;
         super.dispatch.apply(this,rest);
      }
   }
}

