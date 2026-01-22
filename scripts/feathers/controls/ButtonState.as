package feathers.controls
{
   import flash.Boot;
   
   public final class ButtonState
   {
      
      public static const __isenum:Boolean = true;
      
      public static var DISABLED:ButtonState = new ButtonState("DISABLED",3,null);
      
      public static var DOWN:ButtonState = new ButtonState("DOWN",2,null);
      
      public static var HOVER:ButtonState = new ButtonState("HOVER",1,null);
      
      public static var UP:ButtonState = new ButtonState("UP",0,null);
      
      public static var __constructs__:Array = ["UP","HOVER","DOWN","DISABLED"];
      
      public var tag:String;
      
      public var index:int;
      
      public var params:Array;
      
      public const __enum__:Boolean = true;
      
      public function ButtonState(param1:String, param2:int, param3:Array)
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

