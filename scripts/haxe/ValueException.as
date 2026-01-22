package haxe
{
   import flash.Boot;
   
   public class ValueException extends Exception
   {
      
      public var value:*;
      
      public function ValueException(param1:* = undefined, param2:Exception = undefined, param3:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(Std.string(param1),param2,param3);
         value = param1;
      }
      
      override public function unwrap() : *
      {
         return value;
      }
   }
}

