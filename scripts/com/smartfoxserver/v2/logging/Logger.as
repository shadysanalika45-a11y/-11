package com.smartfoxserver.v2.logging
{
   import flash.events.EventDispatcher;
   
   public class Logger extends EventDispatcher
   {
      
      private var _enableConsoleTrace:Boolean = true;
      
      private var _enableEventDispatching:Boolean = false;
      
      private var _loggingLevel:int = 200;
      
      private var _loggingPrefix:String;
      
      public function Logger(param1:String = "SFS2X")
      {
         super();
         this._loggingPrefix = param1;
      }
      
      public function get enableConsoleTrace() : Boolean
      {
         return this._enableConsoleTrace;
      }
      
      public function set enableConsoleTrace(param1:Boolean) : void
      {
         this._enableConsoleTrace = param1;
      }
      
      public function get enableEventDispatching() : Boolean
      {
         return this._enableEventDispatching;
      }
      
      public function set enableEventDispatching(param1:Boolean) : void
      {
         this._enableEventDispatching = param1;
      }
      
      public function get loggingLevel() : int
      {
         return this._loggingLevel;
      }
      
      public function set loggingLevel(param1:int) : void
      {
         this._loggingLevel = param1;
      }
      
      public function debug(... rest) : void
      {
         this.log(LogLevel.DEBUG,rest.join(" "));
      }
      
      public function info(... rest) : void
      {
         this.log(LogLevel.INFO,rest.join(" "));
      }
      
      public function warn(... rest) : void
      {
         this.log(LogLevel.WARN,rest.join(" "));
      }
      
      public function error(... rest) : void
      {
         this.log(LogLevel.ERROR,rest.join(" "));
      }
      
      private function log(param1:int, param2:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:LoggerEvent = null;
         if(param1 < this._loggingLevel)
         {
            return;
         }
         var _loc5_:String = LogLevel.toString(param1);
         if(this._enableConsoleTrace)
         {
            trace("[" + this._loggingPrefix + "|" + _loc5_ + "]",param2);
         }
         if(this._enableEventDispatching)
         {
            _loc3_ = {};
            _loc3_.message = param2;
            _loc4_ = new LoggerEvent(_loc5_.toLowerCase(),_loc3_);
            dispatchEvent(_loc4_);
         }
      }
   }
}

