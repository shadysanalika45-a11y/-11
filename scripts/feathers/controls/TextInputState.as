package feathers.controls
{
   import flash.Boot;
   
   public final class TextInputState
   {
      
      public static const __isenum:Boolean = true;
      
      public static var DISABLED:TextInputState = new TextInputState("DISABLED",1,null);
      
      public static var ENABLED:TextInputState = new TextInputState("ENABLED",0,null);
      
      public static var ERROR:TextInputState = new TextInputState("ERROR",3,null);
      
      public static var FOCUSED:TextInputState = new TextInputState("FOCUSED",2,null);
      
      public static var __constructs__:Array = ["ENABLED","DISABLED","FOCUSED","ERROR"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function TextInputState(param1:String, param2:int, param3:Array)
      {
         tag = param1;
         index = param2;
         params = param3;
      }
      
      final public function toString() : String
      {
         return Boot.enum_to_string(this);
      }
   }
}

