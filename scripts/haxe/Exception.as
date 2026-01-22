package haxe
{
   import flash.Boot;
   
   public class Exception extends Error
   {
      
      public var __skipStack:int;
      
      public var __previousException:Exception;
      
      public var __nativeStack:String;
      
      public var __nativeException:Error;
      
      public function Exception(param1:String = undefined, param2:Exception = undefined, param3:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         __previousException = param2;
         if(param3 != null && param3 is Error)
         {
            __nativeException = param3;
            __nativeStack = NativeStackTrace.normalize(param3.getStackTrace());
         }
         else
         {
            __nativeException = this;
            __nativeStack = NativeStackTrace.normalize(new Error().getStackTrace(),1);
         }
      }
      
      public static function caught(param1:*) : Exception
      {
         if(param1 is Exception)
         {
            return param1;
         }
         if(param1 is Error)
         {
            return new Exception(param1.message,null,param1);
         }
         return new ValueException(param1,null,param1);
      }
      
      public static function thrown(param1:*) : *
      {
         var _loc2_:* = null as ValueException;
         if(param1 is Exception)
         {
            return param1.get_native();
         }
         if(param1 is Error)
         {
            return param1;
         }
         _loc2_ = new ValueException(param1);
         ++_loc2_.__skipStack;
         return _loc2_;
      }
      
      public function unwrap() : *
      {
         return __nativeException;
      }
      
      public function toString() : String
      {
         return get_message();
      }
      
      final public function get_native() : *
      {
         return __nativeException;
      }
      
      public function get_message() : String
      {
         return this.message;
      }
   }
}

