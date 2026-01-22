package org.osflash.signals
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class MonoSignal implements ISignal
   {
      
      protected var _valueClasses:Array;
      
      protected var slot:Slot;
      
      public function MonoSignal(... rest)
      {
         super();
         this.valueClasses = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
      }
      
      public function get valueClasses() : Array
      {
         return this._valueClasses;
      }
      
      public function set valueClasses(param1:Array) : void
      {
         this._valueClasses = param1 ? param1.slice() : [];
         var _loc2_:int = int(this._valueClasses.length);
         while(_loc2_--)
         {
            if(!(this._valueClasses[_loc2_] is Class))
            {
               throw new ArgumentError("Invalid valueClasses argument: " + "item at index " + _loc2_ + " should be a Class but was:<" + this._valueClasses[_loc2_] + ">." + getQualifiedClassName(this._valueClasses[_loc2_]));
            }
         }
      }
      
      public function get numListeners() : uint
      {
         return this.slot ? 1 : 0;
      }
      
      public function add(param1:Function) : ISlot
      {
         return this.registerListener(param1);
      }
      
      public function addOnce(param1:Function) : ISlot
      {
         return this.registerListener(param1,true);
      }
      
      public function remove(param1:Function) : ISlot
      {
         var _loc2_:ISlot = null;
         if(Boolean(this.slot) && this.slot.listener == param1)
         {
            _loc2_ = this.slot;
            this.slot = null;
            return _loc2_;
         }
         return null;
      }
      
      public function removeAll() : void
      {
         if(this.slot)
         {
            this.slot.remove();
         }
      }
      
      public function dispatch(... rest) : void
      {
         var _loc2_:int = int(this._valueClasses.length);
         var _loc3_:int = int(rest.length);
         if(_loc3_ < _loc2_)
         {
            throw new ArgumentError("Incorrect number of arguments. " + "Expected at least " + _loc2_ + " but received " + _loc3_ + ".");
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!(rest[_loc4_] is this._valueClasses[_loc4_] || rest[_loc4_] === null))
            {
               throw new ArgumentError("Value object <" + rest[_loc4_] + "> is not an instance of <" + this._valueClasses[_loc4_] + ">.");
            }
            _loc4_++;
         }
         if(this.slot)
         {
            this.slot.execute(rest);
         }
      }
      
      protected function registerListener(param1:Function, param2:Boolean = false) : ISlot
      {
         if(this.slot)
         {
            throw new IllegalOperationError("You cannot add or addOnce with a listener already added, remove the current listener first.");
         }
         return this.slot = new Slot(param1,this,param2);
      }
   }
}

