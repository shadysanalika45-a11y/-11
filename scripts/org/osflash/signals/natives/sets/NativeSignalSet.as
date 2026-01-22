package org.osflash.signals.natives.sets
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import org.osflash.signals.natives.INativeDispatcher;
   import org.osflash.signals.natives.NativeSignal;
   
   public class NativeSignalSet
   {
      
      protected var target:IEventDispatcher;
      
      protected const _signals:Dictionary = new Dictionary();
      
      public function NativeSignalSet(param1:IEventDispatcher)
      {
         super();
         this.target = param1;
      }
      
      public function getNativeSignal(param1:String, param2:Class = null) : NativeSignal
      {
         if(null == param1)
         {
            throw new ArgumentError("eventType must not be null.");
         }
         return this._signals[param1] = this._signals[param1] || new NativeSignal(this.target,param1,param2 || Event);
      }
      
      public function get numListeners() : int
      {
         var _loc2_:INativeDispatcher = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._signals)
         {
            _loc1_ += _loc2_.numListeners;
         }
         return _loc1_;
      }
      
      public function get signals() : Array
      {
         var _loc2_:INativeDispatcher = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this._signals)
         {
            _loc1_[_loc1_.length] = _loc2_;
         }
         return _loc1_;
      }
      
      public function removeAll() : void
      {
         var _loc1_:INativeDispatcher = null;
         for each(_loc1_ in this._signals)
         {
            _loc1_.removeAll();
            delete this._signals[_loc1_.eventType];
         }
      }
   }
}

