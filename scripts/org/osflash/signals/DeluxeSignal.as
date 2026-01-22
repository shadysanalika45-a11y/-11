package org.osflash.signals
{
   import org.osflash.signals.events.IBubbleEventHandler;
   import org.osflash.signals.events.IEvent;
   
   public class DeluxeSignal extends PrioritySignal
   {
      
      protected var _target:Object;
      
      public function DeluxeSignal(param1:Object = null, ... rest)
      {
         this._target = param1;
         rest = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
         super(rest);
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         if(param1 == this._target)
         {
            return;
         }
         removeAll();
         this._target = param1;
      }
      
      override public function dispatch(... rest) : void
      {
         var _loc2_:int = int(_valueClasses.length);
         var _loc3_:int = int(rest.length);
         if(_loc3_ < _loc2_)
         {
            throw new ArgumentError("Incorrect number of arguments. " + "Expected at least " + _loc2_ + " but received " + _loc3_ + ".");
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!(rest[_loc4_] is _valueClasses[_loc4_] || rest[_loc4_] === null))
            {
               throw new ArgumentError("Value object <" + rest[_loc4_] + "> is not an instance of <" + _valueClasses[_loc4_] + ">.");
            }
            _loc4_++;
         }
         var _loc5_:IEvent = rest[0] as IEvent;
         if(_loc5_)
         {
            if(_loc5_.target)
            {
               _loc5_ = _loc5_.clone();
               rest[0] = _loc5_;
            }
            _loc5_.target = this.target;
            _loc5_.currentTarget = this.target;
            _loc5_.signal = this;
         }
         var _loc6_:SlotList = slots;
         while(_loc6_.nonEmpty)
         {
            _loc6_.head.execute(rest);
            _loc6_ = _loc6_.tail;
         }
         if(!_loc5_ || !_loc5_.bubbles)
         {
            return;
         }
         var _loc7_:Object = this.target;
         while(Boolean(_loc7_) && Boolean(_loc7_.hasOwnProperty("parent")))
         {
            _loc7_ = _loc7_["parent"];
            if(!_loc7_)
            {
               break;
            }
            if(_loc7_ is IBubbleEventHandler)
            {
               if(!IBubbleEventHandler(_loc5_.currentTarget = _loc7_).onEventBubbled(_loc5_))
               {
                  break;
               }
            }
         }
      }
   }
}

